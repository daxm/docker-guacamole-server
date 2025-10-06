import requests
import sys

# Configuration
base_url = "https://guacamole.local:8443/api/session/data/mysql"
token = "your_auth_token_here"  # Replace with guacadmin authToken from `curl -X POST -d 'username=guacadmin&password=<your_password>' https://guacamole.local:8443/api/tokens --insecure`

def api_request(method, endpoint):
    """Helper function for Guacamole API requests"""
    headers = {"Guacamole-Token": token}
    url = f"{base_url}/{endpoint}"
    if method == "GET":
        response = requests.get(url, headers=headers, verify=False)
    else:
        raise ValueError(f"Unsupported method: {method}")
    if response.status_code != 200:
        print(f"Error on {method} {endpoint}: {response.status_code} - {response.text}")
        sys.exit(1)
    return response.json()

# List user groups
groups = api_request("GET", "userGroups")
for group in groups:
    print(f"User Group: {group['identifier']}")