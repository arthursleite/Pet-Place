const Usuario = require('../model/usuario');

function cadastrarUsuario(req, res) {
    let usuario = {
        email: req.body.email,
        senha: req.body.senha,
        nome: req.body.nome,
        data_nascimento: req.body.data_nascimento,
        admin: req.body.admin === '1' // Converte o valor para booleano
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

function configView(req, res){
        res.render('configuracao.html');
    
}


function atualizarUsuario(req, res) {
    let usuario = {
        email: req.body.email,
        senha: req.body.senha,
        nome: req.body.nome,
        data_nascimento: req.body.data_nascimento,
    }
    Usuario.update(
      usuario,
      {
        where: {
          id: req.body.id,
        },
      }
    ).then(function (sucesso) {
        console.log(JSON.stringify(usuario));
        res.json({ mensagem: "Usuário atualizado com sucesso!" });
    })
    .catch(function (erro) {
        res.json({ mensagem: `Erro ao atualizar o usuário. ${erro}` });
    });

}

function testePost(req, res) {
    console.log("Teste post");
    console.log(req.body);
    res.json({ mensagem: "Teste post" });
}


module.exports = {
    cadastrarUsuario,
    listarUsuarios,
    configView,
    atualizarUsuario,
    testePost
}