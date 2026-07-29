# Deployment Guide

Complete the environment setup in the [README](README.md) first.

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
