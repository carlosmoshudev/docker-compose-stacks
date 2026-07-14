# Dashboard stack

Este directorio contiene `homepage`, `homarr` y `glances`.

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

- `HOMEPAGE_HOST_PORT`, `HOMARR_HOST_PORT`, `GLANCES_HOST_WEB_PORT` y `GLANCES_HOST_API_PORT` pueden ajustarse.
- Usa `HOMEPAGE_ALLOWED_HOSTS=*` solo en entornos de prueba.
