# Deployment Guide

## Set up the environment

From the repository root, create and activate the virtual environment:

```bash
uv venv venv
source venv/bin/activate
uv sync --active
```

Set your NVIDIA API key:

```bash
export NVIDIA_API_KEY="your-api-key"
```

Optional model override for the reasoning controls notebook:

```bash
export NEMOTRON_MODEL="nvidia/nemotron-3-super-120b-a12b"
```

## Install code-server

```bash
curl -fsSL https://code-server.dev/install.sh | sh
```

Install the Python and Jupyter extensions:

```bash
code-server \
  --install-extension ms-python.python \
  --install-extension ms-toolsai.jupyter
```

## Start code-server

From the repository root, run:

```bash
code-server --auth none --port 8888
```

Open [http://localhost:8888](http://localhost:8888) in your browser and select
`venv/bin/python` as the notebook kernel.

> `--auth none` disables authentication. Use it only in a trusted environment.
