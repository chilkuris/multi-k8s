docker build -t pratsoff/multi-client:latest -t pratsoff/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pratsoff/multi-server:latest -t pratsoff/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pratsoff/multi-worker:latest -t pratsoff/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pratsoff/multi-client:latest
docker push pratsoff/multi-server:latest
docker push pratsoff/multi-worker:latest

docker push pratsoff/multi-client:$SHA
docker push pratsoff/multi-server:$SHA
docker push pratsoff/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pratsoff/multi-server:$SHA
kubectl set image deployments/client-deployment client=pratsoff/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pratsoff/multi-worker:$SHA

