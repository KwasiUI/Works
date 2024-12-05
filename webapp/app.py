

from flask import Flask, render_template, request, send_file
import pandas as pd
import pickle
import os
from prophet import Prophet

# Initialize Flask App
app = Flask(__name__)

# Define upload and download folders

UPLOAD_FOLDER = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'uploads')
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


UPLOAD_FOLDER = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'forecasts')
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['FORECAST_FOLDER'] = UPLOAD_FOLDER


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    # Check if a file was uploaded
    if 'file' not in request.files:
        return "No file uploaded", 400
    
    file = request.files['file']
    
    if file.filename == '':
        return "No file selected", 400

    # Save the uploaded file
    file_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
    file.save(file_path)


    # Read the uploaded CSV
    try:
        data = pd.read_csv(file_path)
        data.columns = ['ds', 'y'] 
        data['ds'] = pd.to_datetime(data['ds'])
        data=data.resample('M', on='ds').sum().reset_index()
    except Exception as e:
        return f"Error processing file: {e}", 400

    # Generate future dates and make predictions
    v_crisis = pd.DataFrame({
        'holiday': 'crisis',
        'ds': pd.date_range(start='2022-10-01', end='2023-03-01', freq='D'),  # Use daily crisis
        'lower_window': 0,
        'upper_window': 0
    })

# Step 3: Initialize and Fit the Prophet Model
    model = Prophet(yearly_seasonality=True, holidays=v_crisis)

    # Fit the model on the training data
    model.fit(data)





    future = model.make_future_dataframe(periods=12, freq='M')
    forecast = model.predict(future)

    # Save the forecast to a CSV
    forecast_file = os.path.join(app.config['FORECAST_FOLDER'], 'forecast.csv')
    forecast['ds'] = pd.to_datetime(forecast['ds'])  # Ensure 'ds' is a datetime type
    forecast['actual'] = data['y'].astype(float)  # Ensure predictions are floats
    forecast['forecast'] = forecast['yhat'].astype(float)  # Ensure predictions are floats
    forecast['yhat_lower'] = forecast['yhat_lower'].astype(float)  # Lower bound as float
    forecast['yhat_upper'] = forecast['yhat_upper'].astype(float)  # Upper bound as float
    forecast[['ds','actual','forecast', 'yhat_lower', 'yhat_upper']].to_csv(forecast_file, index=False)

    return send_file(forecast_file, as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True)
