Zaphod is now on PyPi as zaphodtex
##################################
:date: 2025-09-19 14:31:15
:modified: 2025-09-19 14:31:15
:author: ankur
:category: Research
:tags: LaTeX, Git, Fedora, Zaphod
:slug: zaphod-is-now-on-pypi-as-zaphodtex
:summary: Zaphod_ is now installable from PyPi as :code:`zaphodtex`

A quick announcement post.

I had written Zaphod_ several years ago.
It is a python wrapper around LaTeXdiff_ that enables a Git workflow for generating diffs in LaTeX_ documents.
A demonstration is in the initial `announcement post <{filename}/20160213-zaphod-a-latex-change-tracking-tool.rst>`__.
It lets you generate a diff, and it also lets you pick and choose what bits from the diff you want to incorporate.
It does all of this using Git, so no work is every lost, and everything can be undone (or redone).

I finally got around to publishing it on PyPi `as a package <https://pypi.org/project/zaphodtex>`__.
Unfortunately, the name, zaphod, was already taken, so I have published it as :code:`zaphodtex`.

So, you can now install it on your system directly using pip or uv:

.. code:: terminal

    uv pip install zaphodtex

It will also make it easier for people to use it in their projects, on GitHub Actions and so on.


.. _Zaphod: https://github.com/sanjayankur31/zaphod
.. _LaTeXdiff: https://github.com/ftilmann/latexdiff
.. _LaTeX: https://www.latex-project.org/
