#! /bin/bash

#check whether user have sudo permission or not

sudo -n true
if [ $? -ne 0 ]
    then
        echo "The user have not enough permision"
        exit
fi



#function for dependency check
Check_java(){
    java -version
    if [ $? -ne 0 ]      #checking java is installed in system or not
        then
            sudo brew install openjdk-7-jre-headless -y   #if java is not install in the system,it will install with the help of this command and elk require 7 ot 7+ version of java for setup.
    elif[ "`java -version 2> /tmp/version && awk '/version/ { gsub(/"/, "", $NF); print ( $NF < 1.7 ) ? "YES" : "NO" }' /tmp/version`" == "YES" ]
        then    
            brew install openjdk-7-jre-headless -y
    fi
}




install_elastic(){
    #install logstash 
    brew upgrade
    

    #install elasticsearch
    brew update
    brew install elasticsearch
    tar -xvf elasticsearch-2.3.1.tar.gz
    brew services start elasticsearch

    #modifying .bash_profile to set path variable
    # cd ~/.bash_profile
    # echo "export ES_HOME=~/apps/elasticsearch/elasticsearch-2.3.1" | sudo tee -a destination.txt
    # echo "export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_77/Contents/Home" | sudo tee -a destination.txt
    # echo "export PATH=$ES_HOME/bin:$JAVA_HOME/bin:$PATH" | sudo tee -a destination.txt

    #add these path variables to .bash_profile 
}

install_kibana(){

    #install kibana
    curl -L -O https://download.elastic.co/kibana/kibana/kibana-4.3.0-darwin-x64.tar.gz
    cd /path/to/archive
    tar -zxvf kibana-4.3.0-darwin-x64.tar.gz


    #open kibana.yml and made changes in config file.
    # The Elasticsearch instance to use for all your queries.
    # elasticsearch.url: "http://localhost:9200"
}

install_logstash{
    #install logstash
    brew install logstash
    brew services start logstash

}

system=1

if [ $system -et 1]
    then
        Check_java
        install_elastic
        install_kibana
        install_logstash
else
    then
     echo "This script doesn't support ELK installation on this OS."
fi