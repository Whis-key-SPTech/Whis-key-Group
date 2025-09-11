-- Integrantes do Grupo 02

-- Gleison Almeida de Freitas Ra: 01252044
-- Gustavo Henrique de Souza Ra: 01252106
-- Gustavo Kenzo Iwahashi  Ra: 01252005
-- Leandro Almeida da Silva Ra: 01252021
-- Matheus Strilicherk Ra: 01252110
-- Mauro Moreno Fernandes Ra: 01252111
-- Rafael Alexandre da Silva Ra: 01252060
-- Marina Yuri Okamoto Ra: 01252051



CREATE DATABASE BD_WHISKEY;



USE BD_WHISKEY;



-- Tabela contendo as informações de cadastro das empresas contratantes.
CREATE TABLE empresa(
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
nome_empresa VARCHAR (50)NOT NULL,
cnpj CHAR (17) NOT NULL,
dt_inicio_contrato DATE NOT NULL,
dt_fim_contrato DATE
);

-- Tabela contendo as informações de cadastro dos usuários de cada empresa.
CREATE TABLE usuario(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
id_empresa INT NOT NULL,
nome_usuario VARCHAR (50) NOT NULL,
email VARCHAR (100) NOT NULL UNIQUE,
senha VARCHAR (100) NOT NULL
);

-- Tabela contendo os dados coletados pelos sensores de temperatura.
/*Esta tabela contém temperatura máxima e mínima, apenas porque ainda não podemos relacionar as tabelas,
 porém essas informações serão futuramente transferidas para a tabela predefinicoes.*/
CREATE TABLE monitor_temp(
id_temp INT PRIMARY KEY AUTO_INCREMENT,
id_sensor INT NOT NULL,
dt_coleta DATE DEFAULT (CURRENT_DATE),
hr_coleta TIME DEFAULT (CURRENT_TIME),
temperatura DECIMAL (4,2) NOT NULL,
temp_max DECIMAL (4,2),
temp_min DECIMAL (4,2)
);

-- Tabela contendo os dados coletados pelos sensores de umidade.
/*Esta tabela contém umidade máxima e mínima, apenas porque ainda não podemos relacionar as  tabelas,
 porém, essas informações serão futuramente transferidas para tabelas predefinicoes.*/
CREATE TABLE monitor_umid(
id_umid INT PRIMARY KEY AUTO_INCREMENT,
id_sensor INT NOT NULL,
dt_coleta DATE DEFAULT (CURRENT_DATE),
hr_coleta TIME DEFAULT (CURRENT_TIME),
umidade INT NOT NULL,
umid_max INT,
umid_min INT
);

-- Tabela contendo as configurações e limitadores de temperatura e umidade para cada tipo de whisky.
/*Esta tabela será utilizada futuramente para relacionar as predefinições de temperatura e umidade máxima e mínima para cada tipo de whisky,
 ela irá se relacionar com as tabelas monitor_temp, monitor_umid e tipo_whisky a fim de conectar todos esses dados.*/
CREATE TABLE predefinicao (
id_predefinicao INT PRIMARY KEY AUTO_INCREMENT,
id_tipo_whisky INT NOT NULL,
temp_max DECIMAL (4,2),
temp_min DECIMAL (4,2),
umid_max INT,
umid_min INT
);

-- Tabela contendo os tipos de whisky.
CREATE TABLE tipo_whisky (
id_whisky INT PRIMARY KEY AUTO_INCREMENT,
tipo_whisky VARCHAR (50)
);

-- Tabela contendo as informações dos sensores.
-- Esta tabela será usada futuramente para se relacionar com as tabelas a cima a fim de um maior controle dos dados.
CREATE TABLE sensor(
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
codigo_sensor CHAR(5), -- Os dois primeiros números determinam o número do sensor e os outros determinam a identificação do barril a qual o sensor pertence.
localidade VARCHAR (100)
);



-- Comando para descrever as configurações de cada tabela.
DESC empresa;
DESC usuario;
DESC monitor_temp;
DESC monitor_umid;
DESC predefinicao;
DESC tipo_whisky;
DESC sensor;



-- Inserção dos dados na tabela empresa.
INSERT INTO empresa (nome_empresa, cnpj, dt_inicio_contrato, dt_fim_contrato) VALUE
	('Brown-Forman', '36.631.108/0001-20', '2025-08-20', NULL),
	('Diageo plc', '62.166.848/0001-42', '2025-08-20', '2030-08-20'),
	('Pernod Ricard', '33.856.394/0017-09', '2025-08-20', NULL),
	('Bacardi Limited', '59.104.737/0001-05', '2025-08-20', '2027-08-20'),
	('Beam Suntor', '17.530.779/0001-50', '2025-08-20', '2035-08-20');

-- Inserção dos dados na tabela usuario.
INSERT INTO usuario (id_empresa, nome_usuario, email, senha) VALUE
	(1, 'Gleison Almeida','gleison.almeida@gmail.com', '1651656125'),
	(2, 'Gustavo Kenzo','gustavo.kenzo@gmail.com', '165165561'),
	(3, 'Gustavo Henrique','gustavo.henrique@gmail.com', '4854616584'),
	(4, 'Marina Yuri','marina.yuri@gmail.com', '6541654684'),
	(5, 'Leandro Almeida','leandro.almeida@gmail.com', '6516545165');
    
