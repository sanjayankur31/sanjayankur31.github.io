Bash functions for working with UV
##################################
:date: 2025-09-10 17:04:09
:modified: 2025-09-10 17:04:09
:author: ankur
:category: Tech
:tags: Python, Bash, UV, Pip, Fedora, Pew
:slug: bash-functions-for-working-with-uv
:summary: I wrote up a few bash functions to make working with uv_ slightly quicker.

I finally made the switch from pip_ to uv_ recently.
uv_ is much quicker that pip_.
I won't go into how/why here, but I will link you to `this video that explains it <https://youtu.be/gSKTfG1GXYQ?si=7RWGTdRZdinvZP2X>`__.
When working with packages such as PyNeuroML_ that have quite a few dependencies, the speed up begins to matter, especially when one is developing and may create and remove virtual environments quite often.

I used to use Pew_ to manage my Python virtual environments.
It is a great tool.
Unfortunately, `it isn't quite maintained any more <https://github.com/pew-org/pew/issues/218>`__, and that means support for things like uv_ are probably not going to happen soon.

I went looking for a similar wrapper around uv_ and there are some, but they're simple enough where I thought writing my own bash functions/aliases is probably preferable.
So, here's what I've added to my `bashrc`.
They are a number of functions/aliases to:

- list virtual environments
- create a new virtual environment using uv_
- activate virtual environments
- remove virtual environments
- install packages using uv_

A simple bash shell completion function is also setup.
The listing and removal functions aren't really uv_ specific here, but I prefix them with :code:`uv` for consistency.

(I don't use another shell, so please adapt these to whatever you use):


.. code-block:: bash

    # uv helpers
    export VIRTUAL_ENV_HOME="$HOME/.virtualenvs/"
    uvnew () {
        if command -v uv 2>&1 > /dev/null
        then
            pushd $VIRTUAL_ENV_HOME && uv venv "$@" && popd
        else
            echo "uv not installed"
        fi
    }
    uvls () {
        ls $VIRTUAL_ENV_HOME
    }
    uvrm () {
        venv_name=$1
        read -p "Delete env \"$venv_name\"? Are you sure? (Yy)" -n 1 -r
        # (optional) move to a new line
        echo
        # input is stored in REPLY if no var is given to read
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo "Removing $VIRTUAL_ENV_HOME/$venv_name"
            rm -rf $VIRTUAL_ENV_HOME/$venv_name
        fi
    }
    _venv_completions () {
        local cur
        cur="${COMP_WORDS[COMP_CWORD]}"
        pushd $VIRTUAL_ENV_HOME 2>&1 >/dev/null
            COMPREPLY=($(compgen -o dirnames -- "$cur"))
        popd >/dev/null 2>&1
    }
    uvactivate () {
        venv_name=$1
        if [ -e "$VIRTUAL_ENV_HOME/$venv_name/bin/activate" ]
        then
            source "$VIRTUAL_ENV_HOME/$venv_name/bin/activate"
        else
            echo "Could not find activation script"
            echo "Available venvs are"
            uvls
        fi
    }
    complete -F _venv_completions uvactivate
    complete -F _venv_completions uvrm

    alias uvpip="uv pip"


On Fedora, uv_ is in the repositories, so it can be installed with:

.. code-block:: bash

    sudo dnf install uv


If you have your own wrappers for working with :code:`uv` that are better than these simple bits, please drop me a word.


.. _uv: https://github.com/astral-sh/uv/
.. _pip: https://pypi.org/project/pip/
.. _PyNeuroML: https://docs.neuroml.org/Userdocs/Software/pyNeuroML.html
.. _Pew: https://github.com/pew-org/pew/issues
