const Produto = require('../model/produto');

function indexView(req, res) {
    res.render('index.html');
}

function listarProdutos(req, res) {
    const isAdmin = req.session.usuario ? req.session.usuario.admin : false;

    Produto.findAll({
        where: {
            indicador_ativo: 1
        }
    }).then((produtos) => {
        res.render('home.html', { produtos, isAdmin });
    }).catch((erro_recupera_produtos) => {
        res.render('home.html', { erro_recupera_produtos, isAdmin });
    });
}

function listarCarrinho(req, res) {
    if (!req.session.usuario) {
        return res.status(403).render("home.html", { erro: "Você precisa estar logado para ver o carrinho." });
    }
    console.log("REQ USUARIO: ", req.session.usuario);
    Produto.findAll({
        where: {
            id_usuario: req.session.usuario.id,
            carrinho: 1,
            indicador_ativo: 1
        }
    }).then((produtosCarrinho) => {
        res.render('carrinho.html', { produtosCarrinho });
    }).catch((erro_recupera_produtos_carrinho) => {
        res.render('carrinho.html', { erro_recupera_produtos_carrinho });
    });
}

function cadastrarProduto(req, res) {
    if (!req.session.usuario || !req.session.usuario.admin) {
        return res.status(403).render("home.html", { erro: "Você não tem permissão para adicionar produtos." });
    }

    let produto = {
        produto: req.body.produto,
        id_usuario: req.session.usuario.id,
        categoria: req.body.categoria,
        quantidade: req.body.quantidade,
        data_vencimento: req.body.data_vencimento,
        indicador_ativo: 1,
        estilo: req.body.estilo
    };

    Produto.create(produto).then(() => {
        res.redirect('/home');
    }).catch((err) => {
        console.log(err);
        let erro_cadastrar_produto = true;
        res.render("home.html", { erro_cadastrar_produto });
    });
}

function editarProduto(req, res) {
    console.log("Editando produto...");
    let idProduto = req.params.id;
    let novosDados = {
        produto: req.body.produto,
        categoria: req.body.categoria,
        quantidade: req.body.quantidade,
        data_vencimento: req.body.data_vencimento,
    };

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
    if (!req.session.usuario || !req.session.usuario.admin) {
        return res.status(403).render("home.html", { erro: "Você não tem permissão para remover produtos." });
    }

    const produtoId = req.params.id;
    Produto.destroy({
        where: {
            id: produtoId
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
    if (!req.session.usuario) {
        return res.status(403).render("home.html", { erro: "Você precisa estar logado para adicionar ao carrinho." });
    }

    const produtoId = req.params.id;
    Produto.update(
        { carrinho: 1, id_usuario: req.session.usuario.id },
        { where: { id: produtoId } }
    ).then(() => {
        res.redirect('/home');
    }).catch((err) => {
        console.log(err);
        res.json({ mensagem: "Erro ao adicionar o produto ao carrinho." });
    });
}

function removerDoCarrinho(req, res) {
    if (!req.session.usuario) {
        return res.status(403).render("home.html", { erro: "Você precisa estar logado para remover do carrinho." });
    }

    const produtoId = req.params.id;
    Produto.update(
        { carrinho: 0 },
        { where: { id: produtoId, id_usuario: req.session.usuario.id } }
    ).then(() => {
        res.redirect('/home');
    }).catch((err) => {
        console.log(err);
        res.json({ mensagem: "Erro ao remover o produto do carrinho." });
    });
}

function finalizarCompra(req, res) {
    if (!req.session.usuario) {
        return res.status(403).render("home.html", { erro: "Você precisa estar logado para finalizar a compra." });
    }

    Produto.update(
        { carrinho: 0 },
        { where: { id_usuario: req.session.usuario.id, carrinho: 1 } }
    ).then(() => {
        res.redirect('/home');
    }).catch((err) => {
        console.log(err);
        res.json({ mensagem: "Erro ao finalizar a compra." });
    });
}

module.exports = {
    indexView,
    listarProdutos,
    listarCarrinho,
    cadastrarProduto,
    editarProduto,
    removerProduto,
    adicionarAoCarrinho,
    removerDoCarrinho,
    finalizarCompra
};