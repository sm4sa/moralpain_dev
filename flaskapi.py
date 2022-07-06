from flask import Flask, json, jsonify
from flask_cors import CORS, cross_origin

submissions = {
    "list": [
        {
            "score": 1,
            "selections": [],
            "timestamp": 1655237295,
            "id": "28308ccfe579417ebe5d32b106ed48d9"
        },
        {
            "score": 3,
            "selections": ["002_02", "004_01"],
            "timestamp": 1655237806,
            "id": "48a1633f0fb64b2fb6d58c303ac82bba"
        }
    ]
}

api = Flask(__name__)
CORS(api, support_credentials=True)

@api.route('/admin/submissions', methods=['GET'])
@cross_origin(supports_credentials=True)
def get_submissions():
  return json.dumps(submissions)

if __name__ == '__main__':
    api.run() 