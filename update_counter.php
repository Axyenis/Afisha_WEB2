<?php
// Подключение к базе данных
$servername = "localhost";
$username = "root";
$password = "Den110400311008";
$dbname = "cinema_db";

$conn = new mysqli($servername, $username, $password, $dbname);

// Проверка соединения
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Увеличение счетчика на 1
$sql = "UPDATE visitors_counter SET counter_value = counter_value + 1 WHERE id = 1";

if ($conn->query($sql) === TRUE) {
    echo "Record updated successfully";
} else {
    echo "Error updating record: " . $conn->error;
}

$conn->close();
?>