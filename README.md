# Bootcamp Playbook

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Python](https://img.shields.io/badge/python-%3E%3D3.13-blue.svg)](https://www.python.org/downloads/)

This repository contains the hands-on content for the Agentic AI Bootcamp. The
playbook takes participants from NVIDIA Nemotron inference and reasoning
controls to an MCP-backed movie tool and a NeMo Agent Toolkit workflow, with
Phoenix used to inspect the workflow and function spans that NAT exports.

## What You Will Learn

By completing the playbook, you will learn how to:

- call NVIDIA Nemotron through an OpenAI-compatible API and compare thinking
  on, thinking off, bounded reasoning, and low-effort reasoning;
- query a SQLite movie database and expose it as a reusable Model Context
  Protocol (MCP) tool with FastMCP;
- discover and invoke MCP tools from the NeMo Agent Toolkit command-line
  interface;
- connect an MCP tool to a Nemotron-powered ReAct agent using a YAML-defined
  NeMo Agent Toolkit workflow; and
- export NAT telemetry to Phoenix, inspect workflow and function spans, and
  identify which operations require additional instrumentation.

## Contents

See the [Deployment Guide](Deployment_Guide.md) to set up the environment.

### Notebooks

The `notebooks/` folder contains three hands-on notebooks for NVIDIA Nemotron models, MCP tools, and NeMo Agent Toolkit workflows.

- `01_reasoning_controls_notebook.ipynb`: compare Nemotron thinking on and off, tune the reasoning budget, and explore low-effort reasoning.
- `02_movie_database_mcp.ipynb`: build and validate a high-level MCP server that exposes the movie SQLite database through a `search_movies` tool.
- `03_nemo_agent_toolkit.ipynb`: connect the movie MCP server to a Nemotron-powered ReAct agent and inspect the workflow and function spans exported to Phoenix.
