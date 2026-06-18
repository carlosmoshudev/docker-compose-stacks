# docker-compose-stacks | Pilas de Docker compose para entorno PRODUCCIÓN

Este workspace agrupa varias pilas Docker Compose independientes, cada una en su carpeta raíz.

## Estructura

- `automation/` : n8n
- `dashboard/` : homepage, homarr, glances
- `docker/` : autoheal, dozzle, diun, netdata, portainer, scrutiny
- `home/` : esphome, homeassistant, matter-server, mosquitto, nodered
- `library/` : audiobookshelf, calibre-web, kavita, romm, romm-db
- `media/` : transmission, prowlarr, sonarr, radarr, bazarr, lidarr, jellyfin, jellyseerr, unpackerr, recyclarr, flaresolverr
- `network/` : adguardhome, nginx-proxy-manager
- `productivity/` : it-tools, mealie

## Uso general

1. Para variables comunes al workspace, edita el archivo raíz:

```powershell
notepad .\.env.example
```

2. Para cada stack, copia su ejemplo local y ajusta los valores:

```powershell
Copy-Item .\<stack>\.env.example .\<stack>\.env
notepad .\<stack>\.env
```

3. Entra en la carpeta del stack y ejecuta:

```powershell
cd .\<stack>
docker compose up -d
```

## Notas importantes

- No se recomienda versionar los archivos `.<stack>/.env` si contienen claves o credenciales.
- `COMPOSE_PROJECT_NAME` es utilizado para identificar cada proyecto Compose.
- `TZ`, `SOCK`, `LOCALTIME`, `DBUS`, `MEDIA`, `DOWNLOADS` y `WATCH` son valores comunes compartidos por varias pilas.
- `ZIGBEE_ADAPTER` y `ZIGBEE2MQTT_PORT` son variables opcionales para servicios comentados en `home/compose.yaml`.
- El mapa mantenible de puertos esta en `PUERTOS.md`.
- Las ideas no aplicadas para futuros contenedores estan en `sugerencias.md` y en el `sugerencias.md` de cada stack.

## Cambios aplicados

- Se estandarizaron etiquetas `autoheal`/`diun.enable` en stacks y servicios seleccionados.
- Se añadieron healthchecks básicos en `dashboard` y `productivity` para que los servicios sean más robustos.

