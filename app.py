from flask import Flask
app=Flask(__name__)
@app.route('/')
def hello():
    return "My first project li live now and i want to became the best cloud engineer in the world!"
if __name__ == '__main__' :
    app.run(host='0.0.0.0',port=8080)
# Testing my pipeline v3