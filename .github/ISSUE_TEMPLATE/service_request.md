---
name: Service request
about: Proponer un nuevo contenedor, stack o herramienta para el homelab
title: "ADD(scope): "
labels: "type:service, area:docker, risk:needs-review"
assignees: "carlosmoshudev"
---

## Servicio propuesto

- Nombre:
- Imagen o proyecto:
- Documentacion:

## Problema que resuelve

Explica que necesidad cubre y por que merece vivir en el homelab.

## Stack sugerido

- [ ] automation
- [ ] dashboard
- [ ] docker
- [ ] home
- [ ] library
- [ ] media
- [ ] network
- [ ] productivity
- [ ] stack nuevo

## Requisitos previstos

- Puertos:
- Volumenes:
- Variables `.env`:
- Dependencias:
- Acceso externo: si/no

## Riesgos

- [ ] Requiere privilegios elevados.
- [ ] Monta Docker socket.
- [ ] Usa `network_mode: host`.
- [ ] Expone panel de administracion.
- [ ] Maneja secretos o datos personales.
- [ ] Requiere backup.

## Criterios de aceptacion

- [ ] `compose.yaml` valida con `docker compose config`.
- [ ] `.env.example` documenta variables necesarias.
- [ ] `README.md` o `PUERTOS.md` queda actualizado si aplica.
- [ ] No se versiona appdata ni secretos.
