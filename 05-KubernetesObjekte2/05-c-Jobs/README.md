# Jobs

## YAML
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: dice
spec:
  completions: 4
  parallelism: 1
  template:
    spec:
      containers:
      - name: dice
        image: busybox
        command:
          - /bin/sh
          - -c
          - | 
            if [ $(($RANDOM % 2 + 1)) -eq 2 ]; then
              echo "Pair - you are complete" 
              exit 0
            else
              echo "Impair - try again"
              exit 1
            fi
      restartPolicy: Never
  backoffLimit: 24
```

## Demo
* `kubectl apply -f dice-job.yaml`
* `watch kubectl get jobs,pods`
* `kubectl delete job dice`
* `kubectl get pods`

# CronJobs

## YAML
```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "*/1 * * * *"
  concurrencyPolicy: Forbid
  startingDeadlineSeconds: 100
  suspend: false
  successfulJobsHistoryLimit: 2
  failedJobsHistoryLimit: 2
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox
            imagePullPolicy: IfNotPresent
            args:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
```

## Demo
* `kubectl apply -f hello-cronjob.yaml`
* `watch kubectl get jobs,pods`