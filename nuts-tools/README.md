
# Enhancing the NUTS environment with your own tools 

The Nuage Ultimate Test System (NUTS)  is a great environment to evaluate the capabilities of Nuage VSP. This repository contains a number of playbooks that extend the standard Liberty setup to 
- install your own public key - allowing you to do passwordless logins into VMs
- install docker - allowing you to evaluate a mixed environment of VMs, Bare-Metals and Docker Containers
- correct Nagios config files - making it easier to check if your environment is healthy
- install nuage-amp-sync - allowing you to run VSD-Managed mode with full synchronization between VSD and OpenStack
- update your RedHat Subscription

This repo comes with a pre-defined hosts inventory that makes it quite straightforward to get started.
A sample `user-vars.yml` is also provided where you can customize file locations, public keys etc.

# System setup
The servers running your NUTS environment are accessible behind their own gateway. To extend the installed OpenStack or Nuage environment, we first have to setup your local SSH client that it proxies the Ansible commands through the NUTS gateway.
For this to work effeciently, you should load the necessary private keys in Pageant (or other local keystore). Of essence here are

- Private key to your own jumphost
- Private Key to NUTS
- Internal Access Key in NUTS. This can be copied from the NUTS jumpbox.

Execute these commands on your machine, replacing the value of the NUTS jumbox variable with your assigned IP.

```
nutsjumpbox=NUTS-JUMPBOX-IP
cat <<EOF > .ssh/config
Host 10.0.0.*
  ProxyCommand ssh -W %h:%p $nutsjumpbox
  User root
  
Host $nutsjumpbox
  Hostname $nutsjumpbox
  User admin
  ForwardAgent yes
  ControlMaster auto
  ControlPath ~/.ssh/nuts-%r@%h:%p
  ControlPersist 5m
EOF
```

## Install the playbooks of this repo

```
git clone https://github.com/jonasvermeulen/nuage-depl-tools.git
cd nuage-depl-tools/nuts-tools 
```

## Refine the OpenStack Controller

```
ansible-playbook -i hosts refine-osctrl.yml
```

## Install Docker

```
ansible-playbook -i hosts install-docker.yml
```

## Install nuage-amp-sync

```
ansible-playbook -i hosts install-nuage-amp.yml
```


## Update RedHat Subscription

The variables are defined in rh-subs-vars.yml:

- `rh_username`
- `rh_password`
- `rh_pool`

It is stored as a Ansible Vault'ed variable file, so you'd need to replace it with your own (and Vault it as well).
The ansible command to update the RedHat Suscription is

```
ansible-playbook -i hosts update-rh-subs.yml --ask-vault-pass
```




