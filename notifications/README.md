# Notifications stack

Este directorio contiene `apprise`, un gateway centralizado para enviar notificaciones desde servicios internos hacia Telegram, email, ntfy u otros destinos soportados.

## Archivos

- `compose.yaml`: definicion del servicio.
- `.env.example`: variables documentadas sin secretos.
- `.env`: configuracion local no versionada.

## Setup

```powershell
Copy-Item .\.env.example .\.env
notepad .\.env
docker compose up -d
```

## Uso recomendado

- Mantener el puerto `APPRISE_HOST_PORT` solo en LAN o detras de Nginx Proxy Manager con autenticacion.
- No exponer Apprise directamente a Internet.
- Usar una clave de configuracion como `homelab` y tags como `critical`, `docker`, `media`, `home` y `updates`.
- Si se reutiliza el bot de Telegram de Home Assistant, dejar que Home Assistant sea el unico receptor de comandos. Apprise solo debe enviar mensajes.

## Configuracion inicial

1. Abrir `http://cali-home:8000`.
2. Crear una configuracion con la clave `homelab`.
3. Añadir el destino Telegram, email o ntfy desde la interfaz de Apprise.
4. Asignar tags a cada destino.
5. Probar el estado:

```bash
curl http://cali-home:8000/status
```

## Rotacion de token Telegram

1. Rotar el token en BotFather.
2. Actualizar la URL de Telegram en la configuracion persistente de Apprise.
3. Probar el envio con tag `critical`.
4. Actualizar Home Assistant si comparte el mismo bot.

## Notas

- La configuracion persistente vive en `./data/apprise/config`.
- Los adjuntos persistentes viven en `./data/apprise/attach`.
- Los plugins persistentes viven en `./data/apprise/plugin`.
- No guardar tokens reales en este repositorio.
- `latest` se usa porque la documentacion del proyecto lo define como build estable. Tras validar en produccion puede fijarse version o digest.
