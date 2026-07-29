# Automation stack

Este directorio contiene el stack de `n8n` con PostgreSQL como base de datos principal.

## Archivos

- `compose.yaml`: definición del servicio
- `.env`: configuración local de variables

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose up -d
```

## Notas

- Ajusta `N8N_HOST_PORT` y `N8N_CONTAINER_PORT` según tu configuración.
- Mantén `TZ` actualizado en todas las pilas.
- `WEBHOOK_URL` debe coincidir exactamente con la URL pública usada por integraciones externas, incluyendo la barra final `/`.
- n8n usa `DB_TYPE=postgresdb`; no cambiarlo a `postgres`.
- PostgreSQL persiste en `${APPDATA_DIR}/n8n-db`.
- La purga de ejecuciones queda activada con `EXECUTIONS_DATA_PRUNE=true`, `EXECUTIONS_DATA_MAX_AGE=168` y `EXECUTIONS_DATA_PRUNE_MAX_COUNT=10000`.
- Los paquetes community quedan activados con `N8N_COMMUNITY_PACKAGES_ENABLED=true` y `N8N_UNVERIFIED_PACKAGES_ENABLED=true`; instala solo paquetes de confianza.
- Para leer o escribir archivos desde workflows, usa rutas absolutas dentro del contenedor. Este stack monta `${APPDATA_DIR}/n8n/files` como `/files`.
- `N8N_BLOCK_FILE_ACCESS_TO_N8N_FILES` se mantiene en `true` por seguridad para evitar acceso desde workflows a ficheros internos de `.n8n`.

## Migración desde SQLite

La migración desde SQLite ya se validó con `export:entities` e `import:entities` antes de dejar PostgreSQL como configuración principal. Mantén el backup de SQLite hasta confirmar varios arranques correctos:

```txt
${APPDATA_DIR}/n8n/appdata/database.sqlite
${APPDATA_DIR}/n8n/files/migration/
```

Para futuras migraciones o restauraciones, exportar entidades desde la base activa:

```bash
docker compose config
docker compose exec n8n n8n export:entities --outputDir=/files/migration/entities
```

Los exports de entidades pueden contener datos sensibles. No versionarlos ni compartirlos.
