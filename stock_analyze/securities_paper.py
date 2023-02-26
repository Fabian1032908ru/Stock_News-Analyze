"""
Super Class for the Stockclass
"""

from abc import ABC, abstractmethod
from itertools import islice


class Securities(ABC):

    @abstractmethod
    def __init__(self, stock="None"):
        self.name = stock

    @abstractmethod
    def edit_name(self, new_name):
        self.name = new_name

    @abstractmethod
    def read_csv(self, path):
        values = []
        with open(path, 'r') as csv_file:
            csv_lines = csv_file.readlines()

        for index, csv_line in enumerate(csv_lines):
            if index != 0:
                values.append(csv_line)

        return values

    @abstractmethod
    def read_name_as_csv_title(self):
        pass

    @abstractmethod
    def replace_comma_dot(self, final_values):
        for value in final_values:
            value["closing_course"] = value["closing_course"].replace(",", ".")

        return final_values

    @abstractmethod
    def convert_str_to_int(self, values):
        for value in values:
            value["day"] = float(value["day"])
            value["month"] = float(value["month"])
            value["year"] = float(value["year"])
            value["closing_course"] = float(value["closing_course"])

        return values

    @abstractmethod
    def get_first_year(self, values):
        first_year = values[0]["year"]

        for value in values:
            if value["year"] < first_year:
                first_year = value["year"]

        return first_year

    @abstractmethod
    def get_closing_courses(self, values):
        final_courses = []
        for index, value in enumerate(values):
            if index != 0 and len(value) > 1:
                aux_var = value.split(";")
                day = aux_var[0].split(".")[0]
                month = aux_var[0].split(".")[1]
                year = aux_var[0].split(".")[2]
                course = aux_var[4]
                final_courses.append({"day": day, "month": month, "year": year,
                                      "closing_course": course})

        return final_courses

    def get_closing_courses_if_us(self, values):
        final_courses = []
        for index, value in enumerate(values):
            if index != 0 and len(value) > 1:
                aux_var = value.split(";")
                year = aux_var[0].split("-")[0]
                month = aux_var[0].split("-")[1]
                day = aux_var[0].split("-")[2]
                course = aux_var[4]
                final_courses.append({"day": day, "month": month, "year": year,
                                      "closing_course": course})

        return final_courses

    def get_closing_courses_if_yahoo(self, values):
        final_courses = []
        for value in values:
            calc = value[0].split("-")
            day = int(calc[2])
            month = int(calc[1])
            year = int(calc[0])
            course = value[1]
            final_courses.append({"day": day, "month": month, "year": year,
                                      "closing_course": course})

        return final_courses

    @abstractmethod
    def check_csv_format(self, path: str) -> bool:
        """
        Check in which format the csv is, Could be US data and course with .
        or German format
        :param path: Path of csv to be checked
        :return: False when the format is german style and a True when it is american style
        """
        first_line = []
        with open(path) as fin:
            for line in islice(fin, 1, 2):
                first_line.append(line)

        split_line = first_line[0].split(";")
        if split_line[0].find("-") != -1:
            return True
        return False
