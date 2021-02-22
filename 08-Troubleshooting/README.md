# 08-Troubleshooting

Übungen zum Troubleshootingen

Zwischen den Übungen empfiehlt es sich mit den Scripten

* `./cleanup.sh`
* `./create_namespace.sh`

Einen sauberen Stand zu erzeugen.

## (a) Warmup

### Setup

* Erstelle den Namespace k8s-workshop mit dem Script
  `./create_namespace.sh`
* Deploye die yaml Manifeste im Verzeichnis 08-a-warmup:
  `kubectl apply -f ./08-a-warmup`

### Aufgabe:

Untersuche den Cluster
Was ist hier falsch? Warum wird der Pod nicht gestartet?
Korrigiere die Manifeste und behebe den Fehler.

## (b) Wilde13

### Setup

* CleanUP: `./cleanup.sh ; ./create_namespace.sh`
* `kubectl apply -f ./08-b-wilde13`

Es ist Freitag der 13. Dein Kollege hat ein Deployment Eurer Applikation durchgeführt.
Das Ergebnis siehst Du im Cluster. Von der alten Version läuft noch ein Pod, aber die neue Version funktioniert scheinbar nicht.

### Rolle das Deployment zurück. Benutze dazu nur kubectl !

# Lösungen

## (a) Warmup

```yaml
IyBEYXMgQ29udGFpbmVyIEltYWdlIGlzdCBmYWxzY2ggYW5nZWdlYmVuLgoKIyBLb3JyZWt0OgogICAgc3BlYzoKICAgICAgY29udGFpbmVyczoKICAgICAgLSBuYW1lOiBoZWxsby1hcHAKICAgICAgICBpbWFnZTogaGFyYm9yMi5jc3ZjZGV2LnZwYy5hcnZhdG8tc3lzdGVtcy5kZS9rOHMtd29ya3Nob3AvaGVsbG8tYXBwOjEuMA==
```

## (b) Wilde13

```bash
a3ViZWN0bCByb2xsb3V0IGhpc3RvcnkgZGVwbG95bWVudCBoZWxsb3dlYgoKa3ViZWN0bCByb2xsb3V0ICB1bmRvIGRlcGxveW1lbnQgaGVsbG93ZWIgLS10by1yZXZpc2lvbj0x
``` 


