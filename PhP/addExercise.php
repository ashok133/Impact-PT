<?php
//Adds exercise to database
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

 	$name = $_GET['name'];
 	$description = $_GET['description'];

	$addExercise = "INSERT INTO Exercise (Name, Description) VALUES ('$name','$description')";

            if (mysqli_query($con, $addExercise)){
               echo 'success';
            }

            else {
                echo 'limitationupdatefail';
            }

?>
