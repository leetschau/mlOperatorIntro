# # Recommender Algorithms

# Based on [Beginner Tutorial: Recommender Systems in Python](https://www.datacamp.com/community/tutorials/recommender-systems-python).

# ## Simple Recommender

import pandas as pd

metadata = pd.read_csv('data/movies_metadata.csv', low_memory=False)
metadata.shape

metadata.columns

C = metadata['vote_average'].mean()
m = metadata['vote_count'].quantile(0.90)

q_movies = metadata.copy().loc[metadata['vote_count'] >= m]
q_movies.shape

q_movies.shape[0] / metadata.shape[0]

def weighted_rating(x, m=m, C=C):
    v = x['vote_count']
    R = x['vote_average']
    # Calculation based on the IMDB formula
    return (v/(v+m) * R) + (m/(m+v) * C)

q_movies['score'] = q_movies.apply(weighted_rating, axis=1)
q_movies = q_movies.sort_values('score', ascending=False)
q_movies[['title', 'vote_count', 'vote_average', 'score']].head(20)

# ## Content-based Recommender

metadata['overview'].head()

from sklearn.feature_extraction.text import TfidfVectorizer

tfidf = TfidfVectorizer(stop_words='english')
metadata['overview'] = metadata['overview'].fillna('')
tfidf_matrix = tfidf.fit_transform(metadata['overview'])
tfidf_matrix.shape

tfidf.get_feature_names()[5000:5010]

from sklearn.metrics.pairwise import linear_kernel

cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)  # very calculation intensive, run it on good hardware
cosine_sim.shape

