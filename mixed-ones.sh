#1
docker run -itd -v $PWD/n1:/var/log/nginx -v $PWD/n1.conf:/etc/nginx/conf.d/default.conf -v $PWD/nginx.conf:/etc/nginx/nginx.conf -v $PWD/index.php:/etc/nginx/html/index.php --name n1 -p 8081:8081 nginx:latest
#2
docker run -itd -v $PWD/n2:/var/log/nginx -v $PWD/n2.conf:/etc/nginx/conf.d/default.conf --name n2 -p 8082:8082 nginx:latest
#3
docker run -itd -v $PWD/n3:/var/log/nginx -v $PWD/n3.conf:/etc/nginx/conf.d/default.conf --name n3 -p 
8083:8083 nginx:latest
#4
docker run -itd -v $PWD/n4:/var/log/nginx -v $PWD/n4.conf:/etc/nginx/conf.d/default.conf --name n4 -p 8085:8085 nginx:latest
#5
docker run -itd -v $PWD/app:/var/log/apache2 -v $PWD/index.html:/var/www/html/index.html --name app -p 8084:80 awsdevopro/apache-php56

docker exec -i n2 service nginx reload && docker exec -i n1 service nginx reload && docker exec -i n3 service nginx reload


seq 1 5 | xargs -n1 -P10  curl "http://172.17.0.1:8081"

### nginx milliseconds format

https://serverfault.com/questions/732395/can-nginx-log-time-in-iso-8601-format-but-include-milliseconds

Fpr application testing

### http load testing application: 

`docker run -it --rm -t rufus/siege-engine -b -r 2 -c 30 curl http://172.17.0.1:8081`
Dockerfile: https://hub.docker.com/r/rufus/siege-engine/dockerfile


### Misscellenious
docker run -it -v $PWD/tests:/jmeter/apache-jmeter-5.4/bin/tests awsdevopro/jmmaster bash
date; X="LT-1-5"; date; jmeter -Jserver.rmi.ssl.disable=true -n -t ./nginx-tps-testing.jmx -l ./nginx-${X}_csv_$(date +"%F_%H%M").csv -e -o ./nginx-${X}_reports_$(date +"%F_%H%M"); date
--------------------------

docker run -it --rm -t rufus/siege-engine -b -r 1 -c 30 curl http://172.17.0.1:8081

Document: https://www.joedog.org/articles-tuning/

docker run -itd --rm -p 9000:9000 --name php-fpm php:fpm