/* A inserção de dados nas tabelas de monitoramento serão mínimas apenas para demonstrar o funcionamento das tabelas,
 tendo em vista que o funcionamento pleno será feito através do Arduino.*/
-- monitor_temp
INSERT INTO monitor_temp (id_sensor, temperatura, temp_max, temp_min) VALUE
	(1, 25, 20, 15),
	(1, 18, 20, 15),
	(2, 10, 20, 15);
    
-- monitor_umid
INSERT INTO monitor_umid (id_sensor, umidade, umid_max, umid_min) VALUE
	(1, 50, 60, 40),
	(3, 70, 60, 40),
	(2, 30, 60, 40);
    
/*A inserção de dados na tabela predefinicao, tipo_whisky e sensor serão mínimas apenas para demonstrar o funcionamento da tabela
tendo em vista que não a utilizaremos no momento.*/

-- predefinicao
INSERT INTO predefinicao (id_tipo_whisky, temp_max, temp_min, umid_max, umid_min) VALUE
	(1, 20, 15, 60, 40);
    
-- tipo_whisky
INSERT INTO tipo_whisky (tipo_whisky) VALUE 
	('Bourbon'),
	('Single Malt'),
	('Blended Malt'),
	('Single Grain'),
	('Blended Grain'),
	('Scotch Blended'),
	('Tennessee'),
	('Rye');
    
-- sensor
iNSERT INTO sensor (codigo_sensor, localidade) VALUE
	('01556', 'Armazem Norte 1'),
	('02678', 'Armazem Norte 2'),
	('03478', 'Armazem Norte 3');

-- Apresentação dos dados cadastrados na tabela empresa.
SELECT * FROM empresa;
SELECT nome_empresa AS Empresa, cnpj AS CNPJ, dt_inicio_contrato AS 'Inicio do contrato' FROM empresa;

-- Apresentação dos dados cadastrados na tabela usuario.
SELECT * FROM usuario;
SELECT nome_usuario AS Nome, email AS Email FROM usuario;

-- Apresentação dos dados cadastrados na tabela monitor_temp.
SELECT * FROM monitor_temp;
SELECT temperatura AS 'Graus Celsius', dt_coleta AS 'Data', hr_coleta AS Hora FROM monitor_temp;

-- Apresentação dos dados cadastrados na tabela monitor_umid.
SELECT * FROM monitor_umid;
SELECT umidade AS '% Umidade no Ar', dt_coleta AS 'Data', hr_coleta AS Hora FROM monitor_umid;

-- Apresentação dos dados cadastrados na tabela predefinicao.
SELECT * FROM predefinicao;
SELECT * FROM predefinicao;

-- Apresentação dos dados cadastrados na tabela tipo_whisky.
SELECT * FROM tipo_whisky;
SELECT tipo_whisky AS 'Tipos Cadastrados' FROM tipo_whisky;

-- Apresentação dos dados cadastrados na tabela sensor.
SELECT * FROM sensor;
SELECT codigo_sensor AS 'Sensor', localidade AS Localizado FROM sensor;



-- Apresentação dos dados de forma tratada a fim de apresentar se o valor está a cima ou a baixo do padrão de temperatura selecionado.
SELECT *, CASE WHEN temperatura < temp_min THEN 'Abaixo!'
WHEN temperatura > temp_max 
THEN 'Acima!' 
END AS Aviso
FROM monitor_temp WHERE id_temp > 0;

-- Apresentação dos dados de forma tratada a fim de apresentar se o valor está a cima ou a baixo do padrão de umidade selecionado.
SELECT *, CASE WHEN umidade < umid_min THEN 'Abaixo!'
WHEN umidade > umid_max 
THEN 'Acima!' 
END AS Aviso
FROM monitor_umid WHERE id_umid > 0;
    


-- Sistema de mensagem de alerta para caso a temperatura esteja acima do limite.
SELECT CONCAT('O sensor de id ', id_sensor, ' está com a temperatura acima do limite!') AS Aviso
FROM monitor_temp WHERE temperatura > temp_max;

-- Sistema de mensagem de alerta para caso a temperatura esteja abaixo do limite.
SELECT CONCAT('O sensor de id ', id_sensor, ' está com a temperatura abaixo do limite!') AS Aviso 
FROM monitor_temp WHERE temperatura < temp_min;

-- Sistema de mensagem de alerta para caso a umidade esteja acima do limite.
SELECT CONCAT('O sensor de id ', id_sensor, ' está com a umidade acima do limite!') AS Aviso 
FROM monitor_umid WHERE umidade > umid_max;

-- Sistema de mensagem de alerta para caso a umidade esteja abaixo do limite.
SELECT CONCAT('O sensor de id ', id_sensor, ' está com a umidade abaixo do limite!') AS Aviso 
FROM monitor_umid WHERE umidade < umid_min;