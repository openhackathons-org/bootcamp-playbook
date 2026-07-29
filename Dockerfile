FROM python:3.13-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG CODE_SERVER_VERSION=4.112.0

ENV VIRTUAL_ENV=/opt/bootcamp-playbook-env \
    UV_PROJECT_ENVIRONMENT=/opt/bootcamp-playbook-env \
    PATH="/opt/bootcamp-playbook-env/bin:${PATH}" \
    UV_LINK_MODE=copy \
    JUPYTER_PLATFORM_DIRS=1 \
    NAT_TELEMETRY_ENABLED=false \
    PHOENIX_PORT=6006

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        build-essential \
        ca-certificates \
        curl \
        git \
        tini \
    && rm -rf /var/lib/apt/lists/*

RUN python -m venv "${VIRTUAL_ENV}" \
    && pip install --no-cache-dir --upgrade pip uv

WORKDIR /workspace/bootcamp-playbook

COPY pyproject.toml uv.lock ./
RUN uv sync --active --frozen --no-cache

RUN python -m ipykernel install \
    --sys-prefix \
    --name python3 \
    --display-name "Python 3.13 (bootcamp-playbook)"

RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version "${CODE_SERVER_VERSION}" \
    && code-server \
        --install-extension ms-python.python \
        --install-extension ms-toolsai.jupyter

EXPOSE 8888 6006 8000

ENTRYPOINT ["tini", "--"]
CMD ["code-server", "--bind-addr", "0.0.0.0:8888", "--auth", "none", "/workspace/bootcamp-playbook"]
