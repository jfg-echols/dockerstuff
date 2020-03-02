docker network create --driver overlay frontend
zgh4dv8mla3ana1wg7g3y0ctr

docker network create --driver overlay backend
zgh4dv8mla3ana1wg7g3y0ctr

docker service create --name vote --network frontend -p 80:80 --replicas=3 bretfisher/examplevotingapp_vote
i89f2003cmlic4plnbf5xu502

docker service create --name redis --network frontend --replicas=2 redis:3.2
miwtlyvk0680svgfremyqsctw

docker service create --name worker --network frontend --replicas=1 bretfisher/examplevotingapp_worker:java
hh1rk3855nemdzhtwfylox90o
docker service update --network-add backend worker

docker volume create --label postgresvol
d0cda0a89cdd2fbb3163cfa181b0879dbf9e6d28b2a5f2ae5d1c55c13ccfcf36

docker service create --name db --network backend --replicas=1 --env POSTGRES_PASSWORD=example --mount src=postgresvol,dst='/var/lib/postgresql/data' postgres:9.4
y0arom9jisk5nwb28yjivbqvu

docker service create --name result --replicas=1 -p 6969:80 --network backend bretfisher/examplevotingapp_result
a8ank59ujtzx7gbzx04sislno