# utils.py
import random
import string

def generate_random_email(domain="example.com"):
    chars = string.ascii_lowercase + string.digits
    random_email = ''.join(random.choice(chars) for _ in range(10)) + "@" + domain
    return random_email

def generate_random_invalid_email(domain="invalid-domain.com"):
    chars = string.ascii_uppercase + string.digits
    random_email = ''.join(random.choice(chars) for _ in range(10)) + "@" + domain
    return random_email

def generate_random_weak_password(length=8):
    chars = string.ascii_letters + string.digits
    random_password = ''.join(random.choice(chars) for _ in range(length))
    return random_password

def generate_random_strong_password(length=12):
    chars = string.ascii_letters + string.digits + string.punctuation
    random_password = ''.join(random.choice(chars) for _ in range(length))
    return random_password

def generate_random_very_strong_password(length=16):
    chars = string.ascii_letters + string.digits + string.punctuation
    random_password = ''.join(random.choice(chars) for _ in range(length))
    return random_password

def generate_random_birthdate():
    day = str(random.randint(1, 28)).zfill(2)
    month = str(random.randint(1, 12)).zfill(2)
    year = str(random.randint(1900, 2022))
    return f"{day}-{month}-{year}"

def generate_random_product():
    categories = ["Alimentos", "Brinquedos", "Medicamentos", "Acessórios", "Higiene", "Roupas", "Camas e Casinhas", "Coleiras e Guias", "Caixas de Transporte", "Produtos para Treinamento", "Outros"]
    products = {
    "Alimentos": ["Ração Royal Canin para Cães", "Purina Pro Plan para Gatos", "Alimento Natural para Pássaros", "Alimento para Peixes", "Biscoitos para Cães", "Snacks para Gatos"],
    "Brinquedos": ["Jogue e Caça de Bolinhas", "Rato de Pelúcia", "Túnel de Exercício", "Pilha de Bolas", "Hamaca para Gatos"],
    "Medicamentos": ["Desparasitante para Cães", "Vacina para Gatos", "Suplemento Vitamínico para Pássaros", "Remédio para Pulgas", "Remédio para Vermes"],
    "Acessórios": ["Collar Elétrico para Treinamento", "Ramalhete de Caminhada", "Cama para Cães", "Correia para Cães", "Coleira para Cães"],
    "Higiene": ["Shampoo para Cães", "Tosa de Unhas para Gatos", "Corte de Pé para Cães", "Pasta de Dentes para Cães", "Desodorante para Cães"],
    "Roupas": ["Casaco para Cães", "Gorro para Cães", "Raincoat para Cães", "Calça para Cães", "Camiseta para Cães"],
    "Camas e Casinhas": ["Cama para Gatos", "Casa para Cães", "Cama para Pássaros", "Cama para Roedores", "Cama para Répteis"],
    "Coleiras e Guias": ["Coleira para Gatos", "Guia para Cães", "Guia para Gatos", "Coleira para Cães de Treinamento", "Coleira para Cães de Exposição"],
    "Caixas de Transporte": ["Caixa de Transporte para Cães", "Caixa de Transporte para Gatos", "Caixa de Transporte para Pássaros", "Caixa de Transporte para Roedores", "Caixa de Transporte para Répteis"],
    "Produtos para Treinamento": ["Bola de Treinamento para Cães", "Tubo de Treinamento para Cães", "Clicker para Treinamento", "Corrente para Treinamento", "Jogo de Comando para Cães"],
    "Outros": ["Produto de Limpeza", "Litros de Água", "Ração para Aves", "Cama para Répteis", "Brinquedo para Roedores"]
}
    category = random.choice(categories)
    product = random.choice(products[category])
    price = round(random.uniform(10.00, 100.00), 2)
    return {"name": product, "price": price, "category": category}