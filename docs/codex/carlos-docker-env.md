# Carlos Docker `.env` and `.env.example` guide

## Objetivo

Esta guía define cómo estructurar los archivos `.env` y `.env.example` de los stacks Docker del homelab.

El objetivo es mantener una convención clara, segura y fácil de reutilizar entre stacks de producción, laboratorio y servicios auxiliares.

## Reglas generales

* Cada stack debe tener su propio `.env`.
* El archivo `.env` contiene valores reales y no debe versionarse.
* El archivo `.env.example` documenta las variables necesarias y sí debe versionarse.
* No escribir secretos reales, tokens, contraseñas ni claves API en `.env.example`.
* No usar valores falsos con apariencia de secreto real.
* Usar placeholders claros como `CHANGEME`, `REPLACE_ME` o valores vacíos.
* Mantener separadas las variables generales, variables por servicio y puertos.
* Usar nombres de variables en mayúsculas.
* Usar prefijos por servicio cuando la variable pertenezca a un servicio concreto.
* Evitar comentarios inline en líneas con variables.
* Preferir comentarios en líneas separadas.

## Estructura recomendada

```dotenv
# ============================================================
# STACK: Stack Name [PRODUCCIÓN]                  .env.example
# ------------------------------------------------------------
# - ServiceNameA: https://servicename.example.com
# - ServiceNameB: https://github.com/someone/servicenameb
# ------------------------------------------------------------
# Desarrollado y mantenido por Carlos Moshu
# Stack de cali-home, servidor doméstico de Carlos y Lilia
# ============================================================

# ------------------------------------------------------------
# Compose
# ------------------------------------------------------------

COMPOSE_PROJECT_NAME=pro_stackname

# ------------------------------------------------------------
# Common environment
# ------------------------------------------------------------

TZ=Europe/Madrid
PUID=1000
PGID=1000
SERVER_HOSTNAME=cali-home

# ------------------------------------------------------------
# Common paths
# ------------------------------------------------------------

APPDATA_DIR=/srv/containers/pro/stackname/data
DOCKER_SOCK_PATH=/var/run/docker.sock
LOCALTIME_PATH=/etc/localtime
DBUS_PATH=/run/dbus
DRIVES_PATH=/srv/storage
MEDIA_DIR=/srv/media
DOWNLOADS_DIR=/srv/downloads
WATCH_DIR=/srv/watch
TRANSCODE_CACHE_DIR=/srv/transcode

# ------------------------------------------------------------
# ServiceNameA
# ------------------------------------------------------------

SERVICENAMEA_ACCEPT_CONNECTIONS_FROM=*
SERVICENAMEA_DB_HOST=servicenamea-db
SERVICENAMEA_DB_NAME=servicenamea
SERVICENAMEA_DB_USER=servicenamea
SERVICENAMEA_DB_PASSWORD=CHANGEME

# ------------------------------------------------------------
# ServiceNameB
# ------------------------------------------------------------

SERVICENAMEB_USER=CHANGEME
SERVICENAMEB_KEY=CHANGEME

# ------------------------------------------------------------
# Telegram API
# ------------------------------------------------------------

TELEGRAM_TOKEN=CHANGEME
TELEGRAM_CHAT_IDS=CHANGEME

# ------------------------------------------------------------
# Service ports
# ------------------------------------------------------------

SERVICENAMEA_HOST_PORT=8081
SERVICENAMEA_CONTAINER_PORT=80

SERVICENAMEB_HOST_PORT=3001
SERVICENAMEB_CONTAINER_PORT=3000
```

## Convención de nombres

### Variables generales

Usar nombres simples y reutilizables:

```dotenv
TZ=Europe/Madrid
PUID=1000
PGID=1000
SERVER_HOSTNAME=cali-home
```

### Rutas

Las rutas deben terminar en `_DIR` cuando apunten a directorios y en `_PATH` cuando apunten a archivos o sockets concretos.

Ejemplos:

```dotenv
APPDATA_DIR=/srv/containers/pro/stackname/data
MEDIA_DIR=/srv/media
DOWNLOADS_DIR=/srv/downloads
DOCKER_SOCK_PATH=/var/run/docker.sock
```

### Variables de servicios

Las variables específicas de un servicio deben usar prefijo con el nombre del servicio:

```dotenv
N8N_HOST=n8n.cali.home
N8N_PORT=5678
N8N_PROTOCOL=https
```

### Puertos

Usar siempre esta estructura cuando se documenten puertos mediante `.env`:

```dotenv
SERVICE_HOST_PORT=8080
SERVICE_CONTAINER_PORT=80
```

Ejemplo:

```dotenv
PORTAINER_HOST_PORT=9443
PORTAINER_CONTAINER_PORT=9443
```

## `.env` real

El archivo `.env` real puede contener valores sensibles y específicos del entorno.

No debe versionarse nunca.

Ejemplo:

```dotenv
SERVICENAMEA_DB_PASSWORD=valor-real-privado
TELEGRAM_TOKEN=token-real-privado
```

## `.env.example`

El archivo `.env.example` debe permitir entender qué variables necesita el stack sin exponer datos reales.

Ejemplo correcto:

```dotenv
SERVICENAMEA_DB_PASSWORD=CHANGEME
TELEGRAM_TOKEN=CHANGEME
```

Ejemplo incorrecto:

```dotenv
SERVICENAMEA_DB_PASSWORD=password123
TELEGRAM_TOKEN=0000000001:AAAbbCCdEf1gH_IjKl2M34n5o_pq-RsTTT
```

Aunque sean valores falsos, no deben parecer secretos reales.

## Uso en `compose.yaml`

Las variables del `.env` deben usarse en `compose.yaml` de forma clara:

```yaml
services:
  servicenamea:
    image: example/servicenamea:latest
    container_name: servicenamea
    restart: unless-stopped
    environment:
      TZ: ${TZ}
      PUID: ${PUID}
      PGID: ${PGID}
      DB_HOST: ${SERVICENAMEA_DB_HOST}
    volumes:
      - ${APPDATA_DIR}/servicenamea:/config
    ports:
      - "${SERVICENAMEA_HOST_PORT}:${SERVICENAMEA_CONTAINER_PORT}"
```

## Checklist antes de versionar

Antes de hacer commit:

* Comprobar que `.env` está ignorado por Git.
* Comprobar que `.env.example` sí aparece en Git.
* Revisar que no hay secretos reales.
* Revisar que no hay tokens falsos con apariencia real.
* Revisar que todas las variables usadas en `compose.yaml` existen en `.env.example`.
* Ejecutar `docker compose config` para validar interpolación de variables.
* Revisar `git status --short` antes de hacer commit.

## Comandos útiles

```bash
git status --short
docker compose config
docker compose --env-file .env config
```

## Recomendación para Codex

Cuando Codex modifique un stack Docker:

* Debe actualizar `.env.example` si añade o cambia variables.
* Debe avisar si falta una variable usada en `compose.yaml`.
* Debe evitar tocar `.env` salvo petición explícita.
* Debe revisar que no se introducen secretos en archivos versionados.
* Debe mantener la estructura de secciones del `.env.example`.
