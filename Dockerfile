# Use the official vllm image for gpu with Volta, Turing, Ampere, Ada Lovelace, Hopper, Blackwell architecture (7.0 <= Compute Capability <= 12.1)
# The default base image uses vLLM 0.21.0. For CUDA 12.9 environments, build with --build-arg VLLM_IMAGE=vllm/vllm-openai:v0.21.0-cu129.
# Compute Capability version query (https://developer.nvidia.com/cuda-gpus)
# Support x86_64 architecture
ARG VLLM_IMAGE=vllm/vllm-openai:v0.21.0
FROM ${VLLM_IMAGE}

# Install libgl for opencv support & Noto fonts for Chinese characters
RUN apt-get update && \
    apt-get install -y \
        fonts-noto-core \
        fonts-noto-cjk \
        fontconfig \
        libgl1 && \
    fc-cache -fv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install mineru latest
RUN python3 -m pip install -U 'mineru[core]>=3.2.1' --break-system-packages && \
    python3 -m pip cache purge

# Download models and update the configuration file
RUN /bin/bash -c "mineru-models-download -s huggingface -m all"

# Set the entry point to activate the virtual environment and run the command line tool
ENTRYPOINT ["/bin/bash", "-c", "export MINERU_MODEL_SOURCE=local && exec \"$@\"", "--"]
