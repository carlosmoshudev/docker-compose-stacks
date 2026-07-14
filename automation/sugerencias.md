# Sugerencias para Automation

Estas ideas no estan aplicadas. Evaluarlas antes de modificar produccion.

| Servicio | Motivo |
| --- | --- |
| PostgreSQL para n8n | Mejor opcion que SQLite si crecen workflows, ejecuciones o usuarios. |
| Redis | Util para modo queue de n8n si necesitas workers o mas fiabilidad en ejecuciones largas. |
| Browserless / Playwright service | Complementa automatizaciones que necesiten navegador headless controlado. |
| Apprise | Centraliza notificaciones hacia Telegram, mail, Discord u otros canales. |
