docker build -t csteel/multi-client:latest -t csteel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t csteel/multi-server:latest -t csteel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t csteel/multi-worker:latest -t csteel/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push csteel/multi-client:latest
docker push csteel/multi-client:$SHA
docker push csteel/multi-server:latest
docker push csteel/multi-server:$SHA
docker push csteel/multi-worker:latest
docker push csteel/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=csteel/multi-server:$SHA
kubectl set image deployments/client-deployment client=csteel/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=csteel/multi-worker:$SHA