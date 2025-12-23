# Production Dockerfile for SpendInsight landing page
# Uses nginx to serve static files with reasonable defaults for production

FROM nginx:stable-alpine

LABEL maintainer="Dev Team <dev@spendinsight.example>"
LABEL org.opencontainers.image.source="https://github.com/your-org/your-repo"

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy site files
COPY . /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

# Healthcheck to ensure container is serving
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -q --spider http://127.0.0.1:80/ || exit 1

# Start nginx in foreground
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
