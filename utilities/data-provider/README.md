# Assay.Works Data Sync Instructions

Thank you for your help in uploading data as part of this project!
Please see the following instructions on uploading data to the Google Cloud bucket.

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

## Additional Notes

- __Alternative data upload path__: if an alternative data upload path is preferred, please reference and update `gsutil_sync.bat` as follows:
  - Original: `gsutil rsync data gs://waylab-assayworks-bucket`
  - Updated: `gsutil rsync <new data location> gs://waylab-assayworks-bucket`
- __Additional gsutil rsync options__: additional options for the `gsutil rsync` command may be found from the following link: <https://cloud.google.com/storage/docs/gsutil/commands/rsync>
