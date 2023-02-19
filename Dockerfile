# Base container image
FROM babashka/babashka

# Install Babashka script dependencies
RUN apt-get -y update
RUN apt-get -y install git
RUN git config --global --add safe.directory /github/workspace
RUN apt-get install -y nodejs
RUN apt-get install -y curl unzip

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf aws awscliv2.zip

# Copy entry point script from action repository to the filesystem path `/` of the container
COPY entrypoint.bb.clj /entrypoint.bb.clj

# Code file to execute when the Docker container starts up (`entrypoint.bb.clj`)
ENTRYPOINT ["bb", "/entrypoint.bb.clj"]
