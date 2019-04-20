<?php
//Adds a progress note to a user
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

    $userid = $_GET['userid'];
    $actiondate = $_GET['actiondate'];
    $action = $_GET['action'];
    $notes = $_GET['notes'];

        $setProgress = "INSERT INTO Progress (UserID, actionDate, Action, Measurement) VALUES ('$userid','$actiondate','$action','$notes')";
          if (mysqli_query($con, $setProgress)){
              echo 'progressinsertsuccess/';
            }
          else{
              echo 'progressinsertfail';
            }



    mysqli_close($con);
?>
