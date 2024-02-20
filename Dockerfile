# Use the official Nginx image as a parent image
FROM nginx:alpine

# Copy custom nginx config if you have one
# COPY nginx.conf /etc/nginx/nginx.conf

# Remove the default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy the build output from Flutter build to the Nginx serve directory
COPY build/web /usr/share/nginx/html

# Expose port 80 to the Docker host, so we can access it
# from the outside.
EXPOSE 80

# The CMD command tells the container to run this command by default
# when it is launched. The command launches Nginx and tells it to stay
# in the foreground so the container does not stop.
CMD ["nginx", "-g", "daemon off;"]