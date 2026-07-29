# Finance stack

Este stack contiene Firefly III para finanzas personales.

## Servicios

| Servicio | Imagen | Puerto | Persistencia |
| --- | --- | --- | --- |
| `firefly` | `fireflyiii/core:latest` | `${FIREFLY_HOST_PORT}:8080` | `${APPDATA_DIR}/firefly/upload` |
| `firefly-cron` | `alpine:3.20` | No publica | No aplica |
| `firefly-db` | `mariadb:11.4` | No publica | `${APPDATA_DIR}/mariadb` |

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose config
docker compose up -d
```

URL local esperada:

```txt
http://cali-home:8088
```

## Notas operativas

- `FIREFLY_APP_KEY` debe tener exactamente 32 caracteres aleatorios.
- `FIREFLY_STATIC_CRON_TOKEN` debe tener exactamente 32 caracteres aleatorios.
- La base de datos no publica puerto al host.
- La red Docker del stack usa `172.30.21.0/24`.
- Firefly III contiene datos financieros: proteger con proxy, HTTPS y credenciales fuertes si se expone fuera de LAN.

## Validacion

```bash
docker compose config
docker compose ps
docker compose logs --tail=100 firefly
curl http://cali-home:8088
```

