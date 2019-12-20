#!/bin/bash

# remove comment if you want to enable debugging
#set -x

source /tmp/.env

## add new user
# useradd -m -s /bin/bash -U ${USERNAME} -u ${USER_UID}
# cp -pr /home/vagrant/.ssh ${HOME_DIR}/
# chown -R ${USERNAME}:${USERNAME} ${HOME_DIR}
# echo "%${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}

#### Install packages ######
apt-get update -y
apt-get install -y make build-essential linux-headers-generic
apt-get install -y python-pip python3-pip unzip jq
pip install awscli

#add git repo
add-apt-repository -y ppa:git-core/ppa

#install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce
curl -fsSL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
# add docker privileges
usermod -aG docker ${USERNAME}

#install git
apt-get install -y git
curl -fsSL https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash -\
    && apt-get install -y git-lfs

#terraform
terraform=/usr/local/bin/terraform
if [ -f "$terraform" ]; then
T_VERSION=$(/usr/local/bin/terraform -v | head -1 | cut -d ' ' -f 2 | tail -c +2)
T_RETVAL=${PIPESTATUS[0]}
fi

[[ $T_VERSION != $TERRAFORM_VERSION ]] || [[ $T_RETVAL != 0 ]] \
&& wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
&& unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# packer
packer=/usr/local/bin/packer
if [ -f "$packer" ]; then
P_VERSION=$(/usr/local/bin/packer -v)
P_RETVAL=$?
fi

[[ $P_VERSION != $PACKER_VERSION ]] || [[ $P_RETVAL != 1 ]] \
&& wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
&& unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm packer_${PACKER_VERSION}_linux_amd64.zip

# clean up
apt-get clean
