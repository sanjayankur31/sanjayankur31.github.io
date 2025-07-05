Splitting Taskwarrior tasks to sub-tasks
########################################
:date: 2025-07-05 13:11:35
:modified: 2025-07-05 13:11:35
:author: ankur
:category: Tech
:tags: Taskwarrior, Productivity, Python
:slug: splitting-taskwarrior-tasks-to-sub-tasks
:summary: A quick script to split Taskwarrior tasks in to sub-tasks.


.. raw:: html

    <center>

.. image:: {static}/images/20250705-tw.png
    :alt: Logo for Taskwarrior
    :target: https://taskwarrior.org
    :scale: 50%
    :height: 300px

.. raw:: html

    </center>


A feature that I often miss in Taskwarrior_ (which I use for managing my tasks in a `Getting Things Done <https://en.wikipedia.org/wiki/Getting_Things_Done>`__ method) is the ability to split tasks into sub-tasks.

A common use case, for example, is when I add a research paper that I want to read to my task list.
It's usually added as "Read <title of research paper>", with the URL or the file path as an annotation.
However, when I do get down to read it, I want to break it down into smaller, manageable tasks that I can do over a few days such as "Read introduction", "Read results".
This applies for lots of other tasks too, which turn into projects with sub-tasks when I finally do get down to working on them.

The way to do it is to create new tasks for each of these, and then replace the original task with them.
It is also a workflow that cab be easily scripted so that one doesn't have to manually create the tasks and copy over annotations and so on.

Here is a script I wrote:

.. code:: python


    #!/usr/bin/env python3
    """
    Split a taskwarrior task into sub-tasks

    File: task-split.py

    Copyright 2025 Ankur Sinha
    Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
    """


    import typing
    import typer
    import subprocess
    import json


    import logging


    logging.basicConfig(level=logging.NOTSET)
    logger = logging.getLogger("task-split")
    logger.setLevel(logging.INFO)
    logger.propagate = False

    formatter = logging.Formatter("%(name)s (%(levelname)s): %(message)s")
    handler = logging.StreamHandler()
    handler.setLevel(logging.INFO)
    handler.setFormatter(formatter)

    logger.addHandler(handler)


    def split(src_task: int, new_project: str, sub_tasks: typing.List[str],
              dry_run: bool = True) -> None:
        """Split task into new sub-tasks

        For each provided sub_tasks string, a new task is created using the string
        as description in the provided new_project. Annotations from the provided
        src_task are copied over and the src_task is removed.

        If dry_run is enabled (default), the src_task will be obtained but not
        processed.

        :param src_task: id of task to split
        :type src_task: int
        :param sub_tasks: list of sub-tasks to create
        :type sub_tasks: list(str)
        :returns: None

        """
        # Always get info on the task
        get_task_command = f"task {src_task} export"
        logger.info(get_task_command)
        ret = subprocess.run(get_task_command.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        if ret.returncode == 0:
            task_stdout = ret.stdout.decode(encoding="utf-8")
            task_json = (json.loads(task_stdout)[0])
            logger.info(task_json)
            tags = task_json.get('tags', [])
            priority = task_json.get('priority')
            due = task_json.get('due')
            estimate = task_json.get('estimate')
            impact = task_json.get('impact')
            annotations = task_json.get('annotations', [])
            description = task_json.get('description')
            uuid = task_json.get('uuid')

            for sub_task in sub_tasks:
                new_task_command = f"task add project:{new_project} tags:{','.join(tags)} priority:{priority} due:{due} impact:{impact} estimate:{estimate} '{sub_task}'"
                logger.info(new_task_command)
                if not dry_run:
                    ret = subprocess.run(new_task_command.split())
                    if dry_run or ret.returncode:
                        annotate_task_command = f"task +LATEST annotate '{description}'"
                        logger.info(annotate_task_command)
                        if not dry_run:
                            ret = subprocess.run(annotate_task_command.split())
                            for annotation in annotations:
                                annotation_description = annotation['description']
                                annotate_task_command = f"task +LATEST annotate '{annotation_description}'"
                                logger.info(annotate_task_command)
                                if not dry_run:
                                    ret = subprocess.run(annotate_task_command.split())

            mark_original_as_done_command = f"task uuid:{uuid} done"
            logger.info(mark_original_as_done_command)
            if not dry_run:
                ret = subprocess.run(mark_original_as_done_command.split())


    if __name__ == "__main__":
        typer.run(split)


It uses `typer <https://typer.tiangolo.com/>`__ to provide command line features:

.. code:: bash

    task-split --help

    Usage: task-split [OPTIONS] SRC_TASK NEW_PROJECT SUB_TASKS...

    Split task into new sub-tasks

    Arguments
    *    src_task         INTEGER       [default: None]
    *    new_project      TEXT          [default: None]
    *    sub_tasks        SUB_TASKS...  [default: None]

    Options
    --dry-run    --no-dry-run      [default: dry-run]
    --help                         Show this message and exit.


So, if one has a task "Put up shelves" with ID 800, it can now be broken into a number of smaller tasks:

.. code:: bash

    task-split 800 "personal.shelves" "Buy shelves" "Buy drill" "Buy tools"


This will add the new tasks to the "personal.shelves" topic, and copy over meta-data from the original task, such as annotations, priority, due date and other user defined attributes.
It runs in "dry-run" mode by default to give me a chance to double-check the commands/tasks.
To carry out the operations, pass the :code:`--no-dry-run` flag to the script too.

The script is heavily based on my personal workflow, but can easily be tweaked.
It lives `here on GitHub <https://github.com/sanjayankur31/100_dotfiles/blob/main/bin/task-split>`__ and you are welcome to modify it to suit your own workflow.

Please remember to make it executable and put it in your PATH to be able to run the command on your terminal, and do remember to install typer.
On Fedora, this would be :code:`sudo dnf install python3-typer`.


.. _Taskwarrior: https://taskwarrior.org/
