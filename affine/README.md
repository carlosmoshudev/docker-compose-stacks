# AFFiNE stack

Este stack contiene AFFiNE, una herramienta self-hosted para notas, documentos, pizarras y colaboracion. Es buen candidato para probar integraciones con IA, bases de conocimiento y automatizaciones.

## Servicios

| Servicio | Imagen | Puerto | Persistencia |
| --- | --- | --- | --- |
| `affine` | `ghcr.io/toeverything/affine:${AFFINE_REVISION}` | `${AFFINE_HOST_PORT}:3010` | `${APPDATA_DIR}/affine` |
| `affine-migration` | `ghcr.io/toeverything/affine:${AFFINE_REVISION}` | No publica | Reutiliza config/storage de AFFiNE |
| `affine-db` | `pgvector/pgvector:pg16` | No publica | `${APPDATA_DIR}/postgres` |
| `affine-redis` | `redis:7-alpine` | No publica | Sin persistencia configurada |

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose config
docker compose up -d
```

URL local esperada:

```txt
http://cali-home:3010
```

## Notas operativas

- Cambia `AFFINE_DB_PASSWORD` antes de arrancar el stack.
- `AFFINE_REVISION=stable` sigue la recomendacion oficial para self-hosted. Si una actualizacion rompe algo, fijar una version concreta tras validar.
- La base de datos usa `pgvector/pgvector:pg16`, requerido por AFFiNE para capacidades modernas de busqueda/IA.
- Redis queda interno en la red Docker y no publica puerto.
- El job `affine-migration` se ejecuta antes de levantar `affine`.

## Validacion

```bash
docker compose config
docker compose ps
docker compose logs --tail=100 affine
curl http://cali-home:3010
```

