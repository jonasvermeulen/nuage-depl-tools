# nuage-depl-tools


This repository is used to store Deployment tools for setting up your own Nuage Networks installation, and to share little code snippets that are useful when working with a Nuage Networks installation.

# Preparing your VM as a fresh Jumphost

To get you started from a fresh Centos 7 Minimal installation:
- Set proxy when working in corporate environment:

```
export http_proxy=http://135.245.192.7:8000
echo "proxy=http://135.245.192.7:8000" >> /etc/yum.conf

```

- Set hostname

```
   hostname jumphost
   echo "jumphost" > /etc/hostname
```

- Update packages and install GIT and Ansible

```
yum update -y
yum install -y epel-release git 
yum install -y ansible
```

- Setup passwordless access to your Jumphost  

``` 
mkdir .ssh
chmod 700 .ssh
scp <localhost>:publickey .ssh/authorized_keys
chmod 644 .ssh/authorized_keys
restorecon .Rv .ssh
```



  
