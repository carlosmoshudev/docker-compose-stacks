# Carlos Docker `compose.yaml` guide

## Objetivo

Esta guía define la estructura recomendada para los archivos `compose.yaml` de los stacks Docker del homelab.

El objetivo es mantener stacks claros, seguros, documentados, fáciles de revisar y coherentes entre producción, laboratorio y servicios auxiliares.

## Reglas generales

* Usar `compose.yaml` como nombre principal del archivo.
* Usar `name:` para definir el nombre del proyecto Compose.
* Mantener una estructura consistente entre stacks.
* Separar configuración sensible en `.env`.
* No hardcodear secretos, tokens, contraseñas ni claves API.
* Usar variables de entorno documentadas en `.env.example`.
* Evitar publicar puertos innecesarios en el host.
* No usar `latest` en servicios críticos salvo decisión explícita.
* Añadir `restart: unless-stopped` salvo que haya una razón para no hacerlo.
* Añadir `healthcheck` cuando el servicio lo soporte de forma razonable.
* Añadir `logging` cuando el servicio pueda generar muchos logs.
* Validar siempre con `docker compose config` después de modificar el archivo.

## Estructura base

```yaml
# ============================================================
# STACK: Stackname [PRODUCCIÓN]              compose.yaml
# ------------------------------------------------------------
# - ServiceNameA: https://servicename.example.com
# - ServiceNameB: https://github.com/someone/servicenameb
# ------------------------------------------------------------
# Desarrollado y mantenido por Carlos Moshu
# Stack de cali-home, servidor doméstico de Carlos y Lilia
# ============================================================

name: stackname

# ============================================================
# BLOQUES REUTILIZABLES
# ============================================================

x-common-env: &common-env
  TZ: ${TZ}
  PUID: ${PUID}
  PGID: ${PGID}

x-common-labels: &common-labels
  autoheal: "true"
  diun.enable: "true"

x-http-healthcheck: &http-healthcheck
  interval: 1m30s
  timeout: 10s
  retries: 3
  start_period: 30s

x-default-logging: &default-logging
  driver: "json-file"
  options:
    max-size: "10m"
    max-file: "3"

services:
  # ============================================================
  # ServiceNameA
  # ------------------------------------------------------------
  # Breve resumen del servicio y su función dentro del stack.
  # ============================================================
  service-name-a:
    image: example/servicenamea:1.0.0
    container_name: service-name-a
    restart: unless-stopped

    environment:
      <<: *common-env
      SERVICE_SETTING: ${SERVICENAMEA_SETTING}

    volumes:
      - ${APPDATA_DIR}/servicenamea:/config
      - ${LOCALTIME_PATH}:/etc/localtime:ro

    ports:
      - "${SERVICENAMEA_HOST_PORT}:${SERVICENAMEA_CONTAINER_PORT}"

    labels:
      <<: *common-labels

    healthcheck:
      <<: *http-healthcheck
      test: ["CMD-SHELL", "wget --no-verbose --tries=1 --spider http://127.0.0.1:${SERVICENAMEA_CONTAINER_PORT} || exit 1"]

    logging: *default-logging

    networks:
      - stackname-net

networks:
  stackname-net:
    name: stackname-net
    driver: bridge
```

## Orden recomendado dentro de cada servicio

Mantener este orden siempre que sea posible:

```yaml
services:
  service-name:
    image:
    container_name:
    restart:

    depends_on:

    environment:

    volumes:

    ports:

    expose:

    labels:

    healthcheck:

    logging:

    networks:
```

No es obligatorio que todos los servicios tengan todas las secciones. Solo deben añadirse cuando tengan sentido.

## Comentarios

Los comentarios deben ayudar a entender el stack, no llenar el archivo de ruido.

Usar comentarios para:

* Separar servicios visualmente.
* Explicar decisiones no obvias.
* Explicar por qué se usa una versión concreta.
* Explicar configuraciones delicadas.
* Marcar servicios críticos.
* Avisar de dependencias importantes.

Evitar comentarios para cosas evidentes.

Ejemplo correcto:

```yaml
# Se fija esta versión porque la 2.0 cambia el formato de la base de datos.
image: example/service:1.9.4
```

Ejemplo innecesario:

```yaml
# Puerto del servicio
ports:
  - "8080:80"
```

## Imágenes

En producción, preferir versiones fijadas:

```yaml
image: example/service:1.4.2
```

Evitar en servicios críticos:

```yaml
image: example/service:latest
```

`latest` puede usarse en laboratorio o pruebas, pero debe quedar claro que no es una decisión de producción.

## `container_name`

En este homelab se permite usar `container_name` para facilitar operación manual, logs y diagnóstico.

Ejemplo:

```yaml
container_name: portainer
```

No usar nombres ambiguos ni genéricos como:

```yaml
container_name: app
container_name: db
container_name: server
```

Preferir nombres claros:

```yaml
container_name: n8n
container_name: n8n-postgres
container_name: homepage
```

## Variables de entorno

Preferir variables desde `.env`:

```yaml
environment:
  TZ: ${TZ}
  PUID: ${PUID}
  PGID: ${PGID}
```

También se puede usar un bloque reutilizable:

```yaml
x-common-env: &common-env
  TZ: ${TZ}
  PUID: ${PUID}
  PGID: ${PGID}

services:
  service-name:
    environment:
      <<: *common-env
      SERVICE_SETTING: ${SERVICE_SETTING}
```

