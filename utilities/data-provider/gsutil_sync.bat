::  This file automates how data are sync'd to a
::  Google Cloud Cloud Storage bucket using a
::  pre-existing service account key.
::
::  Notes:
::  ----------------------------------------------------
::  presumes gsutil has already been installed and is
::  available in the path.
::  see gsutil docs for more information:
::  https://cloud.google.com/storage/docs/gsutil_install

::  authenticate gcloud for the service account
::  note: this is the preferred method for authenticating gsutil
::  see the following for more details:
::  https://cloud.google.com/storage/docs/gsutil/commands/config#configuring-service-account-credentials
call gcloud auth activate-service-account --key-file=service-account.json

::  synchronize data from local directory `./data`
::  to bucket lab-initiative-bucket
::  see the following for more details:
::  https://cloud.google.com/storage/docs/gsutil/commands/rsync
call gsutil -m rsync -r data gs://waylab-assayworks-bucket

pause
