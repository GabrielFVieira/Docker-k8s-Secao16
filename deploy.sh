docker build -t gabrielfvieira/multi-client-k8s:latest -t gabrielfvieira/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t gabrielfvieira/multi-server-k8s:latest -t gabrielfvieira/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t gabrielfvieira/multi-worker-k8s:latest -t gabrielfvieira/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push gabrielfvieira/multi-client-k8s:latest
docker push gabrielfvieira/multi-server-k8s:latest
docker push gabrielfvieira/multi-worker-k8s:latest

docker push gabrielfvieira/multi-client-k8s:$SHA
docker push gabrielfvieira/multi-server-k8s:$SHA
docker push gabrielfvieira/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gabrielfvieira/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=gabrielfvieira/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=gabrielfvieira/multi-worker-k8s:$SHA