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

## (c) ReadyOrNot
### Setup
* CleanUP: `./cleanup.sh ; ./create_namespace.sh`
* `kubectl apply -f ./08-c-readyornot`

Schaue Dir die Pods an. Es sieht so aus als würde der Container immer wieder restartet.
Was ist die Ursache, wo liegt der Fehler


## (d) OhOh
### Setup
* CleanUP: `./cleanup.sh ; ./create_namespace.sh`
* `kubectl apply -f ./08-d-OhOh`

Schaue Dir die Pods an. Es sieht so aus als würde der Container immer wieder restartet.
Was ist die Ursache, wo liegt der Fehler?

## (e) LongWay

### Setup
* CleanUP: `./cleanup.sh ; ./create_namespace.sh`
* `kubectl apply -f ./08-d-longway`

Die Website die hier deployed wird scheint nicht erreichbar zu sein:

Wer die Übung#2 nicht gemacht hat. Muss noch den Eintrag in der `/etc/hosts` anlegen.

```bash
$ curl website.k8s-workshop.info
<html>
<head><title>503 Service Temporarily Unavailable</title></head>
<body>
<center><h1>503 Service Temporarily Unavailable</h1></center>
<hr><center>nginx</center>
</body>
</html>
```

Was ist hier (alles) falsch?

# Lösungen

## (a) Warmup

```yaml
IyBEYXMgQ29udGFpbmVyIEltYWdlIGlzdCBmYWxzY2ggYW5nZWdlYmVuLgoKIyBLb3JyZWt0OgogICAgc3BlYzoKICAgICAgY29udGFpbmVyczoKICAgICAgLSBuYW1lOiBoZWxsby1hcHAKICAgICAgICBpbWFnZTogaGFyYm9yMi5jc3ZjZGV2LnZwYy5hcnZhdG8tc3lzdGVtcy5kZS9rOHMtd29ya3Nob3AvaGVsbG8tYXBwOjEuMA==
```

## (b) Wilde13

```bash
a3ViZWN0bCByb2xsb3V0IGhpc3RvcnkgZGVwbG95bWVudCBoZWxsb3dlYgoKa3ViZWN0bCByb2xsb3V0ICB1bmRvIGRlcGxveW1lbnQgaGVsbG93ZWIgLS10by1yZXZpc2lvbj0x
```

## (c) ReadyOrNot

RGFzIERlcGxveW1lbnQgaGF0IGVpbmUgbGl2ZW5lc3MgdW5kIHJlYWRpbmVzc1Byb2JlIGNvbmZpZ3VyaWVydCBkaWUgw7xiZXJwcsO8ZnQsIG9iIGRlciBDb250YWluZXIgcmljaHRpZyBnZXN0YXJ0ZXQgaXN0LgpEaWUgdmVyd2VuZGV0ZSBVUkwgKHBhdGgpIGlzdCBtaXQgZWluZW0gVGlwcGZlaGxlciBrb25maWd1cmllcnQgKC9oYWVsdGggc3RhdHQgL2hlYWx0aCkuIMOEbmRlcnQgbWFuIGRpZSBVUkwgZsO8ciBkZW4gQ2hlY2sgaXN0IGRhcyBQcm9ibGVtIGdlbMO2c3QuCgpQZXIga3ViZWN0bCBkZXNjcmliZSBwb2QgPD4gc2llaHQgbWFuLCBkYXNzIGRpZSBQcm9iZXMgZmVobHNjaGxhZ2VuLgpXZW5uIG1hbiBkZW4ga29ycmVrdGVuIFBmYWQgbmljaHQgc29mb3J0IGVya2VubnQsIGhpbGZ0IGVzIGRpZSBBcHBsaWthdGlvbiB6dSBhbmFseXNpZXJlbi4gRW50d2VkZXIgaW0gQ29udGFpbmVyIChleGVjICsgY2F0IGluZGV4LnBocCkgb2RlciBpbSBTb3VyY2U=

