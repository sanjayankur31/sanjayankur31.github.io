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

Biophysically detailed models are hard to build
------------------------------------------------

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


In spite of NeuroML_ and other community developed tools, a bottle-neck remains.
In addition to the biology and biophysics, to build and run models, one also needs to know modelling/simulation and related software development practices.
This is a lot, presents quite a steep learning curve, and so, it makes modelling less accessible to researchers.

LLM based assistants provide a possible solution
-------------------------------------------------

LLMs based assistants provide a possible solution.
LLMs provide a way for people to interact with technology using natural language.
We are hoping to leverage LLMs in two ways.

RAG
====

A first way in which we can use LLMs to make NeuroML_ more accessible is to make it easier for people to query information about NeuroML_.

Given that LLMs have a tendency to hallucinate, the industry standard for using them for information retrieval is the `RAG <https://en.wikipedia.org/wiki/Retrieval-augmented_generation>`__ system.
In a RAG system, instead of the LLM answering a user query using its own "trained" data, where it can freely hallucinate, a curated set of information is searched for the answer.
The LLM is provided this information and asked to generate a response strictly based on it.

This improves the quality of the responses.
However, note RAGs can still generate errors.
Their responses are only as good as the information provided to them.
For NeuroML_ we have curated sources of information that can be used in the RAG:

- the documentation from https://docs.neuroml.org
- various publications
- other sources of information, such as well validated models from our `Open Source Brain platform <https://github.com/OpenSourceBrain>`__

I have spent the past couple of months creating a RAG for NeuroML_.
It lives `here on GitHub <https://github.com/NeuroML/neuroml-ai/tree/main/rag_pkg>`__ as a Python package and a test deployment is `here on HuggingFace <https://huggingface.co/spaces/NeuroML/NeuroML-AI>`__.
It works very well, so we consider it stable and ready for use.
Please feel free to use it and provide feedback on how we can improve it.

.. figure:: {static}/images/20260129-nml-rag-langgraph.png
    :width: 60 %
    :align: center
    :alt: A LangGraph for the NeuroML RAG implementation.
    :target: {static}/images/20260129-nml-rag-langgraph.png
    :class: text-center img-responsive pagination-centered

    A LangGraph for the NeuroML RAG implementation.


Note that we haven't dedicated too many resources to the HuggingFace instance, so it may trip over frequently.
To use it, consider using it locally on your system where you can use your own HuggingFace API key and pay for usage.
You can also use it locally using `Ollama <ollama.com>`__.

The package can be installed using :code:`pip`.
The RAG system is exposed via a REST API (using FastAPI), and a couple of simple clients provided---a cli, and a Streamlit web UI.


Model generation and simulation
=================================

Another way in which LLMs could accelerate modelling is by helping researchers build and simulate the models.
Unfortunately, LLMs don't do very well when generating NeuroML_ code.
They tend to mix up lots of different libraries with NeuroML_ in my testing.
This could be because there isn't so much NeuroML_ Python code out there for LLMs to "learn" from during their training.

One option is for us to fine tune a model with NeuroML_ examples, but this is quite an undertaking.
We currently don't have access to the infrastructure required to do this, and if we do manage to get it, we will still need to generate NeuroML_ data for the fine-tuning.
Finally, we will have to publish/host/deploy the model for the community to use.


An alternative, with `function/tool calls <https://platform.openai.com/docs/guides/function-calling>`__ becoming the norm in LLMs, is to set up a LLM based agentic code generation workflow.

Unlike a free flowing general-purpose programming language like Python (where LLMs are getting better every day already), NeuroML has a formally defined schema which models can be validated against.
Each model component fits in at a particular place, and each parameter is very well defined in terms of its units and significance.
NeuroML_ provides multiple levels of validation that provide the user with specific, detailed error feedback when a model component is found to be invalid.
Further, the NeuroML_ libraries already include functions to validate models, read and write them, and to simulate them using different simulation engines.

These features lend themselves nicely to a workflow where we use LLMs to iteratively generate and validate small snippets of NeuroML_ code.
This is currently a work in progress in a separate `package <https://github.com/NeuroML/neuroml-ai/tree/main/code_ai_pkg>`__.



.. _NeuroML: https://docs.neuroml.org
