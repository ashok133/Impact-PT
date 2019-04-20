<?php
//Updates profile information if it doesn't already exist, adds it if it does
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

	$userid = $_GET['userid'];
    $phone = $_GET['phone'];
    $email = $_GET['email'];
    $address = $_GET['address'];
    $age = $_GET['age'];


	$getinfo = "SELECT * FROM Player Where UserID='$userid'";
            $result = mysqli_query($con, $getinfo);
            if (mysqli_num_rows($result) > 0){
                $updateinfo= "UPDATE Player SET Phone = '$phone', Email = '$email', Address = '$address', Age = '$age' WHERE UserID=$userid";
                if(mysqli_query($con, $updateinfo)){
                	echo 'updateplayersuccess';
            	}
            	else{
             	   echo 'userinsertfail';
           		 }
                }
            else{
                $insertUser = "INSERT INTO Player (UserID, Phone, Email, Address, Age) VALUES ('$userid', '$phone', '$email', '$address', '$age')";
                if(mysqli_query($con, $insertUser)){
                	echo 'insertplayersuccess';
            	}
            	else{
             	   echo 'userinsertfail';
           		 }
                }


?>
