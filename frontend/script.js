async function loadMovies(){

const response=await fetch("http://127.0.0.1:5000/movies");

const movies=await response.json();

let output="";

movies.forEach(movie=>{

output += `
<div class="card">

<h3>${movie.title}</h3>

<p><strong>Genre:</strong> ${movie.genre}</p>

<p><strong>⭐ Rating:</strong> ${movie.rating}</p>

</div>
`;

});

document.getElementById("movies").innerHTML=output;

}

