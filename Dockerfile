# Multi-stage build for better optimization
FROM nginx:alpine

# Set environment variables
ENV NGINX_PORT=80
ENV NGINX_ROOT=/usr/share/nginx/html

# Remove default Nginx static files
RUN rm -rf ${NGINX_ROOT}/*

# Create custom Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy your existing HTML file and any assets
COPY index.html ${NGINX_ROOT}/
# If you have CSS/JS/images, uncomment these lines:
# COPY css/ ${NGINX_ROOT}/css/
# COPY js/ ${NGINX_ROOT}/js/
# COPY images/ ${NGINX_ROOT}/images/

# Create a non-root user for security
RUN addgroup -g 1001 -S www-user && \
    adduser -S www-user -u 1001 -G www-user && \
    chown -R www-user:www-user /var/cache/nginx && \
    chown -R www-user:www-user /var/log/nginx && \
    chown -R www-user:www-user /etc/nginx/conf.d && \
    chown -R www-user:www-user ${NGINX_ROOT}

# Switch to non-root user
USER www-user

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:${NGINX_PORT}/ || exit 1

# Expose port
EXPOSE ${NGINX_PORT}

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
