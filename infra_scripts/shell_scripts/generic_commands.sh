# Jenkins
# -------
# docker run -d -p 80:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home dvzpoc/jenkins:latest (Docker version)
# docker exec 03ad45ee0870 cat /var/jenkins_home/secrets/initialAdminPassword
# PWD: 927dde068fe74da7b55adfd2ae15e4c5

# taskmeui
# ---------
# docker run -d -p 5000:5000 --name taskmeui dvzpoc/taskmeui:latest 

# taskmedb
# --------
# docker run -d -p 3000:3000 --name taskmedb dvzpoc/taskmedb:latest 

# Redis
# ---------
# docker run --name taskmeds-redis -d dvzpoc/redis:latest redis-server --appendonly yes
# redis-cli
# Keys *
# flushall (Delete All)
# set name raaja
# get name
# del name


 #This is for initial postgreSQL setup and up the container
 #----------------------------------------------------------
 # --mount type=bind,source="$(Get-Location)"\postgresdata,target=/var/lib/postgresql/data ` For Bind
 # --mount type=volume,source=postgresdata,target=/var/lib/postgresql/data ` For Volume
#  docker run -d -p 5432:5432 `
#      --network adminui-backend --network-alias transientDB `
#      -e POSTGRES_USER=python_user `
#      -e POSTGRES_PASSWORD=deloittevzpoc `
#      -e POSTGRES_DB=TransientDataStore `
#      --mount type=volume,source=postgresdata,target=/var/lib/postgresql/data `
#     dvzpoc/edgeonprem_postgres:latest

 #This is for subsequent postgreSQL container up       
 #-----------------------------------------------
 # --mount type=bind,source="$(Get-Location)"\postgresdata,target=/var/lib/postgresql/data ` For Bind
 # --mount type=volume,source=postgresdata,target=/var/lib/postgresql/data ` For Volume
 # Use --network-alias transientdb when required to explicity specify the alias for DB server
#  docker run -d -p 5432:5432 `
#      --network adminui-backend `
#     dvzpoc/edgeonprem_postgres:latest
 

#  #This is for adminer UI container up   
#  #------------------------------------------------
#  docker run -d -p 8080:8080 `
#     --network adminui-backend `
#     dvzpoc/edgeonprem_postgresql_ui:latest

