# 1. Use a trusted base image.
FROM debian:bullseye-slim

# 2. Use ARG for the version.
ARG CODE_SERVER_VERSION="4.91.1"

# 3. As ROOT, install all system dependencies needed.
# This is the correct place to do all 'apt-get install' operations.
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    # Add any other tools you need here, e.g., git, zsh, etc.
    git \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# 4. As ROOT, download and install the code-server application.
RUN wget https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb && \
    dpkg -i code-server_${CODE_SERVER_VERSION}_amd64.deb && \
    rm code-server_${CODE_SERVER_VERSION}_amd64.deb

# 5. Create the non-root user.
# DO NOT add this user to the sudo group or modify /etc/sudoers.
RUN useradd --create-home --shell /bin/bash coder

# 6. Switch to the non-root user for the rest of the build and for runtime.
# This user now has no root privileges.
USER coder

# 7. Set the working directory.
WORKDIR /home/coder/project

# 8. Expose the port.
EXPOSE 8080

# 9. Define the command to run as the 'coder' user.
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
