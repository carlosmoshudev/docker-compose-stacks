# Contributing

Este repositorio contiene configuración del homelab de Carlos. Los cambios deben ser pequeños, claros, seguros y fáciles de revisar.

## Reglas básicas

- No commitear `.env`, secretos, tokens ni credenciales reales.
- No commitear carpetas `data/`, backups ni datos persistentes de contenedores.
- No cambiar puertos publicados sin documentarlo.
- No añadir servicios nuevos sin explicar su propósito.
- No hacer cambios destructivos sin revisión previa.
- No mezclar cambios no relacionados en el mismo commit.

## Commits

Formato obligatorio:

```txt
TYPE(scope): short description
```

Tipos permitidos:

- `ADD`
- `FIX`
- `DELETE`
- `UPDATE`
- `DOCS`
- `REFACTOR`
- `SECURITY`
- `CHORE`

Ejemplos:

```txt
ADD(homepage): add initial service configuration
FIX(n8n): correct secure cookie environment variable
DOCS(codex): add docker compose guide
SECURITY(adguard): avoid exposing admin port
```

## Validación recomendada

Antes de hacer commit:

```bash
git status --short
docker compose config
```