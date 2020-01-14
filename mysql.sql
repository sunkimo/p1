-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- 主機： localhost
-- 產生時間： 2020 年 01 月 14 日 20:46
-- 伺服器版本： 10.3.18-MariaDB
-- PHP 版本： 7.2.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `sunkimo`
--
CREATE DATABASE IF NOT EXISTS `sunkimo` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `sunkimo`;

-- --------------------------------------------------------

--
-- 資料表結構 `people`
--

CREATE TABLE `people` (
  `p_num` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `id` varchar(10) NOT NULL,
  `address` varchar(60) NOT NULL,
  `rfid_no` varchar(8) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0,
  `rname` varchar(10) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `mphone` varchar(10) NOT NULL,
  `rlinetoken` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 傾印資料表的資料 `people`
--

INSERT INTO `people` (`p_num`, `name`, `id`, `address`, `rfid_no`, `state`, `rname`, `telephone`, `mphone`, `rlinetoken`) VALUES
(1, '王大明', 'T123456789', '屏東市大馬路1號', '791cd85a', 1, '王小明', '087654321', '0987654321', 'e5ugA1t7eLyVGLX3hA9Fo8RLrfXsXIRnkBcr9ZHYGoK'),
(2, '張大千', 'T123456780', '屏東市大馬路2號', '32e4d21e', 1, '張小千', '087654320', '0987654320', 'Tnr8sAjy7CslvMbbZuuu0t8W1D1B25NdyXLFJWbx67o'),
(3, '李四', 'T123456785', '屏東市大馬路3號', '00000000', 0, '李小二', '087654323', '0987654322', 'e5ugA1t7eLyVfsdgsdsfasf5435435353453'),
(10, 'sdfas', 'sadfsad', 'sadfsa', 'fdsaf11', 0, 'sadfsad', 'sadf', '0987654321', '123456789abcdekskgkda'),
(11, '吳56', 'T12236855', '屏東市大馬路100號', '123456aa', 0, '吳大', '23423', '0987654321', '123456789abcdekskgkd'),
(12, '吳585', 'T12236811', '屏東市大馬路100號', '123456bc', 0, '吳大', '23423', '0987654321', '123456789abcdekskgkdadds2');

-- --------------------------------------------------------

--
-- 資料表結構 `record`
--

CREATE TABLE `record` (
  `rec_num` int(11) NOT NULL,
  `rfid_no` varchar(50) NOT NULL,
  `sensorID` varchar(10) NOT NULL,
  `time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `rfid`
--

CREATE TABLE `rfid` (
  `rf_num` int(11) NOT NULL,
  `rfid_no` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `sensor`
--

CREATE TABLE `sensor` (
  `sn_num` int(11) NOT NULL,
  `sensorID` varchar(10) NOT NULL,
  `location` varchar(50) NOT NULL,
  `sn_address` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 傾印資料表的資料 `sensor`
--

INSERT INTO `sensor` (`sn_num`, `sensorID`, `location`, `sn_address`) VALUES
(1, 'PT900001', '22.657137,120.510836', '屏東大學-屏商校區-圖資大樓'),
(2, 'PT900002', '22.660163,120.511098', '屏東市民生東路60號'),
(3, 'PT900003', '25.657137,120.510836', '感測位置7'),
(4, 'PT900004', '25.657137,125.510836', '感測位置8'),
(5, 'PT900005', '27.657137,120.510836', '感測位置2'),
(6, 'PT900006', '25.657137,105.510836', '感測位置10');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`p_num`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `rfid_no` (`rfid_no`);

--
-- 資料表索引 `record`
--
ALTER TABLE `record`
  ADD PRIMARY KEY (`rec_num`);

--
-- 資料表索引 `rfid`
--
ALTER TABLE `rfid`
  ADD PRIMARY KEY (`rf_num`);

--
-- 資料表索引 `sensor`
--
ALTER TABLE `sensor`
  ADD PRIMARY KEY (`sn_num`),
  ADD UNIQUE KEY `sensorID` (`sensorID`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `people`
--
ALTER TABLE `people`
  MODIFY `p_num` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `record`
--
ALTER TABLE `record`
  MODIFY `rec_num` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `rfid`
--
ALTER TABLE `rfid`
  MODIFY `rf_num` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `sensor`
--
ALTER TABLE `sensor`
  MODIFY `sn_num` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
