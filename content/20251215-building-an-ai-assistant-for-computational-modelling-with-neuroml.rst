Building an AI assistant for computational modelling with NeuroML
#################################################################
:date: 2026-01-29 13:08:21
:modified: 2026-01-29 13:08:21
:author: ankur
:category: Tech
:tags: LLM, RAG, NeuroML, Neuroscience, Computational neuroscience, Computational modelling, LangChain, LangGraph, Agentic AI, Tools, MCP, Ollama, Python
:slug: building-an-ai-assistant-for-computational-modelling-with-neuroml
:status: draft
:summary: A progress report on building an LLM/AI assistant for computational modelling in neuroscience with NeuroML_.

Problem: Biophysically detailed models are hard to build
---------------------------------------------------------

While experiments remain the primary method by which we neuroscientists gather information on the brain, we still rely heavily on theory and models to unify the different observations from experiments into coherent theories.
In models, unlike experiments, we can generally modify all components, test out parameter sets, and record/observe every element of the model.

Computational models of the brain can be built with different levels of detail and this depends on the research hypothesis/question being investigated.
Biologically detailed models, where we include all the biological mechanisms that we know of---detailed neurons with their ionic conductances and so on---are important when want to understand the mechanisms underlying different emergent behaviours.

.. figure:: {static}/images/neuroml-logo.png
    :width: 40 %
    :align: center
    :alt: NeuroML is a standard and software ecosystem for biophysically detailed neuronal modelling.
    :target: #
    :class: text-center img-responsive pagination-centered

    NeuroML_ is a standard and software ecosystem for biophysically detailed neuronal modelling.

These detailed models are complex and difficult to build.
NeuroML_, a standard and software ecosystem for computational modelling in Neuroscience, aims to help by making models easier to work with.
The standard provides ready-to-use model components and models can be validated before they are simulated.
NeuroML_ is also simulator independent, which allows researchers to create a model and run it using different simulation software.


All of this is great, but a bottle neck remains.
To build and run a model, one needs to know lots of technical bits.
One effectively needs to know the biology, the biophysics, and one needs to also know the simulation and related software development and related best practices.
Even though NeuroML_ uses standard neuroscience terms to make sure it's speaking the same language as experimentalists, working with models requires lots of specialist knowledge, knowledge that most people do not have the time to gain.

Possible solution: LLM based agentic assistants
------------------------------------------------

This is where LLMs come in as a possible solution.
LLMs provide a way for people to interact with technology using natural language.
Since LLMs use semantic similarity ("meaning"), they are also able to "understand" different specific jargon, for example scientific jargon.

Finally, as LLMs improve and their e, we can now use LLMs to control other tools.


.. _NeuroML: https://docs.neuroml.org
