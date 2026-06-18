# AGENTS.md

## Objetivo del proyecto

Este repositorio contiene configuración y automatizaciones para el homelab de Carlos:
Docker, Home Assistant, servicios de red, monitorización, backups y herramientas internas.

## Cómo trabajar

- Antes de modificar archivos, revisa la estructura del proyecto.
- No inventes servicios, variables ni puertos sin comprobar los archivos existentes.
- Mantén los cambios pequeños, claros y reversibles.
- Explica siempre qué has cambiado y por qué.
- Si hay riesgo de romper producción, propón primero un plan.

## Docker

- Usa `compose.yaml` como archivo principal.
- No hardcodees secretos.
- Usa `.env.example` para documentar variables.
- Mantén nombres de servicios claros y consistentes.
- Añade `restart: unless-stopped` salvo que haya una razón para no hacerlo.
- Añade healthchecks cuando el servicio lo soporte.
- No expongas puertos innecesarios fuera de la red Docker.
- La estructura es siempre `{stack-name}/` { - `Data/` | - `.env` | `.env.example` | `compose.yaml` | `README.md`
- En raiz documentamos los puertos, tanto de host como el del conteneor. Buscaremos documentarlo de una mejor manera de como actualmente está.

## Home Assistant

- No modificar `configuration.yaml` sin revisar antes integraciones existentes.
- Preferir paquetes o includes si el archivo principal empieza a crecer.
- Documentar entidades, sensores y automatizaciones nuevas.

## Estilo

- Código limpio.
- Comentarios solo cuando aporten contexto real.
- Logs en castellano.
- Nombres descriptivos.
- Evitar soluciones “mágicas” difíciles de mantener.
- Aplicaremos SOLID y CleanCode en la medida de lo posible. Patrones de diseño siempre son bienvenidos.

## Validación

Antes de terminar:

- Revisar diff completo.
- Comprobar sintaxis YAML.
- Indicar comandos recomendados para probar.
- Señalar cualquier cambio que requiera reinicio de contenedores o servicios.

## Seguridad

- Nunca escribir tokens, contraseñas, claves API ni datos personales en archivos versionados.
- Si aparece un secreto en el repo, avisar y recomendar rotación.
- No abrir servicios sensibles a Internet sin proxy, autenticación y HTTPS.

## Información más específica

En el proyecto tienes /docs/codex donde encontrarás guias para trabajar.