# Base image
FROM nginx:latest

# Copy nginx.conf file
COPY nginx.conf /etc/nginx/nginx.conf
