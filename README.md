# Docker Configuration Files for DocPath Electronic Signature Integration (ESI)

This is a complete example about how to deploy DocPath ® Electronic Signature Integration in Linux using Docker. The example must be completed with the following files in the same directory as the repositorized files:

- `esi-installer-2.x.y.jar`: DocPath ® Electronic Signature Integration Installer.
- `DocPath License File.olc`: License file.
 
## Steps 
To successfully perform the example, follow the steps as indicated below:
- Use the `openjdk:8` image. This is a Linux Debian image with OpenJDK 8 pre-installed.
- Install DocPath ® Electronic Signature Integration.
- Copy the license file into the image.
- Use port 1795 to receive generation requests.
- Run the `run.sh` file on the container entrypoint. `run.sh` is performed as follows:
  - Starts the license server to allow DocPath ® Electronic Signature Integration 2 execution.
  - Deploys DocPath ® Electronic Signature Integration 2.

## Necessary changes
- Change the `esi-installer-2.x.y.jar` with the corresponding version of DocPath ® Electronic Signature Integration 2.
- Change the `DocPath_License_File.olc` file with the corresponding license filename.

## How to build and deploy
Now we are going to build the container by executing the following sentence in the same directory where the dockerfile file is located:

`docker build -t docpath/esi .`

**IMPORTANT!** the full stop at the end indicates the directory where the container is located. This is mandatory.

In the installation, the following values has been taken by default:
- -adminusername**admin**
- -adminpassword**admin**
- -licserverpath **/usr/local/docpath/licenseserver**
- -licserverport**1765**
- -databaseserver**MySQL** 
- -databasename**dpesi** 
- -databasehost**localhost** 
- -databaseport**3306** 
- -databaseuser**root**
- -databasepassword**root**
- -databasecheckconnection**false**

Run the container once it has been built, using the following sentence:

`docker run --name esi --hostname <container_hostname> --detach -p 1795:1795 -e DB_TYPE=<db_type> -e DB_HOST=<db_ip> -e DB_PORT=<db_port> -e DB_USER=<db_user> -e DB_PASS=<db_pass> -e DB_NAME=<db_name> -e AIM_URL=<aim_url> -e AIM_TOKEN=<aim_token> docpath/esi`

The used parameters are:
- `--name`: this parameter indicates the name of the container, in this case esi.
- `--hostname`: this parameter indicates the hostname of the machine with the license.
- `--detach`: this parameter indicates that no messages are displayed in the execution console, silent mode.
- `-p 1795:1795`: this parameter indicates the port of both host machine and esi.
- `docpath/esi`: this is the name assigned previously while building the container.
- `db_type`: Type of the database (MySQL or SQLServer).
- `db_ip`: IP of the database.
- `db_port`: Port of the database.
- `db_user`: User with privileges to connect to the database.
- `db_pass`: Password of the user with privileges.
- `db_name`: Name of the database or schema where ESI is installed.
- `aim_url`: AIM application URL.
- `aim_token`: Application token in AIM.
