<?php
//Selects a patients next appointment
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

if (!$con)
  { die("Failed to connect to MySQL: ".mysqli_connect_error."\n"); }

$userid = $_GET['userid'];
$physicianArr = [];
$patientArr = [];
$apmtArr = [];

$getPhysician = 'SELECT User.UserID, User.FirstName, User.LastName FROM User JOIN Physician ON User.UserID = Physician.UserID;';
$resultPhysician = mysqli_query($con, $getPhysician);
if (mysqli_num_rows($resultPhysician) > 0) {
  while($row=mysqli_fetch_assoc($resultPhysician)) {
    $physicianArr[] = $row;
  }
}
else {
  echo '/user select fail';
}

$getPatient = 'SELECT User.UserID, User.FirstName, User.LastName FROM User JOIN Player ON User.UserID = Player.UserID;';
$resultPatient = mysqli_query($con, $getPatient);
if (mysqli_num_rows($resultPatient) > 0) {
  while($row=mysqli_fetch_assoc($resultPatient)) {
    $patientArr[] = $row;
  }
}
else {
  echo '/user select fail';
}

$getApmt = "SELECT * FROM Appointments WHERE PatientID = '$userid'";
$resultApmt = mysqli_query($con, $getApmt);
if (mysqli_num_rows($resultApmt) > 0) {
  while($row=mysqli_fetch_assoc($resultApmt)) {
    $apmtArr[] = $row;
  }
}
else {
  echo 'mysqli query failed';
}

$finalJSON = array("Physician"=>$physicianArr, "Patient"=>$patientArr, "Appointment"=>$apmtArr);
echo json_encode($finalJSON);

?>
