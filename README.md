# Testing for Docker containers   
This is my first test with Docker containers that work towards an infrastructure as code.   

# Setup   
Current idea is to create on the hardware directories with your favorite configuration management tool. Idea is to create 2 directories:   
/hdfs-data   
/hdfs-nn   

Each directory has a location to the desired projectname. In this case we use "management" as an example:   
   
/hdfs-data/management   
/hdfs-nn/management   
   
# Starting the container   
Add volumes to your container, you choose if you would like to use docker volumes or persistent path's directly on the host machine.   
   
Example command to start container:    
docker run --net=host -i -t -v /hdfs-nn/management:/hdfs-nn/ -v /hdfs-data/management/:/hdfs-data/ anldisr/hdfs-docker-nn   

