const Produto = require('../model/produto');

function indexView(req, res) {
    res.render('index.html');
}

function listarProdutoECarrinho(req, res) {
    const usuarioId = req.session.usuario.id;
    const produtosPromise = Produto.findAll({
        where: {
            id_usuario: usuarioId,
            indicador_ativo: 1
        }
    });

    const produtosCarrinhoPromise = Produto.findAll({
        where: {
            id_usuario: usuarioId,
            indicador_ativo: 1,
            carrinho: 1
        }
    });

    Promise.all([produtosPromise, produtosCarrinhoPromise])
        .then(([produtos, produtosCarrinho]) => {
            res.render('home.html', { produtos, produtosCarrinho });
        })
        .catch((erro) => {
            res.render('home.html', { erro });
        });
}

function cadastrarProduto(req, res) {
    let produto = {
        produto: req.body.produto,
        id_usuario: req.session.usuario.id,
        categoria: req.body.categoria, //orcamento
        quantidade: req.body.quantidade,
        data_vencimento: req.body.data_vencimento,
        indicador_ativo: 1,
        estilo: req.body.estilo
    }

    Produto.create(produto).then(() => {
        res.redirect('/home');
    }).catch((err) => {
        console.log(err);
        let erro_cadastrar_produto = true;
        res.render("home.html", { erro_cadastrar_produto });
    });

}

function editarProduto(req, res) {
    console.log("Editando produto...")
    let idProduto = req.params.id;
    let novosDados = {
        produto: req.params.produto,
        categoria: req.params.categoria,
        quantidade: req.params.quantidade,
        data_vencimento: req.params.data_vencimento,
    }

    Produto.update(novosDados, { where: { id: idProduto } })
        .then(() => {
            res.json({ mensagem: "Produto atualizado com sucesso!" });
        })
        .catch((err) => {
            console.log(err);
            res.json({ mensagem: "Erro ao atualizar o Produto." });
        });
}

function removerProduto(req, res) {
    const produtoId = req.params.id;
    Produto.destroy({
        where: {
            id: produtoId,
            id_usuario: req.session.usuario.id
        }
    }).then(() => {
        res.redirect('/home');
    }).catch((err) => {
        console.log(err);
        let erro_remover_produto = true;
        res.render("home.html", { erro_remover_produto });
    });
}

function adicionarAoCarrinho(req, res) {
    console.log("Entrou no carrinho");
    let idProduto = req.params.id;
    let novosDados = {
        carrinho: true
    }

    Produto.update(novosDados, { where: { id: idProduto } })
        .then(() => {
            res.redirect('/home');
        })
        .catch((err) => {
            console.log(err);
            res.json({ mensagem: "Erro ao adicionar o produto ao carrinho." });
        });
    console.log("Adicionando produto ao carrinho...");
}

module.exports = {
    indexView,
    listarProdutoECarrinho,
    cadastrarProduto,
    editarProduto,
    removerProduto,
    adicionarAoCarrinho
}