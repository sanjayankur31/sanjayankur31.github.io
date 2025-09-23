A Cookiecutter template to quickstart NeuroML modelling projects
################################################################
:date: 2025-09-23 10:44:04
:modified: 2025-09-23 10:44:04
:author: ankur
:category: Research
:tags: NeuroML, Cookiecutter, Neuroscience, Computational Neuroscience, Pre-commit, Python, libNeuroML, PyNeuroML, GitHub, Git
:slug: a-cookiecutter-template-to-quickstart-neuroml-modelling-projects
:summary: I created a Cookiecutter_ project template that incorporates recommended modelling and coding practices to accelerate setting up a NeuroML_ modelling project.

.. raw:: html

    <center>

.. image:: {static}/images/20250923-neuroml-cookiecutter.png
    :alt: Cookiecutter and NeuroML project logos
    :target: #
    :scale: 60%
    :height: 300px

.. raw:: html

    </center>



Creating new modelling projects, like other programming projects, include a number of repeated steps.
When using the NeuroML_ standard, one would use the `libNeuroML API`_ to:

- create a new NeuroMLDocument (top level container class that includes all NeuroML components)
- create a network
- create populations
- add cells
- add connections
- add stimuli
- record various quantities (membrane potentials, for example)
- create a LEMS_ simulation

One also needs to, among other steps, at least:

- install the NeuroML python packages: pyNeuroML_ pulls in most of them
- select the simulation engine, and install the pyNeuroML_ extra to pull that in

This is sufficient to create and simulate a model.
Most people would tend to stop here, because this is really all they need to run their simulations and carry out their research.
This is fine, but it misses out on recommended/best practices which make the modelling project:

- easier to manage and collaborate on
- ready for sharing/reuse from the beginning (instead of people "cleaning up" their code in a panic when they need to share it as part of a publication)

So, for NeuroML_ projects, I created a Cookiecutter_ template that generates all of this boilerplate code, and implements a number of general and NeuroML_ related best practices:

- adds a license
- creates a clean directory structure that separates code from data, model code from analysis code, and model/simulation parameters from the model generation logic
- creates a template Python script to create and simulate the model
- adds Typer_ based command line support in the script
- sets up the project as a Git repository
- adds requirements.txt files, linters, pre-commit hooks, and so on---things that we commonly use in software development
- adds continuous validation of the model using the `OSB Model Validation framework`_ as a GitHub Action (model validation is another strength of NeuroML_)
- enables the use of `git-annex`_ to manage data in a separate repository


Here is what the directory structure looks like.
The :code:`{{ cookiecutter.__project_slug }}` and similar bits get renamed by Cookiecutter_ to create the required files/folders:

.. code:: bash

    $ tree -a \{\{\ cookiecutter.__project_slug\ \}\}/
    {{ cookiecutter.__project_slug }}/
    ├-- code
    |   ├-- analysis
    |   |   └-- Readme.md
    |   ├-- .flake8
    |   ├-- model
    |   |   ├-- cells
    |   |   |   └-- .test.validate.omt
    |   |   ├-- {{ cookiecutter.__project_slug_nospace }}.py
    |   |   ├-- inputs
    |   |   |   └-- .test.validate.omt
    |   |   ├-- parameters
    |   |   |   ├-- general.json
    |   |   |   └-- model.json
    |   |   ├-- Readme.md
    |   |   └-- synapses
    |   |       └-- .test.validate.omt
    |   ├-- .pre-commit-config.yaml
    |   ├-- requirements-dev.txt
    |   └-- requirements.txt
    ├-- data
    |   └-- Readme.md
    ├-- .github
    |   └-- workflows
    |       └-- omv-ci.yml
    ├-- LICENSE
    └-- Readme.md


Here is a video that illustrates creation of an example project using the template.
One can install Cookiecutter_ in a virtual environment using :code:`pip` or :code:`uv` from PyPi, and run this command to get the template and interactively create a new project:

.. code:: bash

    $ cookiecutter gh:sanjayankur31/neuroml-model-template



.. raw:: html

    <iframe width="560" height="315" src="https://www.youtube.com/embed/8t1S4M0T_HY" frameborder="0" allowfullscreen>
    </iframe>


I am using the template myself, so I have tested the template, and there is CI in the repository to make sure it functions correctly with the default set up.
I expect it will evolve further as others use it and provide more ideas/feedback on additional features that may be useful to include.

So, please, give it a go, and let me know what you think.


.. _git-annex: https://git-annex.branchable.com/
.. _NeuroML: https://docs.neuroml.org
.. _Cookiecutter: https://cookiecutter.readthedocs.io/en/stable/
.. _libNeuroML API: https://libneuroml.readthedocs.io/en/development/userdocs/
.. _pyNeuroML: https://docs.neuroml.org/Userdocs/Software/pyNeuroML.html
.. _LEMS: https://docs.neuroml.org/Userdocs/NeuroMLv2AndLEMS.html
.. _OSB Model Validation framework: https://github.com/OpenSourceBrain/osb-model-validation
.. _Typer: https://typer.tiangolo.com/