```yaml
YXBpVmVyc2lvbjogYXBwcy92MQpraW5kOiBEZXBsb3ltZW50Cm1ldGFkYXRhOgogIG5hbWU6IGhlbGxvd2ViCiAgbGFiZWxzOgogICAgYXBwOiBoZWxsbwpzcGVjOgogIHNlbGVjdG9yOgogICAgbWF0Y2hMYWJlbHM6CiAgICAgIGFwcDogaGVsbG8KICAgICAgdGllcjogd2ViCiAgdGVtcGxhdGU6CiAgICBtZXRhZGF0YToKICAgICAgbGFiZWxzOgogICAgICAgIGFwcDogaGVsbG8KICAgICAgICB0aWVyOiB3ZWIKICAgIHNwZWM6CiAgICAgIGNvbnRhaW5lcnM6CiAgICAgIC0gbmFtZTogaGVsbG8tYXBwCiAgICAgICAgaW1hZ2U6IGhhcmJvcjIuY3N2Y2Rldi52cGMuYXJ2YXRvLXN5c3RlbXMuZGUvazhzLXdvcmtzaG9wL2hlbGxvLXBocDoxLjAKICAgICAgICBpbWFnZVB1bGxQb2xpY3k6IEFsd2F5cwogICAgICAgIHBvcnRzOgogICAgICAgIC0gY29udGFpbmVyUG9ydDogODAKICAgICAgICBsaXZlbmVzc1Byb2JlOgogICAgICAgICAgaHR0cEdldDoKICAgICAgICAgICAgcGF0aDogL2hhZWx0aAogICAgICAgICAgICBwb3J0OiA4MAogICAgICAgICAgaW5pdGlhbERlbGF5U2Vjb25kczogNQogICAgICAgICAgcGVyaW9kU2Vjb25kczogNQogICAgICAgICAgdGltZW91dFNlY29uZHM6IDEKICAgICAgICAgIHN1Y2Nlc3NUaHJlc2hvbGQ6IDEKICAgICAgICAgIGZhaWx1cmVUaHJlc2hvbGQ6IDMKICAgICAgICByZWFkaW5lc3NQcm9iZToKICAgICAgICAgIGh0dHBHZXQ6CiAgICAgICAgICAgIHBhdGg6IC9oYWVsdGgKICAgICAgICAgICAgcG9ydDogODAKICAgICAgICAgIGluaXRpYWxEZWxheVNlY29uZHM6IDUKICAgICAgICAgIHBlcmlvZFNlY29uZHM6IDUKICAgICAgICAgIHRpbWVvdXRTZWNvbmRzOiAxCiAgICAgICAgICBzdWNjZXNzVGhyZXNob2xkOiAxCiAgICAgICAgICBmYWlsdXJlVGhyZXNob2xkOiAz
```

## (d) OhOh

RGVyIENvbnRhaW5lciB3aXJkIGxhdWZlbmQgUmVzdGFydGVkLiBFaW4gYGt1YmVjdGwgZGVzY3JpYmUgcG9kYCB6ZWlndCwgZGFzcyBkZXIgVm9yZ8OkbmdlciBlaW4gT09NS2lsbGVkIEV2ZW50IHplaWd0LiBELmguIGRhcyBrb25maWd1cmllcnRlIE1lbW9yeSBMaW1pdCB2b24gMTAwTWkgd2lyZCDDvGJlcnNjaHJpdHRlbi4KCkRhIHdpciBub2NoIG5pY2h0IHdpc3NlbiB3aWUgdmllbCBSQU0gZGVyIENvbnRhaW5lciB3aXJrbGljaCBicmF1Y2h0IG11c3MgbWFuIGlobiBudXIgYW5hbHlzaWVyZW4uIEVzIHdpcmQgc2ljaCB6ZWlnZW4sIGRhc3MgMTIwTWkgZGF1ZXJoYWZ0IGJlbsO2dGlndCB3ZXJkZW4uIApBbnBhc3N1bmcgZGVyIE1lbW9yeSBQYXJhbWV0ZXIgd8OkcmUgc2lubnZvbGwgYXVmOg==


