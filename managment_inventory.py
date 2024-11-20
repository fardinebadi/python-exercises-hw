import logging
from prettytable import prettytable, PrettyTable

logging.basicConfig(filename='logs.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


class Item:
    def __init__(self, ids, name, quantity, price):
        self.ids = ids
        self.name = name
        self.quantity = quantity
        self.price = price
        self.items = []

    def check(self, amount):
        if amount <= 0:
            logging.warning('sorry amount lass the zero')
        else:
            return True

    def add_new_item(self, item):
        self.items.append(item)
        logging.info(f"update add new items: {item}")
        return self.get_item_information()

    def generation_reports(self):
        table = PrettyTable()
        table.field_names = ['id', 'name', 'quantity', 'price']
        for item in self.items:
            table.add_row([item.ids, item.name, item.quantity, item.price])
        return table

    def update_stock(self, amount):
        self.check(amount)
        self.quantity += amount
        if amount == "-":
            self.quantity -= amount
            return logging.INFO(f'new update quantity:{self.quantity}')
        logging.info(f'new update quantity:{self.quantity}')
        return self.quantity

    def get_item_information(self):
        return {
            "ids": self.ids,
            "name": self.name,
            "quantity": self.quantity,
            "price": self.price
        }


class PhysicalItem(Item):
    def __init__(self, ids, name, quantity, price, weight, dimensions):
        super().__init__(ids=ids, name=name, quantity=quantity, price=price)
        self.weight = weight
        self.dimensions = dimensions
        self.items = []

    def update_stock(self, amount):
        info = super().update_stock(amount)
        return info

    def get_item_information(self):
        info = super().get_item_information()
        return f'{info},weight:{self.weight},dimensions:{self.dimensions}'


class DigitalItem(Item):
    def __init__(self, ids, name, quantity, price, file_size, download_link):
        super().__init__(ids=ids, name=name, quantity=quantity, price=price)
        self.file_size = file_size
        self.download_link = download_link


    def update_stock(self, amount):
        info = super().update_stock(amount)
        return info

    def get_item_information(self):
        info = super().get_item_information()
        return f'{info},file_size:{self.file_size}MB ,download_link:{self.download_link}'
