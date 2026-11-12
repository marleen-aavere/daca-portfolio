-- Loo tabel
CREATE TABLE IF NOT EXISTS team_members (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(100),
    week INT DEFAULT 0,
    joined_at TIMESTAMP DEFAULT NOW()
);

-- Lisa meeskonnaliikmed
INSERT INTO team_members (name, role, week)
VALUES
    ('Marleen Aavere', 'Andmeanalüütik', 0),
    ('Toomas Kask', 'IT Director', 0),
    ('Kristi Tamm', 'CEO', 0),
    ('Anna Mets', 'Marketing Lead', 0);

-- Vaata tulemust
SELECT * FROM team_members;