<?php
//Select all product name
    $con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
    { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }

    $getinfo = "select * from Products";
    $result = mysqli_query($con, $getinfo);
    if (mysqli_num_rows($result) > 0){
        while($row=mysqli_fetch_assoc($result)){
            $name = $row['Name'];
            echo $name;
            echo '/';
        }
    }
    else{
        echo '/user select fail';
    }
    ?>
