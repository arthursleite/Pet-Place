const express = require('express');
const router = express.Router();

const produtoController = require('../controller/produtoController');
const autenticacaoController = require('../controller/autenticacaoController');

router.get('/', produtoController.indexView);
router.get('/src/views/configuracao.html', produtoController.configView);
router.get('/home', autenticacaoController.verificarAutenticacao, produtoController.homeView);
router.post('/cadastrar_produto', autenticacaoController.verificarAutenticacao, produtoController.cadastrarProduto);
router.post('/editar_produto/:id', autenticacaoController.verificarAutenticacao,produtoController.editarProduto);
router.post('/remover_produto/:id', autenticacaoController.verificarAutenticacao, produtoController.removerProduto);

module.exports = router;