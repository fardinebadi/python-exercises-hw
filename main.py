import psycopg2
import logging

logging.basicConfig(filename='inventory.log', level=logging.INFO, format='%(asctime)s - %(message)s')



def get_connection():
    return psycopg2.connect(
        dbname="fardin", user="psqll", password="fardin", host="localhost"
    )



class Item:
    def __init__(self, id, name, quantity, price):
        self.id = id
        self.name = name
        self.quantity = quantity
        self.price = price

    def update_stock(self, quantity):
        self.quantity += quantity
        logging.info(f"Stock updated for {self.name}. New quantity: {self.quantity}")

    def get_info(self):
        return f"ID: {self.id}, Name: {self.name}, Quantity: {self.quantity}, Price: {self.price}"


class PhysicalItem(Item):
    def __init__(self, id, name, quantity, price, weight, dimensions):
        super().__init__(id, name, quantity, price)
        self.weight = weight
        self.dimensions = dimensions

    def get_info(self):
        return super().get_info() + f", Weight: {self.weight}, Dimensions: {self.dimensions}"


class DigitalItem(Item):
    def __init__(self, id, name, quantity, price, file_size, download_link):
        super().__init__(id, name, quantity, price)
        self.file_size = file_size
        self.download_link = download_link

    def get_info(self):
        return super().get_info() + f", File Size: {self.file_size}MB, Download Link: {self.download_link}"


def create_table():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS inventory (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100),
            quantity INT,
            price FLOAT,
            type VARCHAR(50),
            weight FLOAT,
            dimensions VARCHAR(50),
            file_size FLOAT,
            download_link VARCHAR(255)
        );
    """)
    conn.commit()
    cursor.close()
    conn.close()


def insert_item(item):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO inventory (name, quantity, price, type, weight, dimensions, file_size, download_link)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
    """, (
        item.name, item.quantity, item.price,
        'PhysicalItem' if isinstance(item, PhysicalItem) else 'DigitalItem',
        getattr(item, 'weight', None), getattr(item, 'dimensions', None),
        getattr(item, 'file_size', None), getattr(item, 'download_link', None)
    ))
    conn.commit()
    cursor.close()
    conn.close()


def update_stock_in_db(item_id, quantity):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE inventory
        SET quantity = quantity + %s
        WHERE id = %s;
    """, (quantity, item_id))
    conn.commit()
    cursor.close()
    conn.close()


def get_all_items():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM inventory;")
    items = cursor.fetchall()
    cursor.close()
    conn.close()
    return items


def find_low_stock(threshold):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM inventory WHERE quantity < %s;", (threshold,))
    items = cursor.fetchall()
    cursor.close()
    conn.close()
    return items


def get_total_value():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT SUM(price * quantity) FROM inventory;")
    total_value = cursor.fetchone()[0]
    cursor.close()
    conn.close()
    return total_value

create_table()
item1 = PhysicalItem(1, 'Laptop', 50, 1000.00, 2.5, '35x25x2 cm')
item2 = DigitalItem(2, 'E-book', 100, 15.00, 10.0, 'https://example.com/book')

insert_item(item1)
insert_item(item2)

item1.update_stock(10)
update_stock_in_db(1, 10)  # Increase stock for item with ID 1 by 10
items = get_all_items()
print(items)

low_stock_items = find_low_stock(10)
print(low_stock_items)
total_value = get_total_value()
print(f"Total Inventory Value: {total_value}")
