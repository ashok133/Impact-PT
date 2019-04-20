<?php
//Displays next appointments
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
    }

  $userid = $_GET['userid'];
  $apmtArr = [];
  $userArr = [];

  $getAppmt = "SELECT * FROM Appointments WHERE PatientID = '$userid';";
      $result = mysqli_query($con, $getAppmt);
      if (mysqli_num_rows($result) > 0) {
        while($row=mysqli_fetch_assoc($result)) {
          $apmtArr[] = $row;
        }
      }
      else {
        echo 'mysql query failed';
      }

  $getUsers = "SELECT UserID, FirstName, LastName FROM User;";
    $resultUsers = mysqli_query($con, $getUsers);
    if (mysqli_num_rows($result) > 0) {
      while($row=mysqli_fetch_assoc($resultUsers)) {
        $userArr[] = $row;
      }
    }

$finalJSON = array("Appointments"=>$apmtArr, "Users"=>$userArr);
echo json_encode($finalJSON);

?>
