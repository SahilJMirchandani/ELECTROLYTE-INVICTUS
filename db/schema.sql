-- ProTrack Analytics Database Schema

-- Users Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Components Table
CREATE TABLE components (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PCBs (Printed Circuit Boards) Table
CREATE TABLE pcbs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    version VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PCB Components Table
CREATE TABLE pcb_components (
    id SERIAL PRIMARY KEY,
    pcb_id INT REFERENCES pcbs(id) ON DELETE CASCADE,
    component_id INT REFERENCES components(id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Production Log Table
CREATE TABLE production_log (
    id SERIAL PRIMARY KEY,
    pcb_id INT REFERENCES pcbs(id) ON DELETE CASCADE,
    produced_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL
);

-- Consumption History Table
CREATE TABLE consumption_history (
    id SERIAL PRIMARY KEY,
    component_id INT REFERENCES components(id) ON DELETE CASCADE,
    consumed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL
);

-- Procurement Triggers Table
CREATE TABLE procurement_triggers (
    id SERIAL PRIMARY KEY,
    component_id INT REFERENCES components(id) ON DELETE CASCADE,
    threshold_quantity INT NOT NULL,
    trigger_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_components_name ON components(name);
CREATE INDEX idx_pcbs_name ON pcbs(name);
CREATE INDEX idx_pcb_components_pcb_id ON pcb_components(pcb_id);
CREATE INDEX idx_pcb_components_component_id ON pcb_components(component_id);
CREATE INDEX idx_production_log_pcb_id ON production_log(pcb_id);
CREATE INDEX idx_consumption_history_component_id ON consumption_history(component_id);
CREATE INDEX idx_procurement_triggers_component_id ON procurement_triggers(component_id);