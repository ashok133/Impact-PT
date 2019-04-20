<?php
//Display profile information
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

 	$userid = $_GET['userid'];

	$getinfo = "SELECT * FROM User Where UserID='$userid'";
            $result = mysqli_query($con, $getinfo);
            if (mysqli_num_rows($result) > 0){
                while($row=mysqli_fetch_assoc($result)){
                	echo '/';
                    $fname = $row['FirstName'];
                    echo $fname;
                    echo ' ';
                    $mname = $row['MiddleName'];
                    echo $mname;
                    echo ' ';
                    $lname = $row['LastName'];
                    echo $lname;
                    echo '/';
                }
            }
            else{
                echo 'userselectfail';
            }
    $getinfo1 = "SELECT * FROM Login Where UserID='$userid'";
            $result1 = mysqli_query($con, $getinfo1);
            if (mysqli_num_rows($result1) > 0){
                while($row=mysqli_fetch_assoc($result1)){
                    $username = $row['Username'];
                    echo $username;
                    echo '/';
                }
            }
            else{
                echo 'loginselectfail';
            }
	$getinfo2 = "SELECT * FROM Player Where UserID='$userid'";
            $result2 = mysqli_query($con, $getinfo2);
            if (mysqli_num_rows($result2) > 0){
                while($row=mysqli_fetch_assoc($result2)){
                    $phone = $row['Phone'];
                    echo $phone;
                    echo '/';
                    $email = $row['Email'];
                    echo $email;
                    echo '/';
                    $address = $row['Address'];
                    echo $address;
                    echo '/';
                    $age = $row['Age'];
                    echo $age;
                }
            }
            else{
                echo 'playerselectfail';
            }

?>
