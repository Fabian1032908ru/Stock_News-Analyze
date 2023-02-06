"""
Class to get data and then draw a Graph
"""

from abc import abstractmethod
import matplotlib.pyplot as plt
import numpy as np
import os

# get current directory
path = os.getcwd()
# prints parent directory
parent_dic = os.path.abspath(os.path.join(path, os.pardir))


class Graph():

    @abstractmethod
    def __int__(self, name="Name is still missing"):
        self.name = name

    @abstractmethod
    def draw_daily_average_over_year(self, daily_average, save_picture=False, save_format=None):
        """
        Creates the interface of the Graph based on the daily average buy data
        :param daily_average: Data to be passed as List of Month with every single day as data
        included
        :param save_picture: if you dont want to show the plot, but want to save the picture
        :param save_format: You can export the picture in diffrent formats
            Best Format is .eps  it is a nearly a svg, high resolution
        """

        days_a_year = []
        mid_values, end_values = [], []

        for month in daily_average:
            for day in month:
                mid_values.append(day)

        for i in range(len(mid_values)):
            days_a_year.append(i)

        end_values_np = np.array(mid_values)
        z_curve = np.polyfit(days_a_year, end_values_np, 50)
        p_curve = np.poly1d(z_curve)

        # averaging all points of the graph to get a fluent line
        for index, _ in enumerate(mid_values):
            calc_average = []
            for dif in range(-7, 7):
                calc_average.append(mid_values[(index + dif) % len(mid_values)])
            end_values.append(sum(calc_average) / len(calc_average))

        # Removing first 7 and last 15 Elements because they don't match with correct data
        del end_values[:7]
        del days_a_year[:7]
        del end_values[-15:]
        del days_a_year[-15:]

        plt.plot(days_a_year, end_values, lw=2, solid_capstyle='round', color='black')
        plt.plot(days_a_year, p_curve(days_a_year), color="red")
        # naming the x axis
        plt.xlabel("Year Overview")
        # naming the y axis
        plt.ylabel("Average buy course")
        plt.title(f"Graph of {self.name}")
        # function to show the plot

        if save_picture:
            print("Test123")
            plt.savefig(f"{parent_dic}/saved_pngs/"
                        f"{self.name}.{save_format}")
        else:
            plt.show()
