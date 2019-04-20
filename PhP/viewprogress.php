<?php
//Selects a user's progress notes
    $con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
    { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        //        echo "Connected to the database, ";
    }

    $userid = $_GET['userid'];

    $getinfo = "SELECT * FROM Progress Where UserID='$userid'";
    $result = mysqli_query($con, $getinfo);
    if (mysqli_num_rows($result) > 0){
        while($row=mysqli_fetch_assoc($result)){
            $date = $row['actionDate'];
            echo $date;
            echo ' - ';
            $action = $row['Action'];
            echo $action;
            echo ':';
            $measurement = $row['Measurement'];
            echo $measurement;
            echo '/';
        }
    }
    else{
        echo 'progressselectfail';
    }
    ?>
