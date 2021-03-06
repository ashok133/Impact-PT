<?php

class RegisterUser{

  public $username;
  public $firstName;
  public $lastName;
  public $email;
  public $password;
  public $phone;
  public $accessCode;

  public function __construct($data){
    $this->username = isset($data['username']) ? $data['username'] : null;
    $this->firstName = isset($data['firstName']) ? $data['firstName'] : null;
    $this->lastName = isset($data['lastName']) ? $data['lastName'] : null;
    $this->email = isset($data['email']) ? $data['email'] : null;
    $this->password = isset($data['password']) ? $data['password'] : null;
    $this->phone = isset($data['phone']) ? $data['phone'] : null;
    $this->accessCode = isset($data['accessCode']) ? $data['accessCode'] : null;
  }

  // for future use
  // public static function fetchAll(){
  //   $db= new PDO(DB_SERVER,DB_USER,DB_PW);
  //   $sql= 'SELECT * from RegisteredUsers';
  //   $statement=$db->prepare($sql);
  //   $success=$statement->execute();
  //   $arr=[];
  //   while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
  //     $temp =  new RegisterUser($row);
  //     array_push($arr, $temp);
  //   }
  //   return $arr;
  // }

  public function create() {

    // checking if the user already pcntl_wexitstatus
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);
    $user_check_query = "SELECT * FROM RegisteredUsers WHERE email = ? LIMIT 1";
    $user_check_stmt = $db->prepare($user_check_query);
    $status = $user_check_stmt->execute([
      $this->email
    ]);

    if($row = $user_check_stmt->fetch(PDO::FETCH_ASSOC)) {
      $queryArr = "User already exists";
      $json = json_encode($queryArr, JSON_PRETTY_PRINT);
      header('Content-Type: application/json');
      echo $json;
    }
    else {
      $db = new PDO(DB_SERVER, DB_USER, DB_PW);
      $sql = 'INSERT INTO RegisteredUser(username, firstName, lastName, email, pass, phone) VALUES (?, ?, ?, ?, ?, ?)';
      $statement = $db->prepare($sql);
      $success = $statement->execute([
        $this->username,
        $this->firstName,
        $this->lastName,
        $this->email,
        $this->password,
        $this->phone
      ]);
      $_SESSION['username'] = $this->username;
  	  $_SESSION['success'] = "You are now registered and logged in.";
      $queryArr = "User registered successfully";
      $json = json_encode($queryArr, JSON_PRETTY_PRINT);
      header('Content-Type: application/json');
      // header('location: logCheck.php');
      echo $json;
    }
  }

  public function checkUser() {
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);
    $user_check_query = "SELECT * FROM RegisteredUser WHERE username = ? AND pass = ? LIMIT 1";
    $user_check_stmt = $db->prepare($user_check_query);
    $status = $user_check_stmt->execute([
      $this->username,
      $this->password
    ]);

    $row = $user_check_stmt->fetch(PDO::FETCH_ASSOC);

    if($row) {
      $_SESSION['username'] = $this->username;
  	  $_SESSION['success'] = "You are now logged in";
      $queryArr = "User logged in successfully";
      $json = json_encode($queryArr, JSON_PRETTY_PRINT);
      header('Content-Type: application/json');
      // header('location: logCheck.php');
      echo $json;
    }

    else {
      $queryArr = "Wrong username: ". $this->username. "/ password: ".$this->password.". \nPlease try again.";
      $json = json_encode($queryArr, JSON_PRETTY_PRINT);
      header('Content-Type: application/json');
      echo $json;
    }
  }

  public function checkPhysician() {
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);
    $phy_check_query = "SELECT * FROM Physician WHERE username = ? AND accessCode = ? LIMIT 1";
    $phy_check_stmt = $db->prepare($phy_check_query);
    $status = $phy_check_stmt->execute([
      $this->username,
      $this->accessCode
    ]);

    $row = $phy_check_stmt->fetch(PDO::FETCH_ASSOC);

    if($row) {
      $_SESSION['username'] = $this->username;
  	  $_SESSION['success'] = "You are now logged in";
      $queryArr = "Hello ".$this->username.". Please click OK to continue";
      $json = json_encode($queryArr, JSON_PRETTY_PRINT);
      header('Content-Type: application/json');
      echo $json;
    }

    else {
      $queryArr = "Wrong username: ". $this->username. "/ access code: ".$this->password.". \nPlease try again. If problem persists, please contact the administrator.";
      $json = json_encode($queryArr, JSON_PRETTY_PRINT);
      header('Content-Type: application/json');
      echo $json;
    }
  }
}
