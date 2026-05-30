# mineru-build

Docker-only repository for building and publishing a MinerU image, following the MinerU Docker deployment quick start:
https://opendatalab.github.io/MinerU/quick_start/docker_deployment/

## Files in this repository

- `Dockerfile` (based on MinerU's recommended global Dockerfile)
- `.github/workflows/docker-publish.yml` (builds and publishes to GHCR)
- `README.md`

## Build locally

```bash
docker build -t mineru:latest -f Dockerfile .
```

## Run locally

```bash
docker run --gpus all \
  --shm-size 32g \
  -p 30000:30000 -p 7860:7860 -p 8000:8000 -p 8002:8002 \
  --ipc=host \
  -it mineru:latest \
  /bin/bash
```

## Publish to GHCR with GitHub Actions

The workflow publishes images to:

- `ghcr.io/<owner>/<repo>:latest` on pushes to `main`
- `ghcr.io/<owner>/<repo>:<git-tag>` on version tags like `v1.0.0`

Container package visibility and permissions are managed in GitHub settings.
