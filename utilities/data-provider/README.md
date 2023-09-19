# Data Producer Upload Instructions

Please see the following [rclone](#rclone) or [gsutil](#gsutil) sections for more information on how to upload and synchronize data to be provided to the related Google Cloud Storage bucket.

We suggest using [`rclone`](https://rclone.org) to assist with data uploads to the Google Cloud bucket related to this project.

## rclone

Please see the following instructions on uploading data to the Google Cloud bucket using [rclone](https://rclone.org/).

1. [Install rclone](https://rclone.org/install/).

1. [Configure rclone with Google Cloud Storage](https://rclone.org/googlecloudstorage/).

   - Note: if using a Google account, make sure to authenticate using this account when prompted within the web browser (the terminal will prompt through the browser)

1. Test access to Google Cloud Storage bucket with the configured rclone access using, for example, `rclone ls <configured_name>:lab-initiative-bucket`

1. Synchronize data found within bucket by using [`rclone` commands](https://rclone.org/commands/).

   - Please note: many rclone commands are recursive __by default__ with options to disable.
   - An example with the sync command: `rclone sync <data source>  <configured_name>:lab-initiative-bucket`

### Additional Notes (rclone)

- __Question__: What should I do if I see the error: `"Error 400: Cannot insert legacy ACL for an object when uniform bucket-level access is enabled."`?
- __Answer__: Try using one of the following options (only one is needed):
  - Add an environment variable like the following (command may vary based on operating system): `export RCLONE_GCS_BUCKET_POLICY_ONLY=true`
  - Use an additional command-line flag `rclone --gcs-bucket-policy-only ...<the rest of your command goes here>...`

## gsutil

Please see the following instructions on uploading data to the Google Cloud bucket using [`gsutil`](https://cloud.google.com/storage/docs/gsutil).

__Note:__ The gsutil command provided within the script makes use of the `-m` option for multi-threading performance increases and the `-r` option for recursive data transfer.

1. Ensure `service-account.json` key is found within the same directory where script is run.
1. Prepare data to be uploaded under `./data` directory relative to `gsutil_sync.bat` location.
1. Run the `gsutil_sync.bat` script by double clicking it or from a command line prompt (for example, by typing: `gsutil_sync.bat` and hitting the enter key).

Please reference the following directory tree structure for an example of what the path should contain:

```shell
.
├── README.md
├── data
│   └── <data to be synchronized>
├── gsutil_sync.bat
└── service-account.json
```

### Additional Notes (gsutil)

- __Alternative data upload path__: if an alternative data upload path is preferred, please reference and update `gsutil_sync.bat` as follows:
  - Original: `gsutil rsync data gs://lab-initiative-bucket`
  - Updated: `gsutil rsync <new data location> gs://lab-initiative-bucket`
- __Additional gsutil rsync options__: additional options for the `gsutil rsync` command may be found from the following link: <https://cloud.google.com/storage/docs/gsutil/commands/rsync>
