"""
Testing
"""
import datetime
import random
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
        random.shuffle(self.__ticker_list)
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
            try:
                # data = yf.download(ticker[0], '1970-01-01', '2023-12-31')
                data = yf.download("AAPL", '1970-01-01', '2023-12-31')
            except KeyError:
                print("Not Stock found on yfinance")
            data = data.reset_index()  # len data will be 0 if there is no available data
            if index > 50:
                exit()
            if analyze:
                if len(data) > 500:
                    self.__analyze_data(data, ticker)
                else:
                    print("Not possible to analyze!!!")

    def __analyze_data(self, yfin_data, ticker):
        """
        Get the data, convert them into the format we need and then analyze them
        :param yfin_data: data from yahoo finance
        :param ticker: ticker line of nasdaq list
        :return: calls write analyze to csv file
        """
        print(yfin_data)
        res = []
        for step in range(len(yfin_data)):
            date = str(yfin_data["Date"][step])[:10]
            res.append([date, float(yfin_data["Close"][step])])

        test1 = Stock(ticker)
        final_val = test1.get_closing_courses_if_yahoo(res)
        final_val = test1.convert_str_to_int(final_val)
        final_val = final_val[::-1]
        first_year = test1.get_first_year(final_val)
        chances = self.__calculate_chances(first_year)
        if first_year < 2015:
            call_chance, put_chance = chances[0], chances[1]
            result = test1.analyse_data_day_comparison(final_val, first_year,
                                                       call_chance=call_chance,
                                                       put_chance=put_chance)

            self.__write_analyze_csv(result, ticker, first_year, yfin_data)
            self.__write_analyze_csv_buy_day_based(result, ticker, first_year)

    @staticmethod
    def __write_analyze_csv_buy_day_based(result, ticker, first_year):
        """
        As Add on writing the values in csv files, based on their buy date
        :param result: result values
        :param ticker: ticker symbol to identify the company
        :param first_year: ipo year
        :return:
        """
        for res in result:
            month = res[0][2]["month"]
            day = res[0][2]["day"]
            filename = f"yfinance_ticker/Buy_dates/{day}_{month}.csv"
            file_exist = os.path.isfile(filename)
            if file_exist:
                f = open(filename, "a")
                f.write(f"Chance: {res[0][0]};")
                f.write(f"Profit: {res[0][1]};")
                f.write(f"Ticker Symbol: {ticker[0]};")
                f.write(f"Name: {ticker[1]};")
                f.write(f"Market Cap: {ticker[5]};")
                f.write(f"Country: {ticker[6]};")
                f.write(f"IPO Year: {ticker[7]};")
                f.write(f"Volume: {ticker[8]};")
                f.write(f"Sector: {ticker[9]};")
                f.write(f"Industry: {ticker[10]}")
            else:
                f = open(filename, "w")
                f.write(f"Chance: {res[0][0]};")
                f.write(f"Profit: {res[0][1]};")
                f.write(f"Ticker Symbol: {ticker[0]};")
                f.write(f"Name: {ticker[1]};")
                f.write(f"Market Cap: {ticker[5]};")
                f.write(f"Country: {ticker[6]};")
                f.write(f"IPO Year: {ticker[7]};")
                f.write(f"Volume: {ticker[8]};")
                f.write(f"Sector: {ticker[9]};")
                f.write(f"Industry: {ticker[10]}")

            f.close()

        exit()

    @staticmethod
    def __write_analyze_csv(result, ticker, first_year, yfin_data):
        """
        Writes the data in to a csv file
        :param result:
        :param ticker:
        :param first_year:
        :return:
        """

        if len(ticker[1]) > 15:
            csv_name = ticker[1][:15]
        else:
            csv_name = ticker[1]
        f = open(f"yfinance_ticker/Companies_analyze/{csv_name}_analyze.csv", "w+")
        f.write(f"Ticker Symbol: {ticker[0]}\n")
        f.write(f"Name: {ticker[1]}\n")
        f.write(f"Market Cap: {ticker[5]}\n")
        f.write(f"Country: {ticker[6]}\n")
        f.write(f"IPO Year: {ticker[7]}\n")
        f.write(f"Volume: {ticker[8]}\n")
        f.write(f"Sector: {ticker[9]}\n")
        f.write(f"Industry: {ticker[10]}\n")
        f.write(f"First year of data: {first_year}\n")
        f.write("Chance;Profit;Buy_Day;Buy_Month;Sell_Day;Sell_Month;;")
        if result is not None:
            f.write(";Buy;Course;Sell;Course" * len(result[0][1]))
        else:
            f.write(";Buy;Course;Sell;Course")
        f.write("\n")
        if result is not None:
            for stock_result in result:
                chance = stock_result[0][0]
                profit = str(float(stock_result[0][1]).__round__(2)).replace(".", ",")
                buy_day = stock_result[0][2]["day"]
                buy_month = stock_result[0][2]["month"]
                sell_day = stock_result[0][3]["day"]
                sell_month = stock_result[0][3]["month"]
                f.write(f'''{chance};{profit};{buy_day};{buy_month};{sell_day};{sell_month};;''')
                for days in stock_result[1]:
                    buy_date = \
                        f'''{int(days[0]["day"])}.{int(days[0]["month"])}.{int(days[0]["year"])}'''
                    sell_date = \
                        f'''{int(days[1]["day"])}.{int(days[1]["month"])}.{int(days[1]["year"])}'''
                    buy_course = str(float(days[0]["course"]).__round__(2)).replace(".", ",")
                    sell_course = str(float(days[1]["course"]).__round__(2)).replace(".", ",")
                    f.write(f''';{buy_date};{buy_course};{sell_date};{sell_course}''')
                f.write("\n")
            f.close()
        else:
            f.write("No relevant results")

        f = open(f"yfinance_ticker/Data/{csv_name}_data.csv", "w+")
        f.write("Date;Close;Adj Close;Volume\n")
        for step in range(len(yfin_data)):
            date = str(yfin_data["Date"][step])[:10]
            close = str(yfin_data["Close"][step]).replace(".", ",")
            adj_close = str(yfin_data["Adj Close"][step]).replace(".", ",")
            volume = yfin_data["Volume"][step]
            f.write(f'''{date};{close};{adj_close};{volume}\n''')
        f.close()

    @staticmethod
    def __calculate_chances(first_year):

        current_year = datetime.date.today().year - 1.5
        difference = current_year - first_year
        if first_year < 1984:
            call_chance = 0.75
            put_chance = 0.15
        else:
            call_chance = -0.0000001245893 * difference ** 4 + 0.0000031596081 * difference ** 3 - \
                          0.0000287171413 * difference ** 2 - 0.0033881195779 * difference + \
                          0.9997102044542
            put_chance = 0.0000000075278 * difference ** 4 + 0.0000008609729 * difference ** 3 + \
                         0.0000247593598 * difference ** 2 - 0.0000157194214 * difference - \
                         0.0028931794108
            """
            0.0000000075278 ×* + 0.0000008609729 ×3 + 0.0000247593598 ×2 - 0.0000157194214 x - 0.0028931794108
            """

        return call_chance, put_chance


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
