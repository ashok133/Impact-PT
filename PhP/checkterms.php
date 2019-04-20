<?php
  //Checks if user has confirmed terms and conditions
    $con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
    { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

    userid = $_GET['userid'];
    $userCheck = mysqli_query($con, "SELECT Verified FROM User Where UserID='$userid'");
    if (mysqli_num_rows($userCheck) > 0) {
        while($row=mysqli_fetch_assoc($userCheck)){
            $v = $row['Verified'];
            echo "/";
            echo $v;
        }
    }
    else{
        echo 'error';
    }
