# Estructura del Proyecto AhorrateLo

## Visión General
```
ahorratelo/
├── 📁 frontend/                    # Aplicación React.js
│   ├── 📁 public/                  # Archivos estáticos
│   ├── 📁 src/
│   │   ├── 📁 components/          # Componentes reutilizables
│   │   │   ├── 📁 ui/              # Componentes básicos (Button, Input, etc.)
│   │   │   ├── 📁 layout/          # Layout components (Header, Footer, Sidebar)
│   │   │   ├── 📁 product/         # Componentes relacionados con productos
│   │   │   ├── 📁 shopping/        # Componentes de listas de compras
│   │   │   └── 📁 ai/              # Componentes de IA (chat, recomendaciones)
│   │   ├── 📁 pages/               # Páginas de la aplicación
│   │   │   ├── Home.tsx            # Página principal
│   │   │   ├── Search.tsx          # Búsqueda y comparación
│   │   │   ├── ProductDetail.tsx   # Detalle de producto
│   │   │   ├── ShoppingLists.tsx   # Listas de compras
│   │   │   ├── Recipes.tsx         # Recetario IA
│   │   │   ├── MealPlans.tsx       # Planes de comida
│   │   │   └── Profile.tsx         # Perfil de usuario
│   │   ├── 📁 hooks/               # Custom React hooks
│   │   │   ├── useProducts.ts      # Hook para productos
│   │   │   ├── useShoppingList.ts  # Hook para listas
│   │   │   └── useAI.ts            # Hook para servicios IA
│   │   ├── 📁 services/            # Servicios API
│   │   │   ├── api.ts              # Cliente API base
│   │   │   ├── products.ts         # API de productos
│   │   │   ├── auth.ts             # API de autenticación
│   │   │   └── ai.ts               # API de IA
│   │   ├── 📁 utils/               # Utilidades
│   │   │   ├── formatters.ts       # Formateo de datos
│   │   │   ├── validators.ts       # Validaciones
│   │   │   └── constants.ts        # Constantes
│   │   └── 📁 types/               # Tipos TypeScript
│   │       ├── product.ts          # Tipos de productos
│   │       ├── user.ts             # Tipos de usuario
│   │       └── api.ts              # Tipos de API
│   ├── package.json                # Dependencias Node.js
│   ├── tsconfig.json              # Configuración TypeScript
│   ├── tailwind.config.js         # Configuración Tailwind
│   ├── vite.config.ts             # Configuración Vite
│   └── Dockerfile                 # Imagen Docker
│
├── 📁 backend/                     # API FastAPI
│   ├── 📁 app/
│   │   ├── 📁 api/                 # Endpoints de la API
│   │   │   ├── 📁 v1/              # Versión 1 de la API
│   │   │   │   ├── auth.py         # Autenticación
│   │   │   │   ├── products.py     # Productos y precios
│   │   │   │   ├── shopping.py     # Listas de compras
│   │   │   │   ├── recipes.py      # Recetas
│   │   │   │   └── users.py        # Usuarios
│   │   │   └── deps.py             # Dependencias comunes
│   │   ├── 📁 core/                # Configuración central
│   │   │   ├── config.py           # Configuración de la app
│   │   │   ├── security.py         # Seguridad y JWT
│   │   │   ├── database.py         # Conexión a BD
│   │   │   └── celery.py           # Configuración Celery
│   │   ├── 📁 models/              # Modelos SQLAlchemy
│   │   │   ├── user.py             # Modelo de usuario
│   │   │   ├── product.py          # Modelo de producto
│   │   │   ├── store.py            # Modelo de tienda
│   │   │   └── shopping.py         # Modelos de compras
│   │   ├── 📁 services/            # Lógica de negocio
│   │   │   ├── product_service.py  # Servicio de productos
│   │   │   ├── price_service.py    # Servicio de precios
│   │   │   ├── ai_service.py       # Integración con IA
│   │   │   └── notification_service.py # Notificaciones
│   │   └── 📁 utils/               # Utilidades
│   │       ├── helpers.py          # Funciones auxiliares
│   │       └── validators.py       # Validadores
│   ├── 📁 tests/                   # Tests del backend
│   ├── requirements.txt            # Dependencias Python
│   ├── alembic.ini                # Configuración Alembic
│   └── Dockerfile                 # Imagen Docker
│
├── 📁 scraper/                     # Servicio de Web Scraping
│   ├── 📁 spiders/                 # Spiders de Scrapy
│   │   ├── exito_spider.py         # Spider para Éxito
│   │   ├── jumbo_spider.py         # Spider para Jumbo
│   │   ├── carulla_spider.py       # Spider para Carulla
│   │   ├── olimpica_spider.py      # Spider para Olímpica
│   │   ├── falabella_spider.py     # Spider para Falabella
│   │   └── mercadolibre_spider.py  # Spider para MercadoLibre
│   ├── 📁 items/                   # Definición de items
│   │   └── product_item.py         # Item de producto
│   ├── 📁 pipelines/               # Pipelines de procesamiento
│   │   ├── validation_pipeline.py  # Validación de datos
│   │   ├── database_pipeline.py    # Guardado en BD
│   │   └── image_pipeline.py       # Procesamiento de imágenes
│   ├── 📁 middlewares/             # Middlewares de Scrapy
│   │   ├── rotation_middleware.py  # Rotación de proxies/UA
│   │   └── delay_middleware.py     # Control de delays
│   ├── 📁 utils/                   # Utilidades de scraping
│   │   ├── selectors.py            # Selectores CSS/XPath
│   │   ├── parsers.py              # Parsers de datos
│   │   └── helpers.py              # Funciones auxiliares
│   ├── scrapy.cfg                  # Configuración Scrapy
│   ├── requirements.txt            # Dependencias Python
│   └── Dockerfile                 # Imagen Docker
│
├── 📁 ai-service/                  # Microservicio de IA
│   ├── 📁 models/                  # Modelos de IA
│   │   ├── shopping_optimizer.py   # Optimizador de compras
│   │   ├── recipe_generator.py     # Generador de recetas
│   │   └── meal_planner.py         # Planificador de comidas
│   ├── 📁 services/                # Servicios de IA
│   │   ├── openai_service.py       # Integración OpenAI
│   │   ├── anthropic_service.py    # Integración Anthropic
│   │   └── recommendation_service.py # Sistema de recomendaciones
│   ├── 📁 prompts/                 # Templates de prompts
│   │   ├── shopping_prompts.py     # Prompts para compras
│   │   ├── recipe_prompts.py       # Prompts para recetas
│   │   └── meal_plan_prompts.py    # Prompts para planes
│   ├── 📁 utils/                   # Utilidades de IA
│   │   ├── text_processing.py      # Procesamiento de texto
│   │   └── data_formatting.py      # Formateo de datos
│   ├── main.py                     # Aplicación FastAPI
│   ├── requirements.txt            # Dependencias Python
│   └── Dockerfile                 # Imagen Docker
│
├── 📁 database/                    # Esquemas y migraciones
│   ├── 📁 migrations/              # Migraciones Alembic
│   ├── 📁 seeds/                   # Datos iniciales
│   │   ├── categories.sql          # Categorías de productos
│   │   ├── stores.sql              # Tiendas iniciales
│   │   └── sample_products.sql     # Productos de ejemplo
│   └── 📁 schemas/                 # Esquemas de BD
│       └── init.sql                # Esquema inicial
│
├── 📁 docker/                      # Configuraciones Docker
│   ├── docker-compose.dev.yml      # Desarrollo
│   ├── docker-compose.prod.yml     # Producción
│   └── nginx.conf                  # Configuración Nginx
│
├── 📁 docs/                        # Documentación
│   ├── ARCHITECTURE.md             # Arquitectura del sistema
│   ├── API.md                      # Documentación de API
│   ├── DEPLOYMENT.md               # Guía de despliegue
│   └── CONTRIBUTING.md             # Guía de contribución
│
├── 📁 scripts/                     # Scripts de automatización
│   ├── setup.sh                    # Script de instalación
│   ├── deploy.sh                   # Script de despliegue
│   └── backup.sh                   # Script de backup
│
├── 📁 tests/                       # Tests de integración
│   ├── 📁 e2e/                     # Tests end-to-end
│   └── 📁 integration/             # Tests de integración
│
├── README.md                       # Documentación principal
├── docker-compose.yml              # Orquestación de servicios
├── env.example                     # Variables de entorno ejemplo
├── .gitignore                      # Archivos ignorados por Git
└── LICENSE                         # Licencia del proyecto
```

## Descripción de Componentes

### 🎨 Frontend (React + TypeScript)
- **Tecnologías**: React 18, TypeScript, Tailwind CSS, Vite
- **Características**: SPA responsive, componentes reutilizables, estado global
- **Páginas principales**: Comparador, listas IA, recetario, perfil

### ⚡ Backend (FastAPI)
- **Tecnologías**: FastAPI, SQLAlchemy, PostgreSQL, Redis, Celery
- **Características**: API REST, autenticación JWT, tareas asíncronas
- **Endpoints**: Productos, precios, usuarios, listas, recetas

### 🕷️ Scraper (Scrapy + Selenium)
- **Tecnologías**: Scrapy, Selenium, BeautifulSoup, Chrome headless
- **Características**: Scraping distribuido, rotación de proxies, respeto robots.txt
- **Tiendas**: Éxito, Jumbo, Carulla, Olímpica, Falabella, MercadoLibre

### 🤖 AI Service (OpenAI + Anthropic)
- **Tecnologías**: OpenAI GPT, Anthropic Claude, FastAPI
- **Características**: Listas inteligentes, recetario, optimización presupuesto
- **Funciones**: Generación de contenido, recomendaciones, análisis

### 🗄️ Database (PostgreSQL + Redis)
- **PostgreSQL**: Datos principales (productos, usuarios, precios)
- **Redis**: Cache, sesiones, cola de tareas
- **Características**: Índices optimizados, triggers, extensiones

