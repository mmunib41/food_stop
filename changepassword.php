<?php
header('Content-Type: application/json');
require_once("dbconfig.php");
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
// Getting date from $obj object.
$email = $obj['email'];

 
// Getting Email from $obj object.
$pass = $obj['pass'];
 


 $sql="UPDATE user SET pass='$pass' WHERE email='$email'";

if ($conn->query($sql) === TRUE) {
  $MSG='Record updated successfully';
  $json = json_encode($MSG);
   echo $json ;
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
  mysqli_close($conn); //close mysqli

  

?>