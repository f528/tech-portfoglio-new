#!/bin/bash
set -e

echo "🚀 Starting Laravel application..."

# Create .env file from .env.example if it doesn't exist
if [ ! -f .env ]; then
    echo "📄 Creating .env file from .env.example..."
    cp .env.example .env
fi

# Set APP_URL and ASSET_URL for production
if [ -n "$RENDER_EXTERNAL_URL" ]; then
    echo "🔗 Configuring production URLs..."
    export APP_URL="$RENDER_EXTERNAL_URL"
    export ASSET_URL="$RENDER_EXTERNAL_URL"
    echo "APP_URL set to: $APP_URL"
    echo "ASSET_URL set to: $ASSET_URL"
else
    echo "⚠️  RENDER_EXTERNAL_URL not set, using .env defaults"
fi

# Generate app key if not set
if [ -z "$APP_KEY" ]; then
    echo "🔑 Generating app key..."
    php artisan key:generate --force
fi

# Run migrations
echo "🗄️  Running migrations..."
php artisan migrate --force

# Create admin user if not exists
echo "👤 Creating admin user..."
php artisan admin:create || echo "Admin user already exists or command failed"

# Run seeder to populate database with sample data (optional - don't fail if it errors)
echo "🌱 Seeding database..."
php artisan db:seed --class=AutoDeploySeeder --force || echo "⚠️  Seeder failed, but continuing anyway..."

# Link storage (force recreate if exists)
echo "🔗 Linking storage..."
php artisan storage:link --force || echo "⚠️  Storage link failed, but continuing..."

# Verify storage link and create upload directories
echo "📁 Verifying storage setup..."
ls -la public/ | grep storage || echo "⚠️  Storage symlink not found in public/"

# Create storage subdirectories for uploads
mkdir -p storage/app/public/profile
mkdir -p storage/app/public/projects
mkdir -p storage/app/public/certifications

# Set proper permissions
chmod -R 775 storage/app/public
chown -R www-data:www-data storage/app/public || true

echo "✅ Storage directories ready"

# Publish Filament assets (CSS/JS)
echo "🎨 Publishing Filament assets..."
php artisan filament:assets || true

# Clear and cache config
echo "⚡ Optimizing..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Start server
echo "🌐 Starting PHP server on port ${PORT:-8000}..."
php artisan serve --host=0.0.0.0 --port=${PORT:-8000}
