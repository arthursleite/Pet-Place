const express = require('express');
const router = express.Router();

const usuarioController = require('../controller/usuarioController');

router.post('/cadastrar_usuario', usuarioController.cadastrarUsuario);
router.get('/api/usuarios', usuarioController.listarUsuarios);

router.get('/src/views/configuracao.html/', usuarioController.configView);
router.post('/src/views/configuracao.html', usuarioController.atualizarUsuario);

module.exports = router;