## Flujos de Trabajo

### 1. Scraping Automático
```
Scheduler → Scrapy → Validation → Database → Cache Update → Price Alerts
```

### 2. Búsqueda de Productos
```
User Query → API → Database Query → Cache → Response → Frontend
```

### 3. Generación de Lista IA
```
User Input → Backend → AI Service → Optimization → Database → Response
```

### 4. Plan de Comidas
```
Budget + Preferences → AI Service → Recipe Generation → Shopping List → Response
```

## Tecnologías Clave

### Frontend
- **React 18**: Framework principal
- **TypeScript**: Tipado estático
- **Tailwind CSS**: Estilos utilitarios
- **React Query**: Gestión de estado servidor
- **Vite**: Build tool rápido

### Backend
- **FastAPI**: Framework web moderno
- **SQLAlchemy**: ORM para PostgreSQL
- **Celery**: Tareas asíncronas
- **Redis**: Cache y broker
- **Alembic**: Migraciones de BD

### Scraping
- **Scrapy**: Framework de scraping
- **Selenium**: Automatización de navegador
- **BeautifulSoup**: Parsing HTML
- **Fake User Agent**: Rotación de user agents

### IA
- **OpenAI GPT**: Generación de texto
- **Anthropic Claude**: Análisis y recomendaciones
- **Pandas**: Procesamiento de datos
- **NumPy**: Cálculos numéricos

### DevOps
- **Docker**: Containerización
- **Docker Compose**: Orquestación local
- **PostgreSQL**: Base de datos principal
- **Nginx**: Proxy reverso
- **GitHub Actions**: CI/CD 