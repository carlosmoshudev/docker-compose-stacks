# Pull Request

## Resumen

Describe brevemente qué cambia este PR.

## Tipo de cambio

Marca lo que corresponda:

- [ ] ADD: añade servicio, archivo, feature o documentación nueva.
- [ ] FIX: corrige error de configuración, ruta, variable, puerto o servicio.
- [ ] DELETE: elimina servicio, archivo o configuración obsoleta.
- [ ] UPDATE: modifica configuración existente.
- [ ] DOCS: cambia solo documentación.
- [ ] REFACTOR: reorganiza sin cambiar comportamiento esperado.
- [ ] SECURITY: afecta a seguridad, red, permisos, secretos o exposición.
- [ ] CHORE: mantenimiento general.

## Área afectada

- [ ] Docker
- [ ] Home Assistant
- [ ] Network / DNS / Proxy
- [ ] Monitoring
- [ ] Backup
- [ ] Docs
- [ ] GitHub / CI
- [ ] Codex / agentes
- [ ] Otro

## Riesgo

- [ ] Bajo: cambio documental o no afecta producción.
- [ ] Medio: puede requerir reinicio o validación manual.
- [ ] Alto: afecta producción, red, volúmenes, datos o seguridad.

## Checklist

- [ ] Revisé el diff completo.
- [ ] No se commitean `.env` reales.
- [ ] No se commitean secretos, tokens ni credenciales.
- [ ] No se commitean carpetas `data/`.
- [ ] Actualicé `.env.example` si añadí variables.
- [ ] Actualicé documentación si cambié puertos, rutas o servicios.
- [ ] Validé YAML o indiqué cómo validarlo.
- [ ] Avisé si requiere reinicio de contenedores o servicios.

## Validación realizada

Comandos ejecutados o recomendados:

```bash
git status --short
docker compose config
docker compose ps
docker compose logs
```