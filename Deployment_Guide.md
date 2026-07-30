# Deployment Guide

This playbook supports two ways to run the labs:

1. **Local setup:** create a Python environment and run `code-server` on the
   host.
2. **Docker Compose:** run Python, the locked dependencies, and `code-server`
   in a container.

Both options require:

- [Git](https://github.com/git-guides/install-git)
- An NVIDIA API key
- Ports `8888` (code-server) and `6006` (Phoenix) available on the host

## Option 1: Local setup

### Prerequisites

- [uv](https://docs.astral.sh/uv/getting-started/installation/)
- Python 3.13
- Port `8000` available when a lab starts a local HTTP service

### 1. Create the Python environment

From the repository root, run:

```bash
uv venv --python 3.13 venv
source venv/bin/activate
uv sync --active --frozen
```

The project requires Python 3.13. If it is not installed, install it with:

```bash
uv python install 3.13
```

### 2. Configure the environment

Load the shared, non-secret notebook settings into the same terminal that will
start `code-server`:

```bash
set -a
source .vscode/notebook.env
set +a
```

This exports settings such as `MCP_PORT=8000` and
`NAT_TELEMETRY_ENABLED=false` so they are inherited by code-server, notebook
kernels, and subprocesses launched by the notebooks.

Set your NVIDIA API key separately. Do not add secrets to
`.vscode/notebook.env`, because that file is committed to the repository:

```bash
export NVIDIA_API_KEY="your-api-key"
```

The reasoning notebook uses the following model by default. Override it only
when you need a different compatible model:

```bash
export NEMOTRON_MODEL="nvidia/nemotron-3-super-120b-a12b"
```

### 3. Install code-server

```bash
curl -fsSL https://code-server.dev/install.sh | sh
```

Install the Python and Jupyter extensions:

```bash
code-server \
  --install-extension ms-python.python \
  --install-extension ms-toolsai.jupyter
```

Messages saying an extension is already installed are informational and can be
ignored.

### 4. Start code-server

From the same terminal where you activated the environment, sourced
`.vscode/notebook.env`, and exported `NVIDIA_API_KEY`, run:

```bash
code-server --auth none --port 8888 "$PWD"
```

`"$PWD"` passes the absolute path of the current directory, forcing
code-server to open this repository instead of restoring a workspace from an
earlier session.

Open [http://localhost:8888](http://localhost:8888), navigate to `notebooks/`,
and select the interpreter at `venv/bin/python` if prompted.

Stop code-server with `Ctrl+C`.

> `--auth none` disables authentication. The command is intended for a trusted
> local machine. Do not expose port `8888` to an untrusted network.

## Option 2: Docker Compose

Docker Compose provides the most reproducible setup. The image contains Python
3.13, the dependencies locked in `uv.lock`, code-server, and the Python and
Jupyter extensions. A local GPU is not required when the notebooks call a
remote NVIDIA NIM endpoint.

### Prerequisites

- [Docker Engine](https://docs.docker.com/engine/install/) 24 or newer
- The [Docker Compose plugin](https://docs.docker.com/compose/install/)
- Approximately 6 GB of free disk space

Confirm that Docker is available:

```bash
docker version
docker compose version
```

### 1. Configure the environment

Export your NVIDIA API key before starting Compose:

```bash
export NVIDIA_API_KEY="your-api-key"
```

You may also override the default model:

```bash
export NEMOTRON_MODEL="nvidia/nemotron-3-super-120b-a12b"
```

Compose automatically loads the non-secret container settings in
`.vscode/notebook.env`; you do not need to source that file for the Docker
workflow. Keep secrets such as `NVIDIA_API_KEY` out of the committed file.

### 2. Build and start the environment

From the repository root, run:

```bash
docker compose up --build -d
```

Verify that the service is running:

```bash
docker compose ps
docker compose logs --tail=50 bootcamp-playbook
```

The first build installs the locked Python dependencies and downloads
code-server. Later builds reuse Docker's cache unless the dependency files or
Dockerfile change.

### 3. Open the labs

Open [http://localhost:8888](http://localhost:8888). code-server opens
`/workspace/bootcamp-playbook` automatically. Navigate to `notebooks/` and
start with `01_reasoning_controls_notebook.ipynb`.

The container uses:

| Purpose | Address or path |
| --- | --- |
| code-server | `http://localhost:8888` |
| Phoenix | `http://localhost:6006` |
| Workspace | `/workspace/bootcamp-playbook` |
| Python interpreter | `/opt/bootcamp-playbook-env/bin/python` |

Port `8000` is available inside the container but is not published to the
host. This avoids conflicts with services already using host port `8000`.

The repository is bind-mounted into the container, so source and notebook
changes appear immediately. Rebuild the image after changing `pyproject.toml`,
`uv.lock`, or the Dockerfile:

```bash
docker compose up --build -d
```

### 4. Stop the environment

```bash
docker compose down
```

To also remove the locally built image:

```bash
docker compose down --rmi local
```

## Troubleshooting

### Port already in use

If port `8888` or `6006` is occupied, stop the process using it or change the
host side of the relevant mapping in `docker-compose.yml`. For example:

```yaml
ports:
  - "127.0.0.1:9000:8888"
```

Then open `http://localhost:9000`.

### NVIDIA API key is missing

Export the key and recreate the container so Compose passes the new value:

```bash
export NVIDIA_API_KEY="your-api-key"
docker compose up -d
```

Check whether the variable is present without printing its value:

```bash
docker compose exec bootcamp-playbook sh -lc \
  'test -n "$NVIDIA_API_KEY" && echo "NVIDIA_API_KEY is set" || echo "NVIDIA_API_KEY is missing"'
```

### A NIM endpoint is running on the host

Inside a container, `localhost` refers to the container itself. When a notebook
must call a NIM endpoint running on the host, use
`host.docker.internal` instead of `localhost` in the endpoint URL.

### code-server opens the wrong folder

For the local setup, stop code-server and restart it from the repository root
with:

```bash
code-server --auth none --port 8888 "$PWD"
```

For Docker Compose, the browser should redirect to:

```text
/?folder=/workspace/bootcamp-playbook
```

### View container logs

```bash
docker compose logs -f bootcamp-playbook
```
