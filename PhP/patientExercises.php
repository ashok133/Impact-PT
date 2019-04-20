<?php
//Shows assigned exercises for a specific patient
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
//        echo "Connected to the database, ";
    }

 	$userid = $_GET['userid'];

	$getinfo = "SELECT * FROM AssignedExercise Where UserID='$userid'";
            $result = mysqli_query($con, $getinfo);
            if (mysqli_num_rows($result) > 0){
                while($row=mysqli_fetch_assoc($result)){
                    $name = $row['Exercise'];
                    echo '/';
                    echo $name;
                    echo '/';
                }
            }
            else{
                echo 'limitationselectfail';
            }
?>
