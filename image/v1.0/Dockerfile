FROM registry.suse.com/suse/nginx:1.21

# Copy the local 'index.html' file into the Nginx default 
# web root directory inside the container.
COPY index.html /srv/www/htdocs/index.html
COPY *.png /srv/www/htdocs/

# Expose port 80 so the container can receive traffic.
# Nginx is configured by default to listen on this port.
EXPOSE 80

# The default command for the nginx image starts the Nginx server.
# We don't need to specify a CMD here, but if we wanted to be explicit:
# CMD ["nginx", "-g", "daemon off;"]