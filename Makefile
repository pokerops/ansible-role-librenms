.PHONY: all ${MAKECMDGOALS}

MOLECULE_SCENARIO ?= default
MOLECULE_SERVER_DISTRO ?= ubuntu2204
MOLECULE_CLIENT_DISTRO ?= ubuntu2204
GALAXY_API_KEY ?=
GITHUB_REPOSITORY ?= $$(git config --get remote.origin.url | cut -d: -f 2 | cut -d. -f 1)
GITHUB_ORG = $$(echo ${GITHUB_REPOSITORY} | cut -d/ -f 1)
GITHUB_REPO = $$(echo ${GITHUB_REPOSITORY} | cut -d/ -f 2)
REQUIREMENTS = requirements.yml

all: install version lint test

test: lint
	poetry run molecule test -s ${MOLECULE_SCENARIO}

install:
	@type poetry >/dev/null || pip3 install poetry
	@poetry self add poetry-plugin-export
	@poetry install --no-root

lint: install
	poetry run yamllint .
	poetry run ansible-lint .
	poetry run molecule syntax

roles:
	[ -f ${REQUIREMENTS} ] && yq '.$@[] | .name' -r < ${REQUIREMENTS} \
		| xargs -L1 poetry run ansible-galaxy role install --force || exit 0

collections:
	[ -f ${REQUIREMENTS} ] && yq '.$@[]' -r < ${REQUIREMENTS} \
		| xargs -L1 echo poetry run ansible-galaxy -vvv collection install --force || exit 0

requirements: roles collections

dependency create prepare converge idempotence side-effect verify destroy login reset:
	MOLECULE_SERVER_DISTRO=${MOLECULE_SERVER_DISTRO} MOLECULE_CLIENT_DISTRO=${MOLECULE_CLIENT_DISTRO} \
        poetry run molecule $@ -s ${MOLECULE_SCENARIO}

clean: destroy reset
	poetry env remove $$(which python)

publish:
	@echo publishing repository ${GITHUB_REPOSITORY}
	@echo GITHUB_ORGANIZATION=${GITHUB_ORG}
	@echo GITHUB_REPOSITORY=${GITHUB_REPO}
	@poetry run ansible-galaxy role import \
		--api-key ${GALAXY_API_KEY} ${GITHUB_ORG} ${GITHUB_REPO}

version:
	@poetry run molecule --version

debug: version
	@poetry export --dev --without-hashes
