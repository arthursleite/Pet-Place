*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  /Users/jao/Developer/Pet-Place/Test/Utils.py  WITH NAME  Utils
Suite Setup  Open Browser  ${BASE_URL}  Chrome
Suite Teardown  Close Browser

*** Variables ***
${BASE_URL}  http://localhost:8080

*** Keywords ***
Gerar Email Aleatório
    ${email}=  Evaluate  Utils.generate_random_email()  modules=Utils
    [Return]  ${email}

Gerar Email Inválido
    ${email}=  Evaluate  Utils.generate_random_invalid_email()  modules=Utils
    [Return]  ${email}

Gerar Senha Fraca
    ${password}=  Evaluate  Utils.generate_random_weak_password()  modules=Utils
    [Return]  ${password}

Gerar Senha Forte
    ${password}=  Evaluate  Utils.generate_random_strong_password()  modules=Utils
    [Return]  ${password}

Gerar Senha Muito Forte
    ${password}=  Evaluate  Utils.generate_random_very_strong_password()  modules=Utils
    [Return]  ${password}

Gerar Data de Nascimento
    ${birthdate}=  Evaluate  Utils.generate_random_birthdate()  modules=Utils
    [Return]  ${birthdate}

Cadastrar Usuário
    [Arguments]  ${email}  ${password}  ${birthdate}
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_cadastro  ${email}
    Sleep  1s
    Input Text  id=senha_cadastro  ${password}
    Sleep  1s
    Input Text  id=nome_cadastro  José Augusto Testeson
    Sleep  1s
    Input Text  id=data_nascimento  ${birthdate}
    Sleep  1s
    Select From List By Label    id=admin    Administrador
    Sleep  1s
    Click Button  id=botao-cadastrar
    Sleep  2s
    # Add assertions to validate successful registration
*** Test Cases ***

#LogIn Test Cases 
Login com credenciais válidas de Administrador
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_login  contato@jaolima.com
    Sleep  1s
    Input Text  id=senha_login  Senha@teste321456
    Sleep  1s
    Click Button  id=botao-acessar
    Sleep  2s
    Element Should Be Visible  id=sobre-nos 

Login com credenciais válidas de Usuário
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_login  teste03@email.com
    Sleep  1s
    Input Text  id=senha_login  Senha@teste321456
    Sleep  1s
    Click Button  id=botao-acessar
    Sleep  2s
    Element Should Be Visible  id=sobre-nos 

Login com credenciais não registradas
    ${invalid_email}=  Gerar Email Inválido
    ${weak_password}=  Gerar Senha Fraca
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_login  ${invalid_email}
    Sleep  1s
    Input Text  id=senha_login  ${weak_password}
    Sleep  1s
    Click Button  id=botao-acessar
    Sleep  2s
    Element Should Not Be Visible  id=sobre-nos
    Element Should Contain  css=.alert-danger  Erro ao autenticar usuário!
                
Login com credenciais vazias
    Go To    ${BASE_URL}
    Sleep  1s
    Click Button  id=botao-acessar
    Sleep  2s
    Element Should Not Be Visible  id=sobre-nos
    Element Should Contain  css=.alert-danger  Erro ao autenticar usuário!


Cadastrar Administrador com credenciais válidas
    ${valid_email}=  Generate Random Email
    ${strong_password}=  Generate Random Strong Password
    ${valid_birthdate}=  Generate Random Birthdate
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_cadastro  ${valid_email}
    Sleep  1s
    Input Text  id=senha_cadastro  ${strong_password}
    Sleep  1s
    Input Text  id=nome_cadastro  José Augusto Testeson
    Sleep  1s
    Input Text  id=data_nascimento  ${valid_birthdate}
    Sleep  1s
    Select From List By Label    id=admin    Administrador
    Sleep  1s
    Click Button  id=botao-cadastrar
    Sleep  2s
    Element Should Contain  css=.alert.alert-success  Usuário cadastrado com sucesso!
 
