-- Integrantes do Grupo 05

-- Gustavo Henrique Ra: 01252106      -- Gustavo Rucaglia  Ra: 01252040
-- Giovanni Angel Ra: 01252135        -- André  Ra: 01252023
-- Kauan Batista Ra: 01252066         -- Vitória Ferreira Ra: 01252130

CREATE DATABASE BD_WHISKEY;
USE BD_WHISKEY;
DROP DATABASE BD_WHISKEY;



-- Tabela contendo as informações de cadastro das empresas contratantes.
CREATE TABLE empresa(
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
nome_empresa VARCHAR (50)NOT NULL,
cnpj CHAR (18) NOT NULL
);

-- Tabela contendo o endereço da Destilaria
CREATE TABLE endereco(
id_endereco INT PRIMARY KEY AUTO_INCREMENT,
rua VARCHAR(45));

-- Tabela contendo as destilarias da Empresa
CREATE TABLE destilaria (
id_destilaria INT PRIMARY KEY AUTO_INCREMENT,
qtdSensor int,
fk_endereco INT,
	CONSTRAINT EnderecoDestilaria
		FOREIGN KEY (fk_endereco) 
			REFERENCES endereco(id_endereco),
fk_empresa INT,
	CONSTRAINT EmpresaDestilaria
		FOREIGN KEY (fk_Empresa)
			REFERENCES empresa(id_empresa)
);



-- Tabela em relação a localidade do sensor
CREATE TABLE localidade_sensor(
id_localidadeSensor INT PRIMARY KEY AUTO_INCREMENT,
nome_localidade VARCHAR(45),
numero_local INT
);

-- Tabela contendo as informações de cadastro dos usuários de cada empresa.
CREATE TABLE usuario(
id_usuario INT AUTO_INCREMENT,
nome_usuario VARCHAR (50) NOT NULL,
email VARCHAR (100) NOT NULL UNIQUE,
senha VARCHAR (100) NOT NULL,
privilegio INT,
fk_idEmpresa INT NOT NULL,
CONSTRAINT UsuarioEmpresa 
	FOREIGN KEY (fk_idEmpresa) 
		REFERENCES empresa(id_empresa),
			PRIMARY KEY (id_usuario, fk_idEmpresa)
);

-- Tabela contendo as informações dos sensores.
CREATE TABLE sensor(
id_sensor INT AUTO_INCREMENT,
codigo_sensor CHAR(5),
fk_destilaria INT,
	CONSTRAINT DestilariaDoSensor
		FOREIGN KEY(fk_destilaria)
			REFERENCES destilaria(id_destilaria),
fk_idLocalidadeSensor INT,
	CONSTRAINT SensorLocalidade
		FOREIGN KEY (fk_idLocalidadeSensor)
			REFERENCES localidade_sensor(id_LocalidadeSensor),
situacao VARCHAR(45),
CONSTRAINT CHK_situacao CHECK (situacao IN ('Estável', 'Atenção', 'Grave')),
PRIMARY KEY (id_sensor, fk_idLocalidadeSensor)
);
SELECT count(sensor.id_sensor), endereco.rua FROM destilaria join endereco on endereco.id_endereco = destilaria.fk_endereco join sensor on sensor.fk_destilaria = destilaria.id_destilaria group by endereco.rua;

-- Tabela contendo os dados coletados pelos sensores de temperatura e umidade. 
 CREATE TABLE registro(
id_registro INT AUTO_INCREMENT,
dt_coleta DATE DEFAULT (CURRENT_DATE),
hr_coleta TIME DEFAULT (CURRENT_TIME),
temperatura DECIMAL (4,2) NOT NULL,
umidade INT NOT NULL,
fk_sensor INT NOT NULL,
	CONSTRAINT SensorRegistro 
		FOREIGN KEY (fk_sensor) 
			REFERENCES sensor(id_sensor),
PRIMARY KEY (id_registro, fk_sensor)
);

