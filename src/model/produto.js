const Sequelize = require('sequelize');
const database = require('../db');

const Produto = database.define('produto', {
    id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        allowNull: false,
        primaryKey: true
    },
    id_usuario: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    /*titulo*/produto: {
        type: Sequelize.STRING,
        allowNull: false
    },
    /*subtitulo*/categoria: { //orcamento
        type: Sequelize.STRING,
        allowNull: false
    },
    /*texto*/data_vencimento: {
        type: Sequelize.STRING,
        allowNull: false
    },
    /*texto*/quantidade: {
        type: Sequelize.STRING,
        allowNull: false
    },    
    indicador_ativo: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    estilo: {
        type: Sequelize.STRING,
        allowNull: false
    }
});

module.exports = Produto;