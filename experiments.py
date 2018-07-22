import pandas as pd
from sklearn.ensemble import RandomForestClassifier as rfc
from tpot import TPOTClassifier
from datacleaner import autoclean

df = pd.read_csv('file.csv')
rfc = rfc()
clf = TPOTClassifier(generations=5, population_size=20, verbosity=2)
for i  in range(len(df)):
    m = df['Month']
    rain.append(rainfall[m[i]-1])
df['rainfall'] = rain
df = autoclean(df)
X = df.drop('Disease','Larva', 'Diagno')
y = df['#Target label']

X_train, X_test, y_train, y_test = train_test_split(
...     X, y, test_size=0.33, random_state=42)
clf.fit(X_train, y_train)
joblib.dump(clf.fitted_pipeline_, 'model.pkl')