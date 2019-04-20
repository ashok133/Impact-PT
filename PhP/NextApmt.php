<?php
//Displays next appointment for a User
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database";
		echo '/';
    }

  $userid = $_GET['userid'];

  $getAppmt = "SELECT * FROM Appointments WHERE PhysicianID = '$userid' ORDER BY apmtDate;";
      $result = mysqli_query($con, $getAppmt);
      if (mysqli_num_rows($result) > 0) {
        while($row=mysqli_fetch_assoc($result)) {
            $date = $row['apmtDate'];
                echo $date;
                echo '/';
            $time = $row['apmtTime'];
			         echo $time;
			          echo '/';
            $patient = $row['PatientID'];
			         echo $patient;
               echo '/';
          echo '///';
        }
      }
      else {
        echo 'mysql query failed';
      }
?>
