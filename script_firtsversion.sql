
-- Crear la base de datos y usarla
CREATE DATABASE propierties_managment;
USE propierties_managment;

-- Crear la tabla status
CREATE TABLE status (
  id_status BIGINT PRIMARY KEY AUTO_INCREMENT,
  description VARCHAR(50) NOT NULL
);
-- Modificar la tabla users para que use status como clave foránea
CREATE TABLE users (
  id_user BIGINT PRIMARY KEY AUTO_INCREMENT,
  id_status BIGINT NOT NULL DEFAULT 1, -- Valor por defecto: 'active'
  name VARCHAR(100) NOT NULL,
  lastname VARCHAR(100) NOT NULL,
  identification VARCHAR(20) NOT NULL UNIQUE,
  password TEXT NOT NULL,
  created_date DATE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_status) REFERENCES status (id_status)
);

-- Modificar la tabla rol para que use status como clave foránea
CREATE TABLE rol (
  id_rol BIGINT PRIMARY KEY AUTO_INCREMENT,
  rol VARCHAR(50) NOT NULL,
  id_status BIGINT NOT NULL DEFAULT 1, -- Valor por defecto: 'active'
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_status) REFERENCES status (id_status)
);

-- Resto de las tablas siguen igual, sin cambios para status
CREATE TABLE propierty_type (
  id_propierty_type BIGINT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

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

CREATE TABLE payment (
  id_payment BIGINT PRIMARY KEY AUTO_INCREMENT,
  id_properties BIGINT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  regularity VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_properties) REFERENCES properties (id_properties)
);

CREATE TABLE user_rol (
  id_user BIGINT NOT NULL,
  id_rol BIGINT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id_user, id_rol),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_rol) REFERENCES rol (id_rol)
);

CREATE TABLE payment_user (
  id_user BIGINT NOT NULL,
  id_payment BIGINT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id_user, id_payment),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_payment) REFERENCES payment (id_payment)
);
-- Inserciones----------------------------
-- Insertar los estados estándar
INSERT INTO status (description) 
VALUES 
('active'),
('blocked'),
('deleted');
-- Insertar datos en la tabla users
INSERT INTO users (id_status, name, lastname, identification, password, created_date) 
VALUES 
(1, 'Juan', 'Pérez', '123456789', 'password1', '2023-01-01'),  -- active
(2, 'Ana', 'López', '987654321', 'password2', '2023-02-15'),  -- blocked
(3, 'Carlos', 'Gómez', '1122334455', 'password3', '2023-03-10'); -- deleted

-- Insertar datos en la tabla rol
INSERT INTO rol (rol, id_status) 
VALUES 
('Administrador', 1),  -- active
('Usuario', 1),        -- active
('Propietario', 2);    -- blocked

-- Insertar datos en la tabla propierty_type
INSERT INTO propierty_type (type) 
VALUES 
('Casa'), 
('Apartamento'), 
('Terreno');

-- Insertar datos en la tabla properties
INSERT INTO properties (dir, size, chip, c_catastral, id_type, id_owner) 
VALUES 
('Calle Falsa 123', '150m2', 'CHIP123456', 'CC123456', 1, 1),  -- id_type = 1 (Casa), id_owner = 1 (Juan Pérez)
('Av. Principal 456', '80m2', 'CHIP654321', 'CC654321', 2, 2), -- id_type = 2 (Apartamento), id_owner = 2 (Ana López)
('Calle Secundaria 789', '300m2', 'CHIP987654', 'CC987654', 3, 3); -- id_type = 3 (Terreno), id_owner = 3 (Carlos Gómez)

-- Insertar datos en la tabla payment
INSERT INTO payment (id_properties, price, regularity) 
VALUES 
(1, 1500.00, 'Mensual'),   -- Pago mensual para la propiedad 1
(2, 1200.00, 'Anual'),     -- Pago anual para la propiedad 2
(3, 1800.00, 'Mensual');   -- Pago mensual para la propiedad 3

-- Insertar datos en la tabla user_rol
INSERT INTO user_rol (id_user, id_rol) 
VALUES 
(1, 1), -- Juan Pérez es Administrador
(2, 2), -- Ana López es Usuario
(3, 3); -- Carlos Gómez es Propietario

-- Insertar datos en la tabla payment_user
INSERT INTO payment_user (id_user, id_payment) 
VALUES 
(1, 1), -- Juan Pérez realiza el pago 1
(2, 2), -- Ana López realiza el pago 2
(3, 3); -- Carlos Gómez realiza el pago 3
