# Durbin Lab Data Upload Instructions

Thank you for your help in uploading data as part of this project!
Please see the following instructions on uploading data to the Google Cloud bucket.

We suggest using [`rclone`](https://rclone.org) to assist with data uploads to the Google Cloud bucket related to this project.

1. [Install rclone](https://rclone.org/install/).

1. [Configure rclone with Google Cloud Storage](https://rclone.org/googlecloudstorage/).

   - Note: if using a Google account, make sure to authenticate using this account when prompted within the web browser (the terminal will prompt through the browser)

1. Test access to Google Cloud Storage bucket with the configured rclone access using, for example, `rclone ls <configured_name>:waylab-durbinlab-bucket`

1. Synchronize data found within bucket by using [`rclone` commands](https://rclone.org/commands/).

   - Please note: many rclone commands are recursive __by default__ with options to disable.
   - An example with the sync command: `rclone sync <data source>  <configured_name>:waylab-durbinlab-bucket`

## Frequently Asked Questions (FAQ)

- __Question__: What should I do if I see the error: `"Error 400: Cannot insert legacy ACL for an object when uniform bucket-level access is enabled."`?
- __Answer__: Try using one of the following options (only one is needed):
  - Add an environment variable like the following (command may vary based on operating system): `export RCLONE_GCS_BUCKET_POLICY_ONLY=true`
  - Use an additional command-line flag `rclone --gcs-bucket-policy-only ...<the rest of your command goes here>...`
