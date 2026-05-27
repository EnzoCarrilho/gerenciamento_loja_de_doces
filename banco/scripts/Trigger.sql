DELIMITER $$

CREATE TRIGGER trg_bloquear_update_doce_descartado
BEFORE UPDATE ON tb_doce
FOR EACH ROW
BEGIN

    IF EXISTS (
        SELECT 1
        FROM tb_descarte_doce
        WHERE id_doce = OLD.id
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível alterar um doce descartado';

    END IF;

END $$

DELIMITER ;