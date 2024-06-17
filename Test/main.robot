*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  /Users/jao/Developer/Pet-Place/Test/Utils.py  WITH NAME  Utils
Suite Setup  Open Browser  ${BASE_URL}  Chrome
Suite Teardown  Close Browser

*** Variables ***
${BASE_URL}  http://localhost:8080

*** Keywords ***
Generate Random Email
    ${email}=  Evaluate  Utils.generate_random_email()  modules=Utils
    [Return]  ${email}

Generate Random Invalid Email
    ${email}=  Evaluate  Utils.generate_random_invalid_email()  modules=Utils
    [Return]  ${email}

Generate Random Weak Password
    ${password}=  Evaluate  Utils.generate_random_weak_password()  modules=Utils
    [Return]  ${password}

Generate Random Strong Password
    ${password}=  Evaluate  Utils.generate_random_strong_password()  modules=Utils
    [Return]  ${password}

Generate Random Very Strong Password
    ${password}=  Evaluate  Utils.generate_random_very_strong_password()  modules=Utils
    [Return]  ${password}

Generate Random Birthdate
    ${birthdate}=  Evaluate  Utils.generate_random_birthdate()  modules=Utils
    [Return]  ${birthdate}

Register User
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
Login with valid Admin credentials
    ${valid_email}=  Generate Random Email
    ${strong_password}=  Generate Random Strong Password
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_login  teste01@email.com
    Sleep  1s
    Input Text  id=senha_login  Senha@teste321456
    Sleep  1s
    Click Button  id=botao-acessar
    Sleep  2s
    Element Should Be Visible  id=sobre-nos 

Login with valid User credentials
    ${valid_email}=  Generate Random Email
    ${strong_password}=  Generate Random Strong Password
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_login  teste03@email.com
    Sleep  1s
    Input Text  id=senha_login  Senha@teste321456
    Sleep  1s
    Click Button  id=botao-acessar
    Sleep  2s
    Element Should Be Visible  id=sobre-nos 

Login with unregisterd credentials
    ${invalid_email}=  Generate Random Invalid Email
    ${weak_password}=  Generate Random Weak Password
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
                
Login with empty credentials
    Go To    ${BASE_URL}
    Sleep  1s
    Click Button  id=botao-acessar
    Sleep  2s
    Element Should Not Be Visible  id=sobre-nos
    Element Should Contain  css=.alert-danger  Erro ao autenticar usuário!

Register Admin with valid credentials
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

Register User with valid credentials
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
    Select From List By Label    id=admin    Usuário
    Sleep  1s
    Click Button  id=botao-cadastrar
    Sleep  2s
      Element Should Contain  css=.alert.alert-success  Usuário cadastrado com sucesso!
      
Register with existing email
    ${strong_password}=  Generate Random Strong Password
    ${valid_birthdate}=  Generate Random Birthdate
    # Assuming we register the email first
    Register User    teste01@email.com  ${strong_password}  ${valid_birthdate}
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



