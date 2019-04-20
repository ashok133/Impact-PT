<?php
//Selects previous injuries from a patient
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
//        echo "Connected to the database, ";
    }

 	$userid = $_GET['userid'];

	$getinfo = "SELECT * FROM PreviousInjury Where UserID='$userid'";
            $result = mysqli_query($con, $getinfo);
            if (mysqli_num_rows($result) > 0){
                while($row=mysqli_fetch_assoc($result)){
                    $Injury = $row['Injury'];
                    echo '/';
                    echo $Injury;
                    echo '/';
                }
            }
            else{
                echo 'limitationselectfail';
            }
?>
