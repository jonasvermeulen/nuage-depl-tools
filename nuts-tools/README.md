
# Loading your own tools in NUTS 

The servers running your NUTS environment are accessible behind their own gateway. To extend the installed OpenStack or Nuage environment, we first have to setup your local SSH client that it proxies the Ansible commands through the NUTS gateway.
For this to work effeciently, you should load the necessary private keys in Pageant (or other local keystore). Of essence here are
- Private key to your own jumphost
- Private Key to NUTS
- Internal Access Key in NUTS. This can be copied from the jumpbox.

## Running Ansible from your Jumphost Through the NUTS SSH Gateway 

Execute these commands on your Jumphost, replacing the value of the NUTS jumbox variable with your assigned IP.

```
nutsjumpbox=124.252.253.224
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



