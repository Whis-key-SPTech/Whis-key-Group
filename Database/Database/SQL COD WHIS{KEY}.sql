-- Integrantes do Grupo 05

-- Gustavo Henrique Ra: 01252106 
-- Gustavo Rucaglia  Ra: 01252040
-- Giovanni Angel Ra: 01252135        
-- André  Ra: 01252023
-- Kauan Batista Ra: 01252066         
-- Vitória Ferreira Ra: 01252130

CREATE DATABASE BD_WHISKEY;
USE BD_WHISKEY;
DROP DATABASE BD_WHISKEY;

-- Tabela contendo as informações de cadastro das empresas contratantes.
CREATE TABLE Empresa(
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
nome_empresa VARCHAR (50)NOT NULL,
cnpj CHAR (18) NOT NULL
);

-- Tabela contendo as informações de cadastro dos usuários de cada empresa.
CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(50)NOT NULL,
    email VARCHAR(100)NOT NULL UNIQUE,
    senha VARCHAR(100)NOT NULL,
    privilegio INT,
    fk_idEmpresa INT NOT NULL,
    FOREIGN KEY (fk_idEmpresa) REFERENCES Empresa(id_empresa)
);

CREATE TABLE Endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(8),
    numero INT,
    complemento VARCHAR(45)
);

-- Tabela em relação a localidade do sensor
CREATE TABLE Localidade_Sensor (
    id_LocalidadeSensor INT PRIMARY KEY AUTO_INCREMENT,
    nome_localidade VARCHAR(45),
    numero_local INT
);

CREATE TABLE Destilaria (
    idDestilaria INT PRIMARY KEY AUTO_INCREMENT,
    fkEmpresa INT,
    endereco_idendereco INT,
    Sensor_id_sensor INT,
    Sensor_fk_idLocalidadeSensor INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(id_empresa),
    FOREIGN KEY (endereco_idendereco) REFERENCES Endereco(id_endereco)
);

-- Tabela contendo as informações dos sensores.
CREATE TABLE Sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    codigo_sensor CHAR(5), -- Os dois primeiros números determinam o número do sensor e os outros determinam a identificação do barril a qual o sensor pertence.
    fk_idLocalidadeSensor INT,
    FOREIGN KEY (fk_idLocalidadeSensor) REFERENCES Localidade_Sensor(id_LocalidadeSensor)
);

-- Tabela contendo os dados coletados pelos sensores de temperatura. 
CREATE TABLE Registro (
    id_registro INT PRIMARY KEY AUTO_INCREMENT,
    dt_coleta DATE DEFAULT (CURRENT_DATE),
    hr_coleta TIME  DEFAULT (CURRENT_TIME),
    temperatura DECIMAL(4,2) NOT NULL,
    umidade INT NOT NULL,
    fk_idSensor INT  NOT NULL,
    FOREIGN KEY (fk_idSensor) REFERENCES Sensor(id_sensor)
);

-- Comando para descrever as configurações de cada tabela.
DESC Empresa;
DESC Usuario;
DESC Registro;
DESC Sensor;
DESC Localidade_Sensor;

-- Inserção dos dados na tabela empresa.
INSERT INTO Empresa (nome_empresa, cnpj) VALUE
	('Brown-Forman', '36.631.108/0001-20'),
	('Diageo plc', '62.166.848/0001-42'),
	('Pernod Ricard', '33.856.394/0017-09'),
	('Bacardi Limited', '59.104.737/0001-05'),
	('Beam Suntor', '17.530.779/0001-50');
    
-- Localidade Sensor
INSERT INTO Localidade_Sensor(nome_localidade, numero_local) VALUES
	('Armazém norte','1'),
	('Armazém sul','2'),
	('Armazém leste','3');

-- Inserção dos dados na tabela usuario.
INSERT INTO Usuario (fk_idEmpresa, nome_usuario, email, senha, privilegio) VALUE
	(1,'Kauan Batista','kauan.batista@gmail.com', '1651656125',0),
	(2,'Gustavo Rucaglia','gustavo.rucaglia@gmail.com', '165165561',1),
	(3,'Gustavo Henrique','gustavo.henrique@gmail.com', '4854616584',1),
	(4,'Giovanni Angel','giovanni.angel@gmail.com', '4854616584',1),
	(5,'Vitória Ferreira','vitoria.ferreira@gmail.com', '4854616584',1),
	(3,'André Luiz','andre.luiz@gmail.com', '4854616584',0);

    -- sensor
INSERT INTO Sensor (codigo_sensor, fk_idLocalidadeSensor) values
	('01556',1),
	('02678',2),
	('03478',3);

-- registro
INSERT INTO Registro (temperatura, umidade, fk_idSensor) VALUES
	(25, 50, 1),
	(18, 60, 2),
	(10, 30, 3);
    
    select* from empresa;
    select* from registro;
    select* from sensor;
    select* from usuario;
    
-- JOIN COM AS TABELAS

-- JOIN Geral
SELECT 
    emp.nome_empresa AS Empresa,
    d.idDestilaria AS Destilaria,
    s.codigo_sensor AS Codigo_Sensor,
    l.nome_localidade AS Local_Sensor,
    r.dt_coleta AS Data_Coleta,
    r.hr_coleta AS Hora_Coleta,
    r.temperatura AS Temperatura,
    r.umidade AS Umidade
FROM Empresa emp
JOIN Destilaria d 
    ON emp.id_empresa = d.fkEmpresa
JOIN Sensor s 
    ON s.Predfinicao_has_destilaria_destilaria_idDestilaria = d.idDestilaria
JOIN LocalidadeSensor l 
    ON s.fk_idLocalidadeSensor = l.id_LocalidadeSensor
JOIN Registro r 
    ON r.fk_idSensor = s.id_sensor
ORDER BY emp.nome_empresa, d.idDestilaria, r.dt_coleta;

-- Empresa + Usuário
SELECT 
    e.id_empresa,
    e.nome_empresa,
    u.id_usuario,
    u.nome_usuario,
    u.email
FROM Empresa e
JOIN Usuario u 
    ON e.id_empresa = u.fk_idEmpresa;
  
  -- Destilaria + Sensores + Localidades
    SELECT 
    d.idDestilaria,
    s.id_sensor,
    s.codigo_sensor,
    l.nome_localidade
FROM Destilaria d
JOIN Sensor s 
    ON s.Predfinicao_has_destilaria_destilaria_idDestilaria = d.idDestilaria
JOIN LocalidadeSensor l 
    ON s.fk_idLocalidadeSensor = l.id_LocalidadeSensor;

-- Sensor + Registro
SELECT 
    r.id_registro,
    r.dt_coleta,
    r.hr_coleta,
    r.temperatura,
    r.umidade,
    s.codigo_sensor
FROM Registro r
JOIN Sensor s 
    ON r.fk_idSensor = s.id_sensor;
    
    -- sensor + localidade
    SELECT 
    s.id_sensor,
    s.codigo_sensor,
    l.nome_localidade,
    l.numero_local
FROM Sensor s
JOIN LocalidadeSensor l 
    ON s.fk_idLocalidadeSensor = l.id_LocalidadeSensor;
    
    -- destilaria + endereço
    SELECT 
    d.idDestilaria,
    e.cep,
    e.numero,
    e.complemento
FROM Destilaria d
JOIN Endereco e 
    ON d.endereco_idendereco = e.id_endereco;
    
    -- empresa + destilaria
    SELECT 
    e.id_empresa,
    e.nome_empresa,
    d.idDestilaria,
    d.endereco_idendereco
FROM Empresa e
JOIN Destilaria d 
    ON e.id_empresa = d.fkEmpresa;