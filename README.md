# Legacy Park — Modernized Website

Two modern redesigns of [legacypark.org](https://legacypark.org) for the Legacy Park HOA in Kennesaw, GA.

## Versions

| | Version 1 | Version 2 |
|---|---|---|
| **Theme** | Community Spirit | Modern Hub |
| **Colors** | Forest green + gold | Dark navy + teal |
| **Feel** | Warm, nature-inspired | Bold, modern dashboard |
| **URL** | `/v1.html` | `/v2.html` |

## Live

Deployed at **https://legacypark.astramarisclient.com** via ArgoCD on k3s.

- `/` — Design preview / version selector
- `/v1.html` — Version 1: Community Spirit (green theme)
- `/v2.html` — Version 2: Modern Hub (dark navy theme)

## Deployment

Managed by ArgoCD via [argo-infra](https://github.com/aiclawastamaris1/argo-infra).

- Namespace: `legacy-park`
- Image: `nginx:alpine` with HTML served via ConfigMap
- Ingress: Cilium Gateway API → `legacypark.astramarisclient.com`

To update content: edit `v1.html` or `v2.html`, then run:
```bash
python3 -c "
import yaml
with open('index.html') as f: index = f.read()
with open('v1.html') as f: v1 = f.read()  
with open('v2.html') as f: v2 = f.read()
cm = {'apiVersion':'v1','kind':'ConfigMap','metadata':{'name':'legacy-park-html','namespace':'legacy-park'},'data':{'index.html':index,'v1.html':v1,'v2.html':v2}}
with open('k8s/configmap.yaml','w') as f: yaml.dump(cm, f, allow_unicode=True)
"
git add k8s/configmap.yaml && git commit -m 'update: refresh HTML content' && git push
```

ArgoCD picks up changes within ~3 minutes.
