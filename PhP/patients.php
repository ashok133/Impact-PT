<?php
//Displays a list of patients
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }

    $getinfo = "select * from User INNER JOIN Login ON User.UserID = Login.UserID WHERE Credentials = 0;";
    $result = mysqli_query($con, $getinfo);
    if (mysqli_num_rows($result) > 0){
        while($row=mysqli_fetch_assoc($result)){
          $userid = $row['UserID'];
          echo $userid;
          echo ': ';
          $fname = $row['FirstName'];
          $lname = $row['LastName'];
          echo $fname;
          echo ' ';
          echo $lname;
            echo '/';
        }
      }
      else{
        echo '/user select fail';
      }
?>
