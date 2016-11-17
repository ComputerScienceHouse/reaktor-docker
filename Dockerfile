FROM ruby:alpine
MAINTAINER Steven Mirabito (smirabito@csh.rit.edu)

# Clone Reaktor source and install bundle
RUN apk --no-cache add musl-dev g++ git make && \
    adduser -S reaktor && \
    mkdir -p /opt /var/tmp /run/reaktor && \
    cd /opt && \
    git clone https://github.com/pzim/reaktor.git && \
    ln -sf /dev/stdout /run/reaktor/reaktor.log && \
    chown -R reaktor /opt/reaktor /var/tmp /run/reaktor && \
    chmod og+rwx /var/tmp /run/reaktor && \
    cd /opt/reaktor && \
    bundle install --without test && \
    apk del make

# Copy config files into the container
ADD reaktor-cfg.yml /opt/reaktor
ADD resque.yml /opt/reaktor/config

# Set environment
ENV RACK_ROOT=/opt/reaktor
ENV REAKTOR_LOG=/run/reaktor/reaktor.log
WORKDIR /opt/reaktor

# Expose default port
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["bundle", "exec", "rake", "start"]
