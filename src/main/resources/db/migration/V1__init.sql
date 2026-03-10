CREATE TABLE Person (
    user_id UNIQUEIDENTIFIER PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    active BIT NOT NULL,
    password_digest VARCHAR(80) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

CREATE TABLE Account (
    account_id UNIQUEIDENTIFIER PRIMARY KEY,
    name NVARCHAR(150) NOT NULL,
    account_type TINYINT NOT NULL,
    balance MONEY NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

CREATE TABLE Category (
    category_id UNIQUEIDENTIFIER PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    type TINYINT NOT NULL,
    description VARCHAR(500),
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

CREATE TABLE FinancialTransaction (
    transaction_id UNIQUEIDENTIFIER PRIMARY KEY,
    type TINYINT NOT NULL,
    value MONEY NOT NULL,
    description VARCHAR(500),
    date DATETIME NOT NULL,
    status TINYINT NOT NULL,
    user_id UNIQUEIDENTIFIER,
    account_id UNIQUEIDENTIFIER,
    category_id UNIQUEIDENTIFIER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Person(user_id),
    FOREIGN KEY (account_id) REFERENCES Account(account_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE RecurrentTransaction (
    id UNIQUEIDENTIFIER PRIMARY KEY,
    value MONEY NOT NULL,
    initial_date DATE NOT NULL,
    end_date DATE,
    frequency TINYINT NOT NULL,
    custom_frequency SMALLINT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    account_id UNIQUEIDENTIFIER,
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
);

CREATE TABLE LiquidityProjection (
    projection_id UNIQUEIDENTIFIER PRIMARY KEY,
    calculation_date DATETIME NOT NULL,
    projected_balance MONEY NOT NULL,
    projection_date DATE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    account_id UNIQUEIDENTIFIER,
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
);

CREATE TABLE Alert (
    alert_id UNIQUEIDENTIFIER PRIMARY KEY,
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
    user_access_id UNIQUEIDENTIFIER PRIMARY KEY,
    role TINYINT NOT NULL,
    created_at DATETIME NOT NULL,
    user_id UNIQUEIDENTIFIER,
    FOREIGN KEY (user_id) REFERENCES Person(user_id)
);