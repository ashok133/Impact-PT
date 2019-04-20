<?php
//Logins in and checks if they have checked terms and conditions and if user is patient or physician
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
        {die("Failed to connect to MySQL: " . mysqli_connect_error."\n"); }
    else {
        echo "Connected to the database";
    }

    $username = $_GET['username'];
    $password = $_GET['password'];

    $passresult = mysqli_query($con,"SELECT Password FROM Login where Username='$username'");
    if (mysqli_num_rows($passresult) > 0) {
        while ($row = mysqli_fetch_assoc($passresult)) {
        $hashpass = $row['Password'];
            if (password_verify($password, $hashpass)) {
                $query = "SELECT * FROM Login WHERE Username='$username' AND Password='$hashpass'";
                $result = mysqli_query($con, $query);
                if (mysqli_num_rows($result)) {
                    echo 'success';
                    while($row=mysqli_fetch_assoc($result)) {
                        $userID = $row['UserID'];
                        echo "/$userID";
                        $cred = $row['Credentials'];
                        echo "/cred=$cred";
                        $termCheck = mysqli_query($con, "SELECT Verified FROM User Where UserID='$userID'");
                        if (mysqli_num_rows($termCheck) > 0) {
                            while($row=mysqli_fetch_assoc($termCheck)){
                                $v = $row['Verified'];
                                echo "/";
                                echo $v;
                            }
                        }
                        else{
                            echo 'error';
                        }
                    }
                } else {
                    echo 'fail1';}
            } else {
                echo 'fail2';}
        }
    } else {
        echo 'fail3';}
    mysqli_close($con);
?>
