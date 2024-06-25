# My Shell Scripts

## Overview
This repository contains a collection of useful shell scripts for various tasks. These scripts are designed to simplify and automate repetitive tasks in your development workflow.

## Getting Started

### Prerequisites
- Ensure you have the necessary software installed:
  - [Git](https://git-scm.com/)
  - [Bash](https://www.gnu.org/software/bash/)
  - [Python](https://www.python.org/)
  - [Docker](https://www.docker.com/)
  - [GitHub CLI (gh)](https://cli.github.com/)

### Installation
1. Clone the repository to your local machine:
    ```bash
    git clone git@github.com:Pamsho09/my-shell-scripts.git
    ```

2. Navigate to the project directory:
    ```bash
    cd my-shell-scripts
    ```

### Setting Permissions

#### Giving Permissions to the Repository Folder

To give read, write, and execute permissions to the repository folder, use the following command:

```bash
chmod -R 755 /path/to/my-shell-scripts
```

#### Assigning Execution Permissions to Scripts

To allow the scripts to be executed from any location, follow these steps:

1. Make the script executable:
    ```bash
    chmod +x /path/to/my-shell-scripts/scripts/close_all_apps.sh
    chmod +x /path/to/my-shell-scripts/scripts/py-init.sh
    chmod +x /path/to/my-shell-scripts/scripts/run-docker-cmd.sh
    chmod +x /path/to/my-shell-scripts/scripts/set_env_vars.sh
    ```

2. Optionally, add the script's directory to your `PATH` to run it from any location:
    ```bash
    export PATH=$PATH:/path/to/my-shell-scripts/scripts
    ```

### Running the Scripts

#### Closing All Applications on macOS

This script uses AppleScript to close all applications on macOS.

1. Ensure the AppleScript file `close_all_apps.scpt` is located in your home directory (`~/`).
2. Navigate to the scripts directory:
    ```bash
    cd /path/to/my-shell-scripts/scripts
    ```

3. Execute the script:
    ```bash
    ./close_all_apps.sh
    ```

#### Initializing or Deactivating a Python Virtual Environment

This script initializes or deactivates a Python virtual environment using `venv`.

1. Navigate to the scripts directory:
    ```bash
    cd /path/to/my-shell-scripts/scripts
    ```

2. To initialize and activate a virtual environment:
    ```bash
    ./py-init.sh [env_name]
    ```
    If no environment name is provided, it defaults to `env`.

3. To deactivate the currently activated virtual environment:
    ```bash
    ./py-init.sh --off
    ```

#### Running Docker Commands

This script executes the main Docker command.

1. Navigate to the scripts directory:
    ```bash
    cd /path/to/my-shell-scripts/scripts
    ```

2. Execute the Docker command:
    ```bash
    ./run-docker-cmd.sh [docker_command]
    ```
    Replace `[docker_command]` with the actual Docker command you want to run.

#### Setting Environment Variables in a GitHub Repository

This script sets secret environment variables from a `.env` file to a specified GitHub repository and environment.

1. Ensure you have a `.env` file in the project directory with the environment variables you want to set.
2. Navigate to the scripts directory:
    ```bash
    cd /path/to/my-shell-scripts/scripts
    ```

3. Execute the script with the required arguments:
    ```bash
    ./set_env_vars.sh --repo <owner/repository> --env <environment>
    ```
    Replace `<owner/repository>` with your GitHub repository in the format `owner/repository`, and `<environment>` with the target environment.

### Usage

Provide examples and usage instructions for your scripts. Include command-line examples, configuration details, etc.

### Contributing

If you want others to contribute to your project, include guidelines for contributing, such as:

- Fork the repository
- Create a new branch (`git checkout -b feature-branch`)
- Commit your changes (`git commit -m 'Add new feature'`)
- Push to the branch (`git push origin feature-branch`)
- Create a new Pull Request

### License

Include the license information for your project, for example:

```
MIT License
```

### Contact

Provide contact information or links for further questions or support. For example:

- Email: [your.email@example.com](mailto:your.email@example.com)
- GitHub: [https://github.com/Pamsho09](https://github.com/Pamsho09)
