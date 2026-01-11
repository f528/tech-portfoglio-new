#!/bin/bash

# 🔍 Script di Test Connessione Frontend-Backend
# Questo script testa se il backend è raggiungibile e configurato correttamente

echo "🚀 Test Connessione Frontend-Backend"
echo "===================================="
echo ""

# Colori
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Funzione per test
test_endpoint() {
    local url=$1
    local description=$2
    
    echo -n "Testing $description... "
    
    response=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
    
    if [ "$response" = "200" ]; then
        echo -e "${GREEN}✅ OK${NC} (HTTP $response)"
        return 0
    elif [ "$response" = "000" ]; then
        echo -e "${RED}❌ FAIL${NC} (Cannot connect)"
        return 1
    else
        echo -e "${YELLOW}⚠️  WARNING${NC} (HTTP $response)"
        return 2
    fi
}

# Test CORS
test_cors() {
    local backend_url=$1
    local frontend_url=$2
    
    echo -n "Testing CORS... "
    
    response=$(curl -s -H "Origin: $frontend_url" \
        -H "Access-Control-Request-Method: GET" \
        -X OPTIONS -w "%{http_code}" -o /dev/null \
        "$backend_url/api/portfolio" 2>/dev/null)
    
    if [ "$response" = "200" ] || [ "$response" = "204" ]; then
        echo -e "${GREEN}✅ OK${NC}"
        return 0
    else
        echo -e "${RED}❌ FAIL${NC} (HTTP $response)"
        return 1
    fi
}

# Leggi gli URL
echo "📝 Inserisci gli URL dei tuoi servizi:"
echo ""
read -p "Backend URL (es: https://tuo-backend.onrender.com): " BACKEND_URL
read -p "Frontend URL (es: https://tuo-portfolio.vercel.app): " FRONTEND_URL

echo ""
echo "🔍 Testing endpoints..."
echo ""

# Test Backend Health
test_endpoint "$BACKEND_URL/up" "Backend Health"

# Test API Endpoint
test_endpoint "$BACKEND_URL/api/portfolio" "API Portfolio"

# Test Storage (se disponibile)
test_endpoint "$BACKEND_URL/storage" "Storage Access"

# Test CORS
echo ""
test_cors "$BACKEND_URL" "$FRONTEND_URL"

echo ""
echo "===================================="
echo "📊 Test completato!"
echo ""
echo "Se vedi errori, segui la guida in DEPLOYMENT_FIX.md"
