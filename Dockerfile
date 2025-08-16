# 1. Use the pre-existing, official image from Docker Hub.
FROM codercom/code-server:latest

# 2. Document the port the application will run on.
# This makes it clear to anyone using the image which port to map.
EXPOSE 8080

# 3. Set the default command to run when the container starts.
# This bakes the startup configuration into the image itself.
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
