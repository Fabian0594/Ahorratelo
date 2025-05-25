#!/bin/bash

# AhorrateLo Setup Script
echo "🚀 Configurando AhorrateLo - Comparador de Precios Inteligente"
echo "============================================================"

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Por favor instala Docker primero."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose no está instalado. Por favor instala Docker Compose primero."
    exit 1
fi

# Verificar si Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "❌ Node.js no está instalado. Por favor instala Node.js primero."
    exit 1
fi

# Verificar si Python está instalado
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 no está instalado. Por favor instala Python 3 primero."
    exit 1
fi

echo "✅ Dependencias del sistema verificadas"

# Crear archivo .env si no existe
if [ ! -f .env ]; then
    echo "📝 Creando archivo .env desde env.example..."
    cp env.example .env
    echo "⚠️  Por favor edita el archivo .env con tus configuraciones antes de continuar"
fi

# Setup Frontend
echo "📦 Instalando dependencias del Frontend..."
cd frontend
npm install
cd ..

# Setup Backend
echo "🐍 Configurando entorno virtual de Python para Backend..."
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cd ..

# Setup Scraper
echo "🕷️  Configurando entorno virtual para Scraper..."
cd scraper
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cd ..

# Setup AI Service
echo "🤖 Configurando entorno virtual para AI Service..."
cd ai-service
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cd ..

# Crear Dockerfiles
echo "🐳 Creando Dockerfiles..."

# Frontend Dockerfile
cat > frontend/Dockerfile << 'EOF'
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]
EOF

# Backend Dockerfile
cat > backend/Dockerfile << 'EOF'
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
EOF

# Scraper Dockerfile
cat > scraper/Dockerfile << 'EOF'
FROM python:3.11-slim

# Instalar dependencias del sistema para Selenium
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalar Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "main.py"]
EOF

# AI Service Dockerfile
cat > ai-service/Dockerfile << 'EOF'
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8001

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8001", "--reload"]
EOF

echo "✅ Setup completado!"
echo ""
echo "📋 Próximos pasos:"
echo "1. Edita el archivo .env con tus configuraciones"
echo "2. Ejecuta: docker-compose up -d"
echo "3. Visita http://localhost:3000 para ver la aplicación"
echo ""
echo "🔧 Comandos útiles:"
echo "- docker-compose up -d          # Iniciar todos los servicios"
echo "- docker-compose down           # Detener todos los servicios"
echo "- docker-compose logs [service] # Ver logs de un servicio"
echo "- docker-compose ps             # Ver estado de servicios" 