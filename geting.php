<?php
header('Content-Type: application/json');
require_once("dbconfig.php");
 $json = file_get_contents('php://input');
 $obj = json_decode($json,true);

if ($conn->connect_error) {
 
	die("Connection failed: " . $conn->connect_error);
} 
  $name = $obj["name"];
	// Creating SQL command to fetch all records from user data Table.
	$sql = "SELECT ingredient FROM recipieing WHERE name='$name'";
	 
	$result = $conn->query($sql);
 
if ($result->num_rows >0) {
 
	 while($row[] = $result->fetch_assoc()) {
	 
	 $item = $row;
	 
	 $json = json_encode($item, JSON_NUMERIC_CHECK);
	 
 }
 
} else {
	echo "No Data Found.";
}
echo $json;
$conn->close();

?>