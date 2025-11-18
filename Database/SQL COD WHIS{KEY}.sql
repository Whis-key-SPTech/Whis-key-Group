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
SELECT * FROM destilaria
JOIN empresa
ON id_empresa = fk_empresa;

-- Tabela contendo o endereço da Destilaria
CREATE TABLE endereco(
id_endereco INT PRIMARY KEY AUTO_INCREMENT,
rua VARCHAR(45),
numero INT,
complemento VARCHAR(45));

-- Tabela contendo as destilarias da Empresa
CREATE TABLE destilaria (
id_destilaria INT PRIMARY KEY AUTO_INCREMENT,
fk_endereco INT,
	CONSTRAINT EnderecoDistilaria
		FOREIGN KEY (fk_endereco) 
			REFERENCES endereco(id_endereco),
fk_empresa INT,
	CONSTRAINT EmpresaDestilaria
		FOREIGN KEY (fk_Empresa)
			REFERENCES empresa(id_empresa)
);

-- Tabela em relação a localidade do sensor
CREATE TABLE localidade_sensor(
id_LocalidadeSensor INT PRIMARY KEY AUTO_INCREMENT,
nome_localidade VARCHAR(45),
numero_local INT
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
	CONSTRAINT PredefinicaoEmpresa
		FOREIGN KEY (fk_idEmpresa)
			REFERENCES empresa(id_empresa)
);

-- Tabela contendo as informações de cadastro dos usuários de cada empresa.
CREATE TABLE usuario(
id_usuario INT AUTO_INCREMENT,
nome_usuario VARCHAR (50) NOT NULL,
email VARCHAR (100) NOT NULL UNIQUE,
senha VARCHAR (100) NOT NULL,
privilegio INT,
pk_idEmpresa INT NOT NULL,
CONSTRAINT UsuarioEmpresa 
	FOREIGN KEY (pk_idEmpresa) 
		REFERENCES empresa(id_empresa),
			PRIMARY KEY (id_usuario, pk_idEmpresa)
);

-- Tabela contendo as informações dos sensores.
-- Esta tabela será usada futuramente para se relacionar com as tabelas a cima a fim de um maior controle dos dados.
CREATE TABLE sensor(
id_sensor INT AUTO_INCREMENT,
codigo_sensor CHAR(5), -- Os dois primeiros números determinam o número do sensor e os outros determinam a identificação do barril a qual o sensor pertence.
fk_destilaria INT,
	CONSTRAINT DestilariaDoSensor
		FOREIGN KEY(fk_destilaria)
			REFERENCES destilaria(id_destilaria),
fk_idLocalidadeSensor INT,
	CONSTRAINT SensorLocalidade
		FOREIGN KEY (fk_idLocalidadeSensor)
			REFERENCES localidade_sensor(id_LocalidadeSensor),
PRIMARY KEY (id_sensor, fk_idLocalidadeSensor)
);


-- Tabela contendo os dados coletados pelos sensores de temperatura. 
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
DESC usuario;
DESC registro;
DESC predefinicao;
DESC sensor;
DESC localidade_sensor;




-- Inserção dos dados na tabela empresa.
INSERT INTO empresa (nome_empresa, cnpj) VALUE
	('Brown-Forman', '36.631.108/0001-20'),
	('Diageo plc', '62.166.848/0001-42'),
	('Pernod Ricard', '33.856.394/0017-09'),
	('Bacardi Limited', '59.104.737/0001-05'),
	('Beam Suntor', '17.530.779/0001-50');

-- Dados da destilaria
INSERT INTO destilaria (fk_endereco, fk_empresa) VALUE
	(1, 1),
    (2, 2),
    (3,3);

-- Endereco da destilaria    
INSERT INTO endereco (rua) VALUES
('Rua Miguel'), ('Rua General'), ('Rua Vitoria');
    
-- Localidade Sensor
INSERT INTO localidade_sensor(nome_localidade, numero_local) VALUES
	('Armazém norte','1'),
	('Armazém sul','2'),
	('Armazém leste','3');
    
    
-- predefinicao
INSERT INTO predefinicao (temp_max, temp_min, umid_max, umid_min, tipo_whisky,fk_idEmpresa) VALUE
	(20, 25, 80, 60, 'Lamas', 1),
	(21, 26, 80, 60, 'Old Eight',2),
	(21, 26, 80, 60, 'Old Eight',3),
	(21, 26, 80, 60, 'Old Eight',4),
	(22, 24, 80, 60, 'Blended whisky',5);
    

-- Inserção dos dados na tabela usuario.
INSERT INTO usuario (fk_idEmpresa, nome_usuario, email, senha, privilegio) VALUE
	(1,'Kauan Batista','kauan.batista@gmail.com', '1651656125',0),
	(2,'Gustavo Rucaglia','gustavo.rucaglia@gmail.com', '165165561',1),
	(3,'Gustavo Henrique','gustavo.henrique@gmail.com', '4854616584',1),
	(4,'Giovanni Angel','giovanni.angel@gmail.com', '4854616584',1),
	(5,'Vitória Ferreira','vitoria.ferreira@gmail.com', '4854616584',1),
	(3,'André Luis','andre.luis@gmail.com', '4854616584',0);

    -- sensor
INSERT INTO sensor (codigo_sensor, fk_idPredefinicao, fk_idLocalidadeSensor) VALUE
	('01556',1,1),
	('02678',2,2),
	('03478',3,3);

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

-- JOIN Geral
SELECT registro.id_registro AS ID,
	   empresa.nome_empresa AS Empresa,
	   predefinicao.tipo_whisky AS Tipo_Whisky,
	   localidade_sensor.nome_localidade AS Espaço,
	   registro.temperatura AS Temperatura,
       registro.umidade AS Umidade
       FROM registro
JOIN sensor ON registro.fk_idSensor = sensor.id_sensor
JOIN localidade_sensor ON sensor.fk_idLocalidadeSensor = localidade_sensor.id_LocalidadeSensor
JOIN predefinicao ON sensor.fk_idPredefinicao = predefinicao.id_predefinicao
JOIN empresa ON predefinicao.fk_idEmpresa = empresa.id_empresa
ORDER BY ID;


SELECT * FROM a a WHERE fk_empresa
-- Empresa + Usuário
SELECT empresa.nome_empresa AS Empresa,
       usuario.nome_usuario AS Usuario
FROM empresa
JOIN usuario ON empresa.id_empresa = usuario.fk_idEmpresa;

-- Usuário + Predefinição
SELECT usuario.nome_usuario AS Nome,
       usuario.email AS Email,
       usuario.senha AS Senha,
       usuario.privilegio AS Privilegio,
       predefinicao.tipo_whisky AS Whisky
FROM usuario
JOIN predefinicao ON usuario.fk_idPredefinicao = predefinicao.id_predefinicao;

-- Sensor + Registro
SELECT registro.id_registro AS ID, 
	   registro.temperatura AS Temperatura,
       registro.umidade AS Umidade
       FROM registro
JOIN sensor ON registro.fk_idSensor = sensor.id_sensor
ORDER BY ID;