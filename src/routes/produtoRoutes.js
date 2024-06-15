const express = require('express');
const router = express.Router();

const produtoController = require('../controller/produtoController');
const autenticacaoController = require('../controller/autenticacaoController');

router.get('/', produtoController.indexView);
router.get('/home', autenticacaoController.verificarAutenticacao, produtoController.listarProdutos);
router.get('/carrinho', autenticacaoController.verificarAutenticacao, produtoController.listarCarrinho);
router.post('/cadastrar_produto', autenticacaoController.verificarAutenticacao, produtoController.cadastrarProduto);
router.post('/remover_produto/:id', autenticacaoController.verificarAutenticacao, produtoController.removerProduto);
router.post('/editar_produto/:id', autenticacaoController.verificarAutenticacao, produtoController.editarProduto);
router.post('/adicionar_ao_carrinho/:id', autenticacaoController.verificarAutenticacao, produtoController.adicionarAoCarrinho);
router.post('/remover_do_carrinho/:id', autenticacaoController.verificarAutenticacao, produtoController.removerDoCarrinho);
router.post('/finalizar_compra', autenticacaoController.verificarAutenticacao, produtoController.finalizarCompra);

module.exports = router;