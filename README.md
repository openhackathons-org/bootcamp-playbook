# Workshop Demos

Demos for the agentic AI workshop.

## Contents

### Nemotron notebooks

The `nemotron/` folder contains hands-on notebooks for using NVIDIA Nemotron models through NVIDIA's OpenAI-compatible API endpoint.

- `simple_usage_notebook.ipynb`: end-to-end starter notebook covering basic chat completions, reasoning on/off, a LangChain v1.0 research assistant, and a multi-agent supervisor pattern.
- `reasoning_controls_notebook.ipynb`: focused walkthrough for Nemotron reasoning controls, including `enable_thinking`, `reasoning_budget`, and `low_effort` comparisons.

## Setup

Install dependencies with `uv` from the checked-in `pyproject.toml`.

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
