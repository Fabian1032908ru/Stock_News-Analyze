"""
Creating a Class for the stocks
"""
import math

from securities_paper import Securities
from Draw_Graphs import Graph


class Stock(Securities, Graph):

    def __init__(self, stock="None"):
        self.name = stock
        super().__init__(stock)

    def __str__(self):
        return f"{self.name} Aktie"

    def edit_name(self, new_name):
        super().edit_name(new_name)

    def read_name_as_csv_title(self):
        super().read_name_as_csv_title()

    def read_csv(self, path):
        return super().read_csv(path)

    def replace_comma_dot(self, final_values):
        return super().replace_comma_dot(final_values)

    def convert_str_to_int(self, values):
        return super().convert_str_to_int(values)

    def get_first_year(self, values):
        return super().get_first_year(values)

    def check_csv_format(self, path: str) -> bool:
        return super().check_csv_format(path)

    def get_closing_courses(self, values):
        """
        In Superclass, because every paper needs the same base functions, but analyse can be 
        different
        :param values: 
        :return: 
        """
        return super().get_closing_courses(values)

    def get_closing_courses_if_us(self, values):
        """
        In Superclass, because every paper needs the same base functions, but analyse can be
        different
        :param values:
        :return:
        """
        return super().get_closing_courses_if_us(values)

    def get_highest_value(self, final_values):
        highest_value = None
        if highest_value is None:
            highest_value = final_values[0]

        for value in final_values:
            if float(value["closing_course"]) > float(highest_value["closing_course"]):
                highest_value = value

        return highest_value

    def get_daily_average_over_years(self, final_values, first_year):
        """
        Get the avarage values for everyday over the past years
        :param first_year:
        :param final_values:
        :return:
        """
        average_values = [[[] for _ in range(31)] for _ in range(12)]
        calendar_val = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        for act_month, day_in_month in enumerate(calendar_val):
            for day in range(day_in_month + 1):
                for year in range(int(first_year) + 1, 2023):
                    for value in final_values:
                        if value["year"] == year and value["month"] == (act_month + 1) and \
                                value["day"] == day:
                            average_values[act_month][day - 1].append(value["closing_course"])

        for index1, month in enumerate(average_values):
            for index2, day in enumerate(month):
                if len(day) > 0:
                    average_values[index1][index2] = sum(day) / len(day)
                else:
                    average_values[index1][index2] = average_values[index1][index2 - 1]

        return average_values

    def draw_daily_average_over_year(self, daily_average, save_picture=False, save_format="png"):
        super().draw_daily_average_over_year(daily_average, save_picture, save_format)

    def analyse_data_day_comparison(self, values, first_year, call_chance=0.9, put_chance=0.075):
        calendar_val = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        result = [[[[[], []] for _ in range(31)] for _ in range(12)] for _ in range(252)]
        for current_year in range(int(first_year) + 1, 2022):
            print(current_year)
            for index_buy_month, buy_month in enumerate(calendar_val):
                for buy_day in range(buy_month):
                    buy_value = None
                    act_buy_day = buy_day
                    act_buy_day -= 1
                    act_buy_month = index_buy_month
                    act_buy_year = current_year
                    while True:
                        act_buy_day += 1
                        if act_buy_day > 30:
                            act_buy_month += 1
                            act_buy_day = 0
                        if act_buy_month > 11:
                            act_buy_year += 1
                            act_buy_month = 0
                        for value in values:
                            if value["year"] == act_buy_year and value[
                                "month"] == act_buy_month + 1 \
                                    and value["day"] == act_buy_day + 1:
                                buy_value = value
                        if buy_value is not None:
                            index = values.index(buy_value)
                            for dif in range(15, 250):
                                sell_value = values[index - dif]
                                result[dif][index_buy_month][buy_day][0].append(buy_value)
                                result[dif][index_buy_month][buy_day][1].append(sell_value)
                            break

        buy_or_not = []
        for difs in result:
            for month in difs:
                for days in month:
                    if days and days[0] and days[1]:
                        chance = 0
                        for current_year in range(len(days[0])):
                            if days[1][current_year]['closing_course'] - \
                                    days[0][current_year]['closing_course'] > 0:
                                chance += 1

                        chance /= len(days[0])
                        if (chance > call_chance or chance < put_chance) and chance != 0:
                            buy_or_not.append([[chance, days[0][0], days[1][0]], []])
                            for current_year in range(len(days[0])):
                                buy_or_not[len(buy_or_not) - 1][1].append([
                                    {
                                        "type": "BUY DAY",
                                        "year": days[0][current_year]["year"],
                                        "month": days[0][current_year]["month"],
                                        "day": days[0][current_year]["day"],
                                        "course": days[0][current_year]["closing_course"]
                                    },
                                    {
                                        "type": "SELLING DAY",
                                        "year": days[1][current_year]["year"],
                                        "month": days[1][current_year]["month"],
                                        "day": days[1][current_year]["day"],
                                        "course": days[1][current_year]["closing_course"]
                                    }
                                ])

        print(len(buy_or_not))
        if len(buy_or_not) > 10:
            filtered = self.filter_results(buy_or_not)
        else:
            filtered = buy_or_not

        return filtered

    def filter_results(self, values):
        """
        Function to filter 10 results from all the possible results
        :param values: All possible buying data
        """
        for v in values:
            print(v)

        top_res = []
        current_max = values[0]
        current_lst = [values[0]]
        for value in values:
            if value[0][0] > current_max[0][0]:
                current_max = value
                current_lst = [value]
            elif value[0][0] == current_max[0][0]:
                current_lst.append(value)

        # Evaluate the distance between buying and selling date, best distance is top
        # Only if there are still more then 10 results
        best_day_difference = []
        if len(current_lst) > 10:
            for worth in current_lst:
                print(worth)
                if worth[0][1]["year"] == worth[0][2]["year"]:
                    days = (worth[0][2]["month"] - worth[0][1]["month"]) * 12.5 + \
                           (worth[0][1]["day"] - worth[0][2]["day"])
                else:
                    days = (12 - (worth[0][2]["month"] - worth[0][1]["month"])) * 12.5 + \
                           (worth[0][1]["day"] - worth[0][2]["day"])

                print(days)
                print(self.evaluate_date_differences(days))



        return ""

    def evaluate_date_differences(self, distance):
        """
        Gets the amount of days between two dates and evaluates those dates
        :param distance: Amount of days between the two dates
        :return: returns the aevaluations as float
        """
        result = -0.0000000020357 * distance ** 4 + 0.0000017711697 * distance ** 3 - \
                 0.0005269654884 * distance ** 2 + 0.0572989956457 * distance - 1.0952373976091

        return result
