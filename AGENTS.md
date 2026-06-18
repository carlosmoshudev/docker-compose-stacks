# AGENTS.md

## Objetivo del proyecto

Este repositorio contiene configuración y automatizaciones para el homelab de Carlos:
Docker, Home Assistant, servicios de red, monitorización, backups y herramientas internas.

El objetivo principal es mantener un entorno ordenado, documentado, seguro y fácil de operar.

## Cómo trabajar

* Antes de modificar archivos, revisa la estructura del proyecto.
* No inventes servicios, variables, rutas ni puertos sin comprobar los archivos existentes.
* Mantén los cambios pequeños, claros y reversibles.
* Explica siempre qué has cambiado y por qué.
* Si hay riesgo de romper producción, propón primero un plan.
* No refactorices archivos no relacionados con la tarea.
* No añadas dependencias, imágenes o servicios nuevos sin justificarlo.
* Si una instrucción es ambigua, prioriza seguridad, mínima intervención y documentación.

## Estructura del repositorio

La estructura habitual de cada stack es:

```txt
{stack-name}/
├─ data/
├─ .env
├─ .env.example
├─ compose.yaml
└─ README.md
```

Reglas de estructura:

* `compose.yaml` es el archivo principal de cada stack.
* `.env` contiene valores reales y no debe versionarse.
* `.env.example` documenta las variables necesarias y sí debe versionarse.
* `README.md` explica el propósito del stack, servicios incluidos, puertos, rutas y notas operativas.
* `data/` contiene datos persistentes de contenedores y no debe versionarse.
* En la raíz del repositorio se documentan los puertos usados por host y contenedor.
* Si la documentación actual de puertos es mejorable, proponer una estructura más clara antes de cambiarla.

## Docker

* Usa `compose.yaml` como archivo principal.
* No hardcodees secretos.
* Usa `.env.example` para documentar variables.
* Mantén nombres de servicios claros y consistentes.
* Añade `restart: unless-stopped` salvo que haya una razón para no hacerlo.
* Añade healthchecks cuando el servicio lo soporte de forma razonable.
* No expongas puertos innecesarios fuera de la red Docker.
* No uses `latest` en servicios críticos salvo decisión explícita.
* No cambies puertos publicados en producción sin explicarlo.
* No borres volúmenes, datos, backups ni carpetas persistentes.
* No ejecutes ni recomiendes `docker compose down -v` salvo petición explícita y advertencia clara.
* Antes de proponer cambios en un stack existente, revisa servicios, redes, volúmenes, variables y puertos ya definidos.

## Home Assistant

* No modificar `configuration.yaml` sin revisar antes integraciones existentes.
* Preferir paquetes, includes o archivos separados si el archivo principal empieza a crecer.
* Documentar entidades, sensores, scripts y automatizaciones nuevas.
* No cambiar nombres de entidades existentes sin advertir del impacto.
* No asumir que una integración está disponible sin comprobar la configuración actual.

## Estilo

* Código limpio.
* Comentarios solo cuando aporten contexto real.
* Logs en castellano.
* Nombres descriptivos.
* Evitar soluciones mágicas difíciles de mantener.
* Aplicar Clean Code, SOLID y patrones de diseño solo cuando aporten claridad real.
* Priorizar soluciones simples, mantenibles y fáciles de revisar.

## Documentación

* Mantener actualizados los `README.md` de cada stack.
* Documentar puertos, rutas relevantes, credenciales esperadas mediante variables y pasos básicos de operación.
* No documentar secretos reales.
* Si se añade un servicio, documentar:

  * Para qué sirve.
  * Puerto interno y puerto publicado.
  * Variables necesarias.
  * Volúmenes persistentes.
  * URL local esperada, si aplica.
  * Comando básico de validación.

## Validación

Antes de terminar:

* Revisar el diff completo.
* Comprobar sintaxis YAML.
* Indicar comandos recomendados para probar.
* Señalar cualquier cambio que requiera reinicio de contenedores o servicios.
* Avisar si hay riesgo para producción.
* Recomendar `docker compose config` cuando se modifique un Compose.
* Recomendar `docker compose ps` y `docker compose logs` para validar el estado tras aplicar cambios.

## Seguridad

* Nunca escribir tokens, contraseñas, claves API ni datos personales en archivos versionados.
* Si aparece un secreto en el repositorio, avisar y recomendar rotación.
* No abrir servicios sensibles a Internet sin proxy, autenticación y HTTPS.
* No exponer paneles de administración sin protección.
* No modificar reglas de red, DNS, proxy o autenticación sin explicar riesgos.
* No asumir que un servicio es seguro por estar en red local.

## Commits

Los commits deben seguir una convención clara y consistente.

Formato obligatorio:

```txt
TYPE(scope): short description
```

Tipos permitidos:

* `ADD`: añadir servicio, archivo, feature, configuración o documentación nueva.
* `FIX`: corregir errores, rutas, variables, puertos, healthchecks o configuración rota.
* `DELETE`: eliminar servicios, archivos, variables o documentación obsoleta.
* `UPDATE`: modificar configuración existente sin que sea una corrección directa.
* `DOCS`: cambios exclusivamente de documentación.
* `REFACTOR`: reorganización interna sin cambiar comportamiento esperado.
* `SECURITY`: cambios relacionados con seguridad, secretos, exposición de servicios o permisos.
* `CHORE`: mantenimiento general del repositorio.

Reglas:

* El `TYPE` debe ir en mayúsculas.
* El `scope` debe ir en minúsculas y entre paréntesis.
* El mensaje debe ser breve, claro y en inglés técnico simple.
* No usar commits genéricos como `update`, `changes`, `fix stuff` o `misc`.
* No mezclar cambios no relacionados en el mismo commit.
* No hacer commit de `.env`, secretos, tokens, carpetas `data/`, backups ni archivos temporales.

Ejemplos correctos:

```txt
ADD(homepage): add initial service configuration
FIX(n8n): correct secure cookie environment variable
DELETE(lab): remove unused redmine stack
UPDATE(homeassistant): adjust mqtt integration notes
DOCS(codex): add docker compose guide
REFACTOR(docker): reorganize reusable compose blocks
SECURITY(adguard): avoid exposing admin port
CHORE(repo): update gitignore rules
```

Ejemplos incorrectos:

```txt
update
fix
changes
misc stuff
ADD: homepage
fix(n8n): cookie
DOCS add guide
```

## Información más específica

En `docs/codex/` hay guías adicionales para trabajar en este repositorio.

Consulta esa carpeta cuando la tarea esté relacionada con Docker, documentación, estructura del proyecto, Home Assistant, automatización o normas específicas del homelab.
