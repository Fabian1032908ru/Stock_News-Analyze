"""
Testing the linear regression model on apple stock with a couple data
"""
import string

import nltk
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression, LinearRegression

from train_data import train_data_str, train_data_int

values = set()

with open("/Users/fabian/Desktop/Python/seasonalyze/Stock_News-Analyze/news_analyze/csv/"
          "Apple Inc..csv", 'r') as csv_file:
    csv_lines = csv_file.readlines()

for index, csv_line in enumerate(csv_lines):
    if index != 0:
        values.add(csv_line)

values = list(values)

for index, _ in enumerate(values):
    values[index] = values[index].replace("\n", "")

final_values = []
for v in values:
    # only get the message
    text = v
    text = text.replace("Apple Inc.,", "")[11:]
    text = text[:len(text) - 11]

    # remove all stop words
    stop_words = set(stopwords.words("english"))
    words = nltk.word_tokenize(text)
    words = [word for word in words if word.lower() not in stop_words]
    text = " ".join(words)
    text = text.translate(str.maketrans("", "", string.punctuation))
    text = text.lower().strip()
    final_values.append(text)

final_values.append("Apple declares bankruptcy")

vectorizer = TfidfVectorizer()
train_data = vectorizer.fit_transform(train_data_str)

# Train the classifier
classifier = LinearRegression()
classifier.fit(train_data, train_data_int)

# Predict the label of new strings
new_strings = final_values
new_data = vectorizer.transform(new_strings)
predictions = classifier.predict(new_data)

for index, p in enumerate(predictions):
    print(p, final_values[index])

print("\nAverage of predictions\t", str(sum(predictions) / len(predictions)))
