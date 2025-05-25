# AhorrateLo - Comparador de Precios Inteligente Colombia 🇨🇴

## Descripción
Plataforma web que compara precios de productos en todas las tiendas de Colombia usando web scraping, con IA integrada para generar listas de compras inteligentes y planes de comida según presupuesto.

## Características Principales
- 🔍 **Web Scraping**: Extracción automática de precios de múltiples tiendas colombianas
- 💰 **Comparador de Precios**: Filtros avanzados por precio, calidad, tienda, etc.
- 🤖 **IA Inteligente**: Generación de listas de compras según presupuesto
- 🍽️ **Recetario IA**: Planes de comida personalizados por presupuesto y personas
- 📊 **Dashboard**: Análisis de tendencias de precios y ahorro
- 🏪 **Multi-tienda**: Integración con principales retailers colombianos

## Tecnologías
- **Frontend**: React.js + TypeScript + Tailwind CSS
- **Backend**: FastAPI (Python)
- **Base de Datos**: PostgreSQL + Redis (cache)
- **Web Scraping**: Scrapy + Selenium
- **IA**: OpenAI GPT / Anthropic Claude
- **Deployment**: Docker + AWS/GCP

## Estructura del Proyecto
```
ahorratelo/
├── frontend/          # React.js application
├── backend/           # FastAPI backend
├── scraper/          # Web scraping services
├── ai-service/       # AI microservice
├── database/         # Database schemas & migrations
├── docker/           # Docker configurations
└── docs/             # Documentation
```

## Instalación Rápida
```bash
# Clonar repositorio
git clone <repo-url>
cd ahorratelo

# Instalar dependencias
./scripts/setup.sh

# Ejecutar en desarrollo
docker-compose up -dev
```

## Contribución
Ver [CONTRIBUTING.md](./CONTRIBUTING.md) para guías de contribución.

## Licencia
MIT License - Ver [LICENSE](./LICENSE) 