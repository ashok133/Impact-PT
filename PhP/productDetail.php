<?php
//Describes product details
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
//        echo "Connected to the database, ";
    }

 	$product = $_GET['product'];

	$getinfo = "SELECT * FROM AssignedProducts INNER JOIN Products ON Products.Name = AssignedProducts.Product Where Name='$product'";
            $result = mysqli_query($con, $getinfo);
            if (mysqli_num_rows($result) > 0){
                while($row=mysqli_fetch_assoc($result)){
                    $description = $row['Description'];
                    $cost = $row['Price'];

                    echo $description;
                    echo '/';
                    echo $cost;
                    echo '/';

                    //$image = $row['Image'];
                    //echo '<img src="'.$image.'" alt="HTML5 Icon" style="width:128px;height:128px">';
                    //echo $image;
              			//echo '<img src="data:image/jpeg;base64,'.base64_encode( $row['Image'] ).'"/>';
                }
            }
            else{
                echo 'productselectfail';
            }
?>
