This project creates a minimal image based on suse/nginx to serve a static Demo application for SUSECON 2026.

Files

index.html: The static content.

Dockerfile: The instructions for building the image.

Instructions

1. Build the Docker Image

Run the following command in the same directory as the Dockerfile and index.html.

podman build -t susecon2026-web-app:v1.0 .


2. Run the Container

Once the image is built, run the container, mapping the container's port 80 to your host machine's port 8080:

podman run --rm -p 8080:80 --name web-app susecon2026-web-app


3. View the Website

You can now view the web app page by navigating to:

http://localhost:8080

4. Stop and Remove the Container

When you are finished, you can stop and remove the container:

podman stop web-app
podman rm web-app


5. Publish the Image (Docker Hub Example)

To prepare the image for deployment, you need to publish it to a public registry like Docker Hub or a private registry (like Google Container Registry, AWS ECR, etc.).

Note: Replace [YOUR_DOCKERHUB_USERNAME] with your actual Docker Hub ID.

A. Tag the Image

You must tag the image with the registry path (<username>/<repository>:<tag>). This links your local image to the remote repository.

podman tag susecon2026-web-app [YOUR_DOCKERHUB_USERNAME]/susecon2026-web-app:v1.0


B. Log in to the Registry

Log into your Docker registry account (if you haven't already).

podman login registry-1.docker.io

# Enter your username and password when prompted.


C. Push the Image

Push the newly tagged image to the remote registry. This is the fully qualified image name you will reference in your Kubernetes deployment file.

podman push [YOUR_DOCKERHUB_USERNAME]/susecon2026-web-app:v1.0
