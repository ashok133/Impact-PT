<?php
//Registers a new user
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

    $fname = $_GET['fname'];
    $mname = $_GET['mname'];
    $lname = $_GET['lname'];
    $username = $_GET['username'];
    $password = $_GET['password'];
    $hashedPass = password_hash($password, PASSWORD_DEFAULT);

      $userCheck = mysqli_query($con, "SELECT Username FROM Login Where Username='$username'");
        if (mysqli_num_rows($userCheck) > 0) {
            echo "username taken.";
        }
        else {
          $insertUser = "INSERT INTO User (FirstName, MiddleName, LastName, Verified) VALUES ('$fname', '$mname', '$lname', 'n')";
            if(mysqli_query($con, $insertUser)){
                echo 'userinsertsuccess';
            }
            else{
                echo 'userinsertfail';
            }
          $getID = "SELECT UserID FROM User Where FirstName='$fname' and MiddleName='$mname' and LastName='$lname'";
            $result1 = mysqli_query($con, $getID);
            if (mysqli_num_rows($result1) > 0){
                while($row=mysqli_fetch_assoc($result1)){
                    $userID = $row['UserID'];
                    echo $userID;
                }
            }
            else{
                echo 'userselectfail';
            }
          $sql2 = "INSERT INTO Login (UserID, Username, Password) VALUES ('$userID', '$username', '$hashedPass')";
            if(mysqli_query($con, $sql2)){
                echo 'logininsertsuccess';
            }
            else{
                echo 'logininsertfail';
            }

        }
    mysqli_close($con);
?>
