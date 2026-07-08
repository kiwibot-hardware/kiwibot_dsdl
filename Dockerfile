# Use Python 3.8 as base image (known to work well with Nunavut 0.4.0)
FROM python:3.8-slim

# Install git and required build tools
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install nunavut==2.3.1

# Set working directory
WORKDIR /app

# Clone the public regulated data types
RUN git clone https://github.com/UAVCAN/public_regulated_data_types.git

# Default to bash so we can run commands interactively
CMD ["/bin/bash"]