CREATE DATABASE propierties_managment;
USE propierties_managment
-- Tabla users con campos de fecha
CREATE TABLE users (
  id_user BIGINT PRIMARY KEY AUTO_INCREMENT,
  estatus VARCHAR(20) DEFAULT 'activo',
  name VARCHAR(100) NOT NULL,
  lastname VARCHAR(100) NOT NULL,
  identification VARCHAR(20) NOT NULL UNIQUE,
  password TEXT NOT NULL,
  created_date DATE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla rol con campos de fecha
CREATE TABLE rol (
  id_rol BIGINT PRIMARY KEY AUTO_INCREMENT,
  rol VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  estatus VARCHAR(20) DEFAULT 'activo'
);

-- Tabla propierty_type con campos de fecha
CREATE TABLE propierty_type (
  id_propierty_type BIGINT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla properties con campos de fecha
CREATE TABLE properties (
  id_properties BIGINT PRIMARY KEY AUTO_INCREMENT,
  dir VARCHAR(255) NOT NULL,
  size VARCHAR(50) NOT NULL,
  chip VARCHAR(50) NOT NULL UNIQUE,
  c_catastral VARCHAR(50) NOT NULL UNIQUE,
  id_type BIGINT NOT NULL,
  id_owner BIGINT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_type) REFERENCES propierty_type (id_propierty_type),
  FOREIGN KEY (id_owner) REFERENCES users (id_user)
);

-- Tabla payment con campos de fecha
CREATE TABLE payment (
  id_payment BIGINT PRIMARY KEY AUTO_INCREMENT,
  id_properties BIGINT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  regularity VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_properties) REFERENCES properties (id_properties)
);

-- Tabla user_rol con campos de fecha
CREATE TABLE user_rol (
  id_user BIGINT NOT NULL,
  id_rol BIGINT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id_user, id_rol),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_rol) REFERENCES rol (id_rol)
);

-- Tabla payment_user con campos de fecha
CREATE TABLE payment_user (
  id_user BIGINT NOT NULL,
  id_payment BIGINT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id_user, id_payment),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_payment) REFERENCES payment (id_payment)
);