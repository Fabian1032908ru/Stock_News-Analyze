"""
Get Stock Data from Yahoo Finance
"""

import yfinance as yf
from Stock_Class import Stock

data = yf.download('ADNWW', '1970-01-01', '2023-12-31')

# AAPL - Apple

res = []

data = data.reset_index()

for step in range(len(data)):
    date = str(data["Date"][step])[:10]
    res.append([date, float(data["Adj Close"][step])])

test1 = Stock("Test 1")
ger_or_us = True
final_val = test1.get_closing_courses_if_yahoo(res)
final_val = test1.convert_str_to_int(final_val)
final_val = final_val[::-1]
for test in final_val:
    print(test)

first_year = test1.get_first_year(final_val)
result = test1.analyse_data_day_comparison(final_val, first_year, call_chance=0.8)

for a in result:
    print(a)
