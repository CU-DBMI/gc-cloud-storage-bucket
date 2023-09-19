# Way Lab Data Sync Instructions

This readme covers how to use [rclone](https://rclone.org/) to interact with data stored in the bucket related to this repository.

## Definitions

- [Object Storage](https://en.wikipedia.org/wiki/Object_storage): "Object Storage (also known as object-based storage) is a computer data storage that manages data as objects, ..."
- [Bucket](https://cloud.google.com/storage/docs/buckets): "Buckets are the basic containers that hold your data [on Google Cloud Storage]."
- [Objects](https://cloud.google.com/storage/docs/objects): "Objects are the individual pieces of data that you store in Cloud Storage."
- [rclone](https://rclone.org/): "Rclone is a command-line program to manage files on cloud storage."

## Procedures

The general procedure for gaining access to data stored within a Cloud Storage bucket may be segmented into steps for a __Terraform Administrator__ and a __Way Lab Data Consumer__ (roles are outlined under [the root README.md Roles section](../../README.md#👥-roles)).

### 1.) Terraform Administrator Procedure

1. Communicate with Way Lab data consumer about need for Google account.
1. Add Way Lab data consumer Google account to bucket access as a principal.
    - The principal should have `Storage Object Viewer` and `Storage Legacy Bucket Reader` roles assigned for data full data read access.
1. Communicate with Way Lab data consumer about data access readiness with their account and the bucket name (for example `waylab-assayworks-bucket`).

### 2.) Way Lab Data Consumer Procedure

1. [Install rclone](https://rclone.org/install/).
1. [Configure rclone with Google Cloud Storage](https://rclone.org/googlecloudstorage/).
1. Test access to Google Cloud Storage bucket with the configured rclone access using, for example, `rclone ls <configured_name>:waylab-assayworks-bucket`
1. Download or synchronize data found within bucket by using [`rclone` commands](https://rclone.org/commands/).
    - Please note: many rclone commands are recursive __by default__ with options to disable.
    - An example with the copy command: `rclone copy <configured_name>:waylab-assayworks-bucket`

## Other Tools

This section is provided to share the availability of similar tools which are available to perform this work.

- [gsutil](https://cloud.google.com/storage/docs/gsutil): "gsutil is a Python application [provided by Google] that lets you access Cloud Storage from the command line."
