from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
    return "nice work. top job!!\n"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
