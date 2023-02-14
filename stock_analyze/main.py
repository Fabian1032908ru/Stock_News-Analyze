"""
Testing
"""
import sys

from Stock_Class import Stock
from Stock_Class_Bundel import Stock_analyze_bundel
import os

# get current directory
path = os.getcwd()
# prints parent directory
parent_dic = os.path.abspath(os.path.join(path, os.pardir))

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
    dax_stocks_list_results.append(stocks.analyse_data_day_comparison(final_val, first_year))

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