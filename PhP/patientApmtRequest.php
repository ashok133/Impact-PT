<?php
//Creates an appointment request for a patient
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database ";
    }

    $patientName = $_GET['patientName'];
    $rqstDate = $_GET['rqstDate'];
    $injuryLocation = $_GET['injuryLocation'];

    $insertRequest = "INSERT INTO Requests(patientName, rqstDate, injuryLocation) VALUES ('$patientName','$rqstDate','$injuryLocation');";
    if(mysqli_query($con, $insertRequest)) {
        echo 'successful request';
    }
    else {
        echo 'the request failed';
    }

?>
