import os
import json
import subprocess
    
class AWSAccount:
    def __init__(self, AWS_PROFILE, AWS_SHARED_CREDENTIALS_FILE):
        os.environ["AWS_PROFILE"] = AWS_PROFILE
        os.environ["AWS_SHARED_CREDENTIALS_FILE"] = AWS_SHARED_CREDENTIALS_FILE

        self.aws_profile = AWS_PROFILE
        self.shared_credentials_file = AWS_SHARED_CREDENTIALS_FILE

        caller_identity = self._run(['aws', 'sts', 'get-caller-identity'])
        self.account_id = caller_identity["Account"]
        self.user_id    = caller_identity["UserId"]
        self.arn        = caller_identity["Arn"]

        mfa_devices = self._run(['aws', 'iam', 'list-mfa-devices', '--user-name', self.arn.split("/")[-1]])["MFADevices"][0]  # there can only be two MFA devices per account
        self.username        = mfa_devices["UserName"]
        self.mfa_arn         = mfa_devices["SerialNumber"]
        self.mfa_enable_date = mfa_devices["EnableDate"]

    def get_session_token(self, session_duration=36000):
        mfa_token = input("MFA Token: ")
        session_credentials = self._run(
            [
                "aws",
                "sts",
                "get-session-token",
                "--serial-number", str(self.mfa_arn),
                "--token-code", str(mfa_token),
                "--duration-seconds", str(session_duration)
            ]
        )["Credentials"]

        self.session_credentials = session_credentials

        return session_credentials

    def list_roles(self):
        assumable_roles = []

        groups = self._run(['aws', 'iam', 'list-groups-for-user', '--user-name', self.username])["Groups"]
        """
        {
            "Path": "/",
            "GroupName": "org_app_dev_be_developers",
            "GroupId": "AGPAYWMCUO44FQPMV7BY7",
            "Arn": "arn:aws:iam::597811296056:group/org_app_dev_be_developers",
            "CreateDate": "2022-10-17T16:59:19+00:00"
        },
        """
        for group in groups:

            group_policies = self._run(["aws", "iam", "list-group-policies", "--group-name", group["GroupName"]])

            # this is the catch that makes this code specific for orgtea
            # we only allow trust relationships for groups, this may not be
            # the case for other environments
            for policy in group_policies["PolicyNames"]:
                role_statements = self._run(["aws", "iam", "get-group-policy", "--policy-name", policy, "--group-name", group["GroupName"]])["PolicyDocument"]["Statement"]

                if not isinstance(role_statements, list):
                    role_statements = [role_statements]

                for statement in role_statements:
                    if "sts:AssumeRole" in statement["Action"]:
                        assumable_roles.append(statement["Resource"])

                """ This is an example of the structure that is returned by the command above
                {
                    "GroupName": "org_app_dev_be_developers",
                    "PolicyName": "org_app_dev_be_developers_policy",
                    "PolicyDocument": {
                        "Version": "2012-10-17",
                        "Statement": {
                            "Effect": "Allow",
                            "Action": "sts:AssumeRole",
                            "Resource": "arn:aws:iam::*:role/org/app/dev/aws_iam_role_be_developers"
                        }
                    }
                }
                """


        self.groups = groups
        self.group_policies = group_policies
        self.assumable_roles = assumable_roles

        return assumable_roles

    def assume_role(self, role):
        role_credentials = self._run(['aws', 'sts', 'assume-role', '--role-arn', role, "--role-session-name", "se-backend-default-session"])["Credentials"]


        return role_credentials

    # format session credentials
    def format_credentials(self, profile):
        credentials = f"""
[{profile}]
# expiration: {self.session_credentials["Expiration"]}
aws_access_key_id = {self.session_credentials["AccessKeyId"]}
aws_secret_access_key = {self.session_credentials["SecretAccessKey"]}
aws_session_token = {self.session_credentials["SessionToken"]}
        """
        return credentials

    @staticmethod
    def _run(cmd:list):
        output = subprocess.run(cmd, stdout=subprocess.PIPE)
        return json.loads(output.stdout)
