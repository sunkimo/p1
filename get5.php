<?php
$dsn = "mysql:dbname=sunkimo;host=localhost;port=3306";
$username = "sunkimo";	//資料庫 登入帳號
$password = "123456";	//資料庫 登入密碼

$access_token[] = "";  //line-notify token

$id=$_GET["msg"];   //rfid
$sensorID=$_GET["sensorID"];  //感測器編號
$sn_address="";  //感測器位置


try 
{
   // 建立MySQL伺服器連接和開啟資料庫 
   $link = new PDO($dsn, $username, $password);
   
   // 指定PDO錯誤模式和錯誤處理
   $link->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);

   
   $sql = "SELECT * FROM people where rfid_no='".$id."'";      
   // 送出UTF8編碼的MySQL指令
   $link->query('SET NAMES utf8');
   // 送出查詢的SQL指令
   
   
   if ( $result = $link->query($sql) ) 
   {           
      $total_records = $result->rowCount();      // 取得記錄數     
	  $row = $result->fetch(PDO::FETCH_ASSOC);	 //
      
	  $access_token[0] = $row["rlinetoken"];	 //取出對應的 line-notify token
	  $name=$row["name"];  						 //取出對應的 失蹤人的姓名
	  
	  
	  $sql = "SELECT * FROM sensor where sensorID='".$sensorID."'";
	  $result = $link->query($sql);
	  $row = $result->fetch(PDO::FETCH_ASSOC);
	  $sn_address = $row["sn_address"];			 //感測器的地址
	  $location = $row["location"];              //感測器的GPS資料
   } 
} 
catch (PDOException $e) 
{
   echo "連接失敗: " . $e->getMessage();
}



if($total_records>0)
{
	//組合message的資料，包含(時間，RFID號碼，失蹤人姓名，感測位置，google map網址，GPS字串)

	$message="\r\n時間: ".date('Y-m-d H:i:s')."\r\n\r\n"."RFID:".$id."\r\n";
	$message.="失蹤人: ".$name."\r\n\r\n";
	$message.="感測位置:\r\n".$sn_address."\r\n";
	$message.="\r\n"."https://www.google.com/maps?q=".$location;

	$TargetCount = count($access_token);
	$Push_Content['message'] = $message;
  
	//  for ($i=0;$i<$TargetCount;$i++) 
	//  {
		$ch = curl_init("https://notify-api.line.me/api/notify");
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($Push_Content));
		curl_setopt($ch, CURLOPT_HTTPHEADER, array(
			'Content-Type: application/x-www-form-urlencoded',
			'Authorization: Bearer '.$access_token[0]));
			
		$response_json_str = curl_exec($ch);       //傳送message給聯絡人的line
		curl_close($ch);    
	//  };
	
	//$result = $link->query($sql)
 
}
 
$link = null;
?>