# #This is for PG Admin PostgresSQL UI container up   
# #------------------------------------------------
# #--mount type=bind,source="$(Get-Location)"/target,target=/var/lib/pgadmin/storage/ `
# docker run -d -p 5555:80 `
# --network adminui-backend `
# --name pgadminUI `
# -e "PGADMIN_DEFAULT_EMAIL=admin@domain.com" `
# -e "PGADMIN_DEFAULT_PASSWORD=AdminAdmin" `
# dvzpoc/edgeonprem_postgresql_ui:v2


    # #Start Kafka service firsttime
    # #-----------------------------
    # docker run -d -p 2181:2181 -p 9092:9092 --network adminui-backend --name kafka `
    #     --env ADVERTISED_HOST=localhost `
    #     --env ADVERTISED_PORT=9092 `
    #     --env CONSUMER_THREADS=4 `
    #     --env ZK_CONNECT=localhost:2181 `
    #     --env GROUP_ID=aieismgroup `
    #     --env KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://broker:9092 `
    # dvzpoc/edgeonprem_kafka:baseimage
    
    
    # #Start Kafka service sub sequenct times
    # #--------------------------------------
    #     docker run -d -p 2181:2181 -p 9092:9092 --network adminui-backend `
    # dvzpoc/edgeonprem_kafka:latest
    
    
    # #Create a Topic
    # #--------------
    # docker exec ca43ec168af8 /opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 2 --topic mltrainingvideoclips-topic
    # docker exec ca43ec168af8 /opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 2 --topic workorderdefects-topic
    # docker exec ca43ec168af8 /opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 2 --topic workcentersensors-topic
    # docker exec ca43ec168af8 /opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 2 --topic vqaerrorstats-topic
    # docker exec ca43ec168af8 /opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 2 --topic staticdata-topic
    # docker exec ae0a42bb7757 /opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 2 --topic edgesmart-messagebus-monitor
        
    # #Delete a Topic
    # #--------------
    # docker exec ca43ec168af8 /opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic trainingclips-topic
    
    
    # #List Topics
    # #-----------
    # docker exec ae0a42bb7757 /opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh --list --zookeeper localhost:2181
    
    
    # #Describe the topic
    # #--------------------------------------------
    # ./kafka-topics.sh --describe  --zookeeper localhost:2181 --topic workorderdefects-topic
    
    
    # #Start a producer (in a new terminal window)
    # #------------------------------------------
    # #docker run -it --rm --network adminui-backend --link 1508ea732373 deloittevzpoc/edgeonprem_kafka:baseimage /opt/kafka_2.11-0.10.1.0/bin/kafka-console-producer.sh --broker-list 1508ea732373:9092 --topic trainingclips-topic
    # ./kafka-console-producer.sh --topic workorderdefects-topic --broker-list localhost:9092
    
    
    # #Start a consumer (in a new terminal window)
    # #-------------------------------------------
    # #docker run -it --rm --network adminui-backend --link 1508ea732373 deloittevzpoc/edgeonprem_kafka:baseimage /opt/kafka_2.11-0.10.1.0/bin/kafka-console-consumer.sh --bootstrap-server 1508ea732373:9092 --topic trainingclips-topic --from-beginning
    # ./kafka-console-consumer.sh --topic workorderdefects-topic --bootstrap-server localhost:9092 --from-beginning
    
    # #To change log retention period in Kafka use below commands
    # #sh kafka-topics.sh --zookeeper localhost:2181 --alter --topic workorderdefects-topic --config retention.ms=86400000
    # #sh kafka-configs.sh --describe --zookeeper localhost:2181 --topic workorderdefects-topic

    #     #Soft Delete the Kafka Topics
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name mltrainingvideoclips-topic --entity-type topics  --add-config retention.ms=1000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name workorderdefects-topic --entity-type topics  --add-config retention.ms=1000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name workcentersensors-topic --entity-type topics  --add-config retention.ms=1000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name vqaerrorstats-topic --entity-type topics  --add-config retention.ms=1000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name staticdata-topic --entity-type topics  --add-config retention.ms=1000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name edgesmart-messagebus-monitor --entity-type topics  --add-config retention.ms=1000

    #     #Set the default log retention for Kafka Topics
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name mltrainingvideoclips-topic --entity-type topics  --add-config retention.ms=24400000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name workorderdefects-topic --entity-type topics  --add-config retention.ms=24400000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name workcentersensors-topic --entity-type topics  --add-config retention.ms=24400000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name vqaerrorstats-topic --entity-type topics  --add-config retention.ms=24400000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name staticdata-topic --entity-type topics  --add-config retention.ms=24400000
    #     sh kafka-configs.sh --zookeeper localhost:2181 --alter --entity-name edgesmart-messagebus-monitor --entity-type topics  --add-config retention.ms=24400000



    # #Start Kafka UI service with Proxy 1
    # #-----------------------------------
    # # --rm : To automatically remove the container when exit
    # docker run -d -p 9000:9000 --network adminui-backend `
    # -e KAFKA_BROKERCONNECT=host.docker.internal:9092 `
    # obsidiandynamics/kafdrop
       
    # #Start Kafka UI service with Proxy 2
    # #-----------------------------------
    # docker run -d provectuslabs/kafka-ui:latest `
	# -e KAFKA_CLUSTERS_0_NAME=dockerlocal `
    # -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=host.docker.internal:9092
    
    # #Start Kafka UI service with Proxy 3
    # #-----------------------------------
    # docker run -d --rm -p 8080:80 --network adminui-backend `
    # dvzpoc/edgeonprem_kafka_ui:baseimage


    # #Start Airflow service and UI firsttime
    # #---------------------------------------
    # # --mount type=bind,source="$(Get-Location)"\airflowdags,target=/usr/local/airflow/dags ` For Bind
    # # --mount type=volume,source=airflowdags,target=/usr/local/airflow/dags ` For Volume
    # docker run -d -p 5151:8080 `
    # --mount type=bind,source="$(Get-Location)"\airflowdags,target=/usr/local/airflow/dags `
    # --network adminui-backend dvzpoc/cloud_airflow:latest webserver


    # #Start Airflow service and UI sub sequent times
    # #----------------------------------------------
    # docker run -d -p 5151:8080 `
    # --network adminui-backend dvzpoc/cloud_airflow:latest webserver


    # #To Copy Python DAG Files as below into Container DAGS path
    # #-----------------------------------------------------------
    # docker cp DeloitteVzSampleDAG.py 38c981520cd0:/usr/local/airflow/dags

    # #To directly log into docker container and change code and content under k8 environement
    # kubectl exec --user root airflow-deployment-5dfd75b767-tz5sb -it -- bash
    # docker exec -u root -it 38c981520cd0 /bin/bash


    
    # #Below are Sample Python DAG file
    # #----------------------------------------
    # # import datetime as dt

    # # from airflow import DAG
    # # from airflow.operators.bash_operator import BashOperator
    # # from airflow.operators.python_operator import PythonOperator


    # # def greet():
    # #     print('Writing in file')
    # #     with open('path/to/file/greet.txt', 'a+', encoding='utf8') as f:
    # #         now = dt.datetime.now()
    # #         t = now.strftime("%Y-%m-%d %H:%M")
    # #         f.write(str(t) + '\n')
    # #     return 'Greeted'
    # # def respond():
    # #     return 'Greet Responded Again'
        

    # # default_args = {
    # #     'owner': 'airflow',
    # #     'start_date': dt.datetime(2018, 9, 24, 10, 00, 00),
    # #     'concurrency': 1,
    # #     'retries': 0
    # # }

    # # with DAG('DeloitteVzSample_DAG',
    # #         default_args=default_args,
    # #         schedule_interval='*/10 * * * *',
    # #         ) as dag:
    # #     opr_hello = BashOperator(task_id='say_Hi',
    # #                             bash_command='echo "Hi!!"')

    # #     opr_greet = PythonOperator(task_id='greet',
    # #                             python_callable=greet)
    # #     opr_sleep = BashOperator(task_id='sleep_me',
    # #                             bash_command='sleep 5')

    # #     opr_respond = PythonOperator(task_id='respond',
    # #                                 python_callable=respond)
    # # opr_hello >> opr_greet >> opr_sleep >> opr_respond



