#!/bin/bash

# BiblioVault Development Server Shutdown Script

echo "🛑 Stopping BiblioVault Development Environment..."
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Stop backend
if [ -f /tmp/bibliovault-backend.pid ]; then
    BACKEND_PID=$(cat /tmp/bibliovault-backend.pid)
    if ps -p $BACKEND_PID > /dev/null 2>&1; then
        echo -e "${YELLOW}Stopping Backend (PID: $BACKEND_PID)...${NC}"
        kill $BACKEND_PID
        rm /tmp/bibliovault-backend.pid
        echo -e "${GREEN}✅ Backend stopped${NC}"
    else
        echo -e "${YELLOW}Backend process not found${NC}"
        rm /tmp/bibliovault-backend.pid
    fi
else
    # Try to find and kill by port
    BACKEND_PID=$(lsof -ti:3000)
    if [ ! -z "$BACKEND_PID" ]; then
        echo -e "${YELLOW}Stopping Backend on port 3000 (PID: $BACKEND_PID)...${NC}"
        kill $BACKEND_PID
        echo -e "${GREEN}✅ Backend stopped${NC}"
    else
        echo -e "${GREEN}✅ Backend not running${NC}"
    fi
fi

# Stop frontend
if [ -f /tmp/bibliovault-frontend.pid ]; then
    FRONTEND_PID=$(cat /tmp/bibliovault-frontend.pid)
    if ps -p $FRONTEND_PID > /dev/null 2>&1; then
        echo -e "${YELLOW}Stopping Frontend (PID: $FRONTEND_PID)...${NC}"
        kill $FRONTEND_PID
        rm /tmp/bibliovault-frontend.pid
        echo -e "${GREEN}✅ Frontend stopped${NC}"
    else
        echo -e "${YELLOW}Frontend process not found${NC}"
        rm /tmp/bibliovault-frontend.pid
    fi
else
    # Try to find and kill by port
    FRONTEND_PID=$(lsof -ti:3001)
    if [ ! -z "$FRONTEND_PID" ]; then
        echo -e "${YELLOW}Stopping Frontend on port 3001 (PID: $FRONTEND_PID)...${NC}"
        kill $FRONTEND_PID
        echo -e "${GREEN}✅ Frontend stopped${NC}"
    else
        echo -e "${GREEN}✅ Frontend not running${NC}"
    fi
fi

# Clean up log files
if [ -f /tmp/bibliovault-backend.log ]; then
    rm /tmp/bibliovault-backend.log
fi
if [ -f /tmp/bibliovault-frontend.log ]; then
    rm /tmp/bibliovault-frontend.log
fi

echo ""
echo -e "${GREEN}✅ All servers stopped${NC}"
echo ""
echo -e "ℹ️  PostgreSQL is still running. To stop it:"
echo -e "   pg_ctl -D /opt/homebrew/var/postgresql@14 stop"
echo ""
