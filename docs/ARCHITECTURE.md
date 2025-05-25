# Arquitectura del Sistema AhorrateLo

## Visión General
AhorrateLo es una plataforma de comparación de precios con IA integrada, diseñada con una arquitectura de microservicios para escalabilidad y mantenibilidad.

## Componentes Principales

### 1. Frontend (React + TypeScript)
- **Ubicación**: `/frontend`
- **Tecnologías**: React 18, TypeScript, Tailwind CSS, Vite
- **Responsabilidades**:
  - Interfaz de usuario responsive
  - Comparador de precios con filtros avanzados
  - Dashboard de usuario
  - Integración con servicios de IA

### 2. Backend API (FastAPI)
- **Ubicación**: `/backend`
- **Tecnologías**: FastAPI, SQLAlchemy, PostgreSQL, Redis
- **Responsabilidades**:
  - API REST para el frontend
  - Autenticación y autorización
  - Gestión de productos y precios
  - Coordinación entre servicios

### 3. Servicio de Web Scraping
- **Ubicación**: `/scraper`
- **Tecnologías**: Scrapy, Selenium, BeautifulSoup
- **Responsabilidades**:
  - Extracción de datos de tiendas colombianas
  - Procesamiento y limpieza de datos
  - Detección de cambios de precios
  - Programación de scraping automático

### 4. Servicio de IA
- **Ubicación**: `/ai-service`
- **Tecnologías**: OpenAI GPT, Anthropic Claude, FastAPI
- **Responsabilidades**:
  - Generación de listas de compras inteligentes
  - Recetario basado en presupuesto
  - Recomendaciones personalizadas
  - Análisis de tendencias

### 5. Base de Datos
- **Ubicación**: `/database`
- **Tecnologías**: PostgreSQL, Redis
- **Responsabilidades**:
  - Almacenamiento de productos y precios
  - Cache de consultas frecuentes
  - Historial de precios
  - Datos de usuarios

## Flujo de Datos

### 1. Scraping de Datos
```
Tiendas Online → Scrapers → Procesamiento → Base de Datos → Cache
```

### 2. Consulta de Precios
```
Usuario → Frontend → Backend API → Base de Datos → Respuesta
```

### 3. Generación de IA
```
Usuario → Frontend → Backend → AI Service → Respuesta Inteligente
```

## Tiendas Integradas (Colombia)

### Supermercados
- **Éxito**: Productos de supermercado y hogar
- **Jumbo**: Hipermercado con amplia variedad
- **Carulla**: Supermercado premium
- **Olímpica**: Cadena nacional de supermercados

### Retail General
- **Falabella**: Departamental con múltiples categorías
- **MercadoLibre**: Marketplace con miles de vendedores

## Características de IA

### 1. Lista de Compras Inteligente
- **Input**: Presupuesto, número de personas, preferencias
- **Output**: Lista optimizada con mejores precios y tiendas
- **Algoritmo**: Optimización multi-objetivo (precio, calidad, ubicación)

### 2. Recetario Inteligente
- **Input**: Presupuesto, personas, tiempo, restricciones alimentarias
- **Output**: Plan de comidas con lista de compras
- **Características**: Balanceado nutricionalmente, económico

### 3. Recomendaciones
- **Análisis de tendencias de precios**
- **Predicción de ofertas**
- **Sugerencias de productos alternativos**

## Escalabilidad

### Horizontal
- Múltiples instancias de scrapers
- Load balancing en API
- Sharding de base de datos por región

### Vertical
- Optimización de consultas
- Cache inteligente
- Compresión de datos

## Seguridad

### Autenticación
- JWT tokens
- OAuth2 con Google/Facebook
- Rate limiting

### Scraping Ético
- Respeto a robots.txt
- Delays entre requests
- User agents rotativos
- Proxies cuando sea necesario

## Monitoreo

### Métricas
- Uptime de scrapers
- Latencia de API
- Precisión de precios
- Satisfacción de usuarios

### Alertas
- Fallos en scraping
- Cambios drásticos de precios
- Errores de IA
- Problemas de performance 