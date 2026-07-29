# Backups

Inventario inicial de rutas persistentes y criterios de restauracion.

## Reglas

- Hacer backup antes de cambiar rutas de volumenes.
- Probar restauraciones, no solo copias.
- No versionar backups en Git.
- Guardar secretos fuera del repositorio.

## Rutas persistentes

| Stack | Ruta base | Criticidad | Nota |
| --- | --- | --- | --- |
| affine | `/srv/containers/pro/affine/data` | Media | AFFiNE, PostgreSQL y almacenamiento |
| automation | `/srv/containers/pro/automation/data` | Alta | Workflows y credenciales de n8n |
| dashboard | `/srv/containers/pro/dashboard/data` | Media | Configuracion de dashboards |
| docker | `/srv/containers/pro/docker/data` | Alta | Portainer, Netdata, Scrutiny y DIUN |
| freshrss | `/srv/containers/pro/freshrss/data` | Media | Feeds, usuarios y extensiones |
| home | `/srv/containers/pro/home/data` | Muy alta | Home Assistant, Node-RED, Matter y Mosquitto |
| lab/reactive-resume | `/srv/containers/pro/lab/reactive-resume/data` | Baja | Laboratorio de CVs; subir criticidad si se usa en serio |
| library | `/srv/containers/pro/library/data` | Alta | Bibliotecas y base de datos RomM |
| media | `/srv/containers/pro/media/data` | Alta | Configuracion de servicios media |
| network | `/srv/containers/pro/network/data` | Muy alta | DNS, proxy y certificados |
| productivity | `/srv/containers/pro/productivity/data` | Media | Mealie y herramientas |
| notifications | `/srv/containers/pro/notifications/data` | Media | Configuracion de Apprise |
| vikunja | `/srv/containers/pro/vikunja/data` | Media | Tareas, adjuntos y PostgreSQL |

## Caso especial: RomM

El compose actual monta MariaDB en `./data/room/db`. En disco existen `romm/` y `room/`, por lo que hay que asumir que `room/db` puede contener la base real.

Procedimiento recomendado antes de corregir el nombre:

1. Parar `romm` y `romm-db`.
2. Crear backup completo de `/srv/containers/pro/library/data/room`.
3. Crear backup de la base desde MariaDB si el servicio arranca.
4. Copiar o mover `room/db` a `romm/db` conservando propietarios y permisos.
5. Cambiar `compose.yaml`.
6. Levantar solo `romm-db` y verificar logs.
7. Levantar `romm` y comprobar biblioteca.

## Restauracion minima

1. Parar el stack afectado.
2. Restaurar ruta persistente.
3. Revisar propietario y permisos.
4. Ejecutar `docker compose config`.
5. Levantar el stack.
6. Revisar logs y healthchecks.
