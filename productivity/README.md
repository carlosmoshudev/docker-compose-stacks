# Productivity stack

Este directorio contiene `it-tools` y `mealie`.

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

- `HOSTNAME` se utiliza para construir la URL de `mealie`.
- Revisa los puertos `ITTOOLS_PORT` y `MEALIE_PORT` para evitar conflictos.
