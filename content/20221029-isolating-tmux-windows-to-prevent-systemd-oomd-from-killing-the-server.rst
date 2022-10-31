Isolating Tmux windows to prevent systemd-oomd from killing the server
######################################################################
:date: 2022-10-29 13:30:32
:modified: 2022-10-31 17:22:54
:author: ankur
:category: Tech
:tags: Linux, Tmux, Byobu, Systemd, Fedora
:slug: isolating-tmux-windows-to-prevent-systemd-oomd-from-killing-the-server
:summary: This post documents how one can isolate different Tmux_ windows to prevent one of them getting killed by `systemd-oomd`_ from causing the whole Tmux server (and all sessions!) to also be killed.

I run a number of Tmux_ sessions, one for each project or context, (via Byobu_) to do my work on a daily basis.
Tmux_ uses a client-server architecture, so there's a Tmux_ server running that all of these sessions connect to.
Some time ago, I began noticing that all my Tmux_ sessions were being killed while I worked.
I knew this wasn't a random occurrence.
A look at the logs told me that `systemd-oomd`_ was killing my Tmux_ server, and all my sessions and their windows with it---all my vim sessions, all of it.

This, of course, is far from ideal.
What's happening here is that one of the processes occupying a Tmux_ window consumes lots of CPU/memory and `systemd-oomd`_ needs to kill it.
However, `systemd-oomd`_ does not work on a per-process level.
It works on a cgroup level.
So, it kills the whole cgroup, taking the Tmux_ server down.

I've been looking at ways of preventing this from happening.
One option is to `disable systemd-oomd <https://fedoraproject.org/wiki/User:Tuju/Disable_systemd-oomd>`__ completely.
I think I've been fine before these OOM tools came along, but I do see the advantages of having them.
So I'd rather keep them around and configure them if possible.

The other, perhaps simpler, option is to somehow isolate each of my Tmux_ windows so that they're all killed independently without affecting each other.
I looked into this latter option first.
After some `discussion on Ask Fedora <https://ask.fedoraproject.org/t/how-would-one-create-new-tmux-servers-each-isolated-in-a-separate-slice-so-that-if-systemd-oomd-kills-one-the-other-tmux-servers-keep-living/27891/2>`__, I came up with a solution: run every Tmux_ window in isolation using `systemd-run`.

So, when we start a new Tmux_ session, we want to start our first window using `systemd-run`.
Easiest to do this using a bash function that one can put in their `~/.bashrc` file:

.. code:: bash

    # create new session, and ensure first window runs in a separate systemd
    # scope
    byobu-new-session ()
    {
        byobu new -s $1 systemd-run --user --scope bash
    }


Next, to open a new window in an existing session using `systemd-run`, we can use the `new window` Tmux_ command:

.. code:: bash

    new-window systemd-run --user --scope bash


This can be bound to a keyboard shortcut:

.. code:: bash

    bind-key c new-window systemd-run --user --scope bash


That's it.
Using `systemd-cgls` one can see that each new Tmux_ window starts in a new systemd scope.
To test that this now isolates each window, one can run something like `tail /dev/zero` to cause it to get killed by `systemd-oomd`_ while leaving other windows, sessions, and the server untouched.


This seems to be working very well for me.
If you have a better solution, do let me know, though.


Edit: a simpler way
====================

As it happens, there's a much easier way to do this.
Instead of modifying `~/.bashrc` and then re-binding the `new-window` key, all one needs to do is redefine the `default-command` parameter that Tmux_ uses so that it runs the `systemd-run` command:

.. code:: bash

    # in tmux.conf
    set-option -g default-command 'systemd-run --user --scope bash'


.. _Byobu: https://www.byobu.org/
.. _Tmux: https://github.com/tmux/tmux/wiki
.. _systemd-oomd: https://www.freedesktop.org/software/systemd/man/systemd-oomd.html
