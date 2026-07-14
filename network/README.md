# Network stack

Este directorio contiene `adguardhome` y `nginx-proxy-manager`.

## Archivos

- `compose.yaml`: definición de los servicios
- `.env`: configuración local de variables

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose up -d
```

## Notas

- Ajusta los puertos DNS y HTTP/HTTPS según tu red.
- `ADGUARD_DNS_PORT` suele requerir permisos de red especiales.
