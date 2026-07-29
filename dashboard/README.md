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
- Homepage usa variables `HOMEPAGE_VAR_*` para inyectar secretos en widgets sin dejarlos escritos en `services.yaml`.
- La configuracion viva de Homepage esta en `${APPDATA_DIR}/homepage`; antes de cambios manuales, crea backup de `services.yaml`, `settings.yaml`, `widgets.yaml` y `docker.yaml`.
- Los servicios eventuales deben mantenerse como enlaces/status, sin widgets activos, para evitar errores continuos en logs cuando estan parados.
