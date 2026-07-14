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
- `TELEGRAM_TOKEN` y `TELEGRAM_CHATIDS` son necesarias solo para `diun`.
