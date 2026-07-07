from flask import Flask, jsonify, request
from flask_cors import CORS
import json 

app = Flask(__name__)
CORS(app)

def load_movies():
    with open("movies.json", "r") as file:
        return json.load(file)

@app.route("/")
def home():
    return "Movie Recommendation System Backend Running"

@app.route("/movies")
def movies():
    return jsonify(load_movies())

@app.route("/movie/<int:movie_id>")
def movie(movie_id):
    movies = load_movies()
    for movie in movies:
        if movie["id"] == movie_id:
            return jsonify(movie)
    return jsonify({"message": "Movie not found"})

@app.route("/recommend/<genre>")
def recommend(genre):
    movies = load_movies()
    result = [m for m in movies if m["genre"].lower() == genre.lower()]
    return jsonify(result)

@app.route("/rate", methods=["POST"])
def rate():
    data = request.json
    return jsonify({
        "message": "Rating submitted successfully",
        "data": data
    })

if __name__ == "__main__":
    app.run(debug=True)


    
