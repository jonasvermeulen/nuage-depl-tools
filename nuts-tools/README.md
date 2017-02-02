
# Enhancing the NUTS environment with your own tools 

The Nuage Ultimate Test System (NUTS)  is a great environment to evaluate the capabilities of Nuage VSP. This repository contains a number of playbooks that extend the standard Liberty setup to 
- install your own public key on the Openstack controller - allowing you to do passwordless logins into VMs
- correct Nagios config files on the Openstack controller - making it easier to check if your environment is healthy
- install docker - allowing you to evaluate a mixed environment of VMs, Bare-Metals and Docker Containers
- install Nokia VSR - allowing you to evaluate a mixed environment of VMs and a connection to a PE router
- install nuage-amp-sync - allowing you to run VSD-Managed mode with full synchronization between VSD and OpenStack
- update your RedHat Subscription

This repo comes with a pre-defined hosts inventory that makes it quite straightforward to get started.
A sample `user-vars.yml` is also provided where you can customize file locations, public keys etc.

# System setup
The servers running your NUTS environment are accessible behind their own gateway. To extend the installed OpenStack or Nuage environment, we first have to setup your local SSH client that it proxies the Ansible commands through the NUTS gateway.
For this to work effeciently, you should load the necessary private keys in Pageant (or other local keystore). Of essence here are

- Private key to your own jumphost
- Private key to NUTS
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
sudo yum -y install ansible python-pip
```

## Refine the OpenStack Controller

```
ln -s ~/.ssh/id_rsa.pub files/os_public_key
ansible-playbook -i hosts refine-osctrl.yml
```

## Install Docker on the OS Compute servers

```
ansible-playbook -i hosts install-docker.yml
```

## Install VSR on BareMetal1

```
ansible-playbook -i hosts install-vsr.yml
```

## Install nuage-amp-sync

```
ansible-playbook -i hosts install-nuage-amp.yml
```


## Update RedHat Subscription (required with labs < Mitaka)

The variables are defined in rh-subs-vars.yml:

- `rh_username`
- `rh_password`
- `rh_pool`

It is stored as a Ansible Vault'ed variable file, so you'd need to replace it with your own (and Vault it as well).
The ansible command to update the RedHat Suscription is

```
ansible-playbook -i hosts update-rh-subs.yml --ask-vault-pass
```




