<?php
$host = 'mysql-db'; // <-- Use the Docker Compose service name
$username = 'root';
$password = 'iirs@12345';
$database = 'isrolms';

$mysqli = new mysqli($host, $username, $password, $database);

// Check connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}
echo "Connected successfully to MySQL!";
?>



