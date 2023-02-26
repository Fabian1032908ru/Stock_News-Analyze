"""
Class to format data in a way we need it for diffrent types
"""

from gensim.models import Word2Vec
import nltk
from matplotlib import pyplot as plt
from nltk.corpus import stopwords
from sklearn.manifold import TSNE
import numpy as np


# nltk.download('stopwords')
# only use nltk.download all couple weeks to update stopwords


class Format_data:

    def convert_to_num(self, word_list: list[str]) -> list[int]:
        pass

    def remove_stopwords(self, word_list: list[str]) -> list[str]:
        """
        Remove all stopwords from sentences in the list
        :param word_list: sentences
        :return: return all sentences without the stopwords
        """
        result = []

        for text in word_list:
            # src: asked chatgpt
            stop_words = set(stopwords.words("english"))
            words = nltk.word_tokenize(text)
            words = [word for word in words if word.lower() not in stop_words]
            result.append(" ".join(words))

        return result

    def __init__(self, name="None"):
        self.name = name

    def __str__(self):
        return self.name


if __name__ == '__main__':
    """ a = Format_data()
    b = a.remove_stopwords(["The quick brown fox jumps over the lazy dog."])
    print(b)"""
    
