# CUDA-enabled PyTorch image
FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime

# Prevent Python buffering
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system packages if needed
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy dependencies first (better Docker cache)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose FastAPI port
EXPOSE 8000

# Default interactive shell
CMD ["bash"]