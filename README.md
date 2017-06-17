# How to use  
### Assumptions  
* You have created a project with in google cloud  
* If you are planning to use a custom domain then you have set this up - [please look here](https://cloud.google.com/appengine/docs/standard/python/using-custom-domains-and-ssl)  
* Some understanding of google cloud and app engine should be held  
* You have enabled compute API for the project 
* You have enabled google cloud SQL API

###Possible Errors
Error regarding credential file not being able to be written to, please change permissions on file(sudo chown -R $USER /home/USERNAME/.config)  
Error regarding not being able to write to file, please change permissions(sudo chown -R $USER /home/gavan/.gsutil)  
  
### Before you begin
Make each file executable by running **chmod +x script.sh**  
eg:  
chmod +x 1-gcloud-install.sh  
chmod +x 2-gcloud-env-setup.sh  
chmod +x 3-gcloud-project-setup.sh  
chmod +x 4-gcloud-appeng-setup.sh  
chmod +x 5-gcloud-appeng-deploy.sh  
  
### Running each script
#### 1) Install google cloud and setup default account
Run: **sudo ./1-gcloud-install.sh**  
Description: Setups google cloud in bash.
<br />  

#### 2) Set up the local evironment
Run: **sudo ./2-gcloud-env-setup.sh**  
Description:
Removes  
* PHP7.0  
  
Installs  
* PHP  
* PHP7.1  
* PHP7.1-zip  
* PHP-xml  
* Composer  
* MySQL  
  
Downloads cloud sql proxy and makes it executable  
  
Variables
  
| Variable | Default Value | Notes |  
| --- | --- | --- |  
| BIN_FOLDER_PATH | /usr/local/bin | Please make sure the path used is included in the **$PATH** variable | 

<br />  

#### 3) Creates GCP SQL instance   
Run: **./3-gcloud-project-setup.sh**  
Description: Creates gcp sql instance and sets the root password  
Variables
  
| Variable | Default Value | Notes |  
| --- | --- | --- |
| GCE_INSTANCE_ACTIVATION_POLICY | ALWAYS | |
| GCE_INSTANCE_BACKUP_TIME | 02:00 |  |
| GCE_REGION | asia-northeast1  | [Please check here](https://cloud.google.com/sql/docs/mysql/instance-locations) |
| GCE_TIER | db-n1-standard-1 | [Please check here](https://cloud.google.com/sql/pricing#2nd-gen-instance-pricing) |
| GCE_ZONE | a | [Please check here](https://cloud.google.com/compute/docs/regions-zones/regions-zones) |
| MAINTENANCE_WINDOW_DAY | SUN |  |
| MAINTENANCE_WINDOW_HOUR | 03 |  |
| MYSQL_REPLICATION | SYNCHRONOUS |  |
| MYSQL_VERSION | MYSQL_5_7 |  |
| SQL_ROOT_PASSWORD | KL7wf1nggh |  |
| SQL_SERVER_INSTANCE_NAME | wp |  |
<br />  
 
#### 4) Setting up app engine  
Run: **./4-gcloud-appeng-setup.sh**  
Assumption: you have created a service account for the project and you've downloaded the json key.
Description: Creates bucket, setup cloud sql proxy and creates a DB, installs components with composer, and sets up wordpress.
Variables

| Variable | Default Value | Notes |
| --- | --- | --- |
| DOMAIN_FOR_BUCKET | |  |
| DOMAIN_FOR_STAGING_BUCKET | |  |
| GCE_REGION | asia-northeast1 |  |
| GCE_ZONE | a |  |
| PATH_TO_YOUR_SERVICE_ACCOUNT_JSON |  |  |
| PROJECT_ID | project-1 |  |
| SQL_DB_NAME | wp |  |
| SQL_DB_USER | wp |  |
| SQL_DB_PASSWORD | #569y8A4  |  |
| SQL_ROOT_PASSWORD | KL7wf1nggh |  |
| SQL_SERVER_INSTANCE_NAME | wp |  |
| SQL_ROOT_PASSWORD | KL7wf1nggh |  |
| WORDPRESS_URL |  |  |
<br />  

#### 5) Deploy to app engine  
Run: **./5-gcloud-appeng-deploy.sh**
Assumption: **./4-gcloud-appeng-setup.sh** has been run and everything has been setup.
Description: deploys wordpress to app engine

| Variable | Default Value | Notes |
| --- | --- | --- |
| DOMAIN_FOR_STAGING_BUCKET | |  |

### After installation
Go to the Dashboard, and in the Plugins page, activate the following
plugins:
- Batcache Manager
- GCS media plugin

After activating the plugins, try uploading a media and confirm the
image is uploaded to the GCS bucket.

### Various workflows

#### Install/Update plugins/themes

Because the wp-content directory on the server is read-only, you have
to do this locally. Run WordPress locally and update plugins/themes in
the local Dashboard, then deploy, then activate them in the production
Dashboard. You can also use the `wp-cli` utility as follows:

```
**To update all the plugins**
$ vendor/bin/wp plugin update --all --path=wordpress
**To update all the themes**
$ vendor/bin/wp theme update --all --path=wordpress
```

#### Remove plugins/themes

First Deactivate them in the production Dashboard, then remove them
completely locally. The next deployment will remove those files from
the production environment.

#### Update WordPress itself

Most of the case, just download the newest WordPress and overwrite the
existing wordpress directory. It is still possible that the existing
config files are not compatible with the newest WordPress, so please
update the config file manually in that case.

#### Update the base image

We sometimes release the security update for
[the php-docker image][php-docker]. Then you’ll have to re-deploy your
WordPress instance to get the security update.

Enjoy your WordPress installation!