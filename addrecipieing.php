<?php
header('Content-Type: application/json');
require_once("dbconfig.php");
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
// Getting name from $obj object.
$name = $obj['name'];
 
// Getting calories from $obj object.
$ingredient = $obj['ingredient'];
 

 $sql = "INSERT INTO recipieing(id, name, ingredient) values (Null,'$name','$ingredient')";

if ($conn->query($sql) === TRUE) {
  $MSG='New record created successfully';
  $json = json_encode($MSG);
   echo $json ;
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
  mysqli_close($conn); //close mysqli

  

?>