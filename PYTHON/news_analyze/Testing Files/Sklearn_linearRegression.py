"""
Testing linear Regression based on some test strings
YT Tut src: https://www.youtube.com/watch?v=b0L47BeklTE
"""

import pandas as pd
import numpy as np
from pydataset import data
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from matplotlib import pyplot as plt

pima = data("Pima.tr")
print(pima)

pima.plot(kind='scatter', x='skin', y='bmi')
# plt.show()

# Test Train split
X_train, X_test, y_train, y_test = train_test_split(pima.skin, pima.bmi)
"""
plt.scatter(X_train, y_train, label="Training Data", color="r", alpha=0.7)
plt.scatter(X_test, y_test, label="Training Data", color="g", alpha=0.7)
plt.legend()
"""
# plt.show()

# Create linear model
LR = LinearRegression()
LR.fit(X_train.values.reshape(-1, 1), y_train.values)

prediction = LR.predict(X_test.values.reshape(-1, 1))

plt.plot(X_test, prediction, label="Linear Regression", color="b")
plt.plot(X_test, y_test, label="Linear Regression", color="g", alpha=0.7)
plt.legend()
# plt.show()

print(LR.predict(np.array([[50]]))[0])

