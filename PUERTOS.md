# Mapa de puertos del homelab pro

Documento mantenible para revisar exposicion de servicios Docker. Los valores salen de los `compose.yaml` y de las variables usadas en cada stack.

## Criterios

- `Host` es el puerto publicado en `cali-home`.
- `Contenedor` es el puerto interno del servicio.
- Los servicios con `network_mode: host` no publican puertos con `ports`, pero escuchan directamente en la red del host.
- Los servicios sin puerto publicado deben consumirse por red Docker, por otro contenedor o mediante el servicio que comparte red.

## Puertos publicados

| Stack | Servicio | Variable host | Host | Contenedor | Protocolo | Uso | Nota |
| --- | --- | ---: | ---: | ---: | --- | --- | --- |
| automation | n8n | `N8N_HOST_PORT` | 5678 | `N8N_CONTAINER_PORT` / 5678 | TCP | Automatizaciones | Publicar preferiblemente detras de proxy con autenticacion |
| dashboard | homepage | `HOMEPAGE_HOST_PORT` | 3000 | `HOMEPAGE_CONTAINER_PORT` / 3000 | TCP | Dashboard principal | Red local o proxy |
| dashboard | homarr | `HOMARR_HOST_PORT` | 7575 | `HOMARR_CONTAINER_PORT` / 7575 | TCP | Dashboard alternativo | Red local o proxy |
| dashboard | glances web | `GLANCES_HOST_WEB_PORT` | 61208 | `GLANCES_CONTAINER_WEB_PORT` / 61208 | TCP | Monitorizacion web | Red local |
| dashboard | glances API | `GLANCES_HOST_API_PORT` | 61209 | `GLANCES_CONTAINER_API_PORT` / 61209 | TCP | API de monitorizacion | Valorar si hace falta exponerlo |
| docker | dozzle | `DOZZLE_HOST_PORT` | 8081 | `DOZZLE_CONTAINER_PORT` / 8080 | TCP | Logs Docker | Sensible: proteger con proxy/autenticacion |
| docker | portainer | `PORTAINER_HOST_PORT` | 9443 | `PORTAINER_CONTAINER_PORT` / 9443 | TCP | Gestion Docker | Sensible: no exponer a Internet |
| docker | scrutiny | `SCRUTINY_HOST_PORT` | 8082 | `SCRUTINY_CONTAINER_PORT` / 8080 | TCP | Salud de discos | Red local |
| docker | scrutiny influxdb | `SCRUTINY_INFLUXDB_HOST_PORT` | 18086 | `SCRUTINY_INFLUXDB_CONTAINER_PORT` / 8086 | TCP | Base de datos interna Scrutiny | Valorar retirar publicacion si no se consulta desde fuera |
| docker | netdata | `NETDATA_HOST_PORT` | 19999 | `NETDATA_CONTAINER_PORT` / 19999 | TCP | Monitorizacion sistema | Sensible: red local/proxy autenticado |
| home | esphome | `ESPHOME_PORT` | 6052 | 6052 | TCP | ESPHome | Red local |
| home | mosquitto | `MQTT_PORT` | 1883 | 1883 | TCP | MQTT | No exponer a Internet sin TLS/autenticacion |
| home | nodered | `NODERED_PORT` | 1880 | 1880 | TCP | Automatizaciones visuales | Sensible: proteger con login/proxy |
| library | audiobookshelf | `AUDIOBOOK_PORT` | 13378 | 80 | TCP | Audiolibros/podcasts | Red local o proxy |
| library | calibre-web | `CALIBRE_PORT` | 8084 | 8083 | TCP | Biblioteca Calibre | Red local o proxy |
| library | kavita | `KAVITA_PORT` | 5000 | 5000 | TCP | Comics/libros | Red local o proxy |
| library | romm | `ROMM_PORT` | 8085 | 8080 | TCP | ROMs | Red local o proxy |
| media | transmission-gluetun | `TRANSMISSION_PORT` | 9091 | 9091 | TCP | UI Transmission via VPN | Sensible: red local/proxy autenticado |
| media | prowlarr | `PROWLARR_PORT` | 9696 | 9696 | TCP | Indexadores | Sensible por API keys |
| media | sonarr | `SONARR_PORT` | 8989 | 8989 | TCP | Series | Sensible por API keys |
| media | radarr | `RADARR_PORT` | 7878 | 7878 | TCP | Peliculas | Sensible por API keys |
| media | bazarr | `BAZARR_PORT` | 6767 | 6767 | TCP | Subtitulos | Red local/proxy |
| media | lidarr | `LIDARR_PORT` | 8686 | 8686 | TCP | Musica | Sensible por API keys |
| media | readarr | `READARR_PORT` | 8787 | 8787 | TCP | Libros | Sensible por API keys |
| media | jellyfin | `JELLYFIN_PORT` | 8096 | 8096 | TCP | Streaming multimedia | Proxy recomendado si sale a Internet |
| media | jellyfin discovery | `JELLYFIN_DISCOVERY_PORT` | 7359 | 7359 | UDP | Descubrimiento local | Mantener solo LAN |
| media | jellyfin DLNA | `JELLYFIN_DLNA_PORT` | 7360 | 1900 | UDP | DLNA local | Mantener solo LAN |
| media | jellyseerr | `JELLYSEERR_PORT` | 5055 | 5055 | TCP | Solicitudes multimedia | Proxy recomendado |
| media | flaresolverr | `FLARESOLVERR_PORT` | 8191 | 8191 | TCP | Resolver desafios web | Valorar no exponer fuera de Docker/LAN |
| network | adguard DNS | `ADGUARD_DNS_PORT` | 53 | 53 | TCP/UDP | DNS local | Servicio critico de red |
| network | adguard setup | `ADGUARD_INIT_PORT` | 3001 | 3000 | TCP | Setup inicial AdGuard | Cerrar o restringir tras configuracion si no se usa |
| network | adguard http | `ADGUARD_HTTP_PORT` | 3002 | 80 | TCP | Panel AdGuard | Proteger acceso |
| network | npm http | `NPM_HTTP_PORT` | 80 | 80 | TCP | Proxy HTTP | Entrada publica si aplica |
| network | npm https | `NPM_HTTPS_PORT` | 443 | 443 | TCP | Proxy HTTPS | Entrada publica si aplica |
| network | npm admin | `NPM_ADMIN_PORT` | 81 | 81 | TCP | Admin NPM | Sensible: no exponer a Internet |
| productivity | it-tools | `ITTOOLS_PORT` | 8083 | 80 | TCP | Herramientas tecnicas | Red local o proxy |
| productivity | mealie | `MEALIE_PORT` | 9925 | 9000 | TCP | Recetas | Red local o proxy |

## Servicios sin puerto publicado

| Stack | Servicio | Acceso esperado | Nota |
| --- | --- | --- | --- |
| docker | autoheal | Docker socket | No requiere UI |
| docker | diun | Tarea interna/notificaciones | No requiere UI |
| home | homeassistant | `network_mode: host` | Escucha desde la red host, normalmente `8123` |
| home | matter-server | `network_mode: host` | Necesario para discovery Matter |
| library | romm-db | Red Docker del stack | Base de datos interna |
| media | transmission | Red compartida con `transmission-gluetun` | La UI sale por el puerto de Gluetun |
| media | unpackerr | Red Docker/salidas HTTP | No requiere UI |
| media | recyclarr | Tarea interna | No requiere UI |
