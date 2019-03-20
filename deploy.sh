docker build -t fernandopalmeiro/multi-client:latest -t fernandopalmeiro/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fernandopalmeiro/multi-server:latest -t fernandopalmeiro/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fernandopalmeiro/multi-worker:latest -t fernandopalmeiro/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push fernandopalmeiro/multi-client:latest
docker push fernandopalmeiro/multi-server:latest
docker push fernandopalmeiro/multi-worker:latest

docker push fernandopalmeiro/multi-client:$SHA
docker push fernandopalmeiro/multi-server:$SHA
docker push fernandopalmeiro/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fernandopalmeiro/multi-server:$SHA
kubectl set image deployments/client-deployment client=fernandopalmeiro/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fernandopalmeiro/multi-worker:$SHA