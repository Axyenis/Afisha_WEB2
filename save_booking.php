<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

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

// Получаем данные из POST запроса
$data = json_decode(file_get_contents('php://input'), true);
error_log(print_r($data, true));

$email = $data['email'];
$bookingDetails = "Запись на фильм \"" . $data['movie_title'] . "\" в кинотеатре \"" . $data['cinema_name'] . "\" " . $data['selected_date'] . " в " . $data['selected_time'];

// Подготовка запроса для вставки данных
$stmt = $conn->prepare("INSERT INTO requests (email, booking_details) VALUES (?, ?)");
$stmt->bind_param("ss", $email, $bookingDetails);

// Выполнение запроса
if ($stmt->execute()) {
    echo json_encode(array('success' => true));
} else {
    // Выводим ошибку, если запрос не выполнен успешно
    echo json_encode(array('success' => false, 'error' => $stmt->error));
}

// Закрываем соединение с базой данных
$stmt->close();
$conn->close();
?>
