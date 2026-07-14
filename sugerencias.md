# Sugerencias generales para el homelab

Estas ideas no estan aplicadas. Sirven como backlog para evaluar con calma antes de tocar produccion.

## Seguridad y acceso

| Servicio | Encaje | Motivo |
| --- | --- | --- |
| Authelia o Authentik | `network` | Capa SSO/MFA delante de paneles sensibles publicados por Nginx Proxy Manager. |
| CrowdSec | `network` / `docker` | Deteccion colaborativa de abuso y bloqueo automatizable en proxy/firewall. |
| WireGuard / wg-easy | `network` | Acceso remoto privado al homelab sin exponer paneles internos. |

## Operacion

| Servicio | Encaje | Motivo |
| --- | --- | --- |
| Uptime Kuma | `docker` o `dashboard` | Monitorizacion simple de URLs, puertos y certificados con alertas. |
| Beszel | `docker` | Monitorizacion ligera de hosts y contenedores. |
| Dockge | `docker` | Gestion visual de stacks Compose manteniendo archivos YAML como fuente. |

## Backups

| Servicio | Encaje | Motivo |
| --- | --- | --- |
| Restic / Backrest | stack nuevo `backup` | Backups versionados y cifrados de configuraciones. |
| Kopia | stack nuevo `backup` | Alternativa con UI para backups cifrados. |

## Documentacion

| Servicio | Encaje | Motivo |
| --- | --- | --- |
| Wiki.js o BookStack | `productivity` | Documentar procedimientos, puertos, restauraciones y decisiones del homelab. |
