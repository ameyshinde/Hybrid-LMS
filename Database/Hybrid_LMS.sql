-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 20, 2023 at 01:29 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student_attendance`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `admin_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `uname` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `aptitude`
--

CREATE TABLE `aptitude` (
  `quiz_no` int(11) NOT NULL,
  `question` varchar(200) DEFAULT NULL,
  `option1` varchar(100) DEFAULT NULL,
  `option2` varchar(100) DEFAULT NULL,
  `option3` varchar(100) DEFAULT NULL,
  `option4` varchar(100) DEFAULT NULL,
  `correct_option` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `apti_answers`
--

CREATE TABLE `apti_answers` (
  `quiz_no` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `userans` varchar(100) DEFAULT NULL,
  `correctans` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `year` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `post_date` date NOT NULL,
  `due_date` date NOT NULL,
  `upload_file` varchar(100) DEFAULT NULL,
  `lecturer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `teacher_id` int(11) NOT NULL,
  `teacher_name` varchar(100) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `uname` varchar(45) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `Subject` varchar(50) DEFAULT NULL,
  `Subject_code` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faculty_feedback`
--

CREATE TABLE `faculty_feedback` (
  `fid` int(11) NOT NULL,
  `faculty_name` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `feedback` varchar(400) DEFAULT NULL,
  `uname` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fee_Details`
--

CREATE TABLE `fee_Details` (
  `fee_id` int(11) NOT NULL,
  `StudentName` varchar(50) DEFAULT NULL,
  `Branch` varchar(40) DEFAULT NULL,
  `FeeType` varchar(60) DEFAULT NULL,
  `Amount` int(50) DEFAULT NULL,
  `UTRNo` varchar(200) DEFAULT NULL,
  `FileName` varchar(255) DEFAULT NULL,
  `Upload_date` date DEFAULT NULL,
  `Uploader` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inquiry`
--

CREATE TABLE `inquiry` (
  `inquiry_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `message` varchar(400) DEFAULT NULL,
  `uname` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `notes_id` int(11) NOT NULL,
  `Subject_code` varchar(20) DEFAULT NULL,
  `Subject` varchar(40) DEFAULT NULL,
  `FileName` varchar(255) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `Filetype` varchar(40) DEFAULT NULL,
  `Upload_date` date DEFAULT NULL,
  `file` mediumblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notice`
--

CREATE TABLE `notice` (
  `notice_id` int(11) NOT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `notice` varchar(600) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `notice_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projectinfo`
--

CREATE TABLE `projectinfo` (
  `pid` int(11) NOT NULL,
  `usn` varchar(100) DEFAULT NULL,
  `projecttitle` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `abstract` varchar(400) DEFAULT NULL,
  `status` varchar(100) DEFAULT 'PENDING',
  `feedback` varchar(220) DEFAULT 'NO FEEDBACK',
  `team` varchar(200) DEFAULT NULL,
  `Allocated_guide` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projectreport`
--

CREATE TABLE `projectreport` (
  `reportid` int(11) NOT NULL,
  `USN` varchar(45) DEFAULT NULL,
  `phase` int(11) DEFAULT NULL,
  `report` mediumblob DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `quiz_no` int(11) NOT NULL,
  `question` varchar(200) DEFAULT NULL,
  `option1` varchar(100) DEFAULT NULL,
  `option2` varchar(100) DEFAULT NULL,
  `option3` varchar(100) DEFAULT NULL,
  `option4` varchar(100) DEFAULT NULL,
  `correct_option` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_answers`
--

CREATE TABLE `quiz_answers` (
  `quiz_no` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `userans` varchar(100) DEFAULT NULL,
  `correctans` varchar(100) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `reportid` int(11) NOT NULL,
  `USN` varchar(45) DEFAULT NULL,
  `phase` int(11) DEFAULT NULL,
  `report` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `stud_name` varchar(100) DEFAULT NULL,
  `college_name` varchar(100) DEFAULT NULL,
  `branch` varchar(15) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `address` varchar(400) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `uname` varchar(45) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `stud_name`, `college_name`, `branch`, `mobile`, `address`, `email`, `uname`, `password`, `status`) VALUES
(1001, 'Kishor Kadam', 'VIMEET', 'COMPS', '9404308673', 'Khalapur', 'kadamk33@gmail.com', 'kishor', 'testpass', 1),
(1002, 'Aniket Kadam', 'VIMEET', 'COMPS', '9459227305', 'Khalapur', 'kadamk329@yahoo.com', 'aniket', 'RfeM@uucjA', 1),
(1003, 'Sanket Kadam', 'VIMEET', 'COMPS', '9404308673', 'Khalapur', 'kadamsanket02@gmail.com', 'sanket', '76mhK8CVjX', 0),
(1005, 'Sagar Kharmale', 'VIMEET', 'COMPS', '8855474515', 'Khalapur', 'kharmalesagar@gmail.com', 'sagar', 'ydmNqbRRXH', 1),
(1007, 'Arun Pandit', 'VIMEET', 'COMPS', '7475763616', 'Khalapur', '30arunpandit@gmail.com', 'arun', 'arun', 1),
(1018, 'Shashi Bhure', 'VIMEET', 'COMPS', '9754212356', 'Khalapur', 'shash.88shashi@gmai.com', 'shashi', 'ceMQVdR4q3', 1),
(1019, 'Javed Tamboli', 'VIMEET', 'COMPS', '8855746582', 'Khalapur', 'javed.tamboli33@gmail.com', 'javed', 'x2DNhC8uU3', 1),
(1020, 'Govind Raut', 'VIMEET', 'COMPS', '7858566968', 'Khalapur', 'govindraut22@yahoomail.com', 'govind', 'xS8@ha@2gZ', 1),
(1024, 'David Smith  ', 'VIMEET', 'COMPS', '9404308601', 'Khalapur', 'davidjose94@gmail.com ', 'david', '4UsHjF3V@k', 1),
(1025, 'Rogers Johnson', 'VIMEET', 'COMPS', '9404308602', 'Khalapur', 'rogers12@yahoomail.com', 'rogers', 'BC8phEeTxe', 1),
(1026, 'David Williams  ', 'VIMEET', 'COMPS', '9404308603', 'Khalapur', 'david58@gmail.com', 'david', 'tje7meU74C', 1),
(1027, 'Maria Jones', 'VIMEET', 'COMPS', '9404308604', 'Khalapur', 'mariadecosta@yahoomail.com', 'maria', 'EArgsGJa3m', 1),
(1028, 'Morris Brown', 'VIMEET', 'COMPS', '9404308605', 'Khalapur', 'morrisjames@gmail.com', 'morris', 'NXKhKcVBfk', 1),
(1029, 'Daniel Davis', 'VIMEET', 'COMPS', '9404308606', 'Khalapur', 'danielvictori@yahoomail.com', 'daniel', '1', 1),
(1030, 'Sanders Miller', 'VIMEET', 'COMPS', '9404308607', 'Khalapur', 'sanders56@gmail.com', 'sanders', 'WTkgK7HM5t', 1),
(1031, 'Mark Stoinis', 'VIMEET', 'COMPS', '9404308608', 'Khalapur', 'mark334@gmail.com', 'mark', 'Kt@@RdVvy4', 1),
(1032, 'Morgan Moore', 'VIMEET', 'COMPS', '9404308609', 'Khalapur', 'morganwillams@gmail.com', 'morgan', 'bNUnYP@eay', 1),
(1033, 'Paul Taylor', 'VIMEET', 'COMPS', '9404308610', 'Khalapur', 'paul@gmail.com', 'paul', 'paul', 1),
(1034, 'David Anderson', 'VIMEET', 'COMPS', '9404308611', 'Khalapur', 'david90@yahoomail.com', 'david', 'david', 1),
(1035, 'Chrishaydon Thomas', 'VIMEET', 'COMPS', '9404308612', 'Khalapur', 'chrishaydon78@gmail.com', 'chrishaydon', 'NRx@bT9hc6', 1),
(1036, 'Michael Jackson', 'VIMEET', 'COMPS', '9404308613', 'Khalapur', 'michaeltoddy@hotmail.com', 'michael', '8w4G4hFNaj', 1),
(1037, 'Morgan White  ', 'VIMEET', 'COMPS', '9404308614', 'Khalapur', 'morgan201@gmail.com', 'morgan', 'EyTWKc4GyR', 1),
(1038, 'Rogers Harris', 'VIMEET', 'COMPS', '9404308619', 'Khalapur', 'rogers@hotmail.com', 'rogers', 'kp9rtpcrAD', 1),
(1039, 'Morgan Martin', 'VIMEET', 'COMPS', '9404308616', 'Khalapur', 'morgantoms@yahoomail.com', 'morgan', 'E9Htq9PPJJ', 1),
(1040, 'Morgan Thompson', 'VIMEET', 'COMPS', '9404308617', 'Khalapur', 'morgan85@gmail.com', 'morgan', 'aaDUbe5Ecw', 1),
(1041, 'David Garcia  ', 'VIMEET', 'COMPS', '9404308618', 'Khalapur', 'davidjones@gmail.com', 'david', 'UNSSTj7Uqr', 1),
(1042, 'Maria Martinez  ', 'VIMEET', 'COMPS', '9404308619', 'Khalapur', 'maria_shell@gmail.com', 'maria', 'fqbayTtG@N', 1),
(1043, 'Mike Robinson  ', 'VIMEET', 'COMPS', '9404308620', 'Khalapur', 'mike35@gmail.com', 'mike', 'g6N3mZwQmv', 1),
(1044, 'Miller Clark  ', 'VIMEET', 'COMPS', '9404308621', 'Khalapur', 'milerdavid@yahoomail.com', 'miller', 'KVvBQzcV58', 1),
(1045, 'Ross Rodriguez', 'VIMEET', 'COMPS', '9404308622', 'Khalapur', 'ross45@gmail.com', 'ross', 'gjxpKU62Wz', 1),
(1046, 'Brooks  Lewis  ', 'VIMEET', 'COMPS', '9404308623', 'Khalapur', 'brooks@gmail.com', 'brooks', 'bqQma2EN6s', 0),
(1047, 'Miller Lee ', 'VIMEET', 'COMPS', '9404308624', 'Khalapur', 'miller90@hotmail.com', 'miller', 'x2wZUNRs@D', 1),
(1048, 'Mike Walker ', 'VIMEET', 'COMPS', '9404308625', 'Khalapur', 'mike@hotmail.com', 'mike', '7n72fBTvHz', 1),
(1049, 'Wright Hall', 'VIMEET', 'COMPS', '9404308626', 'Khalapur', 'wright67@gmail.com', 'wright', 'A82mmc87AH', 1),
(1050, 'David Allen', 'VIMEET', 'COMPS', '9404308627', 'Khalapur', 'david_hussy@gmail.com', 'david', 'NHsFRPhEW7', 1),
(1051, 'Smith Young', 'VIMEET', 'COMPS', '9404308628', 'Khalapur', 'smith40@gmail.com', 'smith', 'VJvM3SsADq', 1),
(1052, 'Paul Hernandez  ', 'VIMEET', 'COMPS', '9404308629', 'Khalapur', 'paul789@gmail.com', 'paul', '58PRP4g59c', 1),
(1053, 'Michael King', 'VIMEET', 'COMPS', '9404308630', 'Khalapur', 'michaeljons@gmail.com', 'michael', 'KZer2@MQGS', 1),
(1054, 'Michael Wright', 'VIMEET', 'COMPS', '9404308631', 'Khalapur', 'michaelbuddy@gmail.com', 'michael', 'zUkKKAkXxv', 1),
(1055, 'John Lopez', 'VIMEET', 'COMPS', '9404308632', 'Khalapur', 'johnwright@gmail.com', 'john', 'EZDNz4TzaR', 1),
(1056, 'Paul Hill', 'VIMEET', 'COMPS', '9404308633', 'Khalapur', 'paul_sen@gmail.com', 'paul', 'gK@ryuNNHH', 0),
(1057, 'Ross Tiger', 'VIMEET', 'COMPS', '9404308634', 'Khalapur', 'ross@yahoomail.com', 'ross', '7aUsYzZbRR', 1),
(1058, 'Brooks Green', 'VIMEET', 'COMPS', '9404308635', 'Khalapur', 'brooks856@hotmail.com', 'brooks', 'g6WxpNTnkR', 1),
(1059, 'Cooper Adams', 'VIMEET', 'COMPS', '9404308636', 'Khalapur', 'cooper@gmail.com', 'cooper', 'v@kEnQBZ94', 1),
(1060, 'Ross Baker', 'VIMEET', 'COMPS', '9404308637', 'Khalapur', 'rossToms@gmail.com', 'ross', 'Gy7HGGrJwd', 1),
(1061, 'Cooper Gonzalez', 'VIMEET', 'COMPS', '9404308638', 'Khalapur', 'cooper90@gmail.com', 'cooper', 'kEdjKRfb6M', 1),
(1062, 'Jenny Nelson', 'VIMEET', 'COMPS', '9404308639', 'Khalapur', 'jenny@gmail.com', 'jenny09', 'StTUgnR6Vt', 1),
(1063, 'Paul Carter', 'VIMEET', 'COMPS', '9404308640', 'Khalapur', 'paul8979@gmail.com', 'paul', '4cjh3yvrTz', 1),
(1064, 'Maria Mitchell ', 'VIMEET', 'COMPS', '9404308641', 'Khalapur', 'maria809@gmail.com', 'maria', 'fB7ygxX6sJ', 1),
(1065, 'Bell Perez', 'VIMEET', 'COMPS', '9404308642', 'Khalapur', 'bell@yahoomail.com', 'bell', 'HFeqFh5KTe', 1),
(1066, 'Rivera Roberto ', 'VIMEET', 'COMPS', '9404308643', 'Khalapur', 'rivera@gmail.com', 'rivera', 'BeGQY@nFg5', 1),
(1067, 'Mark Turner', 'VIMEET', 'COMPS', '9404308644', 'Khalapur', 'mark7989@gmail.com', 'mark', 'EcpN2nkSAZ', 1),
(1068, 'Paul Phillips  ', 'VIMEET', 'COMPS', '9404308645', 'Khalapur', 'paul00@gmail.com', 'paul', 'a7SvchyACr', 1),
(1069, 'Brooks Campbell', 'VIMEET', 'COMPS', '9404308646', 'Khalapur', 'brooks@yahoomail.com', 'brooks', '6QpbZNEcU3', 1),
(1070, 'James Parker  ', 'VIMEET', 'COMPS', '9404308647', 'Khalapur', 'james3456@gmail.com', 'james', 'tAUKHCznNK', 1),
(1071, 'John Evans', 'VIMEET', 'COMPS', '9404308648', 'Khalapur', 'john9887@gmail.com', 'john', 'xGGN9zWvVZ', 1),
(1072, 'Rivera Edwards', 'VIMEET', 'COMPS', '9404308649', 'Khalapur', 'rivera777@gmail.com', 'rivera', '5UPAjngeqT', 1),
(1073, 'Chrishaydon Collins', 'VIMEET', 'COMPS', '9404308650', 'Khalapur', 'chrishaydon50@hotmail.com', 'chrishaydon', 'Pr8U@K2bBr', 1),
(1074, 'Bell Stewart ', 'VIMEET', 'COMPS', '9404308651', 'Khalapur', 'bell@gmail.com', 'bell', 'SpJE7JRsXV', 1),
(1075, 'Morris Sanchez  ', 'VIMEET', 'COMPS', '9404308652', 'Khalapur', 'morris@gmail.com', 'morris', 'q@UPxNxtN8', 1),
(1076, 'Cooper  Morris', 'VIMEET', 'COMPS', '9404308653', 'Khalapur', 'copper000@gmail.com', 'cooper', 'aEjb@AD5sd', 1),
(1077, 'James Gosling', 'VIMEET', 'COMPS', '9404308654', 'Khalapur', 'jamesgosling@gmail.com', 'james', '57bGB5Yjtp', 1),
(1078, 'Brooks Reed', 'VIMEET', 'COMPS', '9404308655', 'Khalapur', 'brooks78@rediffmail.com', 'brooks', 'htX@ZJ9GQh', 1),
(1079, 'Morgan Cook', 'VIMEET', 'COMPS', '9404308656', 'Khalapur', 'morgan7657@gmail.com', 'morgan', 'XaxMDK7PbF', 1),
(1080, 'Rivera Morgan', 'VIMEET', 'COMPS', '9404308657', 'Khalapur', 'rivera0989@gmail.com', 'rivera', 'Zr3DtkU4JU', 1),
(1081, 'Bell Johnson', 'VIMEET', 'COMPS', '9404308658', 'Khalapur', 'bell6666@gmail.com', 'bell', 'YcW2pW8PEE', 1),
(1082, 'Wright Murphy', 'VIMEET', 'COMPS', '9404308659', 'Khalapur', 'johnwright@yahoomail.com', 'wright', 'dYWp6e2Pex', 1),
(1083, 'Wright Bailey', 'VIMEET', 'COMPS', '9404308660', 'Khalapur', 'wright88@gmail.com', 'wright', 'VeFvr@W8@y', 1),
(1084, 'Smith Rivera', 'VIMEET', 'COMPS', '9404308661', 'Khalapur', 'smithdavid90@gmail.com', 'smith', 'hzTas2uGRg', 1),
(1085, 'Bell Cooper', 'VIMEET', 'COMPS', '9404308662', 'Khalapur', 'bellToms@gmail.com', 'bell', 'bKdpRAMbde', 1),
(1086, 'Rivera Richardson', 'VIMEET', 'COMPS', '9404308663', 'Khalapur', 'rivera847@gmail.com', 'rivera', 'tv7ysH@ar7', 1),
(1087, 'Brooks Cox', 'VIMEET', 'COMPS', '9404308664', 'Khalapur', 'brooks58@gmail.com', 'brooks', 'w35hPHst3B', 1),
(1088, 'Chrishaydon Howards', 'VIMEET', 'COMPS', '9404308665', 'Khalapur', 'chris@hotmail.com', 'chrishaydon', 'ueTd6Sf8PV', 1),
(1089, 'Michael Ward', 'VIMEET', 'COMPS', '9404308666', 'Khalapur', 'michael@gmail.com', 'michael', 'g9w4UaPQfJ', 1),
(1090, 'Daniel Torres', 'VIMEET', 'COMPS', '9404308667', 'Khalapur', 'daniel@hotmail.com', 'daniel', 'qsCy6tHEgD', 1),
(1091, 'Bell Peterson', 'VIMEET', 'COMPS', '9404308668', 'Khalapur', 'todybell@yahoomail.com', 'bell', '79ajYnP3U3', 1),
(1092, 'Brown Gray', 'VIMEET', 'COMPS', '9404308669', 'Khalapur', 'brown@gmail.com', 'brown', '68Ra5J98C9', 1),
(1093, 'Rogers Ramirez', 'VIMEET', 'COMPS', '9404308670', 'Khalapur', 'rogers90@gmail.com', 'rogers', 'h2wKj4qqjh', 1),
(1094, 'Paul James', 'VIMEET', 'COMPS', '9404308671', 'Khalapur', 'paul@yahoomail.com', 'paul', 'eaDDHQAveX', 1),
(1095, 'John Watson', 'VIMEET', 'COMPS', '9404308672', 'Khalapur', 'john@gmail.com', 'john', 'sgGy2ppdzr', 1),
(1096, 'Wright Brooks', 'VIMEET', 'COMPS', '9404308673', 'Khalapur', 'wright@gmail.com', 'wright', 'cJTq7MTQ@N', 1),
(1097, 'Brooks Kelly', 'VIMEET', 'COMPS', '9404308674', 'Khalapur', 'morgan789@gmail.com', 'brooks', 'YTTxwQmEKm', 1),
(1098, 'Brown Sanders', 'VIMEET', 'COMPS', '9404308675', 'Khalapur', 'brownChong@hotmail.com', 'brown', 'aph6zqEVPS', 1),
(1099, 'Chrishaydon Sanders', 'VIMEET', 'COMPS', '9404308676', 'Khalapur', 'Chrishaydon76@hotmail.com', 'chrishaydon', 'sWgbtfYW7P', 1),
(1100, 'Mark Bennett', 'VIMEET', 'COMPS', '9404308677', 'Khalapur', 'markstoinis@reddiffmail.com', 'mark', 'qzHBbapDWW', 1),
(1101, 'Brooks Wood', 'VIMEET', 'COMPS', '9404308678', 'Khalapur', 'brooks5746@gmail.com', 'brooks', 'xffJqYgbrn', 1),
(1102, 'Jenny Barnes', 'VIMEET', 'COMPS', '9404308679', 'Khalapur', 'jenny420@gmail.com', 'jenny09', 'x@cvmQbny8', 1),
(1103, 'Morgan Ross', 'VIMEET', 'COMPS', '9404308680', 'Khalapur', 'morgan_decosta66@gmail.com', 'morgan', '7rhgCudd25', 1),
(1104, 'Rogers Henderson', 'VIMEET', 'COMPS', '9404308681', 'Khalapur', 'regers_lee@gmail.com', 'rogers', 'HxSgQAEgqz', 1),
(1105, 'Rivera Coleman', 'VIMEET', 'COMPS', '9404308682', 'Khalapur', 'rivera_charlie@hotmail.com', 'rivera', '79yVhGY7d4', 1),
(1106, 'Wright Jenkins', 'VIMEET', 'COMPS', '9404308683', 'Khalapur', 'wright33@gmail.com', 'wright', 'Sssp9VnQSe', 1),
(1107, 'Mike Perry', 'VIMEET', 'COMPS', '9404308684', 'Khalapur', 'mikehussy@yahoomail.com', 'mike', 'gtMjD@w7uG', 1),
(1108, 'Sanders Powell', 'VIMEET', 'COMPS', '9404308685', 'Khalapur', 'sanders@gmail.com', 'sanders', 'NPr7W6zfjW', 1),
(1109, 'James Long', 'VIMEET', 'COMPS', '9404308686', 'Khalapur', 'jameskarlos@gmail.com', 'james', 'zNYbRnfAFH', 1),
(1110, 'Jenny Patterson', 'VIMEET', 'COMPS', '9404308687', 'Khalapur', 'jenny@hotmail.com', 'jenny09', 'XkxsdhweZZ', 1),
(1111, 'Chrishaydon Flores', 'VIMEET', 'COMPS', '9404308688', 'Khalapur', 'chrishaydon66@gmail.com', 'chrishaydon', 'Mv2jgCeafn', 1),
(1114, 'Michael Butler', 'VIMEET', 'COMPS', '9404308691', 'Khalapur', 'michael@yahoomail.com', 'michael', 'VsdnJWZQYh', 1),
(1115, 'Brown Simmons', 'VIMEET', 'COMPS', '9404308692', 'Khalapur', 'brownchaplin@gmail.com', 'brown', 'CsTRDDwQUD', 1),
(1116, 'John Foster', 'VIMEET', 'COMPS', '9404308693', 'Khalapur', 'john@hotmail.com', 'john', 'ADgRvQUgTz', 1),
(1117, 'Morris Gonzales ', 'VIMEET', 'COMPS', '9404308694', 'Khalapur', 'morris@yaoomail.com', 'morris', 'A6tCPtVMqF', 1),
(1118, 'Wright Bryant', 'VIMEET', 'COMPS', '9404308695', 'Khalapur', 'wright9090@gmail.com', 'wright', 'KR7u7z23TY', 1),
(1119, 'Miller Alexander', 'VIMEET', 'COMPS', '9404308696', 'Khalapur', 'davidMiller@yahoomail.com', 'miller', 'Ejzx8QjM8d', 1),
(1125, 'gaurav k ', 'VIMEET', 'COMP', '9869112199', 'khalapur', 'yabivo6620@fandua.com', 'gaurav', 'PY8T4BsVhD', 0),
(1127, 'sanket pednekar', 'VIMEET', 'COMP', '9891223344', 'ghansoli', 'sanketpednekar9250@gmail.com', 'sanketpednekar', 'ZtGW8af@Cj', 0),
(1128, 'Saksham Patil', 'VIMEET', 'COMP', '9307661329', 'Vashi', 'sakshampatil9878@gmail.com', 'saksham', 'saksham', 1),
(1129, 'Amey Shinde', 'VIMEET', 'COMP', '9873627323', 'Khalapur', 'ameyshinde@gmail.com', 'ameyshinde', 'Nrmvts+SFJ2qN0gqbzoEzLV2nBx9hROTNUuJsxU4c+Y=', 1),
(1130, 'Sushant Bagul', 'VIMEET', 'COMP', '9397654131', 'Khalapur', 'sushant@gmail.com', 'sush123', 'sushant', 0),
(1131, 'aakash gupta', 'VIMEET', 'COMP', '9876352121', 'Kharghar', 'aaakash@gmail.com', 'akash', 'lCAqalCKSQSrR/aMoqoT/oFr0VF10dcccw/zPRROikM=', 1);

-- --------------------------------------------------------

--
-- Table structure for table `student_attendance`
--

CREATE TABLE `student_attendance` (
  `student_id` int(11) DEFAULT NULL,
  `attendance` varchar(100) DEFAULT NULL,
  `system_date` date NOT NULL,
  `subject` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_feedback`
--

CREATE TABLE `student_feedback` (
  `fid` int(11) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `feedback` varchar(400) DEFAULT NULL,
  `uname` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_leave`
--

CREATE TABLE `student_leave` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `leave_reasone` varchar(400) DEFAULT NULL,
  `no_of_days` int(11) DEFAULT NULL,
  `leave_status` varchar(45) DEFAULT NULL,
  `leave_apply_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `submission`
--

CREATE TABLE `submission` (
  `id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `upload_file` varchar(200) NOT NULL,
  `submit_date` date NOT NULL,
  `student_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uploads`
--

CREATE TABLE `uploads` (
  `notes_id` int(11) NOT NULL,
  `Subject_code` varchar(20) DEFAULT NULL,
  `Subject` varchar(40) DEFAULT NULL,
  `FileName` varchar(255) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `Filetype` varchar(40) DEFAULT NULL,
  `Upload_date` date DEFAULT NULL,
  `Uploader` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `aptitude`
--
ALTER TABLE `aptitude`
  ADD PRIMARY KEY (`quiz_no`);

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lecturer_user` (`lecturer_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`teacher_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `faculty_feedback`
--
ALTER TABLE `faculty_feedback`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `fee_Details`
--
ALTER TABLE `fee_Details`
  ADD PRIMARY KEY (`fee_id`);

--
-- Indexes for table `inquiry`
--
ALTER TABLE `inquiry`
  ADD PRIMARY KEY (`inquiry_id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`notes_id`);

--
-- Indexes for table `notice`
--
ALTER TABLE `notice`
  ADD PRIMARY KEY (`notice_id`),
  ADD KEY `notice_id` (`notice_id`);

--
-- Indexes for table `projectinfo`
--
ALTER TABLE `projectinfo`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `projectreport`
--
ALTER TABLE `projectreport`
  ADD PRIMARY KEY (`reportid`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`quiz_no`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`reportid`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `student_feedback`
--
ALTER TABLE `student_feedback`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `student_leave`
--
ALTER TABLE `student_leave`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `submission`
--
ALTER TABLE `submission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assignment_id_assignment` (`assignment_id`),
  ADD KEY `fk_student_id_student` (`student_id`);

--
-- Indexes for table `uploads`
--
ALTER TABLE `uploads`
  ADD PRIMARY KEY (`notes_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `aptitude`
--
ALTER TABLE `aptitude`
  MODIFY `quiz_no` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assignment`
--
ALTER TABLE `assignment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faculty_feedback`
--
ALTER TABLE `faculty_feedback`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fee_Details`
--
ALTER TABLE `fee_Details`
  MODIFY `fee_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inquiry`
--
ALTER TABLE `inquiry`
  MODIFY `inquiry_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `notes_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notice`
--
ALTER TABLE `notice`
  MODIFY `notice_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projectinfo`
--
ALTER TABLE `projectinfo`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projectreport`
--
ALTER TABLE `projectreport`
  MODIFY `reportid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `quiz_no` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `reportid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1132;

--
-- AUTO_INCREMENT for table `student_feedback`
--
ALTER TABLE `student_feedback`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_leave`
--
ALTER TABLE `student_leave`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submission`
--
ALTER TABLE `submission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uploads`
--
ALTER TABLE `uploads`
  MODIFY `notes_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
