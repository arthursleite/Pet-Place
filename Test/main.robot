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

*** Test Cases ***
Login with valid credentials
    ${valid_email}=  Generate Random Email
    ${strong_password}=  Generate Random Strong Password
    Go To    ${BASE_URL}
    Input Text  id=email_login  ${valid_email}
    Input Text  id=senha_login  ${strong_password}
    Click Button  id=botao-acessar
    # Add assertions to validate successful login

Login with invalid credentials
    ${invalid_email}=  Generate Random Invalid Email
    ${weak_password}=  Generate Random Weak Password
    Go To    ${BASE_URL}
    Input Text  id=email_login  ${invalid_email}
    Input Text  id=senha_login  ${weak_password}
    Click Button  id=botao-acessar
    # Add assertions to validate login failure

Login with empty credentials
    Go To    ${BASE_URL}
    Click Button  id=botao-acessar
    # Add assertions to validate login failure due to empty fields

Register with valid credentials
    ${valid_email}=  Generate Random Email
    ${strong_password}=  Generate Random Strong Password
    ${valid_birthdate}=  Generate Random Birthdate
    Go To    ${BASE_URL}
    Input Text  id=email_cadastro  ${valid_email}
    Input Text  id=senha_cadastro  ${strong_password}
    Input Text  id=nome_cadastro  José Augusto Testeson
    Input Text  id=data_nascimento  ${valid_birthdate}
    Select From List By Label    id=admin    Administrador
    Click Button  id=botao-cadastrar
    # Add assertions to validate successful registration

Register with existing email
    ${existing_email}=  Generate Random Email
    ${strong_password}=  Generate Random Strong Password
    ${valid_birthdate}=  Generate Random Birthdate
    # Assuming we register the email first
    Register User  ${existing_email}  ${strong_password}  ${valid_birthdate}
    Go To    ${BASE_URL}
    Input Text  id=email_cadastro  ${existing_email}
    Input Text  id=senha_cadastro  ${strong_password}
    Input Text  id=nome_cadastro  José Augusto Testeson
    Input Text  id=data_nascimento  ${valid_birthdate}
    Select From List By Label    id=admin    Administrador
    Click Button  id=botao-cadastrar
    # Add assertions to validate registration failure due to existing email

*** Keywords ***
Register User
    [Arguments]  ${email}  ${password}  ${birthdate}
    Go To    ${BASE_URL}
    Input Text  id=email_cadastro  ${email}
    Input Text  id=senha_cadastro  ${password}
    Input Text  id=nome_cadastro  José Augusto Testeson
    Input Text  id=data_nascimento  ${birthdate}
    Select From List By Label    id=admin    Administrador
    Click Button  id=botao-cadastrar
    # Add assertions to validate successful registration
