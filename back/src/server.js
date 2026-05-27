/**********************************************************************
 * Objetivo: Arquivo responsável pelo funcionamento da API da aplicação
 * Data: 27/05/2026
 * Developer: Enzo Carrilho
 * Versão: 1.0.0
 *********************************************************************/
const express = require('express')

const cors = require('cors')

const PORT = process.env.PORT || 8080

const app = express()

app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'Accept']
}))

app.use(express.json());


app.listen(PORT, () => {
    console.log(`API rodando na porta: ${PORT}`)
})