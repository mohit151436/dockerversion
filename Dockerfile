# Base image
FROM nginx:latest

# Copy custom configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static files
COPY ./public /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
