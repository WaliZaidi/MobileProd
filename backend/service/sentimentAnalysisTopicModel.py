# Step 3: Import libraries
import pandas as pd
import joblib
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from sklearn.multioutput import MultiOutputClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report
import os
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from sklearn.preprocessing import MultiLabelBinarizer

nltk.download('stopwords')
nltk.download('punkt')

# Step 4: Load and preprocess the data
data_path = 'E:\Wali\Festivo\server\service\classified_reviews.csv'  # Update with your actual path
df = pd.read_csv(data_path, delimiter=',')  # Assume the CSV file has 'text' and 'topics' columns

# Drop rows with NaN values in the 'topics' column
df = df.dropna(subset=['topics'])

# Step 5: Tokenize and preprocess the text
stop_words = set(stopwords.words('english'))

def preprocess_text(text):
    words = word_tokenize(text)
    words = [word.lower() for word in words if word.isalpha() and word.lower() not in stop_words]
    return ' '.join(words)

df['Processed_Text'] = df['text'].apply(preprocess_text)

# Step 6: Split the dataset into training and testing sets with a smaller test size
X_train, X_test, y_train, y_test = train_test_split(df['Processed_Text'], df['topics'], test_size=0.1, random_state=42)

# Step 7: Vectorize the text data
# Choose one of the following vectorization methods:

# For N-grams (unigrams and bigrams)
vectorizer = CountVectorizer(ngram_range=(1, 5))  # for unigrams and bigrams
# For TF-IDF
# vectorizer = TfidfVectorizer(max_df=0.95, min_df=7)  # Adjust as needed

X_train_vec = vectorizer.fit_transform(X_train)
X_test_vec = vectorizer.transform(X_test)

# Step 8: Convert the 'topics' column to a multi-label binary format
mlb = MultiLabelBinarizer()
y_train_bin = mlb.fit_transform(y_train)
y_test_bin = mlb.transform(y_test)

# Step 9: Train the model
classifier = MultiOutputClassifier(RandomForestClassifier(n_estimators=100, random_state=42))
classifier.fit(X_train_vec, y_train_bin)

# Step 10: Save the vectorizer and multi-label classifier
joblib.dump(vectorizer, 'vectorizer.joblib')
joblib.dump(classifier, 'multi_label_classifier.joblib')

# Step 11: Load the vectorizer and multi-label classifier
loaded_vectorizer = joblib.load('vectorizer.joblib')
loaded_multi_label_classifier = joblib.load('multi_label_classifier.joblib')

# Step 12: Predict topics for the test set
y_pred_bin = loaded_multi_label_classifier.predict(X_test_vec)

# Step 13: Convert predicted binary format back to original format
y_pred = mlb.inverse_transform(y_pred_bin)

# Step 14: Evaluate the model
accuracy = accuracy_score(y_test_bin, y_pred_bin)
print(f'Accuracy: {accuracy:.2f}')
print('\nClassification Report:\n', classification_report(y_test_bin, y_pred_bin))
