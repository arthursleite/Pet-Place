const Produto = require('../model/produto');

function indexView(req, res) {
    res.render('index.html');
}



function homeView(req, res) {

    Produto.findAll({
        where: {
            id_usuario: req.session.usuario.id,
            indicador_ativo: 1
        }
    }).then((produtos) => {
        res.render('home.html', { produtos });
    }).catch((erro_recupera_produtos) => {
        res.render('home.html', { erro_recupera_produtos });
    });

}

function cadastrarProduto(req, res) {
    let produto = {
        produto: req.body.produto,
        id_usuario: req.session.usuario.id,
        categoria: req.body.categoria,
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

function removerProduto(req, res) {
    const produtoId = req.params.id; // Assuming you pass the annotation ID as a route parameter
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

module.exports = {
    indexView,
    homeView,
    cadastrarProduto,
    removerProduto
}