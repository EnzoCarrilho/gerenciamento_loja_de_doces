
DELIMITER $$

CREATE PROCEDURE prc_cadastrar_doce(
    IN p_nome VARCHAR(80),
    IN p_massa VARCHAR(50),
    IN p_cobertura VARCHAR(50),
    IN p_recheio VARCHAR(50),
    IN p_vencimento DATE,
    IN p_id_usuario INT,
    IN p_id_tipo_doce INT,
    OUT p_message JSON
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_message = JSON_OBJECT(
            'status_code', 500,
            'message', 'Erro ao cadastrar doce'
        );
    END;

    INSERT INTO tb_doce (
        nome,
        massa,
        cobertura,
        recheio,
        vencimento,
        id_usuario,
        id_tipo_doce
    )
    VALUES (
        p_nome,
        p_massa,
        p_cobertura,
        p_recheio,
        p_vencimento,
        p_id_usuario,
        p_id_tipo_doce
    );

    IF ROW_COUNT() > 0 THEN
        SET p_message = JSON_OBJECT(
            'status_code', 201,
            'message', 'Doce cadastrado com sucesso'
        );
    ELSE
        SET p_message = JSON_OBJECT(
            'status_code', 400,
            'message', 'Não foi possível cadastrar o doce'
        );
    END IF;

END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE prc_descartar_doce(
    IN p_id_doce INT,
    IN p_id_usuario INT,
    OUT p_message JSON
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_message = JSON_OBJECT(
            'status_code', 500,
            'message', 'Erro ao descartar doce'
        );
    END;

    IF EXISTS (
        SELECT 1
        FROM tb_descarte_doce
        WHERE id_doce = p_id_doce
    ) THEN

        SET p_message = JSON_OBJECT(
            'status_code', 409,
            'message', 'Este doce já foi descartado'
        );

    ELSE

        INSERT INTO tb_descarte_doce (
            id_doce,
            id_usuario,
            data
        )
        VALUES (
            p_id_doce,
            p_id_usuario,
            CURDATE()
        );

        IF ROW_COUNT() > 0 THEN

            SET p_message = JSON_OBJECT(
                'status_code', 201,
                'message', 'Doce descartado com sucesso'
            );

        ELSE

            SET p_message = JSON_OBJECT(
                'status_code', 400,
                'message', 'Não foi possível descartar o doce'
            );

        END IF;

    END IF;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE prc_listar_doces_vencidos()
BEGIN

    SELECT *
    FROM tb_doce
    WHERE vencimento < CURDATE();

END $$

DELIMITER 


DELIMITER $$

CREATE PROCEDURE prc_listar_doces_disponiveis()
BEGIN

    SELECT d.*
    FROM tb_doce d
    LEFT JOIN tb_descarte_doce descarte
        ON descarte.id_doce = d.id
    WHERE descarte.id IS NULL;

END $$

DELIMITER ;
