<?php
// Параметры подключения к базе данных
$servername = "localhost";
$username = "root";
$password = "Den110400311008";
$dbname = "cinema_db";

// Устанавливаем соединение с базой данных
$conn = new mysqli($servername, $username, $password, $dbname);

// Проверка подключения
if ($conn->connect_error) {
    die("Ошибка подключения: " . $conn->connect_error);
}

// Получаем данные о фильмах и кинотеатрах из таблицы movies и movie_cinemas
$sql_movies = "SELECT movies.*, movie_cinemas.cinema_id 
               FROM movies 
               INNER JOIN movie_cinemas ON movies.id = movie_cinemas.movie_id";
$result_movies = $conn->query($sql_movies);
$movies = array();
if ($result_movies->num_rows > 0) {
    while ($row = $result_movies->fetch_assoc()) {
        $movies[] = $row;
    }
}

// Получаем данные о кинотеатрах
$sql_cinemas = "SELECT * FROM cinemas";
$result_cinemas = $conn->query($sql_cinemas);
$cinemas = array();
if ($result_cinemas->num_rows > 0) {
    while ($row = $result_cinemas->fetch_assoc()) {
        $cinemas[] = $row;
    }
}

// Получаем данные о кинотеатрах для каждого фильма
$sql_movie_cinemas = "SELECT movie_id, cinema_id FROM movie_cinemas";
$result_movie_cinemas = $conn->query($sql_movie_cinemas);
$movie_cinemas = array();
if ($result_movie_cinemas->num_rows > 0) {
    while ($row = $result_movie_cinemas->fetch_assoc()) {
        $movie_cinemas[] = $row;
    }
}

// Закрываем соединение с базой данных
$conn->close();

// Формируем массив данных о фильмах и кинотеатрах
$data = array(
    'movies' => $movies,
    'cinemas' => $cinemas,
    'movie_cinemas' => $movie_cinemas
);

// Возвращаем данные в виде JSON
echo json_encode($data);
?>
