# GitHub Secrets Management Script

## Overview

This Python script automates the creation and update of GitHub secrets for multiple repositories. It utilizes the GitHub API to encrypt secret values using the repository's public key before updating the secrets. This tool is particularly useful for DevOps tasks, such as automating the setup of environment variables across multiple repositories.

## Requirements

- Python 3.x
- requests
- PyNaCl
- GitHub Fine-grained personal access token (PAT)
    - Read access to metadata
    - Read and Write access to secrets

You can install the required Python libraries using pip:

```bash
pip install -r requirements.txt
```

## Configuration

Before running the script, you need to set up a configuration file (config.py) with your GitHub details and the secrets you wish to manage. Here is an example structure for the config.py:

```python
personal_access_token = 'your_personal_access_token_here'
username = 'your_github_username'
repos = ['repo1', 'repo2', 'repo3']
secrets = {
    'SECRET_NAME1': 'SecretValue1',
    'SECRET_NAME2': 'SecretValue2',
}
```

- **personal_access_token**: Your GitHub personal access token with repo scope.
- **username**: Your GitHub username.
- **repos**: A list of repositories to manage secrets for.
- **secrets**: A dictionary where keys are the secret names, and values are the secret values.

## Usage

After setting up your config.py file, run the script with Python:

```bash
python create_gh_secrets.py
```

The script will iterate through each repository listed in your configuration file and create or update the secrets as specified.

## Disclaimer

This script is provided for educational purposes only. Use it at your own risk. Always ensure you have the necessary permissions to manage secrets for the specified repositories.

## License

[MIT](https://opensource.org/licenses/MIT)
