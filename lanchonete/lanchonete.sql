DROP DATABASE lanchonete;

CREATE DATABASE lanchonete;
USE lanchonete;

CREATE TABLE sanduiche(
	codigoSanduiche SMALLINT PRIMARY KEY,
	nome VARCHAR(45),
	preco DECIMAL(5,2)
);

CREATE TABLE cliente(
	codigoCliente INT PRIMARY KEY,
	nome VARCHAR(45),
	telefone VARCHAR(45),
	enderecoLogradouro VARCHAR(45),
	enderecoBairro VARCHAR(45),
	enderecoCidade VARCHAR(45)
);

CREATE TABLE entregador(
	codigoEntregador INT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    telefone VARCHAR(45) NOT NULL
);

CREATE TABLE pedido(
	codigoPedido INT PRIMARY KEY,
	dataEmissao DATE,
    FKcodigoCliente INT,
	status TINYINT,
    FOREIGN KEY (FKcodigoCliente) REFERENCES cliente(codigoCliente)
);

CREATE TABLE pedido_sanduiche(
	FKcodigoSanduiche INT,
    FKcodigoPedido INT,
    FOREIGN KEY (FKcodigoSanduiche) REFERENCES sanduiche(codigoSanduiche),
    FOREIGN KEY (FKcodigoPedido) REFERENCES pedido(codigoPedido)
);

CREATE TABLE pedido_entregador(
	FKcodigoPedido INT,
    FKcodigoEntregador INT,
    FOREIGN KEY (FKcodigoPedido) REFERENCES pedido(codigoPedido),
    FOREIGN KEY (FKcodigoEntregador) REFERENCES entregador(codigoEntregador)
);

INSERT INTO sanduiche VALUES
	(1, "X-Burguer", 14.90),
    (2, "X-Burguer Duplo", 15.90),
    (3, "X-Salada", 13.90),
    (4, "Queijo quente", 8.50),
    (5, "Sanduiche vegetariano", 11.90),
    (6, "Sanduiche de peito de peru", 12.50);

INSERT INTO cliente VALUES
	(1, "Maria", "(41)99999-9999", "Rua da Maria", "Centro", "Curitiba"),
    (2, "Joao", "(41)88888-8888", "Rua do Joao", "Santa Felicidade", "Curitiba"),
    (3, "Rafael", "(41)77777-7777", "Rua do Rafael", "Bigorrilho", "Curitiba");
    
INSERT INTO entregador VALUES
	(1, "Eduardo", "(41)66666-6666"),
    (2, "Murilo", "(41)55555-5555");

INSERT INTO pedido VALUES
	(1, "2021-08-20", 3, 2),
    (2, "2021-08-20", 1, 2),
    (3, "2021-08-21", 2, 2),
    (4, "2021-08-22", 1, 1),
    (5, "2021-08-22", 3, 0),
    (6, "2021-08-22", 2, 0);

INSERT INTO pedido_sanduiche VALUES
	(4, 1),
    (5, 2),
    (3, 3),
    (6, 4),
    (5, 5),
    (3, 6);
    
INSERT INTO pedido_entregador VALUES
	(1, 1),
    (2, 1),
    (3, 2),
    (4, 1),
    (5, 2),
    (6, 1);
    
/*Informações dos pedidos em preparação*/
SELECT pedido.codigoPedido, pedido.dataEmissao, cliente.nome, pedido.status, sanduiche.nome, sanduiche.preco FROM pedido 
JOIN pedido_sanduiche ON pedido_sanduiche.FKcodigoPedido = pedido.codigoPedido
JOIN sanduiche ON sanduiche.codigoSanduiche = pedido_sanduiche.FKcodigoSanduiche
JOIN cliente ON cliente.codigoCliente = pedido.FKcodigoCliente
WHERE pedido.status = 0;

/*Informações da entrega dos pedidos em preparação*/
SELECT pedido.codigoPedido, pedido.dataEmissao, pedido.status, entregador.nome FROM pedido_entregador
JOIN pedido ON pedido.codigoPedido = pedido_entregador.FKcodigoPedido
JOIN entregador ON entregador.codigoEntregador = pedido_entregador.FKcodigoEntregador
WHERE pedido.status = 0;
