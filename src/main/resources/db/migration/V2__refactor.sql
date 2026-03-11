CREATE TABLE Person (
    person_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
    name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    active BIT NOT NULL,
    password_digest VARCHAR(80) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

CREATE TABLE Account (
    account_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
    name NVARCHAR(150) NOT NULL,
    account_type TINYINT NOT NULL,
    balance MONEY NOT NULL CHECK (balance >= 0),
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

CREATE TABLE Category (
    category_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
    name NVARCHAR(100) NOT NULL,
    type TINYINT NOT NULL,
    description VARCHAR(500),
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

CREATE TABLE FinancialTransaction (
    transaction_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
    type TINYINT NOT NULL,
    value MONEY NOT NULL CHECK (value >= 0),
    description VARCHAR(500),
    date DATETIME NOT NULL,
    status TINYINT NOT NULL,
    person_id UNIQUEIDENTIFIER,
    account_id UNIQUEIDENTIFIER,
    category_id UNIQUEIDENTIFIER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(person_id),
    FOREIGN KEY (account_id) REFERENCES Account(account_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE RecurrentTransaction (
    recurrent_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
    value MONEY NOT NULL CHECK (value >= 0),
    initial_date DATE NOT NULL,
    end_date DATE,
    frequency TINYINT NOT NULL,
    custom_frequency SMALLINT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    account_id UNIQUEIDENTIFIER,
    category_id UNIQUEIDENTIFIER,
    FOREIGN KEY (account_id) REFERENCES Account(account_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id),
    CONSTRAINT chk_dates CHECK (end_date IS NULL OR end_date >= initial_date)
);

CREATE TABLE LiquidityProjection (
    projection_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
    calculation_date DATETIME NOT NULL,
    projected_balance MONEY NOT NULL,
    projection_date DATE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    account_id UNIQUEIDENTIFIER,
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
);

CREATE TABLE Alert (
    alert_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
    type TINYINT NOT NULL,
    message VARCHAR(500) NOT NULL,
    date DATE NOT NULL,
    status TINYINT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    liquidity_projection_id UNIQUEIDENTIFIER,
    FOREIGN KEY (liquidity_projection_id) REFERENCES LiquidityProjection(projection_id)
);

CREATE TABLE UserAccess (
    user_access_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
    role TINYINT NOT NULL,
    created_at DATETIME NOT NULL,
    person_id UNIQUEIDENTIFIER,
    account_id UNIQUEIDENTIFIER,
    FOREIGN KEY (person_id) REFERENCES Person(person_id),
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
);