# blockade-buster

Quickly launch a ss-server on DigitalOcean.

## Getting Started

### 1. Obtain a DigitalOcean API token

### 2. Configure

Add `terraform.tfvars`:

```
do_token = "REPLACE_TOKEN_HERE"

do_ssh_keys = [
    "SSH_KEY_FINGERPRINT",
]

do_ssh_private_key = "/path/to/.ssh/id_rsa"

ss_password = "cryiCzYCknrmiRUkjDcOasaGhXqcZA"
```

### 3. Terraform Apply

```
$ terraform init
$ terraform apply
```

## Performance

### 1. Check Logs

```
$ journalctl -f
```

### TODO

* Fast Open
* Firewall Rules