```yaml
YXBpVmVyc2lvbjogYXBwcy92MQpraW5kOiBEZXBsb3ltZW50Cm1ldGFkYXRhOgogIG5hbWU6IHdvcmtsb2FkCnNwZWM6CiAgc2VsZWN0b3I6CiAgICBtYXRjaExhYmVsczoKICAgICAgYXBwOiB3b3JrbG9hZAogIHJlcGxpY2FzOiAxCiAgdGVtcGxhdGU6CiAgICBtZXRhZGF0YToKICAgICAgbGFiZWxzOgogICAgICAgIGFwcDogd29ya2xvYWQKICAgIHNwZWM6CiAgICAgIGNvbnRhaW5lcnM6CiAgICAgICAgLSBuYW1lOiB3b3JrbG9hZAogICAgICAgICAgaW1hZ2U6IGhhcmJvcjIuY3N2Y2Rldi52cGMuYXJ2YXRvLXN5c3RlbXMuZGUvazhzLXdvcmtzaG9wL3dvcmtsb2FkOjEuMAogICAgICAgICAgcmVzb3VyY2VzOgogICAgICAgICAgICByZXF1ZXN0czoKICAgICAgICAgICAgICBtZW1vcnk6ICIxMjBNaSIKICAgICAgICAgICAgbGltaXRzOgogICAgICAgICAgICAgIG1lbW9yeTogIjI0ME1pIg==
```

## (e) LongWay

Hier ist systematisches Troubleshooting angesagt. Am besten Bottom-UP.

### Container

Überprüfe ob der Container die Website ausliefert.

```bash
IyBjb250YWluZXJQb3J0IGVybWl0dGVsbiAtPiA4MDgwCmt1YmVjdGwgcG9ydC1mb3J3YXJkIGRlcGxveW1lbnQvbmdpbnggODA4MDo4MDgwICYKY3VybCBodHRwOi8vbG9jYWxob3N0OjgwODAvCiMgPT4gRGVyIENvbnRhaW5lciBzY2hlaW50IGRpZSBXZWJzaXRlIGF1c3p1bGllZmVybg==
```

### Service

RGVuIFNlcnZpY2UgUG9ydCBrYW5uIG1hbiBuaWNodCBzbyBlaW5mYWNoIG1pdCBwb3J0LWZvcndhcmQgYW5zcHJlY2hlbi4gCkVpbiBQb3J0LUZvcndhcmQgYXVmIGRlbiBTZXJ2aWNlIGxpZWZlcnQgZWluZSBkaXJla3RlIFZlcmJpbmR1bmcgenUgZWluZW0gZGVyIFBvZHMuCgpBYmVyIGF1Y2ggZGllc2VyIFZlcnN1Y2ggYnJpbmd0IHVucyBlaW4gU3TDvGNrIHdlaXRlcjo=

```bash
a3ViZWN0bCBwb3J0LWZvcndhcmQgc3ZjL25naW54IDgwODA6ODAKIyBIw6RuZ3Q=
```

RGllIGjDpG5nZW5kZSBwb3J0LWZvcndhcmQgcmVxdWVzdCB6ZWlndCB1bmQgZGFzIGRlbSBTZXJ2aWNlIGtlaW4gUG9kIHp1Z2VvcmRuZXQgaXN0LgpEYXNzZWxiZSB6ZWlndCBhdWNoIGRpZSBBYmZyYWdlIG5hY2ggZGVuIFNlcnZpY2UgRW5kcG9pbnRz

```bash
JCBrdWJlY3RsIGdldCBlbmRwb2ludHMKCk5BTUUgICAgRU5EUE9JTlRTICAgQUdFCm5naW54ICAgPG5vbmU+ICAgICAgMTdt
```

S2VpbmUgRW5kcG9pbnRzIGbDvHIgZGVuIFNlcnZpY2Ugc2luZCBlaW4gWmVpY2hlbiBmw7xyCiAgYSkgUG9kcyBzaW5kIG5pY2h0IFJFQURZCiAgYikgU2VsZWt0b3IgcGFzc3QgbmljaHQuCgpIaWVyIGlzdCBhdWYgamVkZW4gRmFsbCBkYXMgMi4gZGVyIEZhbGwsIGRlbiBkZXIgUG9kIGlzdCBqYSBhbHMgUmVhZHkgbWFya2llcnQuCkRhcyBhcHAgTGFiZWwgaW0gQ29udGFpbmVyIGhhdCBkZW4gV2VydCB3ZWJzaXRlIHVuZCBuaWNodCB3ZWIu

