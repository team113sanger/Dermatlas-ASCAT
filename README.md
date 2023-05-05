# Dermatlas-ASCAT

Dermatlas Docker image for ASCAT v3.1.2+

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

|                 Main                 |                Develop                |
| :----------------------------------: | :-----------------------------------: |
| [![Main][derm-main]][derm-main-view] | [![Develop][derm-dev]][derm-dev-view] |

- [Dermatlas-ASCAT](#dermatlas-ascat)
  - [Using the container](#using-the-container)
    - [Docker](#docker)
    - [Singularity](#singularity)
  - [Development](#development)
    - [GitHub Actions](#github-actions)
    - [Secrets for Actions](#secrets-for-actions)
    - [GitHub Container Registry](#github-container-registry)
    - [Docker image information](#docker-image-information)
    - [Branching](#branching)

## Using the container

The container can be accessed via the repo [packages](repo-package).

### Docker

Change `develop` as appropriate.  If private you will need to perform relevant authentication.

```
docker pull ghcr.io/cynapse-ccri/dermatlas-ascat:develop

docker run --rm ghcr.io/cynapse-ccri/dermatlas-ascat:develop run_ascat.R --help
```

You will need to mount data appropriately via the docker option `-v`.  Recommended approach:

```
docker run --rm \
    -v /full/path/reference:/var/spool/reference:ro \
    -v /full/path/inputs:/var/spool/inputs:ro \
    -v /full/path/output:/var/spool/output \
    ghcr.io/cynapse-ccri/dermatlas-ascat:develop run_ascat.R ...
```

All paths passed to `run_ascat.R` should use the `/var/spool/*` version of the file location.

### Singularity

Change `develop` as appropriate.  If private you will need to perform relevant authentication.

```
singularity pull docker://ghcr.io/cynapse-ccri/dermatlas-ascat:develop
# creates dermatlas-ascat_develop.sif
singularity exec --cleanenv dermatlas-ascat_develop.sif run_ascat.R --help
```

You will need to mount data appropriately via the singularity bind option `--bind`.  Recommended approach:

```
singularity exec --cleanenv \
    --bind /full/path/reference:/var/spool/reference:ro \
    --bind /full/path/inputs:/var/spool/inputs:ro \
    --bind /full/path/output:/var/spool/output \
    dermatlas-ascat_develop.sif run_ascat.R ...
```

All paths passed to `run_ascat.R` should use the `/var/spool/` version of the file location.

## Development

This repository has been configured to utilise the VSCode + GitHub Codespaces integration.  This means no setup is required.

If developing in a different environment, please ensure you install and activate pre-commit to prevent build errors in
the GitHub Actions workflows.

### GitHub Actions

GitHub actions are active on this repository.  They will execute automatically for:

- Pushes to `develop` & `main`
- Tag creations patterns `v?[0-9]+.[0-9]+.[0-9]+`, `v?[0-9]+.[0-9]+`
- Pull requests against `develop` & `main`

Docker builds within actions have access to a persistent build cache (7 days) so rebuilds are generally rapid.

### Secrets for Actions

Dockerhub account credentials are required to prevent image pulls hitting rate limits.

- Ensure readonly privileges on service account, variables to set are:
  - `DOCKER_HUB_USERNAME`
  - `DOCKER_HUB_ACCESS_TOKEN`

### GitHub Container Registry

Actions automatically register the container image in the GitHub container registry.  You are able to set **containers public**
while keeping **code private**.  Be aware that the `README.md` is common to the code and container registry.

### Docker image information

- Final user is `ascat`

### Branching

The repository has been setup with an expectation that good branching practice is used.

- Features
  - Branch from `develop`
  - Merged to `develop`
- Hotfixes
  - Branch from `main`
  - Merged to `main`, tagged on `main` and then `main` merged into `develop`.

The codespace is configured with hubflow git extensions to simplify this process.  If you are unfamiliar with this please
see [here](hubflow).

If you start the codespace with a branch other than develop you may need to checkout the `develop` branch and switch back
to your working branch to use hubflow commands such as `feature finish` or `hotfix finish`.

<!-- links -->

[derm-dev]: https://github.com/cynapse-ccri/Dermatlas-ASCAT/actions/workflows/build.yaml/badge.svg?branch=develop
[derm-dev-view]: https://github.com/cynapse-ccri/Dermatlas-ASCAT/actions?query=branch%3Adevelop
[derm-main]: https://github.com/cynapse-ccri/Dermatlas-ASCAT/actions/workflows/build.yaml/badge.svg?branch=main
[derm-main-view]: https://github.com/cynapse-ccri/Dermatlas-ASCAT/actions?query=branch%3Amain
