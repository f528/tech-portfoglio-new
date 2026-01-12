FROM php:8.3-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    sqlite3 \
    libsqlite3-dev \
    libzip-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_sqlite mbstring exif pcntl bcmath gd zip

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy composer files first for better caching
COPY composer.json composer.lock ./

# Set composer memory limit and install dependencies
ENV COMPOSER_MEMORY_LIMIT=-1
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --no-dev --no-scripts --no-autoloader --no-interaction --prefer-dist

# Copy application files
COPY . /app

# Generate optimized autoload files
RUN composer dump-autoload --optimize --no-dev

# Create SQLite database directory
RUN mkdir -p /app/database && \
    touch /app/database/database.sqlite && \
    chmod -R 775 /app/database

# Set permissions
RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache

# Expose port
EXPOSE 8000

# Start script
COPY docker-start.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start

CMD ["/usr/local/bin/start"]
