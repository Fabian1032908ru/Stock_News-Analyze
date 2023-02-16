"""
Testing
"""
import sys

from Stock_Class import Stock
from Stock_Class_Bundel import Stock_analyze_bundel
import yfinance as yf
import os
import random

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
        self.__get_data(analyze=True)

    @staticmethod
    def __get_all_ticker():
        """
        Get all the tickers listed in the csv
        """
        ticker_list = []
        with open(f"{parent_dic}/stock_analyze/stock_companies.csv", "r") as csv_ticker:
            csv_lines = csv_ticker.readlines()

        for line in csv_lines:
            ticker_list.append(line.split(","))

        return ticker_list

    def __get_data(self, analyze=False):
        """
        Get all the data from all stocks it is possible for
        :return:
        """
        for index, ticker in enumerate(self.__ticker_list):
            print(ticker[0])
            data = yf.download(ticker[0], '1970-01-01', '2023-12-31')
            data = data.reset_index()  # len data will be 0 if there is no available data
            if analyze:
                if len(data) > 500:
                    self.__analyze_data(data, ticker)
                else:
                    print("Not possible to analyze!!!")

    def __analyze_data(self, yfin_data, ticker):

        res = []

        for step in range(len(yfin_data)):
            date = str(yfin_data["Date"][step])[:10]
            res.append([date, float(yfin_data["Adj Close"][step])])

        test1 = Stock(ticker)
        final_val = test1.get_closing_courses_if_yahoo(res)
        final_val = test1.convert_str_to_int(final_val)
        final_val = final_val[::-1]
        first_year = test1.get_first_year(final_val)
        result = test1.analyse_data_day_comparison(final_val, first_year, call_chance=0.8)

        self.__write_analyze_csv(result, ticker, first_year)

    @staticmethod
    def __write_analyze_csv(result, ticker, first_year):

        f = open(f"yfinance_ticker/{ticker[1]}_analyze.csv", "w+")
        f.write(f"Ticker Symbol: {ticker[0]}\n")
        f.write(f"Name: {ticker[1]}\n")
        # f.write(f"Last Sale: {ticker[2]}\n")
        # f.write(f"% Change: {ticker[3]}\n")
        f.write(f"Market Cap: {ticker[5]}\n")
        f.write(f"Country: {ticker[6]}\n")
        f.write(f"IPO Year: {ticker[7]}\n")
        f.write(f"Volume: {ticker[8]}\n")
        f.write(f"Sector: {ticker[9]}\n")
        f.write(f"Industry: {ticker[10]}\n")
        f.write(f"First year of data: {first_year}\n")
        f.write("Chance;Buy_Day;Buy_Month;Sell_Day;Sell_Month\n")
        for stock_result in result:
            f.write(f'''{stock_result[0]};{stock_result[1]["day"]};{stock_result[1]["month"]};{stock_result[2]["day"]};{stock_result[2]["month"]}\n''')
        f.close()


class Bundle:
    """
    Only analyze the stocks in the csv folder
    """
    def __init__(self):
        self.__analyze()

    @staticmethod
    def __analyze():
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
