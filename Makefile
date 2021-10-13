.PHONY: clean network db koha

clean:
	docker rm -f koha-db koha
	docker network rm koha

network:
	docker network create koha

db:
	docker run -d \
  --name koha-db \
  --network koha \
  -e MYSQL_DATABASE=koha_sample \
  -e MYSQL_PASSWORD=koha \
  -e MYSQL_ROOT_PASSWORD=koha \
  -e MYSQL_USER=koha \
  mysql:5.6.20

koha:
	docker run -d \
  --name koha \
  --network koha\
  -p 6001:6001 \
  -p 8080:8080 \
  -p 8081:8081 \
  -e KOHA_DBHOST=koha-db \
  -e KOHA_INSTANCE=sample \
  -e KOHA_ADMINUSER=koha \
  -e KOHA_ADMINPASS=koha \
  -t digibib/koha:2021-08-27.hotfix.b1
