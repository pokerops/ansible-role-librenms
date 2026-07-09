set allow-duplicate-variables := true

import '.devbox/virtenv/pokerops.ansible-utils.molecule/justfile'

MOLECULE_DOCKER_COMMAND := '/lib/systemd/systemd'
MOLECULE_SERVER_DISTRO := 'ubuntu2404'
MOLECULE_CLIENT_DISTRO := 'ubuntu2404'
MOLECULE_CLIENT_IMAGE := env_var_or_default("MOLECULE_CLIENT_IMAGE", "geerlingguy/docker-" + MOLECULE_CLIENT_DISTRO + "-ansible:latest")
