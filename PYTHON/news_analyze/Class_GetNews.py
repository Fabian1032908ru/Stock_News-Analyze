"""
Class to get the news daily and append to SQL database
"""

import csv
import os
import datetime
import shutil

from GoogleNews import GoogleNews
from caffeinate import caffeinate
import subprocess

# get current directory
path = os.getcwd()
# prints parent directory
parent_dic = os.path.abspath(os.path.join(path, os.pardir))


def make_backup() -> bool:
    """
    Please do not call this function, only Fabian is calling it, because the destination folder
    is somewhere else. But with checking serial number nothing is going to happen.
    """

    result = subprocess.run(["system_profiler", "SPHardwareDataType"], capture_output=True,
                            text=True)
    hardware_info = result.stdout
    # just there to be introduced before assignment
    serial_number = "0"
    lines = hardware_info.split("\n")
    for line in lines:
        if "Serial Number (system):" in line:
            serial_number = line.split(":")[1].strip()
            print("Serial Number:", serial_number)
            break
    if serial_number == "FVFY2HU3HV22":
        current_date = datetime.datetime.now()
        formatted_date = current_date.strftime("%m-%d-%Y")
        src_folder = "/Users/fabian/Desktop/Python/seasonalyze/Stock_News-Analyze/news_analyze/csv"
        dst_folder1 = f"/Users/fabian/Desktop/News_Data_Back_Up_Folder/{formatted_date}"

        if os.path.exists(dst_folder1):
            shutil.rmtree(dst_folder1)
        shutil.copytree(src_folder, dst_folder1)
        return True
    return False


def call_news_class():
    """
    Function to get create for every entry in the txt a News object load all news and save them
    in a csv
    """
    with open(f"{parent_dic}/news_analyze/companies.txt", 'r') \
            as csv_file:
        companies_as_csv = csv_file.readlines()
        companies = []
        for com in companies_as_csv:
            com = com.replace("\n", "")
            companies.append(com)
        print(companies)

    for index, com in enumerate(companies):
        print(f"Current company company: {index} {com}")
        if com == "None":
            g = News()
        else:
            g = News(com)


class News:

    def __init__(self, name=None):
        self.name = name
        if self.name == "General":
            raise Exception("You are not allowed to pass the name General, cause this is a "
                            "default Value")

        self.__get_news()

    def __get_news(self):

        current_date = datetime.datetime.now()
        formatted_date = current_date.strftime("%m/%d/%Y")

        if self.name is None:
            data = []
            googlenews = GoogleNews(start=formatted_date, end=formatted_date)
            googlenews.get_news("top")
            google_result1 = googlenews.results()
            googlenews = GoogleNews(start=formatted_date, end=formatted_date)
            googlenews.get_news("current")
            google_result2 = googlenews.results()

            for result in google_result1:
                data.append(["Top", formatted_date, result["title"], "still open"])
            for result in google_result2:
                data.append(["Current", formatted_date, result["title"], "still open"])

        else:
            data = []
            googlenews = GoogleNews(start=formatted_date, end=formatted_date)
            googlenews.get_news(f"{self.name}")
            google_result_normal = googlenews.results()

            googlenews.get_news(f"{self.name} stock")
            google_result_stock = googlenews.results()

            for result in google_result_normal:
                data.append([self.name, formatted_date, result["title"], "still open"])
            for result in google_result_stock:
                data.append([self.name, formatted_date, result["title"], "still open"])

        if self.__safe_news_date(data):
            pass
        else:
            self.__safe_news_date(data[1:])

    def __safe_news_date(self, data: list[list[str]]):

        if self.name is None:
            self.name = "General"

        path = f"{parent_dic}/news_analyze/csv/{self.name}.csv"

        if os.path.exists(path):

            data = data
            with open(path, "a", newline="") as f:
                writer = csv.writer(f)
                writer.writerows(data)

        else:

            if len(data) > 1:
                return_val = False
            else:
                return_val = True

            data = [["Name", "Data", "News", "Evaluation"], data[0]]
            with open(path, "w", newline="") as f:
                writer = csv.writer(f)
                writer.writerows(data)

            if return_val is False:
                return return_val

        if self.name == "General":
            self.name = None

        return True


if __name__ == '__main__':

    if make_backup() is False:
        print(Warning("You entered with the wrong device to make a backup.\nNo Backup has been "
                      "done!!!"))
    if input("1 get all news") == "1":
        # caffeinate.run()
        call_news_class()
