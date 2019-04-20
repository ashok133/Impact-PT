<?php
//Creates appointment in database
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database";
    }

    $userid = $_GET['userid'];
    $apmtDate = $_GET['apmtDate'];
    $apmtTime = $_GET['apmtTime'];
    $patientid = $_GET['patient'];

    echo $userid;
    echo '-';
    echo $apmtDate;
    echo '-';
    echo $apmtTime;
    echo '-';
    echo $patient;
    echo '-';

    $insertAppointment = "INSERT INTO Appointments(PhysicianID,apmtDate,apmtTime,PatientID) VALUES('$userid','$apmtDate','$apmtTime','$patientid')";
    if(mysqli_query($con, $insertAppointment)) {
        echo 'successfully created appointment';
    }
    else {
        echo 'failed to create appointment';
    }

?>
