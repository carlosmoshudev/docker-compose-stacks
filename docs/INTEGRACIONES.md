# Integraciones

Mapa operativo de integraciones entre servicios del homelab.

## Notificaciones

| Origen | Evento | Destino | Metodo | Tags sugeridos | Prueba |
| --- | --- | --- | --- | --- | --- |
| DIUN | Actualizaciones de imagenes | n8n -> Apprise | Webhook HTTP con cabeceras `Cali-Notify-Key` y `Cali-Notify-Source` | `docker`, `updates` | Lanzar DIUN en modo prueba o esperar ciclo programado |
| Recyclarr | Cambios o errores de sincronizacion | Apprise | Apprise API | `media`, `updates` | Ejecutar sincronizacion manual |
| n8n | Workflows internos | Apprise | HTTP request | `critical`, `home` | Workflow manual con payload de prueba |
| Bazarr | Eventos de subtitulos | Apprise | Webhook/API si se configura | `media` | Envio manual desde el servicio |
| Home Assistant | Comandos y automatizaciones interactivas | Telegram | Integracion nativa HA | `home`, `critical` | Servicio `notify` o comando del bot |
| FreshRSS | Articulos/fuentes seleccionadas | n8n o Vikunja | API/RSS/filtro manual | `rss`, `reading` | Probar con una fuente de GitHub releases |
| Vikunja | Tareas y recordatorios | Calendario/n8n | API, CalDAV o iCal | `home`, `tasks` | Crear tarea de prueba desde n8n |

## Apprise

- URL interna recomendada: `http://apprise:8000` desde la red Docker del stack que lo consuma.
- URL LAN recomendada: `http://cali-home:8000`.
- Clave sugerida: `homelab`.
- Tags base: `critical`, `docker`, `media`, `home`, `updates`.

## DIUN hacia n8n

- Endpoint: `http://cali-home:5678/webhook/notifications`.
- En `docker/compose.yaml` el puerto se documenta como `N8N_NOTIFICATIONS_PORT` para no hardcodear `5678`.
- La clave se envia en la cabecera `Cali-Notify-Key`.
- El origen se envia en la cabecera `Cali-Notify-Source: diun`.
- La clave real debe vivir en `docker/.env` como `CALI_NOTIFY_KEY`.
- DIUN no envia ya a Telegram directamente; n8n decide el destino final y puede reenviar a Apprise.
- El workflow de n8n debe rechazar peticiones sin cabecera valida antes de llamar a Apprise.

## Bot de Telegram

Se puede reutilizar el bot de Home Assistant si Apprise solo envia mensajes. La regla importante es que solo Home Assistant debe recibir comandos o hacer polling/webhook de entrada. Apprise no necesita leer mensajes de Telegram para enviar alertas.

## Apps nuevas en evaluacion

- AFFiNE puede actuar como espacio de notas/documentos y probar integraciones de IA. Mantener claves de proveedores fuera del repositorio.
- Vikunja puede recibir tareas desde n8n, RSS o Telegram si se decide centralizar pendientes.
- FreshRSS puede reducir correos de notificaciones y concentrar lectura tecnica en feeds.
- Reactive Resume queda en `__lab_reactive-resume/` hasta validar si merece promocionarse.
