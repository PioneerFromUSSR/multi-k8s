docker build -t kernelpanic33/multi-client:latest -t kernelpanic33/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kernelpanic33/multi-server:latest -t kernelpanic33/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kernelpanic33/multi-worker:latest -t kernelpanic33/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kernelpanic33/multi-client:latest
docker push kernelpanic33/multi-server:latest
docker push kernelpanic33/multi-worker:latest

docker push kernelpanic33/multi-client:$SHA
docker push kernelpanic33/multi-server:$SHA
docker push kernelpanic33/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kernelpanic33/multi-server:$SHA
kubectl set image deployments/client-deployment client=kernelpanic33/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kernelpanic33/multi-worker:$SHA