```yaml
YXBpVmVyc2lvbjogdjEKa2luZDogU2VydmljZQptZXRhZGF0YToKICBuYW1lOiBuZ2lueAogIGxhYmVsczoKICAgIGFwcDogd2Vic2l0ZQpzcGVjOgogIHR5cGU6IENsdXN0ZXJJUAogIHBvcnRzOgogICAgIyB0aGUgcG9ydCB0aGF0IHRoaXMgc2VydmljZSBzaG91bGQgc2VydmUgb24KICAtIG5hbWU6IGh0dHAKICAgIHBvcnQ6IDgwCiAgICB0YXJnZXRQb3J0OiA4MAogIHNlbGVjdG9yOgogICAgYXBwOiB3ZWJzaXRl
```

VW5kIHNpZWhlIGRhIGRlciBTZXJ2aWNlIGhhdCBlaW5lbiBFbmRwb2ludA==

```bash
JCBrdWJlY3RsIGdldCBlbmRwb2ludHMKTkFNRSAgICBFTkRQT0lOVFMgICAgICAgQUdFCm5naW54ICAgMTcyLjE3LjAuNTo4MCAgIDIxbQ==
```

TGVpZGVyIGZ1bmt0aW9uaWVydCBkaWUgV2Vic2l0ZSBpbW1lciBub2NoIG5pY2h0LiBBbHNvIHdlaXRlciBzdWNoZW4u

### Service++

Wir probieren es wieder mit einem Port-Forward

```bash
JCBrdWJlY3RsIHBvcnQtZm9yd2FyZCBzdmMvbmdpbnggODA4MDo4MApGb3J3YXJkaW5nIGZyb20gMTI3LjAuMC4xOjgwODAgLT4gODAKRm9yd2FyZGluZyBmcm9tIFs6OjFdOjgwODAgLT4gODAKCiMgMi4gVGVybWluYWwKJGN1cmwgaHR0cDovL2xvY2FsaG9zdDo4MDgwLwoKSGFuZGxpbmcgY29ubmVjdGlvbiBmb3IgODA4MApFMDIyNCAxOToyMjoxNi44NTY4MzQgICAzNjIwNyBwb3J0Zm9yd2FyZC5nbzo0MDBdIGFuIGVycm9yIG9jY3VycmVkIGZvcndhcmRpbmcgODA4MCAtPiA4MDogZXJyb3IgZm9yd2FyZGluZyBwb3J0IDgwIHRvIHBvZCA3MTg5Y2FiOGIyYWJmYjlmNDM0ZDdlZjJjODg2ZTgwZjFiMWYxNjMwNTVhZTI5MzhmNzY5NzM2MmQ5NWY1YTViLCB1aWQgOiBleGl0IHN0YXR1cyAxOiAyMDIxLzAyLzI0IDE4OjIyOjE2IHNvY2F0WzI0NTc4XSBFIGNvbm5lY3QoNSwgQUY9MiAxMjcuMC4wLjE6ODAsIDE2KTogQ29ubmVjdGlvbiByZWZ1c2VkCmN1cmw6ICg1MikgRW1wdHkgcmVwbHkgZnJvbSBzZXJ2ZXI=
```

Q29ubmVjdGlvbiByZWZ1c2VkPyBBYmVyIGRlciBDb250YWluZXIgaGF0dGUgZG9jaCBnZWFudHdvcnRldC4gCk9oT2guIDgwLDgwODAgYmVpIGRlbiBnYW56ZW4gUG9ydHMga2FubiBtYW4gc2ljaCBzY2hvbiBtYWwgdmVydHVuLiBEZXIgUG9ydCBpbSBDb250YWluZXIgaXN0IDgwODAsIGRlciBTZXJ2aWNlIGxlaXRldCBhYmVyIGF1ZiBQb3J0IDgwIHdlaXRlci4gRGFzIGthbm4gamEgbmljaHQgcGFzc2VuLg==

```yaml
YXBpVmVyc2lvbjogdjEKa2luZDogU2VydmljZQptZXRhZGF0YToKICBuYW1lOiBuZ2lueAogIGxhYmVsczoKICAgIGFwcDogd2Vic2l0ZQpzcGVjOgogIHR5cGU6IENsdXN0ZXJJUAogIHBvcnRzOgogICAgIyB0aGUgcG9ydCB0aGF0IHRoaXMgc2VydmljZSBzaG91bGQgc2VydmUgb24KICAtIG5hbWU6IGh0dHAKICAgIHBvcnQ6IDgwCiAgICB0YXJnZXRQb3J0OiA4MDgwCiAgc2VsZWN0b3I6CiAgICBhcHA6IHdlYnNpdGU=
```

