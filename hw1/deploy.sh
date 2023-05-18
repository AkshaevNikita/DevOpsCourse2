#!/bin/zsh

# Создаем namespace
kubectl create namespace my-namespace

# Устанавливаем Istio
istioctl install --set profile=demo -y
kubectl label namespace my-namespace istio-injection=enabled

# Создаем deployment и service для первого микросервиса
kubectl apply -f deployment-first.yaml -n my-namespace
kubectl apply -f service-first.yaml -n my-namespace

# Создаем deployment и service для второго микросервиса
kubectl apply -f deployment-second.yaml -n my-namespace
kubectl apply -f service-second.yaml -n my-namespace
kubectl apply -f ingress-gateway.yaml -n my-namespace
kubectl apply -f egress-gateway.yaml -n my-namespace

# Создаем egress для доступа к API "The Breaking Bad API"
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: api-breaking-bad
spec:
  hosts:
  - breakingbadapi.com
  ports:
  - number: 80
    name: http
    protocol: HTTP
  resolution: DNS
EOF

# Создаем gateway и virtualservice
kubectl apply -f istio-gateway.yaml -n my-namespace
kubectl apply -f istio-virtualservice.yaml -n my-namespace

