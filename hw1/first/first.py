from flask import Flask, request
import requests

app = Flask(__name__)

@app.route('/first', methods=['GET'])
def get_data():
    response = requests.get('http://second-service/second')
    return response.json()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8000)
