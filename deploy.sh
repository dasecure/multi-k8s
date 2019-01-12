docker build -t dasecure/multi-client:latest -t dasecure/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dasecure/multi-server:latest -t dasecure/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dasecure/multi-worker:latest -t dasecure/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dasecure/multi-client:latest
docker push dasecure/multi-server:latest
docker push dasecure/multi-worker:latest

docker push dasecure/multi-client:$SHA
docker push dasecure/multi-server:$SHA
docker push dasecure/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=dasecure/multi-server:$SHA
kubectl set image deployments/client-deployment client=dasecure/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dasecure/multi-worker:$SHA
