<html>
   <body>
      <form action="<?php echo $_SERVER['PHP_SELF'];?>" method = "POST">
         Name: <input type = "text" name = "name" />
        <input type = "submit" />
     </form>
  </body>
</html>

<?php
error_reporting(E_ALL);

if(isset( $_POST["name"]  )) {
        if($_POST["name"] == "") {
                exit();
        }
        $name = $_POST["name"];
        $servername = "10.0.1.218";
      $username = "root";
      $password = "root";
      $dbname = "test";
      $conn = mysqli_connect($servername, $username, $password, $dbname);
      if (!$conn) {
      die("Connection failed: " . mysqli_connect_error());
    }

        $sql = "INSERT INTO data (name) VALUES ('".$_POST["name"]."')";
        if (mysqli_query($conn, $sql)) {
        $new_sql = "SELECT * FROM data";
        $result = mysqli_query($conn, $new_sql);
        if (mysqli_num_rows($result) > 0) {
                    // output data of each row
                    echo "The following entries exists in the database:<br>";
                    while($row = mysqli_fetch_assoc($result)) {
                        echo "name: " . $row["name"]. "<br>";
                    }
                }
        } else {
            echo "Error: " . $sql . "<br>" . mysqli_error($conn);
        }
    mysqli_close($conn);


    exit();
   }
?>
