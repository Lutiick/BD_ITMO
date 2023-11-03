

-- DDL

CREATE TABLE Roof (
    id SERIAL PRIMARY KEY,
    status TEXT,
    material TEXT
);

CREATE TABLE Citadel (
    id SERIAL PRIMARY KEY,
    name TEXT,
    desсription TEXT,
    roof INTEGER REFERENCES Roof(id)
);

CREATE TABLE StonesTypes (
    id SERIAL PRIMARY KEY,
    form TEXT,
    material TEXT
);

CREATE TABLE StonesBuilding (
    citadel INTEGER REFERENCES Citadel(id),
    stones_types INTEGER REFERENCES StonesTypes(id),
    count INTEGER
);

CREATE TABLE Protection (
    id SERIAL PRIMARY KEY,
    name TEXT,
    defense_direction TEXT,
    citadel INTEGER REFERENCES Citadel(id)
);

CREATE TABLE ProtectionStatus (
    id SERIAL PRIMARY KEY,
    health_point INTEGER,
    debuff TEXT,
    protection INTEGER REFERENCES Protection(id)
);

CREATE TABLE Enemy (
    id SERIAL PRIMARY KEY,
    name TEXT,
    attack_type TEXT,
    move TEXT,
    citadel INTEGER REFERENCES Citadel(id)
);

CREATE TABLE DamageProtection (
    enemy INTEGER REFERENCES Enemy(id),
    protection INTEGER REFERENCES Protection(id),
    damage INTEGER
);

-- DML
INSERT INTO Roof(status, material) VALUES (
    'Черепица', 'Обрушена'
);
INSERT INTO Citadel(name, desсription, roof) VALUES (
    'Разрушенная цитадель', 'Цитадель покинутая несколько веков назад', 1
);
INSERT INTO StonesTypes(form, material) VALUES
    ('неправильная', 'камень покрытый минералом'),
    ('неправильная', 'камень');
INSERT INTO StonesBuilding(citadel, stones_types, count) VALUES
    (1, 1, 1000),
    (1, 2, 1050);
INSERT INTO Protection(name, defense_direction, citadel) VALUES
    ('Крепостные стены', 'front', 1);
INSERT INTO Enemy(name, attack_type, move, citadel) VALUES
    ('Враги цитадели', 'front', 'water', 1);
INSERT INTO DamageProtection(enemy, protection, damage) VALUES
    (1, 1, 100);
INSERT INTO ProtectionStatus(health_point, debuff, protection) VALUES
    (0, 'Залиты водой', 1);



select * from Protection;

select material from StonesTypes where id in (select stones_types from StonesBuilding where citadel in
    (select citadel from Enemy) and citadel in (select citadel from Protection where name='Крепостные стены'));


select material from stonestypes
    left inner join StonesBuilding SB on StonesTypes.id = SB.stones_types
    left inner join Citadel C on C.id = SB.citadel
    left inner join Protection P on C.id = P.citadel
    left inner join Enemy E on C.id = E.citadel
    where E is not null and P.name = 'Крепостные стены'
