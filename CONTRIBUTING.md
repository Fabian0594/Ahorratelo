# Guía de Contribución - AhorrateLo

¡Gracias por tu interés en contribuir a AhorrateLo! 🎉

## 🚀 Cómo Contribuir

### 1. Fork del Repositorio
```bash
# Haz fork del repositorio en GitHub
# Luego clona tu fork
git clone https://github.com/TU_USUARIO/ahorratelo.git
cd ahorratelo
```

### 2. Configurar el Entorno de Desarrollo
```bash
# Copiar variables de entorno
cp env.example .env

# Ejecutar setup
chmod +x scripts/setup.sh
./scripts/setup.sh

# Iniciar servicios
docker-compose up -d
```

### 3. Crear una Rama para tu Feature
```bash
git checkout -b feature/nombre-de-tu-feature
```

### 4. Hacer tus Cambios
- Sigue las convenciones de código del proyecto
- Añade tests para nuevas funcionalidades
- Actualiza la documentación si es necesario

### 5. Commit y Push
```bash
git add .
git commit -m "feat: descripción de tu cambio"
git push origin feature/nombre-de-tu-feature
```

### 6. Crear Pull Request
- Ve a GitHub y crea un Pull Request
- Describe claramente qué cambios hiciste
- Referencia issues relacionados

## 📋 Convenciones de Código

### Python (Backend/Scraper/AI)
- Usar **Black** para formateo: `black .`
- Usar **isort** para imports: `isort .`
- Seguir **PEP 8**
- Documentar funciones con docstrings
- Tests con **pytest**

### TypeScript/React (Frontend)
- Usar **ESLint** y **Prettier**
- Componentes funcionales con hooks
- Tipado estricto con TypeScript
- Tests con **Jest** y **React Testing Library**

### Commits
Usar [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` nueva funcionalidad
- `fix:` corrección de bug
- `docs:` cambios en documentación
- `style:` formateo, sin cambios de código
- `refactor:` refactoring de código
- `test:` añadir o modificar tests
- `chore:` tareas de mantenimiento

## 🐛 Reportar Bugs

### Antes de Reportar
1. Busca en issues existentes
2. Verifica que sea reproducible
3. Prueba con la última versión

### Template de Bug Report
```markdown
**Descripción del Bug**
Descripción clara y concisa del problema.

**Pasos para Reproducir**
1. Ve a '...'
2. Haz clic en '...'
3. Observa el error

**Comportamiento Esperado**
Qué esperabas que pasara.

**Screenshots**
Si aplica, añade screenshots.

**Entorno**
- OS: [ej. Windows 10]
- Browser: [ej. Chrome 91]
- Versión: [ej. 1.0.0]
```

## 💡 Sugerir Features

### Template de Feature Request
```markdown
**¿Tu feature request está relacionada con un problema?**
Descripción clara del problema.

**Describe la solución que te gustaría**
Descripción clara y concisa de lo que quieres que pase.

**Describe alternativas que has considerado**
Otras soluciones o features que has considerado.

**Contexto adicional**
Cualquier otro contexto o screenshots sobre el feature request.
```

## 🏗️ Estructura del Proyecto

### Añadir Nueva Tienda (Scraper)
1. Crear spider en `scraper/spiders/nueva_tienda_spider.py`
2. Añadir configuración en `env.example`
3. Actualizar documentación
4. Añadir tests

### Añadir Nueva Funcionalidad IA
1. Crear modelo en `ai-service/models/`
2. Añadir prompts en `ai-service/prompts/`
3. Crear endpoint en `ai-service/main.py`
4. Integrar con backend
5. Añadir UI en frontend

### Añadir Nueva Página Frontend
1. Crear componente en `frontend/src/pages/`
2. Añadir ruta en router
3. Crear componentes necesarios
4. Añadir tests
5. Actualizar navegación

## 🧪 Testing

### Backend
```bash
cd backend
pytest tests/ -v
```

### Frontend
```bash
cd frontend
npm test
```

### E2E
```bash
cd tests/e2e
npm run test:e2e
```

## 📚 Documentación

- Actualiza `README.md` para cambios importantes
- Documenta nuevas APIs en `docs/API.md`
- Actualiza `docs/ARCHITECTURE.md` para cambios estructurales

## 🎯 Áreas de Contribución

### 🕷️ Web Scraping
- Añadir nuevas tiendas colombianas
- Mejorar precisión de extracción
- Optimizar performance
- Manejar anti-bot measures

### 🤖 Inteligencia Artificial
- Mejorar algoritmos de optimización
- Añadir nuevos tipos de recomendaciones
- Optimizar prompts
- Integrar nuevos modelos

### 🎨 Frontend
- Mejorar UX/UI
- Añadir nuevas funcionalidades
- Optimizar performance
- Responsive design

### ⚡ Backend
- Optimizar APIs
- Añadir nuevos endpoints
- Mejorar seguridad
- Caching strategies

### 📊 Data & Analytics
- Métricas de uso
- Análisis de precios
- Reportes y dashboards
- Data visualization

## 🏆 Reconocimientos

Los contribuidores serán reconocidos en:
- README.md
- Página de créditos en la app
- Release notes

## 📞 Contacto

- **Issues**: Para bugs y feature requests
- **Discussions**: Para preguntas generales
- **Email**: [tu-email@ejemplo.com]

## 📜 Código de Conducta

Este proyecto sigue el [Contributor Covenant](https://www.contributor-covenant.org/). Al participar, se espera que mantengas este código.

---

¡Gracias por contribuir a AhorrateLo! 🚀 