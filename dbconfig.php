<?php
$servername = "localhost";
$username = "rasanchy_mobi";
$password = "muneeb.ch26";
$dbname = "rasanchy_flutter1";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
 die("Connection failed: " . $conn->connect_error);
}
//echo "Connected successfully";
?>