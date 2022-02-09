<?php
header('Content-Type: application/json');
require_once("dbconfig.php");
 $json = file_get_contents('php://input');
 $obj = json_decode($json,true);

if ($conn->connect_error) {
 
	die("Connection failed: " . $conn->connect_error);
} 
  $ingredient1 = $obj["ingredient1"];
  $ingredient2 = $obj["ingredient2"];
  $ingredient3 = $obj["ingredient3"];
  
	// Creating SQL command to fetch all records from user data Table.
	$sql = "SELECT * from recipie WHERE name IN (SELECT DISTINCT name FROM recipieing WHERE ingredient LIKE '$ingredient1' OR ingredient LIKE '$ingredient2' OR ingredient LIKE '$ingredient3')";
	 
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