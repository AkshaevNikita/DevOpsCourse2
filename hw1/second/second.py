from flask import Flask, jsonify
import requests

app = Flask(__name__)

@app.route('/second', methods=['GET'])
def get_data():
    response = requests.get('https://breakingbadapi.com/api/quote/random')
    quote = response.json()[0]['quote']
    return jsonify({'quote': quote})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9000)

