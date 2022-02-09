<?php
header('Content-Type: application/json');
require_once("dbconfig.php");
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);
 
// Getting name from $obj object.
$name = $obj['name'];
 
$email = $obj["email"];
 
 // Getting Password from JSON $obj array and store into $password.
 $pass = $obj['pass'];
 
 //Applying User Login query with email and password.
$sql = "SELECT * FROM user WHERE email='$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    
     $emailExist = 'Email Already Exist, Please Try Again With New Email Address..!';
	 
	 // Converting the message into JSON format.
	$existEmailJSON = json_encode($emailExist);
	 
	// Echo the message on Screen.
	 echo $existEmailJSON ; 
}

else{
 
// Executing Email Check MySQL Query.
$check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));

 $sql = "INSERT INTO user(id, name, pass, email) values (Null,'$name','$email','$pass')";

if ($conn->query($sql) === TRUE) {
  $MSG='New record created successfully';
  $json = json_encode($MSG);
   echo $json ;
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
}
  mysqli_close($conn); //close mysqli

  

?>