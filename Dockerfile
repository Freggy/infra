FROM ubuntu:22.04
WORKDIR /build
COPY . .
RUN apt update \
    && apt-get install -y wget python3 python3-pip gnupg software-properties-common openssh-client vim \
    && pip install ansible \
    && wget -O- https://apt.releases.hashicorp.com/gpg | \
       gpg --dearmor | \
       tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
       https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
       tee /etc/apt/sources.list.d/hashicorp.list \
    && apt update \
    && apt-get install terraform \
    && ansible-galaxy install -r requirements.yaml
CMD ["bash"]
