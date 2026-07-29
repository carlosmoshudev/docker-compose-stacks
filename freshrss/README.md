# FreshRSS stack

Este stack contiene FreshRSS, un lector RSS self-hosted para seguir webs, blogs, changelogs, releases y noticias sin depender del correo.

## Servicios

| Servicio | Imagen | Puerto | Persistencia |
| --- | --- | --- | --- |
| `freshrss` | `freshrss/freshrss:latest` | `${FRESHRSS_HOST_PORT}:80` | `${APPDATA_DIR}/freshrss` |

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose config
docker compose up -d
```

URL local esperada:

```txt
http://cali-home:8087
```

## Uso recomendado

- Empezar con pocas fuentes: proyectos Docker que uses, blogs tecnicos y changelogs importantes.
- Usar carpetas por tema: `homelab`, `docker`, `seguridad`, `media`, `dev`.
- Si algo es accionable, enviarlo a `n8n` o `Vikunja` en vez de dejarlo perdido como lectura eterna.
- `FRESHRSS_CRON_MIN=4,34` actualiza feeds dos veces por hora.

## Validacion

```bash
docker compose config
docker compose ps
docker compose logs --tail=100 freshrss
curl http://cali-home:8087
```

