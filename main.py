from machine import Pin
import time , network , urequests , mfrc522
#設定2個led  --------------------------------------------------
ready_LED=Pin(12,Pin.OUT)   #(綠色燈)，開機連網完成，會亮綠燈。
Yled=Pin(13,Pin.OUT)   #(黃色燈)，偵測到rfid會亮黃燈0.5秒。 
Yled.value(0)   #關閉(黃色燈)

#建立rfid物件  -------------------------------------------------
rfid = mfrc522.MFRC522(0,2,4,5,14)

#wifi   --------------------------------------------------------
sta_if = network.WLAN(network.STA_IF)
sta_if.active(True)
sta_if.connect("htc0318","aa651127")
while not sta_if.isconnected():
    pass
print("wifi已連上")
print(sta_if.ifconfig())
ready_LED.value(1)   #亮綠燈，表示已連上wifi

#設定  (伺服器ip)  與  (感測模組代號sensorID)  ------------------
serverip ='192.168.43.116'  #伺服器ip
sensorID="PT900001"  #感測器編號
msg=''      #  msg變數，儲存rfid

#lineNotify函數功能：傳送資料到伺服器 (1.偵測到的rfid  2.感測器編號sensorID )-------
def lineNotify(msg ,sensorID):
    url="http://"+serverip+"/get5.php?msg="+msg +"&sensorID="+sensorID
    r=urequests.get(url)
    return r.text #status_code

#偵測到rfid，亮黃燈0.5秒，並傳送資料到伺服器。   ------------------
while True:
    Yled.value(0)
    stat, tag_type = rfid.request(rfid.REQIDL)
    if stat == rfid.OK:
        stat, raw_uid = rfid.anticoll()
        if stat == rfid.OK:
            Yled.value(1)
            id = "%02x%02x%02x%02x" % (raw_uid[0], raw_uid[1], raw_uid[2], raw_uid[3])
        print("偵測到卡號： ", id)
        s = lineNotify(id,sensorID)
        print(s)    
    time.sleep(0.5)