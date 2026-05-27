-- =========================
-- USUÁRIOS
-- =========================

INSERT INTO tb_usuario (nome, email, senha)
VALUES
('João Silva', 'joao@gmail.com', '123456'),
('Maria Oliveira', 'maria@gmail.com', '123456'),
('Carlos Souza', 'carlos@gmail.com', '123456');


-- =========================
-- TIPOS DE DOCE
-- =========================

INSERT INTO tb_tipo_doce (tipo)
VALUES
('Bolo'),
('Torta');


-- =========================
-- DOCES
-- =========================

INSERT INTO tb_doce (
    nome,
    massa,
    cobertura,
    recheio,
    vencimento,
    id_usuario,
    id_tipo_doce
)
VALUES
(
    'Bolo de Chocolate',
    'Chocolate',
    'Brigadeiro',
    'Morango',
    '2026-06-10',
    1,
    1
),
(
    'Torta de Limão',
    'Massa crocante',
    'Merengue',
    'Limão',
    '2026-04-15',
    2,
    2
),
(
    'Bolo Red Velvet',
    'Velvet',
    'Cream Cheese',
    'Frutas Vermelhas',
    '2026-06-20',
    1,
    1
),
(
    'Torta Holandesa',
    'Biscoito',
    'Chocolate',
    'Baunilha',
    '2026-03-12',
    3,
    2
);


-- =========================
-- DESCARTE DE DOCES
-- =========================

INSERT INTO tb_descarte_doce (
    id_usuario,
    id_doce,
    data
)
VALUES
(
    2, 
    1, 
    CURDATE()
);