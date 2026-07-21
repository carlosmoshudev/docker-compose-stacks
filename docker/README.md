# Docker stack

Este directorio contiene herramientas de administración y monitoreo como `autoheal`, `dozzle`, `diun`, `netdata`, `portainer` y `scrutiny`.

## Archivos

- `compose.yaml`: definición de los servicios
- `.env`: configuración local de variables

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose up -d
```

## Notas

- Ajusta puertos de visualización para evitar conflictos.
- DIUN notifica por webhook hacia n8n; Telegram ya no se configura directamente en este stack.
- `CALI_NOTIFY_KEY` es sensible: debe vivir solo en `.env` y debe coincidir con la cabecera que valida el workflow de n8n.
- `N8N_NOTIFICATIONS_HOST`, `N8N_NOTIFICATIONS_PORT` y `N8N_NOTIFICATIONS_PATH` construyen el endpoint `http://cali-home:5678/webhook/notifications`.
- DIUN envia las cabeceras `Cali-Notify-Key`, `Cali-Notify-Source: diun` y `Content-Type: application/json` al webhook de n8n.
