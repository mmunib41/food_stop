 <?php
header('Content-Type: application/json');
require_once("dbconfig.php");
 $json = file_get_contents('php://input');
 
 // Decoding the received JSON and store into $obj variable.
 $obj = json_decode($json,true);
 
 // Getting User email from JSON $obj array and store into $email.
 
 $email = $obj["email"];
 
 // Getting Password from JSON $obj array and store into $password.
 $pass = $obj['pass'];
 
 //Applying User Login query with email and password.
$sql = "SELECT role FROM user WHERE email='$email' && pass='$pass'";
$result = $conn->query($sql);
 
 
 
	if($result->num_rows > 0){
		$row = $result->fetch_assoc();
		if($row[role]==1){
		 // Successfully Login Message.
		 $onLoginSuccess = 'Admin';
		 
		 // Converting the message into JSON format.
		 $SuccessMSG = json_encode($onLoginSuccess);
		 
		 // Echo the message.
		 echo $SuccessMSG ;} 
	 else{
		 // Successfully Login Message.
		 $onLoginSuccess = 'User';
		 
		 // Converting the message into JSON format.
		 $SuccessMSG = json_encode($onLoginSuccess);
		 
		 // Echo the message.
		 echo $SuccessMSG ;}
	 }
	 
	 else{
	 
		 // If Email and Password did not Matched.
		$InvalidMSG = 'Invalid Username or Password Please Try Again' ;
		 
		// Converting the message into JSON format.
		$InvalidMSGJSon = json_encode($InvalidMSG);
		 
		// Echo the message.
		 echo $InvalidMSGJSon ;
	 
	 }
 
 mysqli_close($con);
 ?>