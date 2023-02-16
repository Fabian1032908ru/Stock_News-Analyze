"""
Testing
"""
import sys

from Stock_Class import Stock
from Stock_Class_Bundel import Stock_analyze_bundel
import yfinance as yf
import os

# get current directory
path = os.getcwd()
# prints parent directory
parent_dic = os.path.abspath(os.path.join(path, os.pardir))


class Ticker:
    """
    Analyze all stocks in the stock_companies csv by the ticker and yfinance
    """
    def __init__(self):
        self.__ticker_list = self.__get_all_ticker()

    def __get_all_ticker(self):
        """
        Get all the tickers listed in the csv
        """
        ticker_list = []
        with open(f"{parent_dic}/stock_analyze/stock_companies.csv", "r") as csv_ticker:
            csv_lines = csv_ticker.readlines()

        for line in csv_lines:
            ticker_list.append(line.split(",")[0])

        return ticker_list


class Bundle:
    """
    Only analyze the stocks in the csv folder
    """
    def __init__(self):
        self.__analyze()

    def __analyze(self):
        dax = Stock_analyze_bundel(index_name="Dax")
        dax_stocks = dax.read_all_csv_from_folder(f"{parent_dic}/csv")
        dax.append_stocks(dax_stocks)
        print(dax.return_stocks())
        dax_stocks_list = []
        dax_stocks_list_results = []

        for stock_val in dax_stocks:
            # Calculating minus 4 to remove txt suffix
            dax_stocks_list.append(Stock(stock=stock_val[0:len(stock_val) - 4]))

        for index, stocks in enumerate(dax_stocks_list):
            ger_or_us = stocks.check_csv_format(f"{parent_dic}/csv/" +
                                                dax_stocks[index])
            values = stocks.read_csv(f"{parent_dic}/csv/" + dax_stocks[index])
            print(sys.getsizeof(values), "Size of current Stock, named:")
            print(f"NO {index}")

            if ger_or_us:
                final_val = stocks.get_closing_courses_if_us(values)
            else:
                final_val = stocks.get_closing_courses(values)
            final_val = stocks.replace_comma_dot(final_val)
            first_year = stocks.get_first_year(final_val)
            final_val = stocks.convert_str_to_int(final_val)
            dax_stocks_list_results.append(
                stocks.analyse_data_day_comparison(final_val, first_year))

        f = open("Stock Analyze Data.txt", "w+")
        for index, result in enumerate(dax_stocks_list_results):
            f.write("\n\n")
            f.write(f"Folgend die Daten der {dax_stocks_list[index].name}")
            for index2, stock_result in enumerate(result):
                f.write(f"{index2}: {stock_result}\n")
                if index2 > 50:
                    break
        f.close()

        """
        adidas = Stock()
        adidas.edit_name("Apple")
        print(adidas)

        values = adidas.read_csv(f'{parent_dic}/csv/Apple_Nasdaq.txt')
        final_val = adidas.get_closing_courses_if_us(values)
        final_val = adidas.replace_comma_dot(final_val)
        first_year = adidas.get_first_year(final_val)
        final_val = adidas.convert_str_to_int(final_val)

        daily_average = adidas.get_daily_average_over_years(final_val, first_year)

        adidas.draw_daily_average_over_year(daily_average)

        """


if __name__ == '__main__':
    t = Ticker()