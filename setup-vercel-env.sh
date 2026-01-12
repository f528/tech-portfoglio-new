#!/bin/bash
# Script per configurare Vercel environment variables automaticamente

echo "🚀 Configurazione Vercel Environment Variables..."
echo ""

# Check if vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Vercel CLI non installato. Installalo con:"
    echo "npm install -g vercel"
    exit 1
fi

BACKEND_URL="https://tech-portfoglio-new.onrender.com"

echo "⚙️  Aggiunta environment variables..."

# Add variables for all environments
vercel env add NEXT_PUBLIC_API_URL production preview development <<< "${BACKEND_URL}/api"
vercel env add NEXT_PUBLIC_STORAGE_URL production preview development <<< "${BACKEND_URL}/storage"  
vercel env add NEXT_PUBLIC_BACKEND_URL production preview development <<< "${BACKEND_URL}"

echo ""
echo "✅ Environment variables configurate!"
echo ""
echo "🔄 Triggering redeploy..."
vercel --prod

echo ""
echo "🎉 Fatto! Il frontend si sta redeployando con le nuove variabili."
echo "Aspetta 2-3 minuti e ricarica https://tech-portfoglio-new.vercel.app"
