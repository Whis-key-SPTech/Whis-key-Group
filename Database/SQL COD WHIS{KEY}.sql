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
cnpj CHAR (18) NOT NULL,
dt_inicio_contrato DATE NOT NULL,
dt_fim_contrato DATE
);

-- Tabela contendo as configurações e limitadores de temperatura e umidade para cada tipo de whisky.
/*Esta tabela será utilizada futuramente para relacionar as predefinições de temperatura e umidade máxima e mínima para cada tipo de whisky,
 ela irá se relacionar com as tabelas monitor_temp, monitor_umid e tipo_whisky a fim de conectar todos esses dados.*/
CREATE TABLE predefinicao (
id_predefinicao INT PRIMARY KEY AUTO_INCREMENT,
temp_max DECIMAL (4,2),
temp_min DECIMAL (4,2),
umid_max INT,
umid_min INT,
tipo_whisky VARCHAR (50),
fk_idEmpresa INT,
	CONSTRAINT EmpresaPredefinicao
     FOREIGN KEY (fk_idEmpresa)
		REFERENCES predefinicao(id_predefinicao)
);

-- Tabela contendo as informações de cadastro dos usuários de cada empresa.
CREATE TABLE usuario(
id_usuario INT AUTO_INCREMENT,
fk_idEmpresa INT NOT NULL,
nome_usuario VARCHAR (50) NOT NULL,
email VARCHAR (100) NOT NULL UNIQUE,
senha VARCHAR (100) NOT NULL,
privilegio INT, 
CONSTRAINT UsuarioEmpresa 
foreign key(fk_idEmpresa) 
references empresa(id_empresa),
PRIMARY KEY (id_usuario, fk_idEmpresa)
);

-- Tabela contendo as informações dos sensores.
-- Esta tabela será usada futuramente para se relacionar com as tabelas a cima a fim de um maior controle dos dados.
CREATE TABLE sensor(
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
codigo_sensor CHAR(5), -- Os dois primeiros números determinam o número do sensor e os outros determinam a identificação do barril a qual o sensor pertence.
localidade VARCHAR (100),
fk_idPredefinicao INT,
CONSTRAINT SensorPredefinicao
FOREIGN KEY(fk_idPredefinicao)
REFERENCES predefinicao(id_predefinicao)
);

-- Tabela contendo os dados coletados pelos sensores de temperatura. 
 CREATE TABLE registro (
id_registro INT PRIMARY KEY AUTO_INCREMENT,
fk_idSensor INT NOT NULL,
dt_coleta DATE DEFAULT (CURRENT_DATE),
hr_coleta TIME DEFAULT (CURRENT_TIME),
temperatura DECIMAL (4,2) NOT NULL,
umidade INT NOT NULL,
CONSTRAINT SensorRegistro 
foreign key (fk_idSensor) 
references sensor(id_sensor)
);

-- Comando para descrever as configurações de cada tabela.
DESC empresa;
DESC usuario;
DESC registro;
DESC predefinicao;
DESC sensor;

-- Inserção dos dados na tabela empresa.
INSERT INTO empresa (nome_empresa, cnpj, dt_inicio_contrato, dt_fim_contrato) VALUE
	('Brown-Forman', '36.631.108/0001-20', '2025-08-20', NULL),
	('Diageo plc', '62.166.848/0001-42', '2025-08-20', '2030-08-20'),
	('Pernod Ricard', '33.856.394/0017-09', '2025-08-20', NULL),
	('Bacardi Limited', '59.104.737/0001-05', '2025-08-20', '2027-08-20'),
	('Beam Suntor', '17.530.779/0001-50', '2025-08-20', '2035-08-20');
    
-- predefinicao
INSERT INTO predefinicao (temp_max, temp_min, umid_max, umid_min, tipo_whisky) VALUE
	(20, 25, 80, 60, 'Rye'),
	(21, 26, 80, 60, 'Bourbon'),
	(22, 24, 80, 60, ' Tennessee Whiskey');
    

-- Inserção dos dados na tabela usuario.
INSERT INTO usuario (fk_idEmpresa, nome_usuario, email, senha, privilegio) VALUE
	(1,'Gleison Almeida','gleison.almeida@gmail.com', '1651656125',0),
	(2,'Gustavo Kenzo','gustavo.kenzo@gmail.com', '165165561',1),
	(3,'Gustavo Henrique','gustavo.henrique@gmail.com', '4854616584',1);

    select * from usuario;
    
    SELECT empresa.nome_empresa as Empresa, usuario.nome_usuario as Usuario FROM empresa JOIN usuario 
    ON usuario.fk_idEmpresa = empresa.id_empresa;
    
    -- sensor
INSERT INTO sensor (codigo_sensor, localidade, fk_idPredefinicao) VALUE
	('01556', 'Armazem Norte 1',1),
	('02678', 'Armazem Norte 2',2),
	('03478', 'Armazem Norte 3',3);

    
-- registro
INSERT INTO registro (fk_idSensor,temperatura,umidade) VALUES
	(1, 25, 50),
	(2, 18, 60),
	(3, 10, 30);
    

    select* from predefinicao;
    select* from empresa;
    select* from registro;
    select* from sensor;
    select*from usuario;
    
-- JOIN COM AS TABELAS
-- Empresa + Usuário
SELECT empresa.id_empresa AS ID,
       empresa.nome_empresa AS Empresa,
       empresa.cnpj AS CNPJ,
       empresa.dt_inicio_contrato AS DATA_INICIO_CONTRATO,
       empresa.dt_fim_contrato AS DATA_FIM_CONTRATO
		FROM empresa
		JOIN usuario ON empresa.id_empresa = usuario.fk_idEmpresa;


-- Empresa + Predefinição
SELECT empresa.id_empresa AS ID,
       empresa.email AS Email,
       empresa.senha AS Senha,
       empresa.privilegio AS Privilegio,
       predefinicao.tipo_whisky AS Whisky
FROM usuario
JOIN predefinicao ON usuario.fk_idPredefinicao = predefinicao.id_predefinicao;

-- Sensor + Registro
SELECT registro.temperatura AS Temperatura,
       registro.umidade AS Umidade,
       sensor.localidade AS Localizacao
FROM registro
JOIN sensor ON registro.fk_idSensor = sensor.id_sensor;

-- SELECTS ANTIGOS
    
-- Apresentação dos dados cadastrados na tabela empresa.
SELECT * FROM empresa;
SELECT nome_empresa AS Empresa, cnpj AS CNPJ, dt_inicio_contrato AS 'Inicio do contrato' FROM empresa;

-- Apresentação dos dados cadastrados na tabela usuario.
SELECT * FROM usuario;
SELECT nome_usuario AS Nome, email AS Email FROM usuario;

-- Apresentação dos dados cadastrados na tabela predefinicao.
SELECT * FROM predefinicao;
SELECT tipo_whisky AS 'Tipos Cadastrados' FROM predefinicao;

-- Apresentação dos dados cadastrados na tabela sensor.
SELECT * FROM sensor;
SELECT codigo_sensor AS 'Sensor', localidade AS Localizado FROM sensor;