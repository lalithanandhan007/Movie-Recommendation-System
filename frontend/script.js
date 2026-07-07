async function loadMovies(){

const response=await fetch("http://127.0.0.1:5000/movies");

const movies=await response.json();

let output="";

movies.forEach(movie=>{

output+=`
<h3>${movie.title}</h3>
<p>${movie.genre}</p>
<p>⭐ ${movie.rating}</p>
<hr>
`;

});

document.getElementById("movies").innerHTML=output;

}

