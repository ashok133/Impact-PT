<?php
//Selects patient names
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }

    $getinfo = "SELECT User.UserID, User.FirstName, User.LastName FROM User JOIN Player ON User.UserID = Player.UserID;";
    $result = mysqli_query($con, $getinfo);
    if (mysqli_num_rows($result) > 0){
        while($row=mysqli_fetch_assoc($result)){
          $patientID = $row['UserID'];
          echo $patientID;
          echo '-';
          $fname = $row['FirstName'];
          $lname = $row['LastName'];
          $fullName = $fname.' '.$lname;
          echo $fullName;
          echo '/';
        }
      }
      else{
        echo '/user select fail';
      }
?>
