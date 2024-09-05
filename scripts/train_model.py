import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.preprocessing import StandardScaler
import joblib
import os

# Set paths for CSV and model
csv_file_path = r'C:\Users\darli\Downloads\Bodyfat project\Bodyfat project\public\bodyfat.csv'
model_save_path = r'C:\Users\darli\Downloads\Bodyfat project\Bodyfat project\models\body_fat_predictor.pkl'

# Load the dataset
data = pd.read_csv(csv_file_path)

# Feature selection
features = ['Age', 'Weight', 'Height', 'Neck', 'Chest', 'Abdomen', 
            'Hip', 'Thigh', 'Knee', 'Ankle', 'Biceps', 'Forearm', 'Wrist']
target = 'BodyFat'

# Split the data into features and target
X = data[features]
y = data[target]

# Preprocessing: Scaling features
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

# Initialize and train the model
model = LinearRegression()
model.fit(X_train, y_train)

# Make predictions on the test set
y_pred = model.predict(X_test)

# Evaluate the model
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
print(f'Mean Squared Error: {mse}')
print(f'R^2 Score: {r2}')

# Save the trained model and scaler
os.makedirs(os.path.dirname(model_save_path), exist_ok=True)
joblib.dump({'model': model, 'scaler': scaler}, model_save_path)
print(f'Model and scaler saved to {model_save_path}')
