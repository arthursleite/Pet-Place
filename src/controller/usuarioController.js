const Usuario = require('../model/usuario');

function cadastrarUsuario(req, res) {
    let usuario = {
        email: req.body.email,
        senha: req.body.senha,
        nome: req.body.nome,
        data_nascimento: req.body.data_nascimento
    }
    
    Usuario.create(usuario).then(()=>{
        let sucesso = true;
        res.render("index.html", {sucesso});
    }).catch((err)=>{
        console.log(err);
        let erro = true;
        res.render("index.html", {erro});
    });

}

function listarUsuarios(req, res) {
    Usuario.findAll().then((usuarios)=>{
        res.json(usuarios);
    }).catch((err)=>{
        res.json(err);
    });
}

function atualizarUsuario(req, res) {
    console.log("Atualizando usuário...")
    let idUsuario = req.params.id;
    let novosDados = {
        email: req.params.email,
        senha: req.params.senha,
        nome: req.params.nome,
        data_nascimento: req.params.data_nascimento
    }

    Usuario.update(novosDados, { where: { id: idUsuario } })
        .then(() => {
            res.json({ mensagem: "Usuário atualizado com sucesso!" });
        })
        .catch((err) => {
            console.log(err);
            res.json({ mensagem: "Erro ao atualizar o usuário." });
        });
}


module.exports = {
    cadastrarUsuario,
    listarUsuarios,
    atualizarUsuario
}