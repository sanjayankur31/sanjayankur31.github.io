Building an AI assistant for computational modelling with NeuroML
#################################################################
:date: 2026-01-08 16:25:49
:modified: 2026-01-08 16:25:49
:author: ankur
:category: Tech
:tags: LLM, RAG, NeuroML, Neuroscience, Computational neuroscience, Computational modelling, LangChain, LangGraph, Agentic AI, Tools, MCP, Ollama, Python
:slug: building-an-ai-assistant-for-computational-modelling-with-neuroml
:status: draft
:summary: A progress report on building an LLM/AI assistant for computational modelling in neuroscience with NeuroML_.


.. figure:: {static}/images/neuroml-logo.png
    :width: 40 %
    :align: center
    :alt: NeuroML is a standard and software ecosystem for biophysically detailed neuronal modelling.
    :target: {static}/images/neuroml-logo.png
    :class: text-center img-responsive pagination-centered

    NeuroML_ is a standard and software ecosystem for biophysically detailed neuronal modelling.


The problem statement
----------------------

..
    While experiments remain the main method by which we neuroscientists gather information on the brain, experiments tend to be quite focussed on individual, well defined, controlled behaviours or tasks.
    This is because given the complexity of the brain, we need to be able to clearly connect features of the behaviour/task to the neuronal activity.
    If there are multiple things happening in the task and we cannot clearly say which of them are being represented in our experimental data, we can't really make a statement about either the task or the data.
    We're developing new techniques all the time.
    We can record from many neurons all at once now using things like NeuroPixels_ probes, and there are new analysis/statistical techniques to distil observations and theories from the data.

While experiments remain the main method by which we neuroscientists gather information on the brain, we still rely heavily on theory and models to unify the different observations that we obtain from experiments into coherent theories of how the brain processes information.
In models, generally unlike experiments, we can modify every component of the model, we can test out large parameter sets, and we can observe every element of the model.

Computational models of the brain can be built at different levels.
The level of detail included in a model depends on the research hypothesis/question it is intended to answer.
Biologically detailed models, where we try to include all the biological mechanisms that we know of---detailed neurons with their ionic conductances and so on---are important for cases where we want to understand the mechanisms underlying different behaviours.
For example, we want to understand how increasing the concentration of an ion, say Sodium, affects a neuron and the network that it is part of.
For this, we need to model the ion's dynamics in detail.

These detailed models are not easy to build, though.
They are quite complex, have many parameters, and require a large amount of resources to run.
NeuroML_, a standard and software ecosystem for computational modelling in Neuroscience, aims to help by making models easier to work with.
The standard provides ready-to-use model components, can be validated---so that one knows immediately if they've connected two model components that are not meant to be connected, for example.
NeuroML_ is also simulator independent, which allows us to create a model and run it using different simulation software.


All of this is great, but there's still a bottle neck.
To build and run a model, one needs to know lots of technical bits---lots of software development and related best practices, lots of details about simulations.
Even though NeuroML_ uses standard neuroscience terms to make sure it's speaking the same language as experimentalists, working with models requires lots of specialist knowledge, knowledge that most people do not have the time to gain.


This is where LLMs come in.
With new LLM based methods, we now have the possibility of making modelling more accessible.



.. _NeuroML: https://docs.neuroml.org
