-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.13 - MySQL Community Server - GPL
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- database 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `database` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `database`;

-- 테이블 database.coordinates 구조 내보내기
CREATE TABLE IF NOT EXISTS `coordinates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diaryID` varchar(45) NOT NULL,
  `userID` varchar(45) NOT NULL,
  `point` varchar(45) NOT NULL,
  `region` varchar(45) NOT NULL,
  `latitude` varchar(45) NOT NULL,
  `longitude` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 테이블 데이터 database.coordinates:~0 rows (대략적) 내보내기
DELETE FROM `coordinates`;
/*!40000 ALTER TABLE `coordinates` DISABLE KEYS */;
/*!40000 ALTER TABLE `coordinates` ENABLE KEYS */;

-- 테이블 database.diarydb 구조 내보내기
CREATE TABLE IF NOT EXISTS `diarydb` (
  `diaryID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` varchar(20) NOT NULL,
  `diaryTitle` varchar(64) NOT NULL,
  `diaryContent` text NOT NULL,
  `diaryDate` date NOT NULL,
  `startPoint` varchar(15) NOT NULL,
  `endPoint` varchar(15) NOT NULL,
  PRIMARY KEY (`diaryID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 테이블 데이터 database.diarydb:~0 rows (대략적) 내보내기
DELETE FROM `diarydb`;
/*!40000 ALTER TABLE `diarydb` DISABLE KEYS */;
/*!40000 ALTER TABLE `diarydb` ENABLE KEYS */;

-- 테이블 database.filedb 구조 내보내기
CREATE TABLE IF NOT EXISTS `filedb` (
  `diaryID` int(11) NOT NULL,
  `userID` varchar(20) NOT NULL,
  `fileName` varchar(45) DEFAULT NULL,
  `fileRealName` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 database.filedb:~0 rows (대략적) 내보내기
DELETE FROM `filedb`;
/*!40000 ALTER TABLE `filedb` DISABLE KEYS */;
/*!40000 ALTER TABLE `filedb` ENABLE KEYS */;

-- 테이블 database.userdb 구조 내보내기
CREATE TABLE IF NOT EXISTS `userdb` (
  `userID` varchar(20) NOT NULL,
  `userPassword` varchar(64) NOT NULL,
  `userName` varchar(20) NOT NULL,
  `userEmail` varchar(64) NOT NULL,
  `userEmailChecked` tinyint(1) NOT NULL,
  `emailCode` varchar(7) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 database.userdb:~1 rows (대략적) 내보내기
DELETE FROM `userdb`;
/*!40000 ALTER TABLE `userdb` DISABLE KEYS */;
INSERT INTO `userdb` (`userID`, `userPassword`, `userName`, `userEmail`, `userEmailChecked`, `emailCode`) VALUES
	('admin', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '관리자', 'name8997@naver.com', 1, 'l894f');
/*!40000 ALTER TABLE `userdb` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
