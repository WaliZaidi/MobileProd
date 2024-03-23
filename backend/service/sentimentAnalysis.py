# sentimentAnalysis.py

import joblib
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
import nltk
import sys
import json

# nltk.download('stopwords')
# nltk.download('punkt')

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

def predict_sentiment(new_text):
    # Preprocess new data
    processed_new_text = preprocess_text(new_text)

    # Vectorize the new data using the loaded vectorizer
    new_text_vec = loaded_vectorizer.transform([processed_new_text])

    # Predict sentiment using the loaded classifier
    predicted_sentiment = loaded_classifier.predict(new_text_vec)

    # Return the predicted sentiment as a dictionary
    return {'sentiment': predicted_sentiment[0]}

if __name__ == "__main__":
    # Check if a command-line argument is provided
    if len(sys.argv) != 2:
        print("Usage: python sentimentAnalysis.py <new_text>")
        sys.exit(1)

    new_text = sys.argv[1]
    result = predict_sentiment(new_text)
    print(json.dumps(result))  # Output the result as a JSON string
