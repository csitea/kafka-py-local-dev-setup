import os
import time
import argparse
from classes.AWSAccount import AWSAccount

def get_session_token(AWS_PROFILE, AWS_SHARED_CREDENTIALS_FILE, SESSION_AWS_PROFILE):

    # [=] Set variables ==================================================================================
    timestamp = time.time()

    if not os.path.exists(AWS_SHARED_CREDENTIALS_FILE):
        AWS_SHARED_CREDENTIALS_FILE = os.path.expanduser(os.path.join(f"~/.aws/credentials"))
    # ====================================================================================================

    acc = AWSAccount(AWS_PROFILE, AWS_SHARED_CREDENTIALS_FILE)
    acc.get_session_token()

    # determine where the old session credentials are
    profile_header = 0
    profile_footer = 0
    lines = []

    # read credentials file
    with open(AWS_SHARED_CREDENTIALS_FILE, 'r') as f:
        lines = f.readlines()

    # make a backup
    with open(f"{AWS_SHARED_CREDENTIALS_FILE}.{timestamp}", 'w') as f:
        for line in lines:
            f.write(line)

    print(f"[i] Removing old session credentials from credentials file ::: {AWS_SHARED_CREDENTIALS_FILE}")
    print(f"[i] This could break the file, find a backup at {AWS_SHARED_CREDENTIALS_FILE}.{timestamp}")
    print("[i] New session credentials will be appended to the end of the file.")
    time.sleep(2)

    # determine where session block is
    for index, line in enumerate(lines):
        if f"[{SESSION_AWS_PROFILE}]" in line:
            profile_header = index
            continue
        if profile_header != 0 and "[" in line and "]" in line:
            profile_footer = index - 1
            break

    # block was last entry in file
    if profile_header != 0 and profile_footer == 0:
        profile_footer = len(lines)

    # remove block from file and add new credentials
    if profile_header != profile_footer != 0:
        with open(AWS_SHARED_CREDENTIALS_FILE, 'w') as f:
            for line_number, line in enumerate(lines):
                if line_number < profile_header or line_number > profile_footer:
                    f.write(line)

    with open(AWS_SHARED_CREDENTIALS_FILE, 'a') as f:
        f.write(acc.format_credentials(profile=SESSION_AWS_PROFILE))

def get_roles(ORG, APP, ENV, AWS_PROFILE, AWS_SHARED_CREDENTIALS_FILE):
    # it is expected that the session profile is in place
    acc = AWSAccount(AWS_PROFILE, AWS_SHARED_CREDENTIALS_FILE)
    roles = acc.list_roles()

    assumable_roles = []
    # it is possible that roles comes out as a nested list
    for role in roles:
        if isinstance(role, list) and len(role) > 1:  # strings also return len()
            for nested_role in role:
                assumable_roles.append(nested_role)
        else:
            assumable_roles.append(role)

    # we need to either hardcode the account id to be able to differ
    # rcr, idy and log accounts, or leave labels to the user
    for role in assumable_roles:
        role_name = role.split("/")[-1]
        if f"{ORG}/{APP}/{ENV}" in role:
            print(f"""
[{ORG}_{APP}_{ENV}_{role_name}]
source_profile = {AWS_PROFILE}
role_arn = {role}""")

if __name__ == '__main__':
    ORG = os.environ["ORG"]
    # Get the APP environment variable, set to "all" if not defined or empty
    APP = os.environ.get("APP") or "all"
    # Get the ENV environment variable, set to "all" if not defined or empty
    ENV = os.environ.get("ENV") or "all"

    AWS_SHARED_CREDENTIALS_FILE = os.path.expanduser(os.path.join(f"~/.aws/.{ORG}/credentials"))

    # name of the session profile

    parser = argparse.ArgumentParser(description='AWS Account utils')

    # arguments for authenticating session with MFA device
    parser.add_argument('--authenticate', action='store_true', default=False, help="Authenticate session with MFA for AWS_PROFILE")
    parser.add_argument("-sd", "--session-duration", type=int, default=36000, help="The session duration in seconds [36000s = 10 h]")

    # arguments for getting roles a profile is allowed to assume, based in which groups it belongs to
    parser.add_argument('--get-roles', action='store_true', default=False, help="List roles the profile is allowed to assume")

    args = parser.parse_args()


    if args.authenticate:
        AWS_PROFILE = os.getenv("AWS_PROFILE", default="rtr_adm")
        SESSION_AWS_PROFILE = os.getenv("SESSION_AWS_PROFILE", default=f"{AWS_PROFILE}_sess")
        get_session_token(AWS_PROFILE, AWS_SHARED_CREDENTIALS_FILE, SESSION_AWS_PROFILE)
    elif args.get_roles:
        AWS_PROFILE = os.getenv("AWS_PROFILE", default="rtr_adm_sess")
        get_roles(ORG, APP, ENV, AWS_PROFILE, AWS_SHARED_CREDENTIALS_FILE)

    print("[=] End of action")
