
create database db_ianes_doces;
use db_ianes_doces;

CREATE TABLE tb_usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(64) NOT NULL
);

CREATE TABLE tb_tipo_doce (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(20) NOT NULL
);

CREATE TABLE tb_doce (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    massa VARCHAR(50) NOT NULL,
    cobertura VARCHAR(50),
    recheio VARCHAR(50),
    vencimento DATE NOT NULL,

    id_usuario INT NOT NULL,
    id_tipo_doce INT NOT NULL,

    CONSTRAINT fk_doce_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES tb_usuario(id),

    CONSTRAINT fk_doce_tipo
        FOREIGN KEY (id_tipo_doce)
        REFERENCES tb_tipo_doce(id)
);

CREATE TABLE tb_descarte_doce (
    id INT PRIMARY KEY AUTO_INCREMENT,

    id_usuario INT NOT NULL,
    id_doce INT NOT NULL UNIQUE,

    data DATE NOT NULL,

    CONSTRAINT fk_descarte_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES tb_usuario(id),

    CONSTRAINT fk_descarte_doce
        FOREIGN KEY (id_doce)
        REFERENCES tb_doce(id)
);