Cadastrar Usuário com credenciais válidas
    ${valid_email}=  Gerar Email Aleatório
    ${strong_password}=  Gerar Senha Forte
    ${valid_birthdate}=  Gerar Data de Nascimento
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_cadastro  ${valid_email}
    Sleep  1s
    Input Text  id=senha_cadastro  ${strong_password}
    Sleep  1s
    Input Text  id=nome_cadastro  José Augusto Testeson
    Sleep  1s
    Input Text  id=data_nascimento  ${valid_birthdate}
    Sleep  1s
    Select From List By Label    id=admin    Usuário
    Sleep  1s
    Click Button  id=botao-cadastrar
    Sleep  2s
    Element Should Contain  css=.alert.alert-success  Usuário cadastrado com sucesso!

Cadastrar com email existente
    ${strong_password}=  Gerar Senha Forte
    ${valid_birthdate}=  Gerar Data de Nascimento
    Cadastrar Usuário    teste01@email.com  ${strong_password}  ${valid_birthdate}
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_cadastro  teste01@email.com
    Sleep  1s
    Input Text  id=senha_cadastro  ${strong_password}
    Sleep  1s
    Input Text  id=nome_cadastro  José Augusto Testeson
    Sleep  1s
    Input Text  id=data_nascimento  ${valid_birthdate}
    Sleep  1s
    Select From List By Label    id=admin    Administrador
    Sleep  1s
    Click Button  id=botao-cadastrar
    Sleep  2s
    Element Should Contain  css=.alert-danger  Erro ao cadastrar usuário!

#Homepage Test Cases
Adicionar Produto à página de produtos
    ${product}=  Evaluate  Utils.generate_random_product()  modules=Utils
    ${product_name}=  Set Variable  ${product["name"]}
    ${product_price}=  Set Variable  ${product["price"]}
    ${product_category}=  Set Variable  ${product["category"]}
    Go To    ${BASE_URL}
    Input Text  id=email_login  contato@jaolima.com
    Input Text  id=senha_login  Senha@teste321456
    Click Button  id=botao-acessar
    Element Should Be Visible  id=sobre-nos 
    Sleep  1s
    Scroll Element Into View  id=botao_adicionar
    Sleep    1s
    Input Text    id=produto    ${product_name}
    Sleep  1s
    Input Text    id=categoria    R$ ${product_price}
    Sleep  1s
    Select From List By Label   id=estilo    ${product_category}    
    Sleep  2s
    Click Button    id=botao_adicionar


Adicionar Produto ao Carrinho
    Go To    ${BASE_URL}
    Input Text  id=email_login  contato@jaolima.com
    Input Text  id=senha_login  Senha@teste321456
    Click Button  id=botao-acessar
    Element Should Be Visible  id=sobre-nos 
    Sleep  1s
    Scroll Element Into View  //a[@href='/carrinho'][contains(.,'Ver Carrinho')]
    Sleep  2s
    Click Button    (//button[@type='submit'][contains(@id,'carrinho')][contains(.,'Adicionar ao Carrinho')])[14] 
    Sleep    1s
    Scroll Element Into View  //a[@href='/carrinho'][contains(.,'Ver Carrinho')]
    Sleep    1s
    Click Element  //a[@href='/carrinho'][contains(.,'Ver Carrinho')]
    Sleep    1s    
    Element Should Be Visible     botao_remover_do_carrinho

Finalizar Compra do Carrinho
    Go To    ${BASE_URL}
    Input Text  id=email_login  contato@jaolima.com
    Input Text  id=senha_login  Senha@teste321456
    Click Button  id=botao-acessar
    Element Should Be Visible  id=sobre-nos 
    Sleep  1s
    Scroll Element Into View  //a[@href='/carrinho'][contains(.,'Ver Carrinho')]
    Sleep  1s
    Click Button    //a[@href='/carrinho'][contains(.,'Ver Carrinho')] 
    Sleep    1s
    Click Element  botao_finalizar_compra
    Sleep    1s    
    Element Should Be Visible  id=sobre-nos 
