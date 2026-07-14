# Library stack

Este directorio contiene `audiobookshelf`, `calibre-web`, `kavita`, `romm` y `romm-db`.

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

- Las credenciales de `romm-db` deben mantenerse privadas.
- Ajusta `MEDIA` si tu ruta de librería local cambia.
