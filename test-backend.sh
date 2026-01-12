#!/bin/bash
# Automated Backend API Test Script

echo "🔍 Testing Backend API Endpoints..."
echo "===================================="
echo ""

# Test /api/portfolio endpoint
echo "1️⃣ Testing /api/portfolio endpoint..."
RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" https://tech-portfoglio-new.onrender.com/api/portfolio)
HTTP_CODE=$(echo "$RESPONSE" | grep "HTTP_CODE" | cut -d':' -f2)
BODY=$(echo "$RESPONSE" | sed '/HTTP_CODE:/d')

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ API endpoint is UP (HTTP 200)"
    echo "📊 Response preview:"
    echo "$BODY" | python3 -m json.tool | head -20
else
    echo "❌ API endpoint FAILED (HTTP $HTTP_CODE)"
fi

echo ""
echo "2️⃣ Testing CORS headers..."
CORS_HEADERS=$(curl -s -I -H "Origin: https://tech-portfoglio-new.vercel.app" https://tech-portfoglio-new.onrender.com/api/portfolio | grep -i "access-control")

if [ -z "$CORS_HEADERS" ]; then
    echo "⚠️  CORS headers not found - may need configuration"
else
    echo "✅ CORS headers present:"
    echo "$CORS_HEADERS"
fi

echo ""
echo "3️⃣ Testing admin panel..."
ADMIN_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://tech-portfoglio-new.onrender.com/admin)
if [ "$ADMIN_CODE" = "200" ] || [ "$ADMIN_CODE" = "302" ]; then
    echo "✅ Admin panel accessible (HTTP $ADMIN_CODE)"
else
    echo "❌ Admin panel not accessible (HTTP $ADMIN_CODE)"
fi

echo ""
echo "===================================="
echo "✅ Backend test completed!"
