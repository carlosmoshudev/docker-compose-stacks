# Vikunja stack

Este stack contiene Vikunja, un gestor de tareas y proyectos self-hosted.

## Servicios

| Servicio | Imagen | Puerto | Persistencia |
| --- | --- | --- | --- |
| `vikunja` | `vikunja/vikunja:latest` | `${VIKUNJA_HOST_PORT}:3456` | `${APPDATA_DIR}/vikunja/files` |
| `vikunja-db` | `postgres:16-alpine` | No publica | `${APPDATA_DIR}/postgres` |

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose config
docker compose up -d
```

URL local esperada:

```txt
http://cali-home:3456
```

## Notas operativas

- Cambia `VIKUNJA_SERVICE_SECRET` y `VIKUNJA_DB_PASSWORD` antes de arrancar.
- `VIKUNJA_PUBLIC_URL` debe coincidir con la URL real de acceso, incluyendo esquema y barra final.
- La carpeta de ficheros persistentes debe ser escribible por el usuario interno de Vikunja.
- La base de datos no publica puerto al host.

## Validacion

```bash
docker compose config
docker compose ps
docker compose logs --tail=100 vikunja
curl http://cali-home:3456/health
```

