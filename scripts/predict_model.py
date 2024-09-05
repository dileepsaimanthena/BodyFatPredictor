import sys
import joblib
import numpy as np
import os
base_dir = os.path.dirname(os.path.abspath(__file__))
model_filename = os.path.join(base_dir, '../models/body_fat_predictor.pkl')
model_and_scaler = joblib.load(model_filename)
model = model_and_scaler['model']
scaler = model_and_scaler['scaler']
if len(sys.argv) != 14:
    raise ValueError('Expected 13 features as input.')

input_data = np.array([float(x) for x in sys.argv[1:]]).reshape(1, -1)
expected_features = scaler.mean_.shape[0]
if input_data.shape[1] != expected_features:
    raise ValueError(f'Input data should have {expected_features} features, but has {input_data.shape[1]}.')
input_data_scaled = scaler.transform(input_data)
prediction = model.predict(input_data_scaled)
print(prediction[0])