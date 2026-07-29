# Workshop Demos

Demos for the agentic AI workshop.

## Contents

### Nemotron notebooks

The `nemotron/` folder contains hands-on notebooks for using NVIDIA Nemotron models through NVIDIA's OpenAI-compatible API endpoint.

- `simple_usage_notebook.ipynb`: end-to-end starter notebook covering basic chat completions, reasoning on/off, a LangChain v1.0 research assistant, and a multi-agent supervisor pattern.
- `reasoning_controls_notebook.ipynb`: focused walkthrough for Nemotron reasoning controls, including `enable_thinking`, `reasoning_budget`, and `low_effort` comparisons.

## Setup

Install dependencies with `uv` from the checked-in `pyproject.toml`.
For complete environment and code-server instructions, see the
[Deployment Guide](Deployment_Guide.md).

```bash
uv venv venv
source venv/bin/activate
uv sync --active
export NVIDIA_API_KEY="your-api-key"
```

If you prefer uv's default project environment, let `uv sync` create `.venv`:

```bash
uv sync
source .venv/bin/activate
export NVIDIA_API_KEY="your-api-key"
```

Optional model override for the reasoning controls notebook:

```bash
export NEMOTRON_MODEL="nvidia/nemotron-3-super-120b-a12b"
```

### Code Server

Install code-server and the Python and Jupyter extensions:

```bash
curl -fsSL https://code-server.dev/install.sh | sh
code-server --install-extension ms-python.python --install-extension ms-toolsai.jupyter
```

Start code-server without authentication on port 8888:

```bash
code-server --auth none --port 8888
```

The checked-in `.vscode/settings.json` selects the `venv` environment created
above and uses the repository root as the integrated terminal's working
directory. If you use uv's default `.venv` instead, change
`python.defaultInterpreterPath` to `${workspaceFolder}/.venv/bin/python`.

## Running The Demos

Start Jupyter from the repository root. If you are using the active `venv` setup:

```bash
uv run --active jupyter notebook
```

If you used uv's default `.venv` project environment:

```bash
uv run jupyter notebook
```

Recommended order:

1. Run `nemotron/simple_usage_notebook.ipynb` to introduce the endpoint, reasoning modes, LangChain, and multi-agent concepts.
2. Run `nemotron/reasoning_controls_notebook.ipynb` when you want a deeper workshop segment on reasoning configuration and tradeoffs.

## Notes

- The notebooks prompt for `NVIDIA_API_KEY` if it is not already set.
- The LangChain examples use DuckDuckGo search, which does not require a separate search API key.
- Notebook outputs are intentionally cleared so participants can run the demos live.
