FROM ubuntu

RUN apt update
# Install GIT
RUN apt install -y bash git curl
# Install Python. The first step is used to prevent prompt about timezones.
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone
RUN echo "1 1" | apt install -y python3
# Install GCC and Make
RUN apt install -y build-essential
# Install foundry
RUN curl -L https://foundry.paradigm.xyz > foundry
RUN bash foundry
ENV PATH=${PATH}:/root/.foundry/bin
RUN foundryup
# Install node, npm and n
RUN apt install -y nodejs npm
RUN npm install --global yarn
RUN npm install -g n

WORKDIR /ethernaut
COPY . .

# Do not reproduce this for a real production server.
ENV NODE_OPTIONS=--openssl-legacy-provider

ENTRYPOINT ["yarn"]
