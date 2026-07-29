# Deployment Guide

This guide sets up the Agentic AI bootcamp workspace with Python, Jupyter, and
code-server.

## Prerequisites

Install the following tools before continuing:

- Python 3.11 or later
- [uv](https://docs.astral.sh/uv/)
- `curl`

Clone the repository and open its directory:

```bash
git clone <repository-url>
cd bootcamp-playbook
```

## Set Up the Python Environment

Create and activate a virtual environment, then install the project
dependencies:

```bash
uv venv venv
source venv/bin/activate
uv sync --active
```

Set the NVIDIA API key:

```bash
export NVIDIA_API_KEY="your-api-key"
```

Optionally override the model used by the reasoning controls notebook:

```bash
export NEMOTRON_MODEL="nvidia/nemotron-3-super-120b-a12b"
```

## Install code-server

Install code-server:

```bash
curl -fsSL https://code-server.dev/install.sh | sh
```

Install the Python and Jupyter extensions:

```bash
code-server \
  --install-extension ms-python.python \
  --install-extension ms-toolsai.jupyter
```

## Configure the Workspace

The checked-in `.vscode/settings.json` configures code-server to:

- Use `${workspaceFolder}/venv/bin/python` as the Python interpreter.
- Open integrated terminals in the repository root.
- Exclude system Python installations from the Jupyter kernel list.
- Disable editor AI features.

If you use uv's default `.venv` directory instead, update
`python.defaultInterpreterPath` in `.vscode/settings.json`:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python"
}
```

## Start code-server

From the repository root, run:

```bash
code-server --auth none --port 8888
```

Open `http://localhost:8888` in a browser.

> **Security:** `--auth none` disables authentication. Use it only in a trusted
> local environment. Enable authentication or place code-server behind a
> secured proxy before exposing it to a network.

## Run the Notebooks

You can open and run the notebooks directly through the Jupyter extension in
code-server. Select the interpreter at `venv/bin/python` when prompted.

Alternatively, start the standalone Jupyter server:

```bash
uv run --active jupyter notebook
```

Run the workshop notebooks in this order:

1. `nemotron/simple_usage_notebook.ipynb`
2. `nemotron/reasoning_controls_notebook.ipynb`

## Verify the Setup

Confirm that Python uses the virtual environment:

```bash
python -c "import sys; print(sys.executable)"
```

The printed path should end in `bootcamp-playbook/venv/bin/python`.

Confirm that code-server and its extensions are available:

```bash
code-server --version
code-server --list-extensions
```

The extension list should include:

```text
ms-python.python
ms-toolsai.jupyter
```
