<?php
//Adds recovery notes to a patient
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

 	$userid = $_GET['userid'];
 	$notes = $_GET['notes'];

	$updatelimits = "INSERT INTO RecoveryNotes (UserID, Notes) VALUES ('$userid','$notes')";

            if (mysqli_query($con, $updatelimits)){
               echo 'success';
            }

            else {
                echo 'injuryupdatefail';
            }

?>
