FROM tomcat
MAINTAINER garegin.ayvazyan@ucom.am, garegin.ayvazyan@hotmail.com
RUN apt-get update && apt-get install -y git curl wget net-tools vim elinks sudo gnupg gnupg2 gnupg1 software-properties-common alien libaio1 apache2
RUN curl --silent --location https://deb.nodesource.com/setup_6.x | sudo bash -
RUN apt-get install -y nodejs build-essential npm
RUN git clone https://github.com/crackoffnet/vas_app.git /tmp/vas_app/
WORKDIR /tmp/vas_app/
RUN alien -i oracle-instantclient11.2-basic-11.2.0.3.0-1.x86_64.rpm
RUN alien -i oracle-instantclient11.2-devel-11.2.0.3.0-1.x86_64.rpm
RUN alien -i oracle-instantclient11.2-jdbc-11.2.0.3.0-1.x86_64.rpm
RUN alien -i oracle-instantclient11.2-sqlplus-11.2.0.3.0-1.x86_64.rpm
RUN sed -i -e 's/8080/8070/g' /usr/local/tomcat/conf/server.xml
WORKDIR /tmp/vas_app/autoweb/
RUN npm install
RUN npm install --global grunt
RUN npm install --global grunt-cli bower grunt-karma karma karma-phantomjs-launcher karma-jasmine jasmine-core phantomjs-prebuilt --save-dev
RUN bower install --allow-root
RUN grunt build
RUN mkdir /var/www/html/backend_jars
RUN cp ../vta*.jar /var/www/html/backend_jars/
RUN cp -avr /tmp/vas_app/autoweb/dist/. /var/www/html/
RUN sed -i -e 's/8080/8070/g' /usr/local/tomcat/conf/server.xml \
        && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/servername.conf \