#  #This is for subsequent grafana container up       
#  #-----------------------------------------------
#  docker run -d -p 3000:3000 `
#      --network adminui-backend `
#     dvzpoc/edgeonprem_grafana:v14
 

#     #To Copy Grafana Plugins into Container Plugin path
#     #--------------------------------------------------
#     docker cp dc-single-stat e25bb64faf63:/var/lib/grafana/plugins


#     # REST API URL on RAFAY
#     #----------------------
#     http://10.100.50.22:32762/


#     # REST API URL on AWS Cloud
#     #--------------------------
#     http://54.205.72.13:32763/



    #  #Hadoop Commands To start
    # #-------------------------
    # #SHA256:2wtKTqjQ8ZNE+yg/3sFhilg5UKc0mCOZWO2V0CxWz4s
    # #Used below ref. to prepare the single node Hadoop cluster
    # #https://www.youtube.com/watch?v=4OtquWbcfNg&list=PL4aAubWarQqgNcy_K1PkgZp2b92eHrffL&index=2

    # #Hadoop Home: /usr/local/hadoop
    # #Hadoop server Admin. credentials: ubuntu/098RanD0MPa$$W0rD
    # #Hadoop server Dev. credentials: hduser/admin

    #     #Use below commands to start the Hadoop server
    #     su hduser/admin
    #     start-all.sh / stop-all.sh
    #     nohup start-all.sh > /tmp/log.out  2>&1 &
    #     start-dfs.sh
    #     start-yarn.sh
    #     start-jps.sh
        

    # #Hive Commands to interact with that
    # #-----------------------------------
    # #Used below ref. to prepare the Hive environment
    # #https://www.youtube.com/watch?v=yqEP9ILcSyI&t=10s

    # #Hive Home: /usr/local/hive

    #     #Use below commands Initialize the Hive Meta store 
    #     #hive --service metastore

    #     #To execute the HiveServer use below commands
    #     #docker exec -it docker-hive_hive-server_1 /bin/bash
    #     #/opt/hive/bin/beeline -u jdbc:hive2://localhost:10000 #Docker way

    #     #Below DBs are available to access
    #     #deloittevzpoc_staging
    #     #deloittevzpoc_aggregation 

    #     #Use below command to start the Hiveserver2 service
    #     hive --service hiveserver2
    #     nohup hive --service hiveserver2 > /tmp/log.out  2>&1 &
    #     #ps -ef | grep hive

    #     #To add the user (ubuntu) in hadoop (Group)    
    #     Linux: 
    #     sudo usermod -a -G hadoop hduser
    #     sudo chmod 777 -R /usr/local/hadoop/
        
    #     Hadoop: 
    #     hadoop fs -chown -R root:hadoop /user/hive/warehouse/
    #     hadoop fs -chown -R hduser:hadoop /user/hive/warehouse/
        
    #     #To access Hive from Beeline client on Host machine itself
    #     #/usr/local/hive/bin/beeline -u jdbc:hive2://localhost:10000 #Baremetal Way
    #     !connect jdbc:hive2://
    #     /usr/local/hive/bin/beeline -u jdbc:hive2://

    #     #To access Hive from Beeline client from machine itself in TCP Mode
    #     !connect jdbc:hive2://52.21.54.61:10000 hduser admin org.apache.hive.jdbc.HiveDriver #Worked
    #     /usr/local/hive/bin/beeline -u jdbc:hive2://52.21.54.61:10000 hduser admin org.apache.hive.jdbc.HiveDriver 

    #     #To access Hive from Beeline client from machine itself in HTTP Mode
    #     /usr/local/hive/bin/beeline -u jdbc:hive2://52.21.54.61:10000/hive.server2.transport.mode=http;hive.server2.thrift.http.path=cliservice
    #     !connect jdbc:hive2://52.21.54.61:10000/hive.server2.transport.mode=http;hive.server2.thrift.http.path=cliservice
        
    #     #IfSecuredby Kerbos use below string
    #     !connect jdbc:hive2://52.21.54.61:10000/hive.server2.transport.mode=http;hive.server2.thrift.http.path=cliservice;principal=hive/hduser@REALM
    #     /usr/local/hive/bin/beeline -u jdbc:hive2://52.21.54.61:10000/hive.server2.transport.mode=http;hive.server2.thrift.http.path=cliservice;principal=hive/HOST@REALM
    #     #(OR)
    #     !connect jdbc:hive2://52.21.54.61:10000/principal=<Server_Principal_of_HiveServer2> 
    #     /usr/local/hive/bin/beeline -u jdbc:hive2://52.21.54.61:10000/principal=<Server_Principal_of_HiveServer2> 
    
        
    # #MySQLMetastore
    # #---------------
    # #Used below ref. to prepare the metastore for Hive
    # #http://hiveexperiments.blogspot.com/2015/07/configuring-hive-metastore-on-mysql.html

    # #Hive  to Mysql connection commands
    # #tar -xvzf mysql-connector-java-5.1.36.tar.gz 
    # #cp mysql-connector-java-5.1.36/mysql-connector-java-5.1.36-bin.jar usr/local/hive/lib/

    # #Metastore Uname and Password: mountain/mountain

    #     #Please use below commands to Install MsSQL Connetor packages
    #     #sudo dpkg -i package_file.deb
    #     #sudo apt-get remove package_name
        
    #     #Use below commands Initialize the Hive Meta store 
    #     #sudo service mysql start / Stop 
    #     #schematool -dbType mysql -initSchema  
    #     #schematool -dbType mysql -info


    # #Airflow
    # #-------
    # #transportMode=http;httpPath=cliservice --Only for HTTP Mode
    # #airflow connections -a --conn_id deloittevzpoc_hive_jdbc --conn_type jdbc --conn_host 'jdbc:hive2://52.21.54.61:10000' --conn_extra '{"extra__jdbc__drv_path" : "/usr/local/airflow/hive-jdbc-3.1.2.jar", "extra__jdbc__drv_clsname": "org.apache.hive.jdbc.HiveDriver"}'  conn_login hduser --conn_password admin
    


    # # Hadoop server User Data to start Hadoop and Hive Server
    # # !#/bin/bash

    # #sudo su hduser
    # #start-all.sh
    # #hive --service hiveserver2


    # # Hive Commands To delete all the tables from HIVE
    #     # DROP TABLE IF EXISTS alerts;
    #     # DROP TABLE IF EXISTS area;
    #     # DROP TABLE IF EXISTS completionplan;
    #     # DROP TABLE IF EXISTS defecttypes;
    #     # DROP TABLE IF EXISTS imagesmetastore;
    #     # DROP TABLE IF EXISTS inventoryplan;
    #     # DROP TABLE IF EXISTS machine;
    #     # DROP TABLE IF EXISTS machineperfldgr;
    #     # DROP TABLE IF EXISTS persona;
    #     # DROP TABLE IF EXISTS potentialrootcause;
    #     # DROP TABLE IF EXISTS resolution;
    #     # DROP TABLE IF EXISTS sensors;
    #     # DROP TABLE IF EXISTS sensorsreadings;
    #     # DROP TABLE IF EXISTS shift;
    #     # DROP TABLE IF EXISTS videosclipmetastore;
    #     # DROP TABLE IF EXISTS workcenter;
    #     # DROP TABLE IF EXISTS workorder;
    #     # DROP TABLE IF EXISTS workorderledger;
    #     # DROP TABLE IF EXISTS workordrqltystatus;



    # #HUE Hive Commands
    # #-----------------
    #     #Use below location and commands to override the Hue config
    #     #docker exec -it 07e753c1a408 bash
    #     #cd /usr/share/hue/desktop/conf
    #     #vi z-hue-overrides.ini

    #     #Set and modify below setting to connect with HIVE DW
    #     # [beeswax]
    #     # # Host where HiveServer2 is running.
    #     # # If Kerberos security is enabled, use fully-qualified domain name (FQDN).
    #     hive_server_host=localhost or host.docker.internal

    # # Port where HiveServer2 Thrift server runs on.
    # hive_server_port=10000
    
    # #Use below commands to execute and up the Hue Web UI
    # docker run -d -p 8080:8080 dvzpoc/cloud_hive_ui:baseimage

    # #Use Below Uname and Password to connect with Hue
    # #Uname/Pwd: admin/admin
	    
    



 



    
    