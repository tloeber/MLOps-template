"""
This is an example for how to define a schema for your configuration.
"""

from typing import TypeAlias, Literal

from pydantic import computed_field, Field
from pydantic_settings import BaseSettings
from s3path import S3Path

Environment: TypeAlias = Literal['local', 'dev', 'qa', 'prod']


class BootstrapConfig(BaseSettings):
    """
    The purpose of this config is to define the environment, based on which all the other
    configuration values will be loaded.

    Note that this config will not be loaded from a .env file, but from an environment variable:
    – When deployed, the value will come from Terraform, etc.
    – For development, it could either be globally defined for all project in ~/.bashrc
      (recommended) or for just this project in the IDE.
    """
    ENVIRONMENT: Environment


class AWSConfig(BaseSettings):
    project_name: str
    project_version: str  # Versions data (and probably more in the future)
    region: str
    project_bucket_name: str = Field(
        pattern=r'^[a-zA-Z0-9.\-_]{1,255}$',
    )
    role_name: str | None = None

    @computed_field
    def project_bucket(self) -> S3Path:
        return S3Path(
            # Leading slash serves to mark it as an *absolute* path.
            f'/{self.project_bucket_name}',
        )
