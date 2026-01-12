#!/bin/bash
# Final End-to-End Test Script

echo "🧪 Testing Complete Frontend-Backend Integration..."
echo "=================================================="
echo ""

# Test 1: Backend API
echo "1️⃣ Backend API Test..."
BACKEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://tech-portfoglio-new.onrender.com/api/portfolio)
if [ "$BACKEND_STATUS" = "200" ]; then
    echo "✅ Backend API operational (HTTP $BACKEND_STATUS)"
else
    echo "❌ Backend API issue (HTTP $BACKEND_STATUS)"
fi

echo ""

# Test 2: Frontend accessible
echo "2️⃣ Frontend Accessibility Test..."
FRONTEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://tech-portfoglio-new.vercel.app)
if [ "$FRONTEND_STATUS" = "200" ]; then
    echo "✅ Frontend accessible (HTTP $FRONTEND_STATUS)"
else
    echo "❌ Frontend issue (HTTP $FRONTEND_STATUS)"
fi

echo ""

# Test 3: CORS
echo "3️⃣ CORS Configuration Test..."
CORS_TEST=$(curl -s -I -H "Origin: https://tech-portfoglio-new.vercel.app" https://tech-portfoglio-new.onrender.com/api/portfolio | grep -i "access-control-allow-origin")
if [ -n "$CORS_TEST" ]; then
    echo "✅ CORS configured correctly"
    echo "$CORS_TEST"
else
    echo "⚠️  CORS headers not found"
fi

echo ""

# Test 4: API Data
echo "4️⃣ API Data Test..."
API_DATA=$(curl -s https://tech-portfoglio-new.onrender.com/api/portfolio)
PROFILE_NAME=$(echo "$API_DATA" | python3 -c "import sys, json; print(json.load(sys.stdin)['profile']['name'])" 2>/dev/null)
SKILLS_COUNT=$(echo "$API_DATA" | python3 -c "import sys, json; print(len(json.load(sys.stdin)['skills']))" 2>/dev/null)

if [ -n "$PROFILE_NAME" ]; then
    echo "✅ Profile data: $PROFILE_NAME"
else
    echo "⚠️  Profile data missing"
fi

if [ -n "$SKILLS_COUNT" ] && [ "$SKILLS_COUNT" -gt 0 ]; then
    echo "✅ Skills count: $SKILLS_COUNT"
else
    echo "⚠️  Skills data missing"
fi

echo ""
echo "=================================================="
echo "✅ Test completed! Check results above."
echo ""
echo "🌐 URLs:"
echo "Backend: https://tech-portfoglio-new.onrender.com/admin"
echo "Frontend: https://tech-portfoglio-new.vercel.app"
