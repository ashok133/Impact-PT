<?php
//Assigns exercise to user
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

    $userid = $_GET['userid'];
    echo $userid;
    $exercise = $_GET['exercise'];
    echo $exercise;
    $duration = $_GET['duration'];
    echo $duration;
    $reps = $_GET['reps'];
    echo $reps;
    $times = $_GET['times'];
    echo $times;

      $userCheck = mysqli_query($con, "SELECT Name FROM Exercise Where Name='$name'");
        if (mysqli_num_rows($userCheck) > 0) {
            echo "/exercise exists/";
        }
        else {
          $insertExercise = "INSERT INTO Exercise (Name) VALUES ('$name')";
            if(mysqli_query($con, $insertExercise)){
                echo 'exerciseinsertsuccess/';
            }
            else{
                echo 'exerciseinsertfail';
            }
          }
        $assignExercise = "INSERT INTO AssignedExercise (UserID, Exercise, Duration, Reps, Times) VALUES ('$userid','$exercise','$duration','$reps','$times')";
          if (mysqli_query($con, $assignExercise)){
              echo 'assignedinsertsuccess/';
            }
          else{
              echo 'assignedinsertfail';
            }



    mysqli_close($con);
?>
