# Deployment Guide

## 1. Clone the Repository

```bash
git clone https://github.com/openhackathons-org/bootcamp-playbook
cd bootcamp-playbook
```

## 2. Set Up the Python Environment

Create and activate a virtual environment:

```bash
uv venv venv
source venv/bin/activate
```

Install the project dependencies:

```bash
uv sync --active
```

Set your NVIDIA API key:

```bash
export NVIDIA_API_KEY="your-api-key"
```

## 3. Install code-server

```bash
curl -fsSL https://code-server.dev/install.sh | sh
```

Install the Python and Jupyter extensions:

```bash
code-server \
  --install-extension ms-python.python \
  --install-extension ms-toolsai.jupyter
```

## 4. Start code-server

From the repository root, run:

```bash
code-server --auth none --port 8888
```

Open [http://localhost:8888](http://localhost:8888) in your browser and select
`venv/bin/python` as the notebook kernel.

> `--auth none` disables authentication. Use it only in a trusted environment.
