# docker-compose-stacks | Pilas de Docker compose para entorno PRODUCCIÓN

Este workspace agrupa varias pilas Docker Compose independientes, cada una en su carpeta raíz.

## Estructura

- `automation/` : n8n
- `affine/` : AFFiNE, postgres, redis
- `dashboard/` : homepage, homarr, glances
- `docker/` : autoheal, dozzle, diun, netdata, portainer, scrutiny
- `freshrss/` : FreshRSS
- `home/` : esphome, homeassistant, matter-server, mosquitto, nodered
- `lab/reactive-resume/` : Reactive Resume en laboratorio
- `library/` : audiobookshelf, calibre-web, kavita, romm, romm-db
- `media/` : transmission, prowlarr, sonarr, radarr, bazarr, lidarr, jellyfin, jellyseerr, unpackerr, recyclarr, flaresolverr
- `network/` : adguardhome, nginx-proxy-manager
- `notifications/` : apprise
- `productivity/` : it-tools, mealie
- `vikunja/` : Vikunja, postgres

## Uso general

1. Para cada stack, copia su ejemplo local y ajusta los valores:

```powershell
Copy-Item .\<stack>\.env.example .\<stack>\.env
notepad .\<stack>\.env
```

2. Entra en la carpeta del stack y ejecuta:

```powershell
cd .\<stack>
docker compose up -d
```

## Notas importantes

- No se recomienda versionar los archivos `.<stack>/.env` si contienen claves o credenciales.
- `COMPOSE_PROJECT_NAME` es utilizado para identificar cada proyecto Compose.
- `TZ`, `SOCK`, `LOCALTIME`, `DBUS`, `MEDIA`, `DOWNLOADS` y `WATCH` son valores comunes compartidos por varias pilas.
- `ZIGBEE_ADAPTER`, `ZIGBEE2MQTT_PORT` y `READARR_PORT` son variables opcionales para servicios comentados en sus compose.
- Los stacks bajo `lab/` son pruebas aisladas y no deben asumirse como produccion hasta moverlos y documentarlo.
- El mapa mantenible de puertos esta en `PUERTOS.md`.
- Las integraciones operativas estan en `docs/INTEGRACIONES.md`.
- Los procedimientos de incidencia estan en `docs/RUNBOOK.md`.
- Las rutas y criterios de backup estan en `docs/BACKUPS.md`.
- Las ideas no aplicadas para futuros contenedores estan en `sugerencias.md` y en el `sugerencias.md` de cada stack.

## Cambios aplicados

- Se estandarizaron etiquetas `autoheal`/`diun.enable` en stacks y servicios seleccionados.
- Se añadieron healthchecks básicos en `dashboard` y `productivity` para que los servicios sean más robustos.
