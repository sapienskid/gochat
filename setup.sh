#!/bin/bash

# GoChat Project Setup Script
# This script sets up a FastAPI + LangGraph project with all necessary folders and files

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Error: Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "Setting up GoChat project environment..."

# Create virtual environment
echo "Creating Python virtual environment..."
python -m venv venv
source venv/bin/activate

# Install dependencies from requirements.txt
echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt

# Install create-fastapi-project CLI tool
echo "Installing FastAPI project creation tool..."
pip install -U create-fastapi-project

# Check if this is a first time setup or setup after git clone
FIRST_TIME_SETUP=false
if [ ! -d "app" ]; then
    echo "Detected first time setup (app directory doesn't exist)..."
    FIRST_TIME_SETUP=true
else
    echo "Detected setup after git clone (app directory already exists)..."
fi

# Generate FastAPI project structure if this is a first time setup
if [ "$FIRST_TIME_SETUP" = true ]; then
    echo "Creating FastAPI project structure using CLI..."
    yes | create-fastapi-project  # Use 'yes' to auto-confirm prompts
    
    # Set up additional GoChat-specific directories
    echo "Creating additional GoChat project directories..."
    mkdir -p app/ai/agents
    mkdir -p app/ai/models
    mkdir -p frontend/static/{css,js,assets/images}
    mkdir -p frontend/templates
fi

# Ensure docker directory exists
mkdir -p docker

# Create or update Docker Compose file for PostgreSQL
echo "Setting up Docker configuration..."
cat > docker/docker-compose.yml << 'EOF'
version: '3.8'

services:
  db:
    image: postgres:15-alpine
    volumes:
      - postgres_data:/var/lib/postgresql/data/
    environment:
      - POSTGRES_USER=gochat
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=gochat
    ports:
      - "5432:5432"

volumes:
  postgres_data:
EOF

# Create a .env file for environment variables
echo "Creating .env file..."
cat > .env << 'EOF'
# ============================
# Database settings
# ============================
POSTGRES_SERVER=localhost
POSTGRES_USER=gochat
POSTGRES_PASSWORD=password
POSTGRES_DB=gochat
POSTGRES_PORT=5432

# SQLAlchemy connection string
DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_SERVER}:${POSTGRES_PORT}/${POSTGRES_DB}

# ============================
# Backend settings
# ============================
BACKEND_CORS_ORIGINS=["http://localhost", "http://localhost:8000", "http://localhost:3000"]
PROJECT_NAME=GoChat
SECRET_KEY=changethiskeytosomethingrandom
API_V1_STR=/api/v1
ACCESS_TOKEN_EXPIRE_MINUTES=60

# ============================
# LLM settings
# ============================
ANTHROPIC_API_KEY=your_anthropic_api_key_here
ANTHROPIC_MODEL=claude-3-opus-20240229
TEMPERATURE=0.7
MAX_TOKENS=2000

# ============================
# LangSmith settings (for LangGraph development)
# ============================
LANGCHAIN_TRACING_V2=true
LANGCHAIN_API_KEY=your_langsmith_api_key_here
LANGCHAIN_PROJECT=gochat
LANGCHAIN_ENDPOINT=https://api.smith.langchain.com

# ============================
# Game settings
# ============================
DEFAULT_BOARD_SIZE=19
MAX_GAME_DURATION_DAYS=30
CACHE_EXPIRY_MINUTES=60
EOF

# Create a README for the AI directory
mkdir -p app/ai
cat > app/ai/README.md << 'EOF'
# AI Module for GoChat

This directory contains the LangGraph and LangChain integration for the AI opponent.

## Directory Structure

- `agents/`: Contains LangGraph agent workflows
- `models/`: Contains model integration with Anthropic Claude API
EOF

# Start PostgreSQL in Docker
echo "Starting PostgreSQL in Docker..."
cd docker && docker-compose up -d && cd ..

echo "GoChat project development environment setup complete!"
echo ""
echo "To start development:"
echo "1. Make sure your virtual environment is activated: source venv/bin/activate"
echo "2. Start the FastAPI development server: uvicorn app.main:app --reload"
echo "3. Visit http://localhost:8000 in your browser"
echo "4. API documentation will be at http://localhost:8000/docs"
echo ""
echo "Note: PostgreSQL is running in Docker at localhost:5432"
echo "Database credentials are in your .env file"
echo ""
echo "Don't forget to:"
echo "- Set your actual Anthropic API key in the .env file"
echo "- Set your LangSmith API key if using LangGraph development tools"
echo ""
echo "Happy coding!"