S2F1bSBpc3QgZGVyIFBvcnQga29uZmlndXJpZXJ0IGtsYXBwdCBlcyBhdWNoIG1pdCBkZW4gVGVzdCDDvGJlciBkZW4gU2VydmljZS4KKFBvcnQtRm9yd2FyZCBuZXUgc3RhcnRlbiEpCk1hbiBrw7ZubnRlIGpldHp0IHp1ciBTaWNoZXJoZWl0IG5vY2ggbWFsIHZlcnN1Y2hlbiBpbSBDbHVzdGVyICh2b24gZWluZW0gUG9kIGF1cykKZGllIElQIGRlcyBTZXJ2aWNlIGFuenVzcHJlY2hlbi4gKEJvbnVzIEF1ZmdhYmUpCgpMZWlkZXIga29tbXQgYmVpIGRlciBVUkwgaW1tZXIgbm9jaCBuaWNodHMgYW4gOi0o

### Ingress

V2VubiBtYW4gZGVuIEZlaGxlciBuaWNodCBhdWYgQW5oaWViIHNpZWh0LiBNYW5jaG1hbCBoaWxmdCBlcyBzaWNoIExvZ3MgZGVzIEluZ3Jlc3MgQ29udHJvbGxlcnMgYW56dXNlaGVuLCBkZXIgamEgZsO8ciBkaWUgSW1wbGVtZW50aWVydW5nIGRlcyBJbmdyZXNzIHZlcmFudHdvcnRsaWNoIGlzdC4KCkltIE1pbmlrdWJlIGzDpHVmdCBkZXIgaW0gTmFtZXNwYWNlIGt1YmUtc3lzdGVt

```bash
JCBrdWJlY3RsIC1uIGt1YmUtc3lzdGVtIGxvZ3MgZGVwbG95bWVudC9pbmdyZXNzLW5naW54LWNvbnRyb2xsZXIgLS10YWlsPTIwMAoKVzAyMjQgMTg6NDE6MTMuOTc1NTg2ICAgICAgIDcgY29udHJvbGxlci5nbzo4NTBdIEVycm9yIG9idGFpbmluZyBFbmRwb2ludHMgZm9yIFNlcnZpY2UgIms4cy13b3Jrc2hvcC8iOiBubyBvYmplY3QgbWF0Y2hpbmcga2V5ICJrOHMtd29ya3Nob3AvIiBpbiBsb2NhbCBzdG9yZQ==
```

QWxzbyBzY2hlaW50IGphIHdpZWRlciB3YXMgbWl0IGRlciBLb25maWd1cmF0aW9uIG5pY2h0IHp1IHN0aW1tZW4uCkVzIGlzdCB3aWVkZXIgZGVyIFBvcnQuIEhpZXIgYWxzIE5hbWUgYW5nZWdlYmVuLCBhYmVyIG5pY2h0IG1hdGNoZW5kIHp1bSBOYW1lbiBpbSBTZXJ2aWNlIg==

```yaml
YXBpVmVyc2lvbjogbmV0d29ya2luZy5rOHMuaW8vdjEKa2luZDogSW5ncmVzcwptZXRhZGF0YToKICBuYW1lOiBuZ2lueC1pbmdyZXNzCiAgbGFiZWxzOgogICAgICBhcHA6IHdlYnNpdGUKc3BlYzoKICBydWxlczoKICAtIGhvc3Q6IHdlYnNpdGUuazhzLXdvcmtzaG9wLmluZm8KICAgIGh0dHA6CiAgICAgIHBhdGhzOgogICAgICAtIHBhdGhUeXBlOiBQcmVmaXgKICAgICAgICBwYXRoOiAiLyIKICAgICAgICBiYWNrZW5kOgogICAgICAgICAgc2VydmljZToKICAgICAgICAgICAgbmFtZTogbmdpbngKICAgICAgICAgICAgcG9ydDoKICAgICAgICAgICAgICBuYW1lOiBodHRw
```
