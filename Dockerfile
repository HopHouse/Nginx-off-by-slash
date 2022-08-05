FROM ubuntu

RUN apt-get -y update && apt-get -y install nginx
RUN apt-get -y install vim tmux goaccess git zsh tree
RUN apt install -y golang

# Install GOP
RUN go install github.com/hophouse/gop@latest
RUN export PATH=$PATH:/root/go/bin

# Copy the nginx configuration file
COPY nginx-default.conf /etc/nginx/sites-available/default

# Copy web app content
RUN rm -r /var/www/*
COPY www /var/www

# Upload to the container the exploit
COPY exploit /exploit

# Expose the port for access
EXPOSE 80/tcp

# Run the Nginx server
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]