# sentimentAnalysis.py

import joblib
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
import nltk
import sys
import json

nltk.download('stopwords')
nltk.download('punkt')

# Load the saved vectorizer and classifier
loaded_vectorizer = joblib.load('vectorizer.joblib')
loaded_classifier = joblib.load('classifier.joblib')

# Define stopwords
stop_words = set(stopwords.words('english'))

# Function to preprocess text
def preprocess_text(text):
    words = word_tokenize(text)
    words = [word.lower() for word in words if word.isalpha() and word.lower() not in stop_words]
    return ' '.join(words)

def predict_sentiment_batch(reviews):
    processed_reviews = [preprocess_text(review) for review in reviews]
    new_text_vec = loaded_vectorizer.transform(processed_reviews)
    predicted_sentiments = loaded_classifier.predict(new_text_vec)
    return [{'review': review, 'sentiment': sentiment} for review, sentiment in zip(reviews, predicted_sentiments)]

if __name__ == "__main__":
    # Check if command-line arguments are provided
    if len(sys.argv) < 2:
        print("Usage: python sentimentAnalysisBatch.py <new_text1> <new_text2> ... <new_textN>")
        sys.exit(1)

    new_texts = sys.argv[1:]
    result = predict_sentiment_batch(new_texts)
    print(json.dumps(result))  # Output the result as a JSON string
