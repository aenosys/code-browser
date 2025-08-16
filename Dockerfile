# Use the pre-existing, official image from Docker Hub as the base.
FROM codercom/code-server:latest

# Set the default command to run when the container starts.
# This ensures code-server always starts with these settings.
# --bind-addr 0.0.0.0:8080 : Makes it accessible from your browser.
# --auth none              : Disables the login password for easy access.
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
