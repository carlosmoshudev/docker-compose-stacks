# Automation stack

Este directorio contiene el stack de `n8n`.

## Archivos

- `compose.yaml`: definición del servicio
- `.env`: configuración local de variables

## Setup

```powershell
Copy-Item ..\.env.example .\.env
notepad .\.env
docker compose up -d
```

## Notas

- Ajusta `N8N_PORT` según tu configuración.
- Mantén `TZ` actualizado en todas las pilas.
