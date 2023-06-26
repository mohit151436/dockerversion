# Use the official NGINX base image
FROM nginx:latest

# Copy custom configuration file to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static files to be served by NGINX
COPY static-html-directory /usr/share/nginx/html

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Start NGINX server when the container starts
CMD ["nginx", "-g", "daemon off;"]
