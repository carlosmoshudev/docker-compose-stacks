# Healthchecks, DIUN y Autoheal

## Criterio

DIUN y Autoheal tienen responsabilidades distintas:

- `diun.enable=true` activa la vigilancia de actualizaciones de imagen.
- `autoheal=true` permite que Autoheal reinicie un contenedor marcado como `unhealthy`.
- `autoheal=true` solo debe usarse cuando el servicio tiene un `healthcheck` fiable, ya sea definido en Compose o incluido por la imagen.

No se debe anadir `autoheal=true` a un servicio sin healthcheck real. En ese caso Autoheal no aporta nada y puede dar una falsa sensacion de proteccion.

## Servicios con healthcheck explicito

| Stack | Servicio | Healthcheck |
| --- | --- | --- |
| `automation` | `n8n` | HTTP interno |
| `dashboard` | `glances` | `http://127.0.0.1:61208/api/4/version` |
| `dashboard` | `homarr` | `http://127.0.0.1:7575/api/health/ready` |
| `docker` | `dozzle` | `/dozzle healthcheck` |
| `docker` | `netdata` | `netdatacli ping` |
| `docker` | `scrutiny` | HTTP interno |
| `home` | `esphome` | HTTP interno en `6052` |
| `home` | `homeassistant` | HTTP interno en `8123` |
| `home` | `nodered` | HTTP interno en `1880` |
| `library` | `calibre-web` | HTTP interno |
| `library` | `kavita` | HTTP interno |
| `library` | `romm` | HTTP interno |
| `library` | `romm-db` | `mysqladmin ping` |
| `media` | `transmission-gluetun` | `/gluetun-entrypoint healthcheck` |
| `media` | `transmission` | Web UI interna |
| `media` | `prowlarr` | `/ping` |
| `media` | `sonarr` | `/ping` |
| `media` | `radarr` | `/ping` |
| `media` | `bazarr` | HTTP interno |
| `media` | `lidarr` | `/ping` |
| `media` | `jellyfin` | `/health` |
| `media` | `jellyseerr` | HTTP interno |
| `media` | `flaresolverr` | `/health` |
| `network` | `nginx-proxy-manager` | `/usr/bin/check-health` |
| `notifications` | `apprise` | `/status` |
| `productivity` | `it-tools` | HTTP interno |
| `productivity` | `mealie` | `/api/app/about` |

## Servicios vigilados por DIUN sin autoheal

Estos servicios se vigilan para actualizaciones, pero no se reinician automaticamente porque no hay un healthcheck fiable y mantenible en Compose o porque la imagen no lo recomienda:

| Stack | Servicio | Motivo |
| --- | --- | --- |
| `dashboard` | `homepage` | Sin endpoint de health oficial claro en la imagen actual. |
| `docker` | `autoheal` | Supervisor de reinicios; no debe autogestionarse. |
| `docker` | `diun` | Servicio de vigilancia; no hay healthcheck necesario para autoheal. |
| `docker` | `portainer` | Imagen minimalista sin tooling interno fiable para Compose. |
| `home` | `matter-server` | Servicio host/network sensible; evitar reinicios automaticos por check debil. |
| `home` | `mosquitto` | El check correcto depende de credenciales MQTT reales. |
| `library` | `audiobookshelf` | La documentacion oficial no recomienda healthchecks salvo monitorizacion externa; puede generar ruido en arranques lentos. |
| `media` | `recyclarr` | Tarea/sincronizador, no servicio web continuo critico. |
| `media` | `unpackerr` | Proceso worker sin endpoint HTTP de salud necesario. |
| `network` | `adguardhome` | El proyecto retiro el Docker HEALTHCHECK por problemas operativos. |

## Fuentes usadas

- DIUN Webhook: https://crazymax.dev/diun/notif/webhook/
- Netdata Docker health checks: https://learn.netdata.cloud/docs/netdata-agent/installation/docker
- Nginx Proxy Manager healthcheck opt-in: https://nginxproxymanager.com/advanced-config/
- Gluetun healthcheck: https://github.com/qdm12/gluetun-wiki/blob/main/faq/healthcheck.md
- AdGuard Home releases: https://adguard.com/en/versions/home/release.html
- Audiobookshelf Docker docs: https://audiobookshelf.org/docs/documentation/install/docker/
- Audiobookshelf API: https://api.audiobookshelf.org/
- Jellyfin monitoring: https://jellyfin.org/docs/general/post-install/networking/advanced/monitoring/
- Prowlarr API: https://prowlarr.com/docs/api/
- Radarr API: https://radarr.video/docs/api/

## Validacion recomendada

Ejecutar por stack tras aplicar cambios:

```bash
docker compose config
docker compose up -d
docker compose ps
docker compose logs --tail=100
```

Para comprobar un healthcheck concreto:

```bash
docker inspect --format '{{json .State.Health}}' <contenedor>
```
