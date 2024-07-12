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

$conn->set_charset("utf8");

$now = isset($_POST["sdate"]) ? new DateTime($_POST["sdate"]) : new DateTime();

$room1 = ($_POST["room1"] ?? "") . "%";
$room2 = "%" . ($_POST["room2"] ?? "") . "%";
$title = "%" . str_replace(" ", "", ($_POST["title"]) ?? "") . "%";
$status = "%" . ($_POST["status"] ?? "승인") . "%";
$time = $_POST["time"] ?? "3";
$sdate = $_POST["sdate"] ?? $now->format("Y-m-d");
$ldate = $_POST["ldate"] ?? $now->modify("+1 day")->format("Y-m-d");

$stmt = $conn->prepare("SELECT *, Date_format(사용날짜, '%Y-%m-%d') as 날짜,"
  . "(abs(TIMESTAMPDIFF(minute, 사용날짜, now())) < 60) and 신청여부 = '승인' as 시간 FROM report "
  . "left join status on report.id = status.id "
  . "left join tel on report.id = tel.id "
  . "where 회의실 LIKE ? "
  . "and 회의실 LIKE ? "
  . "and not (회의실 LIKE '%제1동(지상3층)%') "
  . "and replace(회의명, ' ', '') LIKE ? "
  . "and 신청여부 LIKE ? "
  . "and ((Date_format(사용날짜, '%H') > 12) + 1) <> ? "
  . "and 사용날짜 between ? and ? "
  . "order by 날짜 desc, sort, 사용날짜");

$stmt->bind_param("sssssss", $room1, $room2, $title, $status, $time, $sdate, $ldate);
$stmt->execute();
$result = $stmt->get_result();

if ($result === false) {
  echo "FALSE";
  die("Query failed: " . $conn->error);
}

header('Content-type: application/json; charset=utf-8');
echo json_encode($result->fetch_all(MYSQLI_ASSOC), JSON_UNESCAPED_UNICODE);

$conn->close();
