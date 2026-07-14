# Runbook

Guia rapida para incidencias habituales en contenedores.

## Antes de actuar

```bash
docker compose ps
docker compose logs --tail=100 <servicio>
docker compose config
```

No ejecutar `docker compose down -v` salvo que se quiera eliminar volumenes y se haya confirmado backup.

## Exit 1

1. Revisar logs del servicio.
2. Comprobar variables de `.env`.
3. Validar `compose.yaml`.
4. Revisar permisos de rutas montadas.

## Exit 137

Suele indicar que el proceso fue terminado por memoria o por el host.

1. Revisar memoria del host.
2. Revisar logs del kernel o monitorizacion.
3. Comprobar si el servicio tiene picos previsibles.

## Exit 143

Normalmente indica parada ordenada por `SIGTERM`.

1. Revisar si hubo reinicio manual, update o recreacion.
2. Comprobar eventos Docker.
3. Revisar si Autoheal o Watchtower han actuado.

## Unhealthy

1. Leer el healthcheck configurado.
2. Probar manualmente el endpoint desde dentro del contenedor si aplica.
3. Revisar si Autoheal va a reiniciar el servicio.
4. No anadir etiquetas `autoheal` sin healthcheck real.

## Perdida de Telegram

1. Probar conectividad externa desde el host.
2. Revisar token en Home Assistant y Apprise.
3. Verificar `chat_id`.
4. Probar una notificacion por Apprise con tag `critical`.
5. Si se roto el token, actualizar todos los consumidores que compartan bot.

## RomM y MariaDB

La ruta actual de MariaDB apunta a `./data/room/db`. Antes de cambiarla a `./data/romm/db`, confirmar backup y migrar datos de forma controlada. Cambiar solo el compose puede crear una base vacia.
