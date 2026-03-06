from flask import Flask, Response
from prometheus_client import generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

@app.route("/")
def hello():
    return "DevOpsEKS running 🚀"

@app.route("/healthz")
def health():
    return "ok"

@app.route("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)