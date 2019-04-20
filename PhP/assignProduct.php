<?php
//Assigns product to user
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
        echo "Connected to the database, ";
    }

    $userid = $_GET['userid'];
    echo $userid;
    $product = $_GET['product'];
    echo $product;
    $description = $_GET['description'];
    echo $description;




        $assignProduct = "INSERT INTO AssignedProducts (UserID, Product, Description) VALUES ('$userid','$product','$description')";
          if (mysqli_query($con, $assignProduct)){
              echo 'assignedinsertsuccess/';
            }
          else{
              echo 'assignedinsertfail';
            }



    mysqli_close($con);
?>
