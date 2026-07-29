# IPAM stack

Este stack contiene phpIPAM para gestionar rangos, subredes, VLANs e inventario de direcciones IP del homelab.

## Servicios

| Servicio | Imagen | Puerto | Persistencia |
| --- | --- | --- | --- |
| `phpipam-web` | `phpipam/phpipam-www:latest` | `${IPAM_HOST_PORT}:80` | `${APPDATA_DIR}/phpipam` |
| `phpipam-cron` | `phpipam/phpipam-cron:latest` | No publica | Usa la misma DB |
| `phpipam-db` | `mariadb:11.4` | No publica | `${APPDATA_DIR}/mariadb` |

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose config
docker compose up -d
```

URL local esperada:

```txt
http://cali-home:8089
```

## Notas operativas

- Cambia `IPAM_DB_PASSWORD` e `IPAM_DB_ROOT_PASSWORD` antes de arrancar.
- Tras completar el instalador inicial, cambia `IPAM_DISABLE_INSTALLER=true` en `.env`.
- `phpipam-web` y `phpipam-cron` usan `NET_ADMIN` y `NET_RAW` para ping, SNMP y descubrimiento.
- La red Docker del stack usa `172.30.20.0/24`.

## Validacion

```bash
docker compose config
docker compose ps
docker compose logs --tail=100 phpipam-web
curl http://cali-home:8089
```

