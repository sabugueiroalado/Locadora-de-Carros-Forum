CREATE TABLE Marcas (
  codigo INT PRIMARY KEY,
  descricao VARCHAR(50)
);
insert into Marcas VALUES ('1', 'Aston Martin');
insert into Marcas VALUES ('2', 'Audi');
insert into Marcas VALUES ('3', 'Bentley');
insert into Marcas VALUES ('4', 'BMW');
select * from Marcas;
UPDATE Marcas SET descricao = 'Lamborghini' WHERE descricao like 'Aston Martin';


CREATE TABLE Modelos (
  codigo INT PRIMARY KEY,
  codigo_marca INT,
  descricao VARCHAR(50),
  FOREIGN KEY (codigo_marca) REFERENCES Marcas(codigo)
);
INSERT INTO Modelos VALUES ('1', (SELECT codigo FROM Marcas WHERE descricao = 'Aston Martin'), 'DBX');
INSERT INTO Modelos VALUES ('2', (SELECT codigo FROM Marcas WHERE descricao = 'Audi'), 'A4');
INSERT INTO Modelos VALUES ('3', (SELECT codigo FROM Marcas WHERE descricao = 'Bentley'), 'Azure');
INSERT INTO Modelos VALUES ('4', (SELECT codigo FROM Marcas WHERE descricao = 'BMW'), 'X5');
select * from Modelos;
UPDATE Modelos SET descricao = 'Lamborghini Huracan' WHERE descricao like 'DBX';

CREATE TABLE Carros (
  codigo INT PRIMARY KEY,
  codigo_modelo INT,
  ano INT,
  cor VARCHAR(20),
  descricao VARCHAR(100),
  observacoes VARCHAR(200),
  FOREIGN KEY (codigo_modelo) REFERENCES Modelos(codigo)
);
INSERT INTO Carros VALUES ('1', (SELECT codigo FROM Modelos WHERE descricao = 'DBX'), '2015', 'Branco', 'Freio ABS', '50km rodados');
INSERT INTO Carros VALUES ('2', (SELECT codigo FROM Modelos WHERE descricao = 'A4'), '2017', 'Cinza Escuro', 'Armotecedor', '70km rodados');
INSERT INTO Carros VALUES ('3', (SELECT codigo FROM Modelos WHERE descricao = 'Azure'), '2019', 'Vermelho', 'Nitro', 'Airbag');
INSERT INTO Carros VALUES ('4', (SELECT codigo FROM Modelos WHERE descricao = 'X5'), '2022', 'Preta', 'Aerofólio', '120km rodados');
select * from Carros;
UPDATE Carros SET ano = '2020', cor = 'Amarelo', observacoes = '40km rodados' WHERE descricao like 'Freio ABS';
DELETE FROM Carros where cor like 'Preta';

CREATE TABLE Usuarios (
  codigo INT PRIMARY KEY,
  nome VARCHAR(50),
  email VARCHAR(100),
  senha VARCHAR(50)
);
INSERT INTO Usuarios VALUES ('1', 'Vitor', 'vitor@gmail.com', 'calabouço123');
INSERT INTO Usuarios VALUES ('2', 'Gabriel', 'gabriel@gmail.com', 'bolacha321');
INSERT INTO Usuarios VALUES ('3', 'Ana', 'ana@gmail.com', 'arvore213');
INSERT INTO Usuarios VALUES ('4', 'Angela', 'angela@gmail.com', 'porta333');
select * from Usuarios;
DELETE FROM Usuarios where nome like 'Angela';

CREATE TABLE Locacoes (
  codigo INT PRIMARY KEY,
  codigo_carro INT,
  codigo_cliente INT,
  data_retirada DATE,
  data_devolucao DATE,
  valor DECIMAL(10, 2),
  observacoes VARCHAR(200),
  FOREIGN KEY (codigo_carro) REFERENCES Carros(codigo),
  FOREIGN KEY (codigo_cliente) REFERENCES Usuarios(codigo)
);
INSERT INTO Locacoes VALUES ('1', (SELECT codigo FROM Carros WHERE descricao = 'Freio ABS'), (SELECT codigo FROM Usuarios WHERE nome = 'Vitor'), '2023-02-14', '2023-03-14', '759.68', 'Devolver com o tanque cheio');
INSERT INTO Locacoes VALUES ('2', (SELECT codigo FROM Carros WHERE descricao = 'Freio ABS'), (SELECT codigo FROM Usuarios WHERE nome = 'Gabriel'), '2023-01-27', '2023-02-13', '456.68', 'Devolver com o tanque cheio');
INSERT INTO Locacoes VALUES ('3', (SELECT codigo FROM Carros WHERE descricao = 'Freio ABS'), (SELECT codigo FROM Usuarios WHERE nome = 'Ana'), '2023-03-11', '2023-04-01', '865.68', 'Devolver com o tanque cheio');
INSERT INTO Locacoes VALUES ('4', (SELECT codigo FROM Carros WHERE descricao = 'Freio ABS'), (SELECT codigo FROM Usuarios WHERE nome = 'Angela'), '2023-04-30', '2023-06-12', '1332.68', 'Devolver com o tanque cheio');
select * from Locacoes;
DELETE FROM Locacoes where valor like '1332,68';

SELECT L.codigo, C.descricao, U.nome
FROM Locacoes AS L
LEFT JOIN Carros AS C ON L.codigo_carro = C.codigo
LEFT JOIN Usuarios AS U ON L.codigo_cliente = U.codigo;

SELECT L.codigo, C.descricao, U.nome
FROM Locacoes AS L
INNER JOIN Carros AS C ON L.codigo_carro = C.codigo
INNER JOIN Usuarios AS U ON L.codigo_cliente = U.codigo;

SELECT L.codigo, C.descricao, U.nome
FROM Locacoes AS L
RIGHT JOIN Carros AS C ON L.codigo_carro = C.codigo
RIGHT JOIN Usuarios AS U ON L.codigo_cliente = U.codigo;

DELIMITER //
CREATE PROCEDURE SaveUsuario (
  IN p_codigo INT,
  IN p_nome VARCHAR(50),
  IN p_email VARCHAR(100),
  IN p_senha VARCHAR(50)
)
BEGIN
  INSERT INTO Usuarios (codigo, nome, email, senha)
  VALUES (p_codigo, p_nome, p_email, p_senha);
END //
DELIMITER ;

CALL SaveUsuario(5, 'John Doe', 'john@example.com', 'password123');

DELIMITER //
CREATE TRIGGER UpdateModelosDescricao
AFTER UPDATE ON Marcas
FOR EACH ROW
BEGIN
  UPDATE Modelos
  SET descricao = NEW.descricao
  WHERE codigo_marca = OLD.codigo;
END //
DELIMITER ;