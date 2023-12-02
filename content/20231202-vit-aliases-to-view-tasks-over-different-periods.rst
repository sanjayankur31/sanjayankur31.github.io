Vit aliases to view tasks over different periods
################################################
:date: 2023-12-02 18:11:47
:modified: 2023-12-02 18:11:47
:author: ankur
:category: Tech
:tags: Vit, taskwarrior, time-management, task-management, Fedora
:slug: vit-aliases-to-view-tasks-over-different-periods
:summary: A few Vit aliases I use to get an overview of my tasks over different periods of time

I use Vit_ as a terminal interface to view my Taskwarrior_ tasks.
In a terminal, that's just running the :code:`vit` command.
Sometimes, one doesn't want to look at the full list, though.
I usually have a few "views" of my tasks which give me a better idea of my work load.
I add them to my :code:`~/.bashrc` so they're available as commands.
Here they are.
They're very simple, and should be modified to suit one's workflow:

.. code:: bash

    # filters common to all functions
    TASK_FILTERS=""
    # all tasks
    vit-tl ()
    {
        vit ${TASK_FILTERS}
    }
    # tasks due before the end of the day
    vit-tl-today () {
        vit ${TASK_FILTERS} 'due.by:eod'
    }
    # tasks due before the end of the week
    vit-tl-this-week () {
        vit ${TASK_FILTERS} 'due.by:eow'
    }
    # tasks due before the end of the month
    vit-tl-this-month () {
        vit ${TASK_FILTERS} 'due.by:eom'
    }
    # tasks due in a week
    vit-tl-in-a-week () {
        vit ${TASK_FILTERS} 'due.by:1w'
    }
    # tasks due in a month
    vit-tl-in-a-month () {
        vit ${TASK_FILTERS} 'due.by:1m'
    }
    # tasks due in six months
    vit-tl-in-six-months () {
        vit ${TASK_FILTERS} 'due.by:6m'
    }
    # tasks due in a year
    vit-tl-in-a-year () {
        vit ${TASK_FILTERS} 'due.by:1y'
    }
    # next N tasks (2 by default)
    vit-next () {
        echo "Active tasks:"
        echo
        task active
        echo
        echo
        echo "Next ${1:-2} tasks:"
        echo
        task ${TASK_FILTERS} limit:"${1:-2}"
        echo
        echo
    }



.. _Vit: https://github.com/vit-project/vit
.. _Taskwarrior: https://taskwarrior.org/
