#!/bin/bash
# Debug Cloudinary Configuration

echo "🔍 Verifica Configurazione Cloudinary su Render..."
echo "=================================================="
echo ""

# Test API endpoint
echo "1️⃣ Test backend API..."
API_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://tech-portfoglio-new.onrender.com/api/portfolio)
echo "Backend status: HTTP $API_STATUS"
echo ""

# Test admin panel
echo "2️⃣ Test admin panel..."
ADMIN_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://tech-portfoglio-new.onrender.com/admin)
echo "Admin panel status: HTTP $ADMIN_STATUS"
echo ""

echo "3️⃣ Verifica Environment Variables su Render..."
echo "Su Render Dashboard, verifica che siano configurate:"
echo "  ✓ CLOUDINARY_CLOUD_NAME"
echo "  ✓ CLOUDINARY_API_KEY"
echo "  ✓ CLOUDINARY_API_SECRET"
echo "  ✓ FILESYSTEM_DISK=cloudinary"
echo ""

echo "4️⃣ Problemi Comuni Upload:"
echo ""
echo "a) FILESYSTEM_DISK non impostato a 'cloudinary'"
echo "   → Soluzione: Su Render Environment, verifica FILESYSTEM_DISK=cloudinary"
echo ""
echo "b) Credenziali Cloudinary errate"
echo "   → Soluzione: Verifica su cloudinary.com/console"
echo ""
echo "c) Package cloudinary non installato"
echo "   → Già risolto: package installato nel backend"
echo ""
echo "d) Permessi file"
echo "   → Già risolto: permessi configurati nel Dockerfile"
echo ""

echo "=================================================="
echo "📝 Che errore vedi quando provi a caricare?"
echo "   A) Nessun errore ma file non si carica"
echo "   B) Errore rosso con messaggio"
echo "   C) Pagina bianca/crash"
echo "   D) Altro"
