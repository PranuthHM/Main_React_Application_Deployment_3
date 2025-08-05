# Use an official Nginx image as the base image
FROM nginx:stable-alpine

# Copy the static React build files from your project's `build` directory
# to the Nginx public directory inside the container.
COPY build /usr/share/nginx/html

# Expose port 80 to the outside world. This is the port Nginx listens on.
EXPOSE 80

# The default Nginx CMD will serve our files, so we don't need to specify it.
# The `daemon off;` part ensures Nginx runs in the foreground, which is necessary for Docker.
CMD ["nginx", "-g", "daemon off;"]
