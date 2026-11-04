# Imagen base fija para que las builds sean reproducibles
FROM nginx:1.27-alpine

# Metadatos de la imagen
LABEL org.opencontainers.image.title="Product List" \
    org.opencontainers.image.authors="Neyzer Toledo"

# Copiar solo los archivos que se sirven, no todo el contexto
COPY index.html styles.css functions.js /usr/share/nginx/html/

# Puerto de escucha de Nginx
EXPOSE 80

# Verificar que el servidor responde
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -qO- http://localhost/ > /dev/null || exit 1

# Arrancar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
