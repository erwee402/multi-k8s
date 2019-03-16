docker build -t erwee402/multi-client:latest -t erwee402/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t erwee402/multi-server:latest -t erwee402/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t erwee402/multi-worker:latest -t erwee402/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push erwee402/multi-client:latest
docker push erwee402/multi-server:latest
docker push erwee402/multi-worker:latest

docker push erwee402/multi-client:$SHA
docker push erwee402/multi-server:$SHA
docker push erwee402/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=erwee402/multi-server:$SHA
kubectl set image deployments/client-deployment client=erwee402/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=erwee402/multi-worker:$SHA
