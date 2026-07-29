# Workshop Demos

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Python](https://img.shields.io/badge/python-%3E%3D3.13-blue.svg)](https://www.python.org/downloads/)

Demos for the agentic AI workshop.

## Contents

See the [Deployment Guide](Deployment_Guide.md) to set up the environment.

### Notebooks

The `notebooks/` folder contains hands-on notebooks for NVIDIA Nemotron models, MCP tools, and NeMo Agent Toolkit workflows.

- `01_simple_usage_notebook.ipynb`: end-to-end starter notebook covering basic chat completions, reasoning on/off, a LangChain v1.0 research assistant, and a multi-agent supervisor pattern.
- `02_reasoning_controls_notebook.ipynb`: focused walkthrough for Nemotron reasoning controls, including `enable_thinking`, `reasoning_budget`, and `low_effort` comparisons.
- `03_movie_database_mcp.ipynb`: build and validate a high-level MCP server that exposes the movie SQLite database through a `search_movies` tool.
- `04_nemo_agent_toolkit.ipynb`: connect the movie MCP server to a Nemotron-powered ReAct agent and inspect workflow traces with Phoenix.