-- Comando para descrever as configurações de cada tabela.
DESC empresa;
DESC endereco;
DESC destilaria;
DESC localidade_sensor;
DESC usuario;
DESC sensor;
DESC registro;




-- Inserção dos dados na tabela empresa.
INSERT INTO empresa (nome_empresa, cnpj) VALUES
	('Brown-Forman', '36.631.108/0001-20'),
	('Diageo plc', '62.166.848/0001-42'),
	('Pernod Ricard', '33.856.394/0017-09'),
	('Bacardi Limited', '59.104.737/0001-05'),
	('Beam Suntor', '17.530.779/0001-50');

-- Endereco da destilaria    
INSERT INTO endereco (rua) VALUES
('Rua Miguel'), ('Rua General'), ('Rua Vitoria');

-- Dados da destilaria
INSERT INTO destilaria (fk_endereco, fk_empresa) VALUES
	(1, 1),
    (2, 2),
    (3, 3);
    
    INSERT INTO destilaria (fk_endereco, fk_empresa) VALUES
	(1, 1),
    (2, 2),
    (3, 3);


-- Localidade Sensor
INSERT INTO localidade_sensor(nome_localidade, numero_local) VALUES
	('Armazém norte','1'),
	('Armazém sul','2'),
	('Armazém leste','3');

-- Inserção dos dados na tabela usuario.
INSERT INTO usuario (fk_idEmpresa, nome_usuario, email, senha, privilegio) VALUES
	(1,'Kauan Batista','kauan.batista@gmail.com', '1651656125',0),
	(2,'Gustavo Rucaglia','gustavo.rucaglia@gmail.com', '165165561',1),
	(3,'Gustavo Henrique','gustavo.henrique@gmail.com', '4854616584',1),
	(4,'Giovanni Angel','giovanni.angel@gmail.com', '9209394028',1),
	(5,'Vitória Ferreira','vitoria.ferreira@gmail.com', 'ferreira@123',1),
	(3,'André Luis','andre.luis@gmail.com', '4854616584',0);

    -- sensor
INSERT INTO sensor (codigo_sensor, fk_destilaria, fk_idLocalidadeSensor) VALUES
	('01556', 1, 1),
	('02678', 1, 2),
	('03478', 1, 3);


-- registro
INSERT INTO registro (fk_sensor, temperatura, umidade) VALUES
	(1, 25, 50),
	(2, 18, 60),
	(3, 10, 30);
    
    SELECT * FROM empresa;
    SELECT * FROM destilaria;
    SELECT * FROM endereco;
    SELECT * FROM sensor;
    SELECT * FROM localidade_sensor;
    SELECT * FROM usuario;
    SELECT * FROM registro;
    
     SELECT endereco.rua FROM destilaria join  endereco on endereco.id_endereco = destilaria.fk_endereco join sensor on sensor.fk_destilaria = destilaria.id_destilaria;

    
-- JOIN COM AS TABELAS

-- JOIN Geral
SELECT registro.id_registro AS ID,	
	   localidade_sensor.nome_localidade AS Espaço,
	   registro.temperatura AS Temperatura,
       registro.umidade AS Umidade
       FROM registro
JOIN sensor ON registro.fk_sensor = sensor.id_sensor
JOIN localidade_sensor ON sensor.fk_idLocalidadeSensor = localidade_sensor.id_LocalidadeSensor
ORDER BY ID;


-- Empresa + Usuário
SELECT empresa.nome_empresa AS Empresa,
       usuario.nome_usuario AS Usuario
FROM empresa
JOIN usuario ON empresa.id_empresa = usuario.fk_idEmpresa;

-- Usuário
SELECT usuario.nome_usuario AS Nome,
       usuario.email AS Email,
       usuario.senha AS Senha,
       usuario.privilegio AS Privilegio
FROM usuario;

-- Sensor + Registro
SELECT registro.id_registro AS ID, 
	   registro.temperatura AS Temperatura,
       registro.umidade AS Umidade
       FROM registro
JOIN sensor ON registro.fk_sensor = sensor.id_sensor
ORDER BY ID;