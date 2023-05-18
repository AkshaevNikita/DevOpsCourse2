# Запускаем скрипт развертывания
```./deploy.sh ```

# Получаем IP-адрес Istio gateway
``` kubectl get service istio-ingressgateway -n istio-system ```

# Делаем GET-запрос к первому микросервису
``` curl http://<IP-адрес Istio gateway>/first ```
