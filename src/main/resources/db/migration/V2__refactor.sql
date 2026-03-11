-- Email único en Person
ALTER TABLE Person
ADD CONSTRAINT UQ_Person_Email UNIQUE(email);

-- Balance no negativo en Account
ALTER TABLE Account
ADD CONSTRAINT chk_balance CHECK (balance >= 0);

-- Valor no negativo en RecurrentTransaction
ALTER TABLE RecurrentTransaction
ADD CONSTRAINT chk_value CHECK (value >= 0);

-- Constraint de fechas en RecurrentTransaction
ALTER TABLE RecurrentTransaction
ADD CONSTRAINT chk_dates CHECK (end_date IS NULL OR end_date >= initial_date);

-- Agregar columna category_id en RecurrentTransaction
ALTER TABLE RecurrentTransaction
ADD category_id UNIQUEIDENTIFIER;

-- Agregar FK de category_id en RecurrentTransaction
ALTER TABLE RecurrentTransaction
ADD CONSTRAINT FK_RecurrentTransaction_Category FOREIGN KEY (category_id) REFERENCES Category(category_id);