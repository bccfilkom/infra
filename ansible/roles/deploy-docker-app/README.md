Role Name
=========

**deploy-docker-app**

This role automates the process of deploying a Docker-based application. It clones a GitHub repository (public or private), builds a Docker image from the repository, and runs the container with optional volume mounting. This role ensures Docker and Git are installed on the target machine, and it allows for flexible configuration through role variables.

Requirements
------------

- Ansible 2.9 or later.
- Docker and Git must be available on the target host (handled by this role).
- Access to a GitHub account with a personal access token (for private repositories).

Ensure you have `community.docker` collection installed for Docker-related tasks:
```bash
ansible-galaxy collection install community.docker
```

Role Variables
--------------

The following variables need to be set for the role to function properly. They can either be defined in the playbook or in `defaults/main.yml` or `vars/main.yml`.

### Mandatory Variables

- `github_username`: Your GitHub username for cloning the repository.
- `github_access_token`: GitHub Personal Access Token (required for private repositories).
- `github_repo`: The GitHub repository to clone (e.g., `username/repo_name`).
- `home_path`: The path where the application will be cloned (e.g., `/home/user`).
- `app_name`: The name of the application, also used as the directory name where the repo is cloned.
- `image_name`: The name to assign to the Docker image (e.g., `my_app_image`).
- `image_tag`: The tag for the Docker image (e.g., `latest`).
- `container_name`: The name of the Docker container.
- `host_port`: The host port to bind the container's port to.
- `container_port`: The port inside the container to expose.

### Optional Variables

- `branch`: The Git branch to clone. Defaults to `master` or `main`.
- `host_volume`: The path on the host machine to mount as a volume inside the container. Optional. If not set, no volume is mounted.
- `container_volume`: The path inside the container where the host volume should be mounted. Optional.

Dependencies
------------

There are no external dependencies for this role, other than ensuring the required `community.docker` collection is installed.


Example Playbook
----------------

Here is an example of how to use this role:

```yaml
- hosts: servers
  roles:
    - role: deploy-docker-app
      vars:
        github_username: "myusername"
        github_access_token: "ghp_XXXXXXXXXXXXXXXXXXXXXX"
        github_repo: "myusername/private-repo"
        home_path: "/home/user"
        app_name: "custom_app"
        branch: "develop"
        image_name: "my_custom_app"
        image_tag: "v1.0"
        container_name: "custom_app_container"
        host_port: 8080
        container_port: 80
        host_volume: "/data/app"  # Optional, can be left out if no volume is needed
        container_volume: "/app/data"  # Optional, can be left out if no volume is needed
```

License
-------

BSD

Author Information
------------------

Created by [BCC Infra Team](mailto:bcc.filkom@ub.ac.id). Feel free to reach out with any issues or suggestions!
