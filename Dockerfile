# Base image
FROM nginx:latest


# Copy static files
COPY ./public /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
