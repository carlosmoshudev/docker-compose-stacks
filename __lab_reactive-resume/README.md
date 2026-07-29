# Reactive Resume LAB stack

Este stack de laboratorio contiene Reactive Resume para probar creacion y edicion de CVs. Esta separado bajo `__lab_reactive-resume/` porque puede ser temporal y moverlo a produccion deberia ser una decision posterior.

## Servicios

| Servicio | Imagen | Puerto | Persistencia |
| --- | --- | --- | --- |
| `reactive-resume` | `ghcr.io/amruthpillai/reactive-resume:latest` | `${REACTIVE_RESUME_HOST_PORT}:3000` | `${APPDATA_DIR}/app` |
| `reactive-resume-db` | `postgres:16-alpine` | No publica | `${APPDATA_DIR}/postgres` |
| `reactive-resume-redis` | `redis:7-alpine` | No publica | `${APPDATA_DIR}/redis` |
| `reactive-resume-seaweedfs` | `chrislusf/seaweedfs:latest` | No publica | `${APPDATA_DIR}/seaweedfs` |
| `reactive-resume-create-bucket` | `quay.io/minio/mc:latest` | No publica | Job de inicializacion |

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose config
docker compose up -d
```

URL local esperada:

```txt
http://cali-home:3015
```

## Notas operativas

- Cambia todos los valores `replace_with_*` antes de arrancar.
- Este stack usa Postgres, Redis y SeaweedFS porque es la arquitectura actual recomendada por el proyecto.
- PDF generation se realiza en cliente en versiones actuales, por eso no se anade Browserless/Chromium.
- Mantenerlo como laboratorio hasta decidir si merece pasar a un stack productivo.

## Validacion

```bash
docker compose config
docker compose ps
docker compose logs --tail=100 reactive-resume
curl http://cali-home:3015/api/health
```
