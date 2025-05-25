-- AhorrateLo Database Schema
-- Esquema inicial para el comparador de precios

-- Extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Tabla de usuarios
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de categorías de productos
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    parent_id INTEGER REFERENCES categories(id),
    icon VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de tiendas
CREATE TABLE stores (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    website_url VARCHAR(255) NOT NULL,
    logo_url VARCHAR(255),
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    scraping_enabled BOOLEAN DEFAULT TRUE,
    last_scraped_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de productos
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    brand VARCHAR(100),
    model VARCHAR(100),
    sku VARCHAR(100),
    category_id INTEGER REFERENCES categories(id),
    image_url VARCHAR(255),
    specifications JSONB,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de precios de productos por tienda
CREATE TABLE product_prices (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    store_id INTEGER REFERENCES stores(id),
    price DECIMAL(12, 2) NOT NULL,
    original_price DECIMAL(12, 2),
    discount_percentage DECIMAL(5, 2),
    currency VARCHAR(3) DEFAULT 'COP',
    availability VARCHAR(20) DEFAULT 'in_stock',
    product_url VARCHAR(500),
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(product_id, store_id)
);

-- Tabla de historial de precios
CREATE TABLE price_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    store_id INTEGER REFERENCES stores(id),
    price DECIMAL(12, 2) NOT NULL,
    original_price DECIMAL(12, 2),
    discount_percentage DECIMAL(5, 2),
    recorded_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de listas de compras generadas por IA
CREATE TABLE shopping_lists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    budget DECIMAL(12, 2),
    people_count INTEGER,
    duration_days INTEGER,
    preferences JSONB,
    total_estimated_cost DECIMAL(12, 2),
    ai_recommendations TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de items en listas de compras
CREATE TABLE shopping_list_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    shopping_list_id UUID REFERENCES shopping_lists(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id),
    quantity INTEGER NOT NULL DEFAULT 1,
    estimated_price DECIMAL(12, 2),
    recommended_store_id INTEGER REFERENCES stores(id),
    priority INTEGER DEFAULT 1,
    is_purchased BOOLEAN DEFAULT FALSE,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de recetas generadas por IA
CREATE TABLE recipes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    servings INTEGER,
    prep_time_minutes INTEGER,
    cook_time_minutes INTEGER,
    difficulty_level VARCHAR(20),
    instructions TEXT,
    nutritional_info JSONB,
    estimated_cost DECIMAL(10, 2),
    tags TEXT[],
    is_public BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de ingredientes de recetas
CREATE TABLE recipe_ingredients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    recipe_id UUID REFERENCES recipes(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id),
    quantity DECIMAL(8, 2),
    unit VARCHAR(50),
    notes TEXT,
    is_optional BOOLEAN DEFAULT FALSE
);

-- Tabla de planes de comida
CREATE TABLE meal_plans (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12, 2),
    people_count INTEGER,
    dietary_restrictions TEXT[],
    total_estimated_cost DECIMAL(12, 2),
    ai_generated BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de comidas en planes
CREATE TABLE meal_plan_meals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    meal_plan_id UUID REFERENCES meal_plans(id) ON DELETE CASCADE,
    recipe_id UUID REFERENCES recipes(id),
    meal_date DATE,
    meal_type VARCHAR(20), -- breakfast, lunch, dinner, snack
    servings INTEGER DEFAULT 1
);

-- Tabla de valoraciones de productos
CREATE TABLE product_ratings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    store_id INTEGER REFERENCES stores(id),
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    review TEXT,
    verified_purchase BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(product_id, user_id, store_id)
);

-- Tabla de alertas de precios
CREATE TABLE price_alerts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    target_price DECIMAL(12, 2),
    is_active BOOLEAN DEFAULT TRUE,
    notified_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índices para optimización
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_brand ON products(brand);
CREATE INDEX idx_product_prices_product ON product_prices(product_id);
CREATE INDEX idx_product_prices_store ON product_prices(store_id);
CREATE INDEX idx_product_prices_price ON product_prices(price);
CREATE INDEX idx_price_history_product_date ON price_history(product_id, recorded_at);
CREATE INDEX idx_shopping_lists_user ON shopping_lists(user_id);
CREATE INDEX idx_recipes_user ON recipes(user_id);
CREATE INDEX idx_meal_plans_user ON meal_plans(user_id);

-- Índices de texto completo
CREATE INDEX idx_products_name_gin ON products USING gin(name gin_trgm_ops);
CREATE INDEX idx_products_description_gin ON products USING gin(description gin_trgm_ops);

-- Insertar datos iniciales
INSERT INTO categories (name, slug, description) VALUES
('Alimentos', 'alimentos', 'Productos alimenticios en general'),
('Frutas y Verduras', 'frutas-verduras', 'Productos frescos'),
('Carnes y Pescados', 'carnes-pescados', 'Proteínas animales'),
('Lácteos', 'lacteos', 'Productos lácteos y derivados'),
('Panadería', 'panaderia', 'Pan y productos de panadería'),
('Bebidas', 'bebidas', 'Bebidas alcohólicas y no alcohólicas'),
('Limpieza', 'limpieza', 'Productos de limpieza del hogar'),
('Cuidado Personal', 'cuidado-personal', 'Productos de higiene y cuidado'),
('Hogar', 'hogar', 'Artículos para el hogar'),
('Tecnología', 'tecnologia', 'Productos tecnológicos');

INSERT INTO stores (name, slug, website_url, description) VALUES
('Éxito', 'exito', 'https://www.exito.com', 'Cadena de supermercados líder en Colombia'),
('Jumbo', 'jumbo', 'https://www.tiendasjumbo.co', 'Hipermercados con gran variedad de productos'),
('Carulla', 'carulla', 'https://www.carulla.com', 'Supermercados premium'),
('Olímpica', 'olimpica', 'https://www.olimpica.com', 'Supermercados con presencia nacional'),
('Falabella', 'falabella', 'https://www.falabella.com.co', 'Tienda departamental'),
('MercadoLibre', 'mercadolibre', 'https://www.mercadolibre.com.co', 'Marketplace online');

-- Función para actualizar timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers para actualizar timestamps
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_shopping_lists_updated_at BEFORE UPDATE ON shopping_lists
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column(); 