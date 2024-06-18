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
    categories = ["Alimentação", "Brinquedos", "Acessórios", "Cuidado Pessoal", "Saúde"]
    products = {
        "Alimentação": ["Ração Royal Canin para Cães", "Purina Pro Plan para Gatos", "Alimento Natural para Pássaros"],
        "Brinquedos": ["Jogue e Caça de Bolinhas", "Rato de Pelúcia", "Túnel de Exercício"],
        "Acessórios": ["Collar Elétrico para Treinamento", "Ramalhete de Caminhada", "Cama para Cães"],
        "Cuidado Pessoal": ["Shampoo para Cães", "Tosa de Unhas para Gatos", "Corte de Pé para Cães"],
        "Saúde": ["Desparasitante para Cães", "Vacina para Gatos", "Suplemento Vitamínico para Pássaros"],
    }
    category = random.choice(categories)
    product = random.choice(products[category])
    price = round(random.uniform(10.00, 100.00), 2)
    return {"name": product, "price": price, "category": category}