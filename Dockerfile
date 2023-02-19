# Base Container image
FROM babashka/babashka

# Install Babashka script dependencies
RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get install -y curl unzip
RUN curl -O https://download.clojure.org/install/linux-install-1.11.1.1224.sh \
  && chmod +x linux-install-1.11.1.1224.sh \
  && ./linux-install-1.11.1.1224.sh
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf aws awscliv2.zip
RUN apt-get install -y nodejs \
npm
#RUN npm install -g npx
#RUN npm cache clean -f


# Copy entry point script from action repository to the filesystem path `/` of the container
COPY entrypoint.bb.clj /entrypoint.bb.clj

# Code file to execute when the Docker container starts up (`entrypoint.bb.clj`)
ENTRYPOINT ["bb", "/entrypoint.bb.clj"]
