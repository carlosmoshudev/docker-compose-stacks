# Sugerencias para Docker

Estas ideas no estan aplicadas. Evaluarlas antes de modificar produccion.

| Servicio | Motivo |
| --- | --- |
| Dockge | Gestiona stacks Compose desde UI sin abandonar YAML. |
| Watchtower | Alternativa a DIUN si algun stack requiere actualizacion automatica, con mucho cuidado en produccion. |
| cAdvisor | Metricas de contenedores si mas adelante se integra Prometheus/Grafana. |
| Grafana + Prometheus | Observabilidad mas completa si Netdata se queda corto. |
| Loki | Centralizacion de logs si Dozzle deja de ser suficiente. |
