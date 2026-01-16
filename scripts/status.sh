#!/bin/bash

# BiblioVault Server Status Script

echo "📊 BiblioVault Server Status"
echo "════════════════════════════════════════"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check PostgreSQL
echo -n "PostgreSQL:  "
if pg_isready -q; then
    echo -e "${GREEN}✅ Running${NC}"
else
    echo -e "${RED}❌ Not running${NC}"
fi

# Check Backend
echo -n "Backend:     "
if lsof -ti:3000 > /dev/null 2>&1; then
    BACKEND_PID=$(lsof -ti:3000)
    echo -e "${GREEN}✅ Running${NC} (PID: $BACKEND_PID, Port: 3000)"
    # Test health endpoint
    if curl -s http://localhost:3000/api/health > /dev/null 2>&1; then
        echo "             🏥 Health check: OK"
    fi
else
    echo -e "${RED}❌ Not running${NC}"
fi

# Check Frontend
echo -n "Frontend:    "
if lsof -ti:3001 > /dev/null 2>&1; then
    FRONTEND_PID=$(lsof -ti:3001)
    echo -e "${GREEN}✅ Running${NC} (PID: $FRONTEND_PID, Port: 3001)"
else
    echo -e "${RED}❌ Not running${NC}"
fi

echo ""
echo "════════════════════════════════════════"
echo ""

# Show URLs if servers are running
if lsof -ti:3001 > /dev/null 2>&1 || lsof -ti:3000 > /dev/null 2>&1; then
    echo "🌐 Access Points:"
    if lsof -ti:3001 > /dev/null 2>&1; then
        echo -e "   Frontend:  ${GREEN}http://localhost:3001${NC}"
    fi
    if lsof -ti:3000 > /dev/null 2>&1; then
        echo -e "   Backend:   ${GREEN}http://localhost:3000${NC}"
        echo -e "   API Health: ${GREEN}http://localhost:3000/api/health${NC}"
    fi
    echo ""
fi

# Show log locations
echo "📝 Log Files:"
if [ -f /tmp/bibliovault-backend.log ]; then
    echo "   Backend:  /tmp/bibliovault-backend.log"
fi
if [ -f /tmp/bibliovault-frontend.log ]; then
    echo "   Frontend: /tmp/bibliovault-frontend.log"
fi

echo ""
