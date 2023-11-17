# pokerops.librenms

[![Build Status](https://github.com/wpnops/ansible-role-librenms/workflows/molecule/badge.svg)](https://github.com/wpnops/ansible-role-librenms/actions)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-pokerops.librenms-blue.svg)](https://galaxy.ansible.com/wpninfra/librenms/)

An [ansible role](https://galaxy.ansible.com/pokerops/librenms) to install and configure (LibreNMS)[https://www.librenms.org/]

## Role Variables

Please refer to the [defaults file](/defaults/main.yml) for an up to date list of input parameters.

## Dependencies

The following roles must be accessible to the host executing this role

* nephelaiio.plugins
* nephelaiio.nfs
* geerlingguy.nginx
* geerlingguy.mysql
* geerlingguy.php
* geerlingguy.php-versions

## Operating modes and examples

Role can configure a LibreNMS server or client based on the value of the following variables. For servers:

```
- hosts: servers
  vars:
    librenms_server_install: true
  roles:
     - role: pokerops.librenms
```

And for clients

```
- hosts: clients
  roles:
     - role: pokerops.librenms
```

## Testing

Please make sure your environment has [podman](https://podman.io) installed in order to run role validation tests. Additional python dependencies are managed with poetry.

Role is tested against the following distributions (docker images):

 * Ubuntu Focal
 * Ubuntu Jammy

You can test the role directly from sources using the following commands

 ``` sh
 $ poetry install
 $ poetry run molecule test
```

## License

This project is licensed under the terms of the [MIT License](/LICENSE)

