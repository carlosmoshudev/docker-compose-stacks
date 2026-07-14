# Home stack

Este directorio contiene `esphome`, `homeassistant`, `matter-server`, `mosquitto` y `nodered`.

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

- `SOCK`, `LOCALTIME` y `DBUS` son necesarios para varios servicios.
- Ajusta `NODERED_PORT`, `MQTT_PORT` y `ESPHOME_PORT` según tu entorno.
