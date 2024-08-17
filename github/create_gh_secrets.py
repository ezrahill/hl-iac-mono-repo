"""
Create GitHub secrets for a list of repositories.

This script creates or updates GitHub secrets for a list of repositories. It
uses the public key of the repository to encrypt the secret value, and then
sends the encrypted value to the GitHub API.

To use this script, you need to create a personal access token with the
`repo` scope, and then set the `personal_access_token` variable in the
`config.py` file. You also need to set the `username` and `repos` variables in
the `config.py` file.

The `secrets` variable in the `config.py` file is a dictionary where the keys
are the secret names and the values are the secret values. You can add or
remove secrets as needed.

This script requires the `requests` and `PyNaCl` libraries. You can install
them using pip:

    pip install requests pynacl

This script is based on the following GitHub documentation:
https://docs.github.com/en/rest/reference/actions#create-or-update-a-repository-secret
https://docs.github.com/en/rest/reference/actions#get-a-repository-public-key

This script is for educational purposes only. Use it at your own risk.
"""

import json
from base64 import b64encode

from nacl import encoding, public
import requests

import config


def encrypt_public_key(public_key: str, secret_value: str) -> str:
    """Encrypt a Unicode string using the public key."""
    public_key = public.PublicKey(public_key.encode("utf-8"), encoding.Base64Encoder())
    sealed_box = public.SealedBox(public_key)
    encrypted = sealed_box.encrypt(secret_value.encode("utf-8"))
    return b64encode(encrypted).decode("utf-8")


def create_secret(repo_name: str, secret_name: str, secret_value: str, token: str):
    """Create or update a secret in a GitHub repository."""
    headers = {
        "Authorization": f"token {token}",
        "Accept": "application/vnd.github.v3+json",
    }
    public_key_url = (
        f"https://api.github.com/repos/{repo_name}/actions/secrets/public-key"
    )
    response = requests.get(public_key_url, headers=headers)
    public_key = response.json()
    if response.status_code != 200:
        raise Exception(f"Failed to get public key: {response.json()}")

    encrypted_value = encrypt_public_key(public_key["key"], secret_value)

    secret_url = (
        f"https://api.github.com/repos/{repo_name}/actions/secrets/{secret_name}"
    )
    response = requests.put(
        secret_url,
        headers=headers,
        data=json.dumps(
            {
                "encrypted_value": encrypted_value,
                "key_id": public_key["key_id"],
            }
        ),
    )
    if response.status_code not in [201, 204]:
        raise Exception(f"Failed to create/update secret: {response.json()}")


TOKEN = config.personal_access_token
USERNAME = config.username

for repo in config.repos:
    repo_name = f"{USERNAME}/{repo}"
    for secret_name, secret_value in config.secrets.items():
        create_secret(repo_name, secret_name, secret_value, TOKEN)
        print(f"Secret {secret_name} set for {repo_name}")
