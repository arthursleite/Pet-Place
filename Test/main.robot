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

#LogIn Test Cases 
Login with valid Admin credentials
    Go To    ${BASE_URL}
    Sleep  1s
    Input Text  id=email_login  contato@jaolima.com
    Sleep  1s
    Input Text  id=senha_login  Senha@teste321456
    Sleep  1s
    Click Button  id=botao-acessar
    Sleep  2s
    Element Should Be Visible  id=sobre-nos 

Login with valid User credentials
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

#Homepage Test Cases
# Add a Product to product page
#     ${product}=  Evaluate  Utils.generate_random_product()  modules=Utils
#     ${product_name}=  Set Variable  ${product["name"]}
#     ${product_price}=  Set Variable  ${product["price"]}
#     ${product_category}=  Set Variable  ${product["category"]}
#     Go To    ${BASE_URL}
#     Input Text  id=email_login  contato@jaolima.com
#     Input Text  id=senha_login  Senha@teste321456
#     Click Button  id=botao-acessar
#     Element Should Be Visible  id=sobre-nos 
#     Sleep    2s
#     Input Text    id=produto    ${product_name}
#     Input Text    id=preco    ${product_price}
#     Input Text    id=categoria    ${product_category}    
#     Sleep  2s
#     Click Button    id=botao_adicionar

# Add product to Cart 
#     Go To    ${BASE_URL}
#     Input Text  id=email_login  contato@jaolima.com
#     Input Text  id=senha_login  Senha@teste321456
#     Click Button  id=botao-acessar
#     Element Should Be Visible  id=sobre-nos 
#     Sleep    2s
#     # Go to Product Page
#     Click Link  text=Lista de Produtos
#     # Wait for the page to load
#     Sleep  2s
#     # Add a product to the Cart
#     Click Button  id=Adicionar-ao-carrinho-1
#     # Verify that the product is in the Cart
#     # Wait for the page to load
#     Element Should Be Visible  xpath=//span[contains(text(), '1')]

# Add multiple products to Cart

# Shop Cart