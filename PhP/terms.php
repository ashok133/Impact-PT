<?php
//Changes terms and condition status
$conn = mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13", "i494f18_team13");

if (mysqli_connect_errno())
	{echo nl2br("Failed to connect to MySQL: " . mysqli_connect_error() . "\n ");}
else
	{echo nl2br("Established Database Connection \n");}

	$userid = $_GET['UserID'];
	echo '$userid';
	$updateinfo= "UPDATE User SET Verified = 'y' WHERE UserID=$userid";
	if (mysqli_query($conn, $updateinfo)){
                echo 'success';
                }
            	else{
             	   echo 'terms failed';
           		 }




mysqli_close($conn);
?>
