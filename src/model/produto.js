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
        produto: {
        type: Sequelize.STRING,
        allowNull: false
    },
        categoria: { 
        type: Sequelize.STRING,
        allowNull: false
    },
        data_vencimento: {
        type: Sequelize.STRING,
        allowNull: false
    },
        quantidade: {
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
    },
    carrinho: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
        allowNull: false
    }
});

module.exports = Produto;