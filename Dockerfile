FROM ubuntu

RUN apt update
# Install GIT
RUN apt install -y bash git curl python3.12-venv
# Install Python. The first step is used to prevent prompt about timezones.
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone
RUN echo "1 1" | apt install -y python3 pip
# Create a virtual environment and activate it
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install setuptools
# Install GCC and Make
RUN apt install -y build-essential
# Install foundry
RUN curl -L https://foundry.paradigm.xyz > foundry
RUN bash foundry
ENV PATH=${PATH}:/root/.foundry/bin
RUN foundryup
# Install node, npm and n
RUN apt install -y nodejs npm
RUN npm install -g yarn
RUN npm install -g n

WORKDIR /ethernaut
COPY . .

RUN n 16.20.1
RUN cp -r ./contracts ./client/src 
RUN yarn install
RUN yarn compile:contracts

ENTRYPOINT ["yarn"]
