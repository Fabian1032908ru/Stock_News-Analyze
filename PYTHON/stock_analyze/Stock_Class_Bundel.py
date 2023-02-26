"""
Bundeling all Files from one folder to analyze them all together
"""

import os
from typing import List, Type


# from Stock_Class import Stock


class Stock_analyze_bundel():

    def __init__(self, index_name="Index... name missing", list_stocks=None):
        self.index_name = index_name
        self.list_stocks = list_stocks

    def read_all_csv_from_folder(self, dic: str) -> list[str]:
        res = []
        for path in os.listdir(dic):
            if os.path.isfile(os.path.join(dic, path)):
                if path.endswith(".txt"):
                    res.append(path)

        return res

    def append_stocks(self, stocks: List):
        if type(stocks) != list:
            raise ValueError("Wrong data has been passed, please pass a list")

        if self.list_stocks is None:
            self.list_stocks = stocks
        else:
            self.list_stocks += stocks

    def return_stocks(self):
        return self.list_stocks

    def retrun_one_stock(self, index: int) -> classmethod or None:
        try:
            return self.list_stocks[index]
        except IndexError:
            return None
