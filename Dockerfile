# Base image
FROM nginx:latest

# Copy custom HTML files
COPY html /usr/share/nginx/html
