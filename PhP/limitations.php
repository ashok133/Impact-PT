<?php
//Add a Limitation injury to user
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

 	$userid = $_GET['userid'];
 	$limits = $_GET['limits'];

	$updatelimits = "INSERT INTO Limitation (UserID, Limits) VALUES ('$userid','$limits')";

            if (mysqli_query($con, $updatelimits)){
               echo 'success';
            }

            else {
                echo 'limitationupdatefail';
            }

?>
