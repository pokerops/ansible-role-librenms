# wpnops.librenms

[![Build Status](https://github.com/wpnops/ansible-role-librenms/workflows/molecule/badge.svg)](https://github.com/wpnops/ansible-role-librenms/actions)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-wpnops.librenms-blue.svg)](https://galaxy.ansible.com/wpninfra/librenms/)

An [ansible role](https://galaxy.ansible.com/wpnops/librenms) to install and configure (LibreNMS)[https://www.librenms.org/]

## Role Variables

Please refer to the [defaults file](/defaults/main.yml) for an up to date list of input parameters.

## Dependencies

By default this role does not depend on any external roles. If any such dependency is required please [add them](/meta/main.yml) according to [the documentation](http://docs.ansible.com/ansible/playbooks_roles.html#role-dependencies)

## Operating modes and examples

Role can configure a LibreNMS server or client based on the value of the following variables. For servers:

```
- hosts: servers
  vars:
    librenms_server_install: true
  roles:
     - role: wpnops.librenms
```

And for clients

```
- hosts: clients
  roles:
     - role: wpnops.librenms
```

## Testing

Please make sure your environment has [podman](https://podman.io) installed in order to run role validation tests. Additional python dependencies are managed with poetry.

Role is tested against the following distributions (docker images):

  * Ubuntu Focal
  * Debian Buster

You can test the role directly from sources using the following commands

 ``` sh
 $ poetry install
 $ poetry run molecule test
```

## License

This project is licensed under the terms of the [MIT License](/LICENSE)

