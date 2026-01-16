#!/bin/bash

# BiblioVault Deployment Script
# This script handles deployment for both local and production environments

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Default environment
ENVIRONMENT=${1:-"development"}

echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}   BiblioVault Deployment Script${NC}"
echo -e "${BLUE}   Environment: $ENVIRONMENT${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check required tools
echo -e "${YELLOW}🔍 Checking prerequisites...${NC}"

if ! command_exists git; then
    echo -e "${RED}❌ Git is not installed${NC}"
    exit 1
fi

if ! command_exists node; then
    echo -e "${RED}❌ Node.js is not installed${NC}"
    exit 1
fi

if ! command_exists npm; then
    echo -e "${RED}❌ npm is not installed${NC}"
    exit 1
fi

echo -e "${GREEN}✅ All prerequisites met${NC}"
echo ""

# Pull latest code
echo -e "${YELLOW}📦 Pulling latest code from git...${NC}"
cd "$PROJECT_ROOT"
git pull origin main || {
    echo -e "${RED}❌ Failed to pull latest code${NC}"
    exit 1
}
echo -e "${GREEN}✅ Code updated${NC}"
echo ""

# Install/Update Backend Dependencies
echo -e "${YELLOW}📚 Installing backend dependencies...${NC}"
cd "$PROJECT_ROOT/backend"
npm install || {
    echo -e "${RED}❌ Failed to install backend dependencies${NC}"
    exit 1
}
echo -e "${GREEN}✅ Backend dependencies installed${NC}"
echo ""

# Install/Update Frontend Dependencies
echo -e "${YELLOW}📚 Installing frontend dependencies...${NC}"
cd "$PROJECT_ROOT/frontend"
npm install || {
    echo -e "${RED}❌ Failed to install frontend dependencies${NC}"
    exit 1
}
echo -e "${GREEN}✅ Frontend dependencies installed${NC}"
echo ""

# Run Database Migrations
echo -e "${YELLOW}🗄️  Running database migrations...${NC}"
cd "$PROJECT_ROOT/backend"
npx prisma migrate deploy || {
    echo -e "${RED}❌ Failed to run migrations${NC}"
    exit 1
}
npx prisma generate || {
    echo -e "${RED}❌ Failed to generate Prisma client${NC}"
    exit 1
}
echo -e "${GREEN}✅ Database migrations completed${NC}"
echo ""

if [ "$ENVIRONMENT" = "production" ]; then
    # Build Backend
    echo -e "${YELLOW}🔨 Building backend...${NC}"
    cd "$PROJECT_ROOT/backend"
    npm run build || {
        echo -e "${RED}❌ Failed to build backend${NC}"
        exit 1
    }
    echo -e "${GREEN}✅ Backend built successfully${NC}"
    echo ""

    # Build Frontend
    echo -e "${YELLOW}🔨 Building frontend...${NC}"
    cd "$PROJECT_ROOT/frontend"
    npm run build || {
        echo -e "${RED}❌ Failed to build frontend${NC}"
        exit 1
    }
    echo -e "${GREEN}✅ Frontend built successfully${NC}"
    echo ""

    # Restart services (assuming PM2 is used in production)
    if command_exists pm2; then
        echo -e "${YELLOW}🔄 Restarting services with PM2...${NC}"
        pm2 restart bibliovault-backend || pm2 start "$PROJECT_ROOT/backend/dist/index.js" --name bibliovault-backend
        pm2 restart bibliovault-frontend || pm2 start npm --name bibliovault-frontend -- start
        pm2 save
        echo -e "${GREEN}✅ Services restarted${NC}"
    else
        echo -e "${YELLOW}⚠️  PM2 not found. Please restart services manually${NC}"
    fi
else
    # Development environment
    echo -e "${YELLOW}🔄 Restarting development servers...${NC}"
    "$PROJECT_ROOT/scripts/restart-dev.sh"
fi

echo ""
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Deployment completed successfully!${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo ""

if [ "$ENVIRONMENT" = "production" ]; then
    echo -e "${BLUE}📝 Post-deployment checklist:${NC}"
    echo -e "   1. Check application logs"
    echo -e "   2. Verify all services are running"
    echo -e "   3. Test critical endpoints"
    echo -e "   4. Monitor error rates"
else
    echo -e "${BLUE}🎉 Development environment ready!${NC}"
    echo -e "   Frontend: ${GREEN}http://localhost:3001${NC}"
    echo -e "   Backend:  ${GREEN}http://localhost:3000${NC}"
fi

echo ""
