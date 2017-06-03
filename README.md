# How to use  
### Assumptions  
* You have created a project with in google cloud  
* If you are planning to use a custom domain then you have set this up - [please look here](https://cloud.google.com/appengine/docs/standard/python/using-custom-domains-and-ssl)  
* Some understanding of google cloud and app engine should be held  
* You have enabled compute API for the project 
  
### Before you begin
Make each file executable by running **chmod +x script.sh**  
eg:  
chmod +x 0-gcloud-install.sh  
chmod +x 1-gcloud-env-setup.sh  
chmod +x 2-gcloud-project-setup.sh  
chmod +x 3-gcloud-appeng-setup.sh  
chmod +x 4-gcloud-appeng-update.sh  
  
### Running each script
#### 1 Install google cloud locally
Run: **sudo ./0-gcloud-install.sh**  
Setups google cloud in bash.
<br />  

#### 2 Setting up the local evironment
Run: **sudo ./1-gcloud-env-setup.sh**  
Variables
  
| Variable | Default Value | Notes |  
| --- | --- | --- |  
| BIN_FOLDER_PATH | /usr/local/bin | Please make sure the path used is included in the **$PATH** variable |  
| MYSQL_ROOT_PASSWORD_LOCAL | W0rdpass | |

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
<br />  

#### 3 Setting up project  
Script: **./2-gcloud-project-setup.sh**  
Creates gcp sql instance and sets the root password  
Variables
  
| Variable | Default Value | Notes |  
| --- | --- | --- |
| GCE_REGION | asia-northeast1  | [Please check here](https://cloud.google.com/sql/docs/mysql/instance-locations) |
| GCE_ZONE | a | [Please check here](https://cloud.google.com/compute/docs/regions-zones/regions-zones) |
| GCE_TIER | db-n1-standard-1 | [Please check here](https://cloud.google.com/sql/pricing#2nd-gen-instance-pricing) |
| GCE_INSTANCE_ACTIVATION_POLICY | ALWAYS | |
| GCE_INSTANCE_BACKUP_TIME | 02:00 |  |
| MYSQL_VERSION | MYSQL_5_7 |  |
| MAINTENANCE_WINDOW_DAY | SUN |  |
| MAINTENANCE_WINDOW_HOUR | 02 |  |
| MYSQL_REPLICATION | SYNCHRONOUS |  |
| SQL_SERVER_INSTANCE_NAME | wp |  |
| SQL_ROOT_PASSWORD | KL7wf1nggh |  |
<br />  
 
#### 4 Setting up app engine  
Script: **3-gcloud-appeng-setup.sh**  
Assumption: you have a created a service account for the project and you've downloaded the json key.
Creates bucket, setup cloud sql proxy and create a DB, installs components with composer, sets up wordpress, deploys and browses to wordpress.  
Variables
  
| Variable | Default Value | Notes |
| --- | --- | --- |
| PROJECT_ID | project-1 |  |
| GCE_REGION | asia-northeast1 |  |
| GCE_ZONE | a |  |
| SQL_SERVER_INSTANCE_NAME | wp |  |
| PATH_TO_YOUR_SERVICE_ACCOUNT_JSON |  |  |
| SQL_ROOT_PASSWORD | KL7wf1nggh |  |
| SQL_DB_NAME | wp |  |
| SQL_DB_USER | wp |  |
| SQL_DB_PASSWORD | #569y8A4  |  |
<br />  