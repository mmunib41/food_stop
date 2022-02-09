<?php
header('Content-Type: application/json');
require_once("dbconfig.php");
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
// Getting name from $obj object.
$name = $obj['name'];

// Getting name from $obj object.
$description = $obj['description'];

 // Getting imageurl from $obj object.
$imageurl = $obj['imageurl'];

  // Getting imageurls from $obj object.
$imageurls = $obj['imageurls'];
 // Getting totaltime from $obj object.
$totaltime = $obj['totaltime'];
 
 
// Getting totalcalories from $obj object.
$totalcalories = $obj['totalcalories'];
 

 $sql = "INSERT INTO recipie(id, name, description, imageurl, imageurls, totaltime, totalcalories ) values (Null,'$name','$description', '$imageurl', '$imageurls', '$totaltime', '$totalcalories')";

if ($conn->query($sql) === TRUE) {
  $MSG='New record created successfully';
  $json = json_encode($MSG);
   echo $json ;
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
  mysqli_close($conn); //close mysqli

  

?>