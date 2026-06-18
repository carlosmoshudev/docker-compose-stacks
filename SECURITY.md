# Security Policy

Este repositorio puede contener configuración de infraestructura, Docker, Home Assistant, automatización y servicios internos del homelab.

## Información sensible

No se debe commitear:

- Archivos `.env` reales.
- Tokens.
- Contraseñas.
- Claves API.
- Claves privadas.
- Certificados privados.
- Backups con datos reales.
- Carpetas `data/` de contenedores.
- Información personal sensible.
- Detalles de red que no deban exponerse públicamente.

## `.env` y secretos

Los archivos `.env` reales no deben versionarse.

Usar siempre `.env.example` para documentar variables necesarias sin incluir valores reales.

Ejemplo correcto:

```dotenv
TELEGRAM_TOKEN=CHANGEME
DATABASE_PASSWORD=CHANGEME
```

Ejemplo incorrecto:

```dotenv
TELEGRAM_TOKEN=123456789:AA...
DATABASE_PASSWORD=password123
```

## Si se filtra un secreto

Si un secreto se commitea por error:

1. Eliminarlo del repositorio.
2. Rotar la credencial afectada.
3. Revisar si aparece en el historial de Git.
4. Considerar limpiar el historial si el repo es público o compartido.
5. Revisar accesos y logs del servicio afectado.

## Cambios de seguridad

Los cambios que afecten a red, exposición de puertos, DNS, proxy, autenticación, HTTPS, permisos o secretos deben revisarse con especial cuidado.

Ejemplos:

- Abrir un puerto al host.
- Publicar un panel de administración.
- Cambiar configuración de Nginx Proxy Manager.
- Cambiar AdGuard, DNS o reglas de red.
- Montar /var/run/docker.sock.
- Usar privileged: true.
- Usar network_mode: host.
