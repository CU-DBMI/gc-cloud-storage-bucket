"""
Hook for checking values from cookiecutter variables before generating the project.
See the following for more information:
https://cookiecutter.readthedocs.io/en/1.7.0/advanced/hooks.html
"""

import sys

project_name = "{{ cookiecutter.project_name }}"
project_gc_project = "{{ cookiecutter.project_gc_project }}"

# checking for proper length of the project name
# note: we provide the limitation here based on constraints
# for Google service accounts and how the variable is used within template.
# See the following for more information:
# https://cloud.google.com/iam/docs/service-accounts-create#creating
if  not 6 <= len(project_name) <= 21:
    print(
        "ERROR: %s Please use a project name of length 6-21 characters!" % project_name
    )
    sys.exit(1)

# limitation for google project names
# see the following for more information:
# https://cloud.google.com/resource-manager/docs/creating-managing-projects
if not 4 <= len(project_gc_project) <= 30:
    print(
        "ERROR: %s Please use a Google project name of length 4-30 characters!" % project_name
    )
    sys.exit(1)
