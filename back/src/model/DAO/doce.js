/**********************************************************************
 * Objetivo: Arquivo responsável pelo CRUD de Doces
 * Data: 27/05/2026
 * Developer: Enzo Carrilho
 * Versão: 1.0.0
 *********************************************************************/
const db = require("../../database/connection.js")

const selectAvaliableDoces = async function () {
   try {
        let sql = 'CALL prc_listar_doces_disponiveis()'

        const result = await db.raw(sql)
        const doces = result[0][0]

        if(Array.isArray(doces))
            return doces
        else
            return false
        
   } catch (error) {
        return false
   }
}

const selectDiscardedDoces = async function () {
   try {
        let sql = 'CALL prc_listar_doces_descartados()'

        const result = await db.raw(sql)
        const doces = result[0][0]

        if(Array.isArray(doces))
            return doces
        else    
            return false
        
   } catch (error) {
        return false
   }
}

const insertDoce = async function(doce) {
    try {
        let sql = `CALL prc_cadastrar_doce
        (
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            @result
        )`
        
        const exec = await db.raw(
            sql, [
                    doce.nome, 
                    doce.massa, 
                    doce.cobertura, 
                    doce.recheio,
                    doce.quantidade,
                    doce.peso, 
                    doce.vencimento, 
                    doce.id_usuario, 
                    doce.id_tipo_doce
                ]
        )

        const result = await db.raw('SELECT @result')

        if(Array.isArray(result))
            return result[0][0]
        else
            return false

    } catch (error) {
        return false
    }
}

const updateDoce = async (id, doce) => {
    try {
        const result = await db('tb_doce')
            .where({ id: id })
            .update({
                nome: doce.nome, 
                massa: doce.massa, 
                cobertura: doce.cobertura, 
                recheio: doce.recheio,
                quantidade: doce.quantidade,
                peso_kg: doce.peso, 
                vencimento: doce.vencimento,
                id_tipo_doce: doce.id_tipo_doce 
            })

        if(result == 1)
            return result
        else if(result.sqlState === '45000')
            return result.sqlMessage
        else
            return false

    } catch (error) {
        return false
    }
    
}

const discardDoce = async function (idDoce, idUsuario) {
    try {
        let sql = 'CALL prc_descartar_doce(?, ?, @result)'

        const exec = await db.raw(sql, [idDoce, idUsuario])

        const result = await db.raw('SELECT @result')
        
        if(Array.isArray(result))
            return result[0][0]
        else
            return false

    } catch (error) {
        return false
    }
}


module.exports = {
    selectAvaliableDoces,
    selectDiscardedDoces,
    insertDoce
}
