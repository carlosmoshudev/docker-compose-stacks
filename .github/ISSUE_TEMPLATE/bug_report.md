---
name: Bug report
about: Algo no funciona como deberia en un stack o servicio
title: "FIX(scope): "
labels: "type:bug, risk:needs-review"
assignees: "carlosmoshudev"
---

## Resumen

Describe el fallo de forma breve.

## Stack o servicio afectado

- Stack:
- Servicio:
- Archivo relacionado:

## Comportamiento actual

Que ocurre ahora.

## Comportamiento esperado

Que deberia ocurrir.

## Cambios recientes

Indica si ha habido cambios recientes en compose, `.env`, proxy, DNS, rutas, permisos o actualizaciones de imagen.

## Evidencia

Logs, errores o comandos relevantes:

```bash
docker compose ps
docker compose logs --tail=100 <servicio>
docker compose config
```

## Riesgo

- [ ] Bajo: no afecta produccion.
- [ ] Medio: afecta un servicio pero hay workaround.
- [ ] Alto: afecta red, datos, seguridad o varios servicios.

## Checklist

- [ ] No incluye secretos, tokens ni credenciales.
- [ ] No incluye contenido de `.env` real.
- [ ] No incluye datos personales o appdata.
