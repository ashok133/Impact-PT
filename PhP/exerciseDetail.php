<?php
//Selects exercise details to show user
$con=mysqli_connect("db.sice.indiana.edu","i494f18_team13","my+sql=i494f18_team13","i494f18_team13");

    if (!$con)
      { die("Failed to connect to MySQL: ".mysqli_connect_error. "\n"); }
    else {
//        echo "Connected to the database, ";
    }

 	$exercise = $_GET['exercise'];

	$getinfo = "SELECT * FROM AssignedExercise INNER JOIN Exercise ON Exercise.Name = AssignedExercise.Exercise Where Name='$exercise'";
            $result = mysqli_query($con, $getinfo);
            if (mysqli_num_rows($result) > 0){
                while($row=mysqli_fetch_assoc($result)){
                    $description = $row['Description'];
                    $reps = $row['Reps'];
                    $duration = $row['Duration'];
                    $times = $row['Times'];
                    echo $description;
                    echo '/';
                    echo $reps;
                    echo '/';
                    echo $duration;
                    echo '/';
                    echo $times;
                    echo '/';
                    //$image = $row['Image'];
                    //echo '<img src="'.$image.'" alt="HTML5 Icon" style="width:128px;height:128px">';
                    //echo $image;
              			//echo '<img src="data:image/jpeg;base64,'.base64_encode( $row['Image'] ).'"/>';
                }
            }
            else{
                echo 'limitationselectfail';
            }
?>
