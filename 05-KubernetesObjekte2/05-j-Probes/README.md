# liveness / readiness Probes

## Beispiel: livenessProbe mit exec

`kubectl apply -f liveness-exec.yaml`

`watch kubectl get pods`

`kubectl get events`

## Beispiel: livenessProbe mit http

`kubectl apply -f liveness-http.yaml`

`watch kubectl get pods`

`kubectl get events`

```go
http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
    duration := time.Now().Sub(started)
    if duration.Seconds() > 10 {
        w.WriteHeader(500)
        w.Write([]byte(fmt.Sprintf("error: %v", duration.Seconds())))
    } else {
        w.WriteHeader(200)
        w.Write([]byte("ok"))
    }
})
```

## Bespiel: readinessProbe mit exec

`kubectl apply -f readiness-exec.yaml`

`watch kubectl get pods`

`kubectl get events`