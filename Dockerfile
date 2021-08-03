FROM openjdk:8

RUN apt-get update && apt-get install -y apt-utils && apt-get install -y lib32stdc++6 gcc-multilib procps
RUN mkdir -p /required_files
COPY esi-installer-2.x.y.jar /required_files/esi-installer.jar
WORKDIR /required_files
RUN java -jar esi-installer.jar -console -solname"DocPath ESI Service Pack" -solution"/usr/local/docpath/esi/esiserver" -adminusernameadmin -adminpasswordadmin -licserverpath"/usr/local/docpath/licenseserver" -licserverport"1765" -install -silentmode -databaseserver"MySQL" -databasename"dpesi" -databasehost"localhost" -databaseport"3306" -databaseuser"root" -databasepassword"root" -databasecheckconnectionfalse
RUN java -jar esi-installer.jar -console -solname"DocPath ESI Client Pack" -solution"/usr/local/docpath/esi/esiclient" -adminusernameadmin -adminpasswordadmin -licserverpath"/usr/local/docpath/licenseserver" -licserverport"1765" -install -silentmode -databaseserver"MySQL" -databasename"dpesi" -databasehost"localhost" -databaseport"3306" -databaseuser"root" -databasepassword"root" -databasecheckconnectionfalse
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/docpath/esi/esiclient
WORKDIR /
RUN rm -rf /required_files
COPY licenseserver.ini /usr/local/docpath/licenseserver/licenseserver/Configuration/
COPY DocPath_License_File.olc /usr/local/docpath/Licenses/
COPY run.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/run.sh
EXPOSE 1795

ENTRYPOINT ["/usr/local/bin/run.sh"]
