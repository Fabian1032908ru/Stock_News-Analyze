"""
Creates a Trendgraph based computing linear system
"""

from securities_paper import Securities

import numpy as np

class Trendgraph(Securities):
    """
    Class for every stock to compute the Trend-graphs
    """
    def __init__(self, name="Unkown", class_values=None):
        if class_values is None:
            class_values = []
        name = name
        class_values = class_values

    def check_csv_format(self, path: str) -> bool:
        super().check_csv_format(path)

    def convert_str_to_int(self, values):
        super().convert_str_to_int(values)

    def edit_name(self, new_name):
        super().edit_name(new_name)

    def get_closing_courses(self, values):
        super().get_closing_courses(values)

    def get_first_year(self, values):
        super().get_first_year(values)

    def read_csv(self, path):
        super().read_csv(path)

    def read_name_as_csv_title(self):
        super().read_name_as_csv_title()

    def replace_comma_dot(self, final_values):
        super().replace_comma_dot(final_values)

    def test_matrix(self):
        # Calculating is okay
        # Erstellen einer zufälligen Matrix A mit 1000 Unbekannten
        A = np.random.rand(10000, 10000)
        print(A)

        # Erstellen eines zufälligen Vektors b
        b = np.random.rand(10000)
        print(b)

        # Lösen des Gleichungssystems Ax = b
        x = np.linalg.solve(A, b)
        print(len(x))


if __name__ == '__main__':
    t = Trendgraph(name="test")
    t.test_matrix()