Toda variable usada en `compose.yaml` debe estar documentada en `.env.example`.

## Volúmenes

Usar rutas claras y coherentes:

```yaml
volumes:
  - ${APPDATA_DIR}/servicename:/config
```

Reglas:

* Los datos persistentes deben ir bajo `data/` o bajo la ruta definida por `APPDATA_DIR`.
* No montar carpetas del sistema salvo necesidad clara.
* Montar sockets o rutas sensibles solo cuando el servicio lo necesite.
* Montar archivos del host como solo lectura cuando sea posible.

Ejemplo:

```yaml
volumes:
  - ${DOCKER_SOCK_PATH}:/var/run/docker.sock:ro
  - ${LOCALTIME_PATH}:/etc/localtime:ro
```

## Puertos

Publicar puertos solo cuando el servicio necesite acceso desde fuera de la red Docker.

Ejemplo:

```yaml
ports:
  - "${PORTAINER_HOST_PORT}:${PORTAINER_CONTAINER_PORT}"
```

Si el servicio solo necesita comunicación interna entre contenedores, preferir no publicar puerto.

Cuando se usen puertos, deben estar documentados en `.env.example` y en la documentación de puertos del repositorio.

## `expose`

Usar `expose` solo para documentar puertos internos entre contenedores cuando no se quiera publicar el puerto en el host.

Ejemplo:

```yaml
expose:
  - "3000"
```

## Redes

Usar redes explícitas cuando el stack tenga varios servicios o necesite integración con otros stacks.

Ejemplo:

```yaml
networks:
  stackname-net:
    name: stackname-net
    driver: bridge
```

Y en el servicio:

```yaml
networks:
  - stackname-net
```

No conectar servicios a redes externas sin justificarlo.

## `depends_on`

Usar `depends_on` cuando un servicio dependa de otro para arrancar correctamente.

Ejemplo simple:

```yaml
depends_on:
  - postgres
```

Si se usan healthchecks, se puede usar condición:

```yaml
depends_on:
  postgres:
    condition: service_healthy
```

No usar `depends_on` como sustituto de una configuración correcta de reintentos o conexión del propio servicio.

## Labels

Usar `labels` para integraciones como Autoheal, DIUN, Traefik, Homepage u otras herramientas.

Ejemplo:

```yaml
labels:
  autoheal: "true"
  diun.enable: "true"
```

Si una label activa exposición, actualización automática o integración externa, debe revisarse con cuidado.

## Healthchecks

Añadir `healthcheck` cuando haya una forma fiable de comprobar que el servicio funciona.

Ejemplo HTTP:

```yaml
healthcheck:
  interval: 1m30s
  timeout: 10s
  retries: 3
  start_period: 30s
  test: ["CMD-SHELL", "wget --no-verbose --tries=1 --spider http://127.0.0.1:8080 || exit 1"]
```

No añadir healthchecks falsos o frágiles que fallen sin motivo.

## Logging

Usar logging limitado para evitar crecimiento excesivo de logs.

Ejemplo:

```yaml
logging:
  driver: "json-file"
  options:
    max-size: "10m"
    max-file: "3"
```

Puede definirse como bloque reutilizable:

```yaml
x-default-logging: &default-logging
  driver: "json-file"
  options:
    max-size: "10m"
    max-file: "3"

services:
  service-name:
    logging: *default-logging
```

## Cosas que no debe hacer Codex

Codex no debe:

* Inventar puertos.
* Inventar variables de entorno.
* Cambiar rutas persistentes sin avisar.
* Cambiar nombres de contenedores sin justificarlo.
* Añadir servicios nuevos sin explicar para qué sirven.
* Publicar paneles sensibles sin protección.
* Usar `privileged: true` salvo necesidad clara.
* Usar `network_mode: host` salvo necesidad clara.
* Recomendar `docker compose down -v` salvo petición explícita y advertencia clara.
* Eliminar volúmenes, bases de datos, backups o carpetas `data/`.

## Checklist antes de terminar

Antes de dar por bueno un cambio en `compose.yaml`:

* Revisar el diff completo.
* Comprobar que las variables usadas existen en `.env.example`.
* Comprobar que no se han añadido secretos.
* Comprobar que los puertos están documentados.
* Comprobar que los volúmenes persistentes apuntan a rutas correctas.
* Comprobar que no se exponen servicios sensibles innecesariamente.
* Ejecutar o recomendar:

```bash
docker compose config
docker compose ps
docker compose logs
```

## Ejemplo de servicio completo

```yaml
services:
  homepage:
    image: ghcr.io/gethomepage/homepage:v1.0.0
    container_name: homepage
    restart: unless-stopped

    environment:
      <<: *common-env
      HOMEPAGE_ALLOWED_HOSTS: ${HOMEPAGE_ALLOWED_HOSTS}

    volumes:
      - ${APPDATA_DIR}/homepage:/app/config
      - ${DOCKER_SOCK_PATH}:/var/run/docker.sock:ro

    ports:
      - "${HOMEPAGE_HOST_PORT}:${HOMEPAGE_CONTAINER_PORT}"

    labels:
      <<: *common-labels

    logging: *default-logging

    networks:
      - homepage-net

networks:
  homepage-net:
    name: homepage-net
    driver: bridge
```
