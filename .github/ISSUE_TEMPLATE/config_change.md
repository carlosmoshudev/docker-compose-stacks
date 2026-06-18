---
name: Config change
about: Cambio en compose, variables, puertos, proxy, DNS o documentacion operativa
title: "UPDATE(scope): "
labels: "type:change, area:docker, risk:needs-review"
assignees: "carlosmoshudev"
---

## Objetivo

Que se quiere cambiar y por que.

## Alcance

- Stack:
- Servicio:
- Archivos:

## Tipo de cambio

- [ ] Compose.
- [ ] `.env.example`.
- [ ] Puertos.
- [ ] Volumenes o rutas.
- [ ] DNS / proxy / red.
- [ ] Documentacion.
- [ ] Seguridad.

## Impacto esperado

Explica si requiere recrear contenedores, reiniciar servicios, migrar datos o tocar configuracion fuera del repo.

## Plan propuesto

1. Revisar estado actual.
2. Aplicar cambio minimo.
3. Validar sintaxis.
4. Documentar puertos, variables o pasos manuales.

## Validacion

Comandos previstos:

```bash
docker compose config
docker compose up -d
docker compose ps
```

## Checklist

- [ ] No se exponen secretos.
- [ ] No se toca appdata salvo que este indicado y aprobado.
- [ ] Se actualiza `.env.example` si hay variables nuevas.
- [ ] Se actualiza `PUERTOS.md` si cambian puertos.
- [ ] Se indica si requiere reinicio o recreacion.
