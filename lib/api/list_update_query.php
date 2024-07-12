<?php
header('Content-Type: text/html; charset=utf-8');
date_default_timezone_set('Asia/Seoul');

$servername = "localhost";
$username = "root";
$password = "2B@Dinterface";
$database = "mydb";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$stmt = $conn->prepare("SELECT (DATE_ADD(time, INTERVAL '0:30' HOUR_MINUTE) < now()) AS reset FROM ref ORDER BY time");
$stmt->execute();

$result = $stmt->get_result();

$row = $result->fetch_assoc();

if ($row['reset'] === "1") {
  $conn->set_charset("utf8");
  $sql = "INSERT INTO ref VALUES (now())";
  if ($conn->query($sql) === TRUE) {
    echo "success";
  } else {
    echo "failed";
  }
  $conn->close();
} else {
  echo "already";
}
