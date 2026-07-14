# Media stack

Este directorio contiene servicios multimedia como `transmission`, `prowlarr`, `sonarr`, `radarr`, `bazarr`, `lidarr`, `jellyfin` y `jellyseerr`.

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

- `DOWNLOADS`, `WATCH` y `MEDIA` deben apuntar a rutas compartidas válidas.
- `VPN_USER` y `VPN_PASSWORD` son sensibles y no deben compartirse.
- `readarr` queda documentado en `compose.yaml`, pero esta comentado. Si se activa, revisar `READARR_PORT` y `PUERTOS.md`.
