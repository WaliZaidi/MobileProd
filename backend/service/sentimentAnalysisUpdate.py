# Step 3: Import libraries
import pandas as pd
import joblib
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import accuracy_score, classification_report
import os
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
nltk.download('stopwords')
nltk.download('punkt')

# cwd = os.getcwd()

# Step 4: Load and preprocess the data
data_path = 'E:\Wali\Festivo\server\service\classified_reviews1.csv'  # Update with your actual path
df = pd.read_csv(data_path, delimiter=',', names=['text', 'classification'])

# Drop rows with NaN values in the 'classification' column
df = df.dropna(subset=['classification'])

# Step 5: Tokenize and preprocess the text
stop_words = set(stopwords.words('english'))

def preprocess_text(text):
    words = word_tokenize(text)
    words = [word.lower() for word in words if word.isalpha() and word.lower() not in stop_words]
    return ' '.join(words)

df['Processed_Text'] = df['text'].apply(preprocess_text)

# Step 6: Split the dataset into training and testing sets with a smaller test size
X_train, X_test, y_train, y_test = train_test_split(df['Processed_Text'], df['classification'], test_size=0.1, random_state=42)

# Step 7: Vectorize the text data
# Choose one of the following vectorization methods:

# For N-grams (unigrams and bigrams)
vectorizer = CountVectorizer(ngram_range=(1, 5))  # for unigrams and bigrams
# For TF-IDF
#vectorizer = TfidfVectorizer(max_df=0.95, min_df=7)  # Adjust as needed

X_train_vec = vectorizer.fit_transform(X_train)
X_test_vec = vectorizer.transform(X_test)

classifier = MultinomialNB(alpha=0.32)  #adjust alpha value to ensure that the magic recipie has the correct ratios
classifier.fit(X_train_vec, y_train)

# Step 9: Save the vectorizer and classifier
joblib.dump(vectorizer, 'vectorizer.joblib')
joblib.dump(classifier, 'classifier.joblib')

# Step 10: Load the vectorizer and classifier
vectorizer = joblib.load('vectorizer.joblib')
classifier = joblib.load('classifier.joblib')

y_pred = classifier.predict(X_test_vec)
accuracy = accuracy_score(y_test, y_pred)

print(f'Accuracy: {accuracy:.2f}')
print('\nClassification Report:\n', classification_report(y_test, y_pred))
