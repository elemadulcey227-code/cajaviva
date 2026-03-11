-- Agregar constraint de fechas en RecurrentTransaction
ALTER TABLE RecurrentTransaction
ADD CONSTRAINT chk_dates CHECK (end_date IS NULL OR end_date >= initial_date);

-- Asegurar que email sea único en Person
ALTER TABLE Person
ADD CONSTRAINT UQ_Person_Email UNIQUE(email);

-- Agregar FK de category_id en RecurrentTransaction
ALTER TABLE RecurrentTransaction
ADD CONSTRAINT FK_RecurrentTransaction_Category FOREIGN KEY (category_id) REFERENCES Category(category_id);