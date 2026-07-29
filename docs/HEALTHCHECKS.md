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
| `__lab_affine` | `affine` | HTTP interno en `3010` |
| `__lab_affine` | `affine-db` | `pg_isready` |
| `__lab_affine` | `affine-redis` | `redis-cli` |
| `automation` | `n8n-db` | `pg_isready` |
| `automation` | `n8n` | HTTP interno |
| `dashboard` | `glances` | `http://127.0.0.1:61208/api/4/version` |
| `dashboard` | `homarr` | `http://127.0.0.1:7575/api/health/ready` |
| `docker` | `dozzle` | `/dozzle healthcheck` |
| `docker` | `netdata` | `netdatacli ping` |
| `docker` | `scrutiny` | HTTP interno |
| `docker` | `uptime-kuma` | HTTP interno en `3001` |
| `finance` | `firefly` | HTTP interno en `8080` |
| `finance` | `firefly-db` | `mariadb-admin ping` |
| `home` | `esphome` | HTTP interno en `6052` |
| `home` | `homeassistant` | HTTP interno en `8123` |
| `home` | `nodered` | HTTP interno en `1880` |
| `ipam` | `phpipam-db` | `mariadb-admin ping` |
| `ipam` | `phpipam-web` | HTTP interno |
| `__lab_freshrss` | `freshrss` | HTTP interno |
| `__lab_reactive-resume` | `reactive-resume` | `/api/health` |
| `__lab_reactive-resume` | `reactive-resume-db` | `pg_isready` |
| `__lab_reactive-resume` | `reactive-resume-redis` | `redis-cli ping` |
| `__lab_reactive-resume` | `reactive-resume-seaweedfs` | HTTP interno SeaweedFS |
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
| `__lab_vikunja` | `vikunja-db` | `pg_isready` |

## Servicios vigilados por DIUN sin autoheal

Estos servicios se vigilan para actualizaciones, pero no se reinician automaticamente porque no hay un healthcheck fiable y mantenible en Compose o porque la imagen no lo recomienda:

| Stack | Servicio | Motivo |
| --- | --- | --- |
| `dashboard` | `homepage` | Sin endpoint de health oficial claro en la imagen actual. |
| `docker` | `autoheal` | Supervisor de reinicios; no debe autogestionarse. |
| `docker` | `diun` | Servicio de vigilancia; no hay healthcheck necesario para autoheal. |
| `docker` | `portainer` | Imagen minimalista sin tooling interno fiable para Compose. |
| `finance` | `firefly-cron` | Job programado continuo sin endpoint HTTP propio. |
| `home` | `matter-server` | Servicio host/network sensible; evitar reinicios automaticos por check debil. |
| `home` | `mosquitto` | El check correcto depende de credenciales MQTT reales. |
| `__lab_reactive-resume` | `reactive-resume-create-bucket` | Job de inicializacion, no servicio continuo. |
| `library` | `audiobookshelf` | La documentacion oficial no recomienda healthchecks salvo monitorizacion externa; puede generar ruido en arranques lentos. |
| `media` | `recyclarr` | Tarea/sincronizador, no servicio web continuo critico. |
| `media` | `unpackerr` | Proceso worker sin endpoint HTTP de salud necesario. |
| `network` | `adguardhome` | El proyecto retiro el Docker HEALTHCHECK por problemas operativos. |
| `ipam` | `phpipam-cron` | Worker de escaneo sin endpoint HTTP propio. |
| `__lab_vikunja` | `vikunja` | Servicio web vigilado por DIUN; no se fuerza autoheal hasta validar endpoint interno estable en la imagen. |

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
- AFFiNE self-host: https://docs.affine.pro/self-host-affine/install/docker-compose-recommended
- Vikunja Docker example: https://vikunja.io/docs/full-docker-example/
- FreshRSS Docker image: https://hub.docker.com/r/freshrss/freshrss
- Reactive Resume Docker example: https://docs.rxresu.me/self-hosting/docker
- phpIPAM Docker image: https://hub.docker.com/r/phpipam/phpipam-www
- Firefly III Docker install: https://docs.firefly-iii.org/how-to/firefly-iii/installation/docker/
- Uptime Kuma Docker compose: https://github.com/louislam/uptime-kuma/blob/master/compose.yaml

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
