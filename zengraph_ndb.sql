-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 27, 2026 at 10:12 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zengraph_ndb`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_plans`
--

CREATE TABLE `ai_plans` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `goal` varchar(100) DEFAULT NULL,
  `mood` varchar(50) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL,
  `recommended_title` varchar(200) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `match_percent` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ai_plans`
--

INSERT INTO `ai_plans` (`id`, `user_id`, `goal`, `mood`, `level`, `recommended_title`, `duration`, `match_percent`, `created_at`) VALUES
(1, 1, 'Feel Happier', 'Anxious', 'Beginner', 'Cosmic Calm Journey', 15, 85, '2026-03-04 05:36:16'),
(2, 1, 'Increase Calm', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-04 05:58:07'),
(3, 1, 'Sleep Better', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-04 05:58:54'),
(4, 1, 'Improve Focus', 'Anxious', 'Intermediate', 'Cosmic Calm Journey', 15, 85, '2026-03-04 06:13:52'),
(5, 1, 'Improve Focus', 'Sad', 'Intermediate', 'Cosmic Calm Journey', 15, 85, '2026-03-04 06:14:07'),
(6, 1, 'Sleep Better', 'Sad', 'Intermediate', 'Cosmic Calm Journey', 15, 85, '2026-03-04 06:23:06'),
(7, 1, 'Feel Happier', 'Anxious', 'Intermediate', 'Cosmic Calm Journey', 15, 85, '2026-03-04 06:36:13'),
(8, 1, 'Feel Happier', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-04 06:36:31'),
(9, 1, 'Increase Calm', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-04 06:42:59'),
(10, 1, 'Build Mindfulness', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-04 06:48:13'),
(11, 1, 'Increase Calm', 'Excited', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-04 06:52:26'),
(12, 1, 'Increase Calm', 'Neutral', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-04 06:57:42'),
(13, 1, 'Increase Calm', 'Excited', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-04 07:15:19'),
(14, 1, 'Build Mindfulness', 'Excited', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-04 07:28:51'),
(15, 1, 'Sleep Better', 'Neutral', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-04 07:30:36'),
(16, 1, 'Build Mindfulness', 'Neutral', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-04 07:40:32'),
(17, 1, 'Feel Happier', 'Angry', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-04 07:46:12'),
(18, 1, 'Build Mindfulness', 'Neutral', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-04 07:53:37'),
(19, 1, 'Build Mindfulness', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-04 07:55:22'),
(20, 1, 'Build Mindfulness', 'Anxious', 'Intermediate', 'Cosmic Calm Journey', 15, 85, '2026-03-04 08:00:06'),
(21, 1, 'Deep Focus', 'Library', 'General', 'Morning Focus', 10, 100, '2026-03-04 08:00:25'),
(22, 1, 'Deep Focus', 'Neutral', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-04 08:00:31'),
(23, 1, 'Quick Calm', 'Library', 'General', 'Micro Calm', 3, 100, '2026-03-04 08:02:32'),
(24, 1, 'Quick Calm', 'Neutral', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-04 08:02:35'),
(25, 1, 'Increase Calm', 'Excited', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-04 08:37:30'),
(26, 1, 'Build Mindfulness', 'Neutral', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-04 08:50:48'),
(27, 1, 'Increase Calm', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-04 08:56:23'),
(28, 1, 'Build Mindfulness', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-04 09:09:00'),
(29, 1, 'Increase Calm', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-04 09:19:30'),
(30, 2, 'Deep Focus', 'Library', 'General', 'Mindful Walk', 15, 100, '2026-03-06 03:12:59'),
(31, 2, 'Improve Focus', 'Neutral', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-06 03:39:57'),
(32, 2, 'Anxiety Relief', 'Library', 'General', 'Stress Reset', 8, 100, '2026-03-06 03:41:01'),
(33, 2, 'Deep Focus', 'Library', 'General', 'Mindful Walk', 15, 100, '2026-03-06 03:41:09'),
(34, 2, 'Deep Focus', 'Neutral', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-06 03:41:22'),
(35, 2, 'Improve Focus', 'Anxious', 'Beginner', 'Cosmic Calm Journey', 15, 85, '2026-03-10 03:36:15'),
(36, 2, 'Sleep Better', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-10 03:36:59'),
(37, 2, 'Build Mindfulness', 'Angry', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-10 03:40:44'),
(38, 1, 'Feel Happier', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-10 03:44:00'),
(39, 1, 'Sleep', 'Library', 'General', 'Deep Relaxation', 20, 100, '2026-03-10 05:24:37'),
(40, 2, 'Sleep Better', 'Excited', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-10 05:26:36'),
(41, 2, 'Quick Calm', 'Library', 'General', 'Micro Calm', 3, 100, '2026-03-10 06:45:19'),
(42, 2, 'Quick Calm', 'Neutral', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-10 06:45:23'),
(43, 2, 'Improve Focus', 'Sad', 'Beginner', 'Cosmic Calm Journey', 15, 85, '2026-03-11 03:45:15'),
(44, 2, 'Build Mindfulness', 'Happy', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-11 03:45:50'),
(45, 2, 'Increase Calm', 'Neutral', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-11 06:57:28'),
(46, 2, 'Sleep Better', 'Excited', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-11 07:11:07'),
(47, 2, 'Build Mindfulness', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-11 07:11:33'),
(48, 2, 'Feel Happier', 'Excited', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-11 07:33:00'),
(49, 2, 'Sleep Better', 'Sad', 'Intermediate', 'Cosmic Calm Journey', 15, 85, '2026-03-11 07:51:58'),
(50, 2, 'Sleep Better', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-11 08:09:04'),
(51, 2, 'Feel Happier', 'Angry', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-11 08:23:05'),
(52, 2, 'Increase Calm', 'Sad', 'Intermediate', 'Cosmic Calm Journey', 15, 85, '2026-03-11 08:43:12'),
(53, 2, 'Improve Focus', 'Happy', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-12 03:17:05'),
(54, 2, 'Reduce Stress', 'Neutral', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-12 03:21:11'),
(55, 2, 'Reduce Stress', 'Excited', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-13 04:18:16'),
(56, 2, 'Sleep Better', 'Angry', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-13 04:19:20'),
(57, 2, 'Improve Focus', 'Happy', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-13 04:19:59'),
(58, 2, 'Improve Focus', 'Happy', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-13 04:20:13'),
(59, 2, 'Feel Happier', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-13 04:53:59'),
(60, 2, 'Increase Calm', 'Anxious', 'Beginner', 'Cosmic Calm Journey', 15, 85, '2026-03-13 04:54:19'),
(61, 2, 'Reduce Stress', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-13 04:54:32'),
(62, 2, 'Reduce Stress', 'Happy', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-13 04:54:38'),
(63, 2, 'Sleep Better', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-13 04:54:49'),
(64, 2, 'Reduce Stress', 'Sad', 'Beginner', 'Cosmic Calm Journey', 15, 85, '2026-03-13 05:14:09'),
(65, 2, 'Anxiety Relief', 'Library', 'General', 'Breathe & Release', 5, 100, '2026-03-13 05:14:35'),
(66, 2, 'Anxiety Relief', 'Anxious', 'Beginner', 'Cosmic Calm Journey', 15, 85, '2026-03-13 05:14:40'),
(67, 2, 'Deep Focus', 'Library', 'General', 'Mindful Walk', 15, 100, '2026-03-13 05:16:38'),
(68, 2, 'Anxiety Relief', 'Neutral', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-13 05:22:29'),
(69, 2, 'Reduce Stress', 'Happy', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-13 05:30:38'),
(70, 2, 'Build Mindfulness', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-13 05:30:57'),
(71, 2, 'Feel Happier', 'Excited', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-13 05:31:11'),
(72, 2, 'Improve Focus', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-13 05:31:54'),
(73, 2, 'Reduce Stress', 'Neutral', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-13 06:16:11'),
(74, 2, 'Improve Focus', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-13 06:16:28'),
(75, 2, 'Sleep Better', 'Angry', 'Advanced', 'Mind Balance Session', 10, 75, '2026-03-13 06:16:44'),
(76, 2, 'Reduce Stress', 'Happy', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-13 06:36:50'),
(77, 2, 'Increase Calm', 'Anxious', 'Intermediate', 'Cosmic Calm Journey', 15, 85, '2026-03-13 06:37:06'),
(78, 2, 'Build Mindfulness', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-13 06:37:20'),
(79, 2, 'Feel Happier', 'Anxious', 'Intermediate', 'Cosmic Calm Journey', 15, 85, '2026-03-13 06:37:36'),
(80, 2, 'Sleep Better', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-13 06:58:51'),
(81, 2, 'Increase Calm', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-13 06:59:05'),
(82, 2, 'Feel Happier', 'Excited', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-13 06:59:18'),
(83, 2, 'Feel Happier', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-13 07:06:50'),
(84, 2, 'Build Mindfulness', 'Angry', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-13 07:07:06'),
(85, 2, 'Reduce Stress', 'Happy', 'Beginner', 'Mind Balance Session', 10, 75, '2026-03-13 07:07:23'),
(86, 2, 'Reduce Stress', 'Happy', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-13 07:27:54'),
(87, 2, 'Increase Calm', 'Anxious', 'Advanced', 'Cosmic Calm Journey', 15, 85, '2026-03-13 07:28:06'),
(88, 2, 'Feel Happier', 'Excited', 'Intermediate', 'Mind Balance Session', 10, 75, '2026-03-13 09:05:26'),
(89, 5, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-13 09:27:24'),
(90, 8, 'Improve Focus', 'Excited', 'Intermediate', 'Focus Ignition', 10, 85, '2026-03-14 07:24:57'),
(91, 8, 'Reduce Stress', 'Anxious', 'Beginner', 'Safe Harbor Session', 5, 85, '2026-03-14 07:25:39'),
(92, 8, 'Improve Focus', 'Anxious', 'Intermediate', 'Steady Mind Bridge', 10, 85, '2026-03-14 07:30:00'),
(93, 8, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-14 07:30:44'),
(94, 8, 'Breathing Meditation', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-14 07:30:47'),
(95, 8, 'Sleep Better', 'Anxious', 'Advanced', 'Worry-Free Night', 15, 85, '2026-03-14 07:33:23'),
(96, 8, 'Feel Happier', 'Excited', 'Intermediate', 'Radiant Joy Flow', 10, 85, '2026-03-14 07:58:01'),
(97, 8, 'Sleep Better', 'Excited', 'Beginner', 'Soft Landing', 5, 85, '2026-03-14 08:00:27'),
(98, 8, 'Increase Calm', 'Anxious', 'Intermediate', 'Anchor in the Storm', 10, 85, '2026-03-15 06:28:57'),
(99, 8, 'Increase Calm', 'Excited', 'Advanced', 'Gentle Descent', 15, 85, '2026-03-15 06:41:55'),
(100, 8, 'Increase Calm', 'Happy', 'Intermediate', 'Serene Glow', 10, 85, '2026-03-15 06:54:55'),
(101, 8, 'Reduce Stress', 'Anxious', 'Intermediate', 'Safe Harbor Session', 10, 85, '2026-03-16 05:29:32'),
(102, 8, 'Improve Focus', 'Happy', 'Advanced', 'Peak Performance Flow', 15, 85, '2026-03-16 06:14:03'),
(103, 8, 'Increase Calm', 'Excited', 'Advanced', 'Gentle Descent', 15, 85, '2026-03-16 06:59:07'),
(104, 8, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-16 07:17:03'),
(105, 8, 'Breathing Meditation', 'Library', 'General', 'Ocean Breath Awareness', 10, 100, '2026-03-16 07:17:08'),
(106, 8, 'Sleep Better', 'Happy', 'Intermediate', 'Peaceful Sunset', 10, 85, '2026-03-17 03:03:22'),
(107, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 04:07:31'),
(108, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 04:07:33'),
(109, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 04:07:33'),
(110, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 04:07:34'),
(111, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 04:07:34'),
(112, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 04:07:34'),
(113, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 04:07:34'),
(114, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 04:07:34'),
(115, 10, 'Reduce Stress', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-17 04:09:10'),
(116, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 04:45:56'),
(117, 10, 'Reduce Stress', 'Neutral', 'Intermediate', 'Zen Harmony', 10, 85, '2026-03-17 04:55:57'),
(118, 10, 'Improve Focus', 'Neutral', 'Intermediate', 'Mind Balance Session', 10, 85, '2026-03-17 04:56:46'),
(119, 10, 'Increase Calm', 'Neutral', 'Beginner', 'Deep Stillness', 5, 85, '2026-03-17 07:16:57'),
(120, 10, 'Increase Calm', 'Neutral', 'Intermediate', 'Deep Stillness', 10, 85, '2026-03-17 07:18:15'),
(121, 10, 'Increase Calm', 'Neutral', 'Advanced', 'Deep Stillness', 15, 85, '2026-03-17 07:24:51'),
(122, 10, 'Improve Focus', 'Neutral', 'Intermediate', 'Mind Balance Session', 10, 85, '2026-03-17 07:44:36'),
(123, 10, 'Improve Focus', 'Neutral', 'Intermediate', 'Mind Balance Session', 10, 85, '2026-03-17 07:53:26'),
(124, 10, 'Improve Focus', 'Neutral', 'Intermediate', 'Mind Balance Session', 10, 85, '2026-03-17 08:37:31'),
(125, 10, 'Reduce Stress', 'Neutral', 'Intermediate', 'Zen Harmony', 10, 85, '2026-03-17 09:12:29'),
(126, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 09:12:58'),
(127, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 09:13:00'),
(128, 10, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-17 09:13:04'),
(129, 8, 'Improve Focus', 'Angry', 'Intermediate', 'Clarity Through Calm', 10, 85, '2026-03-18 03:24:11'),
(130, 8, 'Sleep Meditation', 'Library', 'General', 'Sleep Wind Down', 10, 100, '2026-03-18 03:25:19'),
(131, 8, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-18 03:33:33'),
(132, 8, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-18 04:11:00'),
(133, 8, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-18 04:11:17'),
(134, 8, 'Sleep Better', 'Neutral', 'Intermediate', 'Cosmic Calm Journey', 10, 85, '2026-03-18 05:01:14'),
(135, 8, 'Improve Focus', 'Neutral', 'Intermediate', 'Mind Balance Session', 10, 85, '2026-03-18 07:03:11'),
(136, 8, 'Reduce Stress', 'Neutral', 'Intermediate', 'Zen Harmony', 10, 85, '2026-03-18 08:20:22'),
(137, 8, 'Sleep Better', 'Anxious', 'Intermediate', 'Worry-Free Night', 10, 85, '2026-03-19 03:39:05'),
(138, 8, 'Sleep Better', 'Happy', 'Beginner', 'Peaceful Sunset', 5, 85, '2026-03-19 16:23:32'),
(139, 8, 'Feel Happier', 'Sad', 'Intermediate', 'Sunrise Within', 10, 85, '2026-03-19 16:24:14'),
(140, 15, 'Reduce Stress', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-23 07:41:59'),
(141, 15, 'Increase Calm', 'Anxious', 'Intermediate', 'Anchor in the Storm', 10, 85, '2026-03-23 07:52:46'),
(142, 15, 'Reduce Stress', 'Happy', 'Beginner', 'Joyful Stillness', 5, 85, '2026-03-23 08:03:02'),
(143, 15, 'Reduce Stress', 'Happy', 'Beginner', 'Joyful Stillness', 5, 85, '2026-03-23 08:03:44'),
(144, 15, 'Increase Calm', 'Anxious', 'Advanced', 'Anchor in the Storm', 15, 85, '2026-03-23 08:05:49'),
(145, 15, 'reduce_stress', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-23 08:11:41'),
(146, 15, 'Mindfulness Meditation', 'Library', 'General', 'Inner Awareness', 15, 100, '2026-03-23 08:17:03'),
(147, 15, 'Reduce Stress', 'Happy', 'Beginner', 'Joyful Stillness', 5, 85, '2026-03-23 08:19:04'),
(148, 2, 'Improve Focus', 'Happy', 'Intermediate', 'Peak Performance Flow', 10, 85, '2026-03-24 04:09:47'),
(149, 2, 'Breathing Meditation', 'Library', 'General', 'Ocean Breath Awareness', 10, 100, '2026-03-24 04:10:01'),
(150, 16, 'Reduce Stress', 'Neutral', 'Intermediate', 'Zen Harmony', 10, 85, '2026-03-24 04:30:23'),
(151, 16, 'Reduce Stress', 'Sad', 'Beginner', 'Gentle Healing Flow', 5, 85, '2026-03-24 04:32:30'),
(152, 16, 'Increase Calm', 'Excited', 'Advanced', 'Gentle Descent', 15, 85, '2026-03-24 04:34:04'),
(153, 16, 'Breathing Meditation', 'Library', 'General', 'Ocean Breath Awareness', 10, 100, '2026-03-24 04:35:31'),
(154, 16, 'Breathing Meditation', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-24 04:35:37'),
(155, 16, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-24 04:37:18'),
(156, 16, 'Breathing Meditation', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-24 04:37:23'),
(157, 16, 'Breathing Meditation', 'Library', 'General', 'Calm Breathing Journey', 10, 100, '2026-03-24 04:40:41'),
(158, 16, 'Reduce Stress', 'Sad', 'Beginner', 'Gentle Healing Flow', 5, 85, '2026-03-24 04:55:44'),
(159, 16, 'Improve Focus', 'Anxious', 'Intermediate', 'Steady Mind Bridge', 10, 85, '2026-03-24 04:56:01'),
(160, 16, 'Improve Focus', 'Anxious', 'Intermediate', 'Steady Mind Bridge', 10, 85, '2026-03-24 05:01:43'),
(161, 16, 'Reduce Stress', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-24 05:01:59'),
(162, 16, 'Reduce Stress', 'Anxious', 'Beginner', 'Safe Harbor Session', 5, 85, '2026-03-24 05:02:21'),
(163, 16, 'Increase Calm', 'Sad', 'Intermediate', 'Still Waters', 10, 85, '2026-03-24 05:02:55'),
(164, 16, 'Increase Calm', 'Sad', 'Intermediate', 'Still Waters', 10, 85, '2026-03-24 05:03:39'),
(165, 16, 'Reduce Stress', 'Anxious', 'Beginner', 'Safe Harbor Session', 5, 85, '2026-03-24 05:22:54'),
(166, 16, 'Loving-kindness Meditation', 'Library', 'General', 'Kindness Expansion', 10, 100, '2026-03-24 05:23:50'),
(167, 16, 'Loving-kindness Meditation', 'Happy', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-24 05:24:00'),
(168, 16, 'Breathing Meditation', 'Library', 'General', 'Relaxing Breath Cycle', 15, 100, '2026-03-24 05:29:29'),
(169, 16, 'Breathing Meditation', 'Library', 'General', 'Relaxing Breath Cycle', 15, 100, '2026-03-24 05:29:35'),
(170, 16, 'Breathing Meditation', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-24 05:29:40'),
(171, 16, 'Mindfulness Meditation', 'Library', 'General', 'Cosmic Calm Journey', 10, 100, '2026-03-24 05:29:52'),
(172, 16, 'Mindfulness Meditation', 'Library', 'General', 'Cosmic Calm Journey', 10, 100, '2026-03-24 05:29:53'),
(173, 16, 'Breathing Meditation', 'Library', 'General', 'Deep Breath Reset', 5, 100, '2026-03-24 05:30:07'),
(174, 16, 'Breathing Meditation', 'Library', 'General', 'Relaxing Breath Cycle', 15, 100, '2026-03-24 05:30:16'),
(175, 16, 'Breathing Meditation', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-24 05:30:32'),
(176, 16, 'Reduce Stress', 'Neutral', 'Intermediate', 'Zen Harmony', 10, 85, '2026-03-24 08:28:02'),
(177, 16, 'Build Mindfulness', 'Neutral', 'Advanced', 'Pure Awareness', 15, 85, '2026-03-24 09:13:22'),
(178, 16, 'Improve Focus', 'Anxious', 'Intermediate', 'Steady Mind Bridge', 10, 85, '2026-03-25 04:44:15'),
(179, 16, 'Build Mindfulness', 'Excited', 'Advanced', 'Mindful Energy', 15, 85, '2026-03-25 04:45:09'),
(180, 16, 'Sleep Better', 'Sad', 'Beginner', 'Nighttime Comfort', 5, 85, '2026-03-25 04:48:53'),
(181, 15, 'Feel Happier', 'Happy', 'Intermediate', 'Joy Amplifier', 10, 85, '2026-03-25 05:17:38'),
(182, 15, 'Feel Happier', 'Angry', 'Intermediate', 'Peace & Positivity', 10, 85, '2026-03-25 05:18:08'),
(183, 17, 'Reduce Stress', 'Neutral', 'Intermediate', 'Zen Harmony', 10, 85, '2026-03-25 05:23:40'),
(184, 17, 'Reduce Stress', 'Neutral', 'Beginner', 'Zen Harmony', 5, 85, '2026-03-25 07:26:53'),
(185, 17, 'Reduce Stress', 'Neutral', 'Intermediate', 'Zen Harmony', 10, 85, '2026-03-25 08:26:00'),
(186, 15, 'Reduce Stress', 'Happy', 'Beginner', 'Joyful Stillness', 5, 85, '2026-03-27 02:47:27'),
(187, 15, 'Sleep Better', 'Happy', 'Intermediate', 'Peaceful Sunset', 10, 85, '2026-03-27 02:47:49'),
(188, 2, 'Increase Calm', 'Neutral', 'Intermediate', 'Deep Stillness', 10, 85, '2026-03-27 02:48:37'),
(189, 2, 'Increase Calm', 'Anxious', 'Advanced', 'Anchor in the Storm', 15, 85, '2026-03-27 02:52:23'),
(190, 2, 'Sleep Better', 'Angry', 'Beginner', 'Release & Rest', 5, 85, '2026-03-27 03:02:40'),
(191, 2, 'Sleep Better', 'Anxious', 'Intermediate', 'Worry-Free Night', 10, 85, '2026-03-27 03:03:42'),
(192, 2, 'Increase Calm', 'Neutral', 'Intermediate', 'Deep Stillness', 10, 85, '2026-03-27 03:13:05'),
(193, 2, 'Sleep Better', 'Angry', 'Intermediate', 'Release & Rest', 10, 85, '2026-03-27 03:29:18'),
(194, 2, 'Improve Focus', 'Angry', 'Intermediate', 'Clarity Through Calm', 10, 85, '2026-03-27 04:34:24'),
(195, 2, 'Improve Focus', 'Anxious', 'Beginner', 'Steady Mind Bridge', 5, 85, '2026-03-27 04:48:09'),
(196, 2, 'Improve Focus', 'Angry', 'Beginner', 'Clarity Through Calm', 5, 85, '2026-03-27 04:48:15'),
(197, 2, 'Sleep Better', 'Anxious', 'Intermediate', 'Worry-Free Night', 10, 85, '2026-03-27 04:53:08'),
(198, 2, 'Sleep Better', 'Happy', 'Intermediate', 'Peaceful Sunset', 10, 85, '2026-03-27 04:53:13'),
(199, 2, 'Feel Happier', 'Happy', 'Intermediate', 'Joy Amplifier', 10, 85, '2026-03-27 05:24:31'),
(200, 2, 'Feel Happier', 'Angry', 'Intermediate', 'Peace & Positivity', 10, 85, '2026-03-27 05:24:39');

-- --------------------------------------------------------

--
-- Table structure for table `challenges`
--

CREATE TABLE `challenges` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `target_days` int(11) DEFAULT 5,
  `week_start` date NOT NULL,
  `week_end` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `challenges`
--

INSERT INTO `challenges` (`id`, `title`, `description`, `target_days`, `week_start`, `week_end`, `created_at`) VALUES
(1, 'Meditate 5 days in a row', 'Build your consistency this week.', 5, '2026-03-16', '2026-03-22', '2026-03-16 06:50:44'),
(2, 'Meditate 5 days in a row', 'Build your consistency this week.', 5, '2026-03-16', '2026-03-22', '2026-03-16 06:51:29');

-- --------------------------------------------------------

--
-- Table structure for table `challenge_participants`
--

CREATE TABLE `challenge_participants` (
  `id` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `days_completed` int(11) DEFAULT 0,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `challenge_participants`
--

INSERT INTO `challenge_participants` (`id`, `challenge_id`, `user_id`, `days_completed`, `joined_at`) VALUES
(1, 2, 8, 0, '2026-03-16 06:58:42');

-- --------------------------------------------------------

--
-- Table structure for table `checkins`
--

CREATE TABLE `checkins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mood_score` float DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `checkins`
--

INSERT INTO `checkins` (`id`, `user_id`, `mood_score`, `created_at`) VALUES
(1, 1, 4, '2026-03-04 05:58:51'),
(2, 1, 5, '2026-03-04 07:30:32'),
(3, 1, 4, '2026-03-04 07:54:58'),
(4, 1, 4, '2026-03-04 07:55:03'),
(5, 1, 5, '2026-03-04 08:00:29'),
(6, 1, 5, '2026-03-04 08:02:33'),
(7, 2, 5, '2026-03-06 03:39:52'),
(8, 2, 5, '2026-03-06 03:41:14'),
(9, 2, 4, '2026-03-10 03:36:13'),
(10, 2, 10, '2026-03-10 03:36:57'),
(11, 2, 1, '2026-03-10 03:40:42'),
(12, 1, 10, '2026-03-10 03:43:58'),
(13, 2, 10, '2026-03-10 05:26:33'),
(14, 2, 5, '2026-03-10 06:45:20'),
(15, 2, 2, '2026-03-11 03:45:12'),
(16, 2, 8, '2026-03-11 03:45:48'),
(17, 2, 5, '2026-03-11 06:57:26'),
(18, 2, 10, '2026-03-11 07:11:01'),
(19, 2, 4, '2026-03-11 07:11:31'),
(20, 2, 10, '2026-03-11 07:32:58'),
(21, 2, 2, '2026-03-11 07:51:55'),
(22, 2, 10, '2026-03-11 08:09:01'),
(23, 2, 1, '2026-03-11 08:23:02'),
(24, 2, 2, '2026-03-11 08:43:09'),
(25, 2, 8, '2026-03-12 03:17:02'),
(26, 2, 5, '2026-03-12 03:21:06'),
(27, 2, 10, '2026-03-13 04:18:12'),
(28, 2, 1, '2026-03-13 04:19:16'),
(29, 2, 8, '2026-03-13 04:19:57'),
(30, 2, 8, '2026-03-13 04:20:11'),
(31, 2, 10, '2026-03-13 04:53:57'),
(32, 2, 4, '2026-03-13 04:54:17'),
(33, 2, 4, '2026-03-13 04:54:30'),
(34, 2, 8, '2026-03-13 04:54:36'),
(35, 2, 10, '2026-03-13 04:54:47'),
(36, 2, 2, '2026-03-13 05:13:56'),
(37, 2, 4, '2026-03-13 05:14:39'),
(38, 2, 8, '2026-03-13 05:30:36'),
(39, 2, 4, '2026-03-13 05:30:56'),
(40, 2, 10, '2026-03-13 05:31:08'),
(41, 2, 4, '2026-03-13 05:31:52'),
(42, 2, 5, '2026-03-13 06:16:08'),
(43, 2, 10, '2026-03-13 06:16:26'),
(44, 2, 1, '2026-03-13 06:16:42'),
(45, 2, 8, '2026-03-13 06:36:48'),
(46, 2, 4, '2026-03-13 06:37:04'),
(47, 2, 4, '2026-03-13 06:37:18'),
(48, 2, 4, '2026-03-13 06:37:34'),
(49, 2, 10, '2026-03-13 06:58:48'),
(50, 2, 4, '2026-03-13 06:59:02'),
(51, 2, 10, '2026-03-13 06:59:17'),
(52, 2, 10, '2026-03-13 07:06:48'),
(53, 2, 1, '2026-03-13 07:07:04'),
(54, 2, 8, '2026-03-13 07:07:21'),
(55, 2, 8, '2026-03-13 07:27:52'),
(56, 2, 4, '2026-03-13 07:28:04'),
(57, 2, 10, '2026-03-13 09:05:23'),
(58, 8, 10, '2026-03-14 07:24:54'),
(59, 8, 4, '2026-03-14 07:25:36'),
(60, 8, 4, '2026-03-14 07:29:57'),
(61, 8, 5, '2026-03-14 07:30:45'),
(62, 8, 4, '2026-03-14 07:33:21'),
(63, 8, 10, '2026-03-14 07:57:58'),
(64, 8, 10, '2026-03-14 08:00:23'),
(65, 8, 4, '2026-03-15 06:28:55'),
(66, 8, 10, '2026-03-15 06:41:53'),
(67, 8, 8, '2026-03-15 06:54:52'),
(68, 8, 4, '2026-03-16 05:29:30'),
(69, 8, 8, '2026-03-16 06:14:00'),
(70, 8, 10, '2026-03-16 06:59:05'),
(71, 8, 5, '2026-03-16 07:16:51'),
(72, 8, 5, '2026-03-16 07:17:05'),
(73, 8, 5, '2026-03-16 07:17:09'),
(74, 8, 8, '2026-03-17 03:03:20'),
(75, 10, 8, '2026-03-17 04:46:08'),
(76, 10, 6, '2026-03-17 04:46:10'),
(77, 8, 1, '2026-03-18 03:24:09'),
(78, 8, 8, '2026-03-18 07:02:57'),
(79, 8, 4, '2026-03-19 03:39:00'),
(80, 8, 8, '2026-03-19 16:23:23'),
(81, 8, 8, '2026-03-19 16:23:30'),
(82, 8, 2, '2026-03-19 16:24:11'),
(83, 8, 8, '2026-03-20 06:19:57'),
(84, 8, 3, '2026-03-20 06:19:58'),
(85, 15, 4, '2026-03-23 07:52:44'),
(86, 15, 8, '2026-03-23 08:03:00'),
(87, 15, 8, '2026-03-23 08:03:41'),
(88, 15, 4, '2026-03-23 08:05:46'),
(89, 15, 8, '2026-03-23 08:19:01'),
(90, 2, 8, '2026-03-24 04:09:44'),
(91, 2, 5, '2026-03-24 04:10:02'),
(92, 16, 2, '2026-03-24 04:32:28'),
(93, 16, 10, '2026-03-24 04:33:46'),
(94, 16, 5, '2026-03-24 04:35:34'),
(95, 16, 5, '2026-03-24 04:37:20'),
(96, 16, 2, '2026-03-24 04:55:41'),
(97, 16, 4, '2026-03-24 04:55:59'),
(98, 16, 4, '2026-03-24 05:01:39'),
(99, 16, 5, '2026-03-24 05:01:57'),
(100, 16, 4, '2026-03-24 05:02:18'),
(101, 16, 2, '2026-03-24 05:02:53'),
(102, 16, 2, '2026-03-24 05:03:32'),
(103, 16, 4, '2026-03-24 05:22:51'),
(104, 16, 4, '2026-03-24 05:23:01'),
(105, 16, 4, '2026-03-24 05:23:12'),
(106, 16, 4, '2026-03-24 05:23:30'),
(107, 16, 4, '2026-03-24 05:23:55'),
(108, 16, 8, '2026-03-24 05:23:58'),
(109, 16, 5, '2026-03-24 05:29:31'),
(110, 16, 5, '2026-03-24 05:29:37'),
(111, 16, 5, '2026-03-24 05:29:54'),
(112, 16, 5, '2026-03-24 05:30:09'),
(113, 16, 5, '2026-03-24 05:30:23'),
(114, 16, 4, '2026-03-25 04:44:13'),
(115, 16, 10, '2026-03-25 04:45:05'),
(116, 16, 2, '2026-03-25 04:48:51'),
(117, 15, 8, '2026-03-25 05:17:34'),
(118, 15, 1, '2026-03-25 05:18:06'),
(119, 15, 8, '2026-03-27 02:47:25'),
(120, 15, 8, '2026-03-27 02:47:46'),
(121, 2, 5, '2026-03-27 02:48:35'),
(122, 2, 4, '2026-03-27 02:52:21'),
(123, 2, 1, '2026-03-27 03:02:38'),
(124, 2, 4, '2026-03-27 03:03:40'),
(125, 1, 0.7, '2026-03-27 03:05:41'),
(126, 2, 5, '2026-03-27 03:13:02'),
(127, 2, 1, '2026-03-27 03:29:17'),
(128, 2, 4, '2026-03-27 04:48:07'),
(129, 2, 1, '2026-03-27 04:48:13'),
(130, 2, 4, '2026-03-27 04:53:05'),
(131, 2, 8, '2026-03-27 04:53:12'),
(132, 2, 8, '2026-03-27 05:24:29'),
(133, 2, 1, '2026-03-27 05:24:37');

-- --------------------------------------------------------

--
-- Table structure for table `emotion_logs`
--

CREATE TABLE `emotion_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mood` varchar(50) DEFAULT NULL,
  `thought` text DEFAULT NULL,
  `predicted_emotion` varchar(50) DEFAULT NULL,
  `confidence` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emotion_logs`
--

INSERT INTO `emotion_logs` (`id`, `user_id`, `mood`, `thought`, `predicted_emotion`, `confidence`, `created_at`) VALUES
(1, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 05:36:16'),
(2, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 05:58:06'),
(3, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 05:58:54'),
(4, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 06:13:52'),
(5, 1, 'Sad', 'Sad', 'fear', '0.9991', '2026-03-04 06:14:07'),
(6, 1, 'Sad', 'Sad', 'fear', '0.9991', '2026-03-04 06:23:06'),
(7, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 06:36:13'),
(8, 1, 'Excited', 'Excited', 'love', '0.9975', '2026-03-04 06:36:31'),
(9, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 06:42:59'),
(10, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 06:48:13'),
(11, 1, 'Excited', 'Excited', 'love', '0.9975', '2026-03-04 06:52:25'),
(12, 1, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-04 06:57:42'),
(13, 1, 'Excited', 'Excited', 'love', '0.9975', '2026-03-04 07:15:19'),
(14, 1, 'Excited', 'Excited', 'love', '0.9975', '2026-03-04 07:28:50'),
(15, 1, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-04 07:30:36'),
(16, 1, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-04 07:40:32'),
(17, 1, 'Angry', 'Angry', 'sadness', '0.9991', '2026-03-04 07:46:12'),
(18, 1, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-04 07:53:37'),
(19, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 07:55:22'),
(20, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 08:00:06'),
(21, 1, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-04 08:00:31'),
(22, 1, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-04 08:02:35'),
(23, 1, 'Excited', 'Excited', 'love', '0.9975', '2026-03-04 08:37:29'),
(24, 1, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-04 08:50:48'),
(25, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 08:56:23'),
(26, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 09:09:00'),
(27, 1, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-04 09:19:30'),
(28, 2, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-06 03:39:57'),
(29, 2, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-06 03:41:22'),
(30, 2, 'Anxious', 'Anxious', 'joy', '0.9976', '2026-03-10 03:36:15'),
(31, 2, 'Excited', 'Excited', 'love', '0.9975', '2026-03-10 03:36:59'),
(32, 2, 'Angry', 'Angry', 'sadness', '0.9991', '2026-03-10 03:40:43'),
(33, 1, 'Excited', 'Excited', 'love', '0.9975', '2026-03-10 03:44:00'),
(34, 2, 'Excited', 'Excited', 'love', '0.9975', '2026-03-10 05:26:35'),
(35, 2, 'Neutral', 'Neutral', 'love', '0.8346', '2026-03-10 06:45:23'),
(36, 2, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-11 03:45:15'),
(37, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-11 03:45:49'),
(38, 2, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-11 06:57:27'),
(39, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-11 07:11:07'),
(40, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-11 07:11:33'),
(41, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-11 07:33:00'),
(42, 2, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-11 07:51:58'),
(43, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-11 08:09:04'),
(44, 2, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-11 08:23:05'),
(45, 2, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-11 08:43:11'),
(46, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-12 03:17:05'),
(47, 2, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-12 03:21:11'),
(48, 2, 'Angry', NULL, 'Neutral', '0', '2026-03-12 08:23:39'),
(49, 2, 'Anxious', NULL, 'Neutral', '0', '2026-03-12 09:00:12'),
(50, 2, 'Anxious', NULL, 'Neutral', '0', '2026-03-12 09:03:17'),
(51, 2, 'Anxious', NULL, 'Neutral', '0', '2026-03-12 09:12:56'),
(52, 2, 'Happy', NULL, 'Neutral', '0', '2026-03-12 09:19:26'),
(53, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-13 04:18:16'),
(54, 2, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-13 04:19:20'),
(55, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-13 04:19:59'),
(56, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-13 04:20:13'),
(57, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-13 04:53:59'),
(58, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 04:54:18'),
(59, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 04:54:32'),
(60, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-13 04:54:38'),
(61, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-13 04:54:49'),
(62, 2, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-13 05:14:09'),
(63, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 05:14:40'),
(64, 2, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-13 05:22:29'),
(65, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-13 05:30:38'),
(66, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 05:30:57'),
(67, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-13 05:31:11'),
(68, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 05:31:54'),
(69, 2, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-13 06:16:10'),
(70, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-13 06:16:28'),
(71, 2, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-13 06:16:44'),
(72, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-13 06:36:50'),
(73, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 06:37:06'),
(74, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 06:37:20'),
(75, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 06:37:36'),
(76, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-13 06:58:51'),
(77, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 06:59:04'),
(78, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-13 06:59:18'),
(79, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-13 07:06:50'),
(80, 2, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-13 07:07:06'),
(81, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-13 07:07:22'),
(82, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-13 07:27:54'),
(83, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-13 07:28:06'),
(84, 2, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-13 09:05:26'),
(85, 8, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-14 07:24:57'),
(86, 8, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-14 07:25:39'),
(87, 8, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-14 07:30:00'),
(88, 8, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-14 07:30:47'),
(89, 8, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-14 07:33:23'),
(90, 8, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-14 07:58:01'),
(91, 8, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-14 08:00:27'),
(92, 8, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-15 06:28:57'),
(93, 8, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-15 06:41:55'),
(94, 8, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-15 06:54:55'),
(95, 8, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-16 05:29:32'),
(96, 8, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-16 06:14:03'),
(97, 8, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-16 06:59:06'),
(98, 8, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-17 03:03:22'),
(99, 10, 'Sad', NULL, 'Neutral', '0', '2026-03-17 04:07:47'),
(100, 10, 'Sad', NULL, 'Neutral', '0', '2026-03-17 04:46:18'),
(101, 10, 'Happy', NULL, 'Neutral', '0', '2026-03-17 04:55:34'),
(102, 10, 'Anxious', NULL, 'Neutral', '0', '2026-03-17 04:56:43'),
(103, 10, 'Sad', NULL, 'Neutral', '0', '2026-03-17 05:15:36'),
(104, 10, 'Angry', NULL, 'Neutral', '0', '2026-03-17 05:30:49'),
(105, 10, 'Angry', NULL, 'Neutral', '0', '2026-03-17 06:45:35'),
(106, 10, 'Excited', NULL, 'Neutral', '0', '2026-03-17 06:45:48'),
(107, 10, 'Happy', NULL, 'Neutral', '0', '2026-03-17 07:16:49'),
(108, 10, 'Neutral', NULL, 'Neutral', '0', '2026-03-17 07:18:00'),
(109, 10, 'Happy', NULL, 'Neutral', '0', '2026-03-17 07:18:11'),
(110, 10, 'Angry', NULL, 'Neutral', '0', '2026-03-17 07:24:47'),
(111, 10, 'Neutral', NULL, 'Neutral', '0', '2026-03-17 07:44:31'),
(112, 10, 'Anxious', NULL, 'Neutral', '0', '2026-03-17 07:53:23'),
(113, 10, 'Angry', NULL, 'Neutral', '0', '2026-03-17 08:37:27'),
(114, 10, 'Sad', NULL, 'Neutral', '0', '2026-03-17 09:12:24'),
(115, 8, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-18 03:24:10'),
(116, 8, 'Neutral', NULL, 'Neutral', '0', '2026-03-18 05:01:11'),
(117, 8, 'Neutral', NULL, 'Neutral', '0', '2026-03-18 07:03:08'),
(118, 8, 'Sad', NULL, 'Neutral', '0', '2026-03-18 08:20:20'),
(119, 8, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-19 03:39:05'),
(120, 8, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-19 16:23:32'),
(121, 8, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-19 16:24:14'),
(122, 15, 'Neutral', NULL, 'Neutral', '0', '2026-03-23 07:41:48'),
(123, 15, 'Sad', NULL, 'Neutral', '0', '2026-03-23 07:42:18'),
(124, 15, 'Neutral', NULL, 'Neutral', '0', '2026-03-23 07:50:05'),
(125, 15, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-23 07:52:46'),
(126, 15, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-23 08:03:02'),
(127, 15, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-23 08:03:44'),
(128, 15, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-23 08:05:48'),
(129, 15, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-23 08:11:41'),
(130, 15, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-23 08:19:04'),
(131, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-24 04:09:46'),
(132, 16, 'Angry', NULL, 'Neutral', '0', '2026-03-24 04:30:03'),
(133, 16, 'Happy', NULL, 'Neutral', '0', '2026-03-24 04:30:47'),
(134, 16, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-24 04:32:30'),
(135, 16, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-24 04:34:03'),
(136, 16, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-24 04:35:37'),
(137, 16, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-24 04:37:23'),
(138, 16, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-24 04:55:44'),
(139, 16, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-24 04:56:01'),
(140, 16, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-24 05:01:43'),
(141, 16, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-24 05:01:58'),
(142, 16, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-24 05:02:20'),
(143, 16, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-24 05:02:55'),
(144, 16, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-24 05:03:39'),
(145, 16, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-24 05:22:54'),
(146, 16, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-24 05:24:00'),
(147, 16, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-24 05:29:39'),
(148, 16, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-24 05:30:32'),
(149, 16, 'Angry', NULL, 'Neutral', '0', '2026-03-24 08:27:37'),
(150, 16, 'Sad', NULL, 'Neutral', '0', '2026-03-24 09:12:59'),
(151, 16, 'Angry', NULL, 'Neutral', '0', '2026-03-24 09:13:18'),
(152, 16, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-25 04:44:15'),
(153, 16, 'Excited', 'Excited', 'Happy', '0.9975', '2026-03-25 04:45:09'),
(154, 16, 'Sad', 'Sad', 'Anxious', '0.9991', '2026-03-25 04:48:53'),
(155, 15, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-25 05:17:38'),
(156, 15, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-25 05:18:08'),
(157, 17, 'Angry', NULL, 'Neutral', '0', '2026-03-25 05:23:36'),
(158, 17, 'Happy', NULL, 'Neutral', '0', '2026-03-25 07:26:50'),
(159, 17, 'Angry', NULL, 'Neutral', '0', '2026-03-25 08:25:57'),
(160, 17, 'Anxious', NULL, 'Neutral', '0', '2026-03-25 08:35:46'),
(161, 17, 'Anxious', NULL, 'Neutral', '0', '2026-03-25 08:36:03'),
(162, 15, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-27 02:47:27'),
(163, 15, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-27 02:47:48'),
(164, 2, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-27 02:48:37'),
(165, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-27 02:52:22'),
(166, 2, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-27 03:02:40'),
(167, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-27 03:03:42'),
(168, 2, 'Neutral', 'Neutral', 'Happy', '0.8346', '2026-03-27 03:13:04'),
(169, 2, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-27 03:29:18'),
(170, 2, 'Happy', NULL, 'Neutral', '0', '2026-03-27 04:19:47'),
(171, 2, 'Neutral', NULL, 'Neutral', '0', '2026-03-27 04:20:03'),
(172, 2, 'Angry', NULL, 'Neutral', '0', '2026-03-27 04:34:20'),
(173, 2, 'Angry', NULL, 'Neutral', '0', '2026-03-27 04:40:13'),
(174, 2, 'Happy', NULL, 'Neutral', '0', '2026-03-27 04:40:45'),
(175, 2, 'Anxious', NULL, 'Neutral', '0', '2026-03-27 04:41:01'),
(176, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-27 04:48:09'),
(177, 2, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-27 04:48:15'),
(178, 2, 'Anxious', NULL, 'Neutral', '0', '2026-03-27 04:51:48'),
(179, 2, 'Anxious', NULL, 'Neutral', '0', '2026-03-27 04:52:04'),
(180, 2, 'Anxious', 'Anxious', 'Happy', '0.9976', '2026-03-27 04:53:07'),
(181, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-27 04:53:13'),
(182, 2, 'Sad', NULL, 'Neutral', '0', '2026-03-27 04:57:49'),
(183, 2, 'Sad', NULL, 'Neutral', '0', '2026-03-27 05:00:17'),
(184, 2, 'Anxious', NULL, 'Neutral', '0', '2026-03-27 05:10:37'),
(185, 2, 'Neutral', NULL, 'Neutral', '0', '2026-03-27 05:11:20'),
(186, 2, 'Excited', NULL, 'Neutral', '0', '2026-03-27 05:11:35'),
(187, 2, 'Angry', NULL, 'Neutral', '0', '2026-03-27 05:17:37'),
(188, 2, 'Neutral', NULL, 'Neutral', '0', '2026-03-27 05:20:11'),
(189, 2, 'Happy', 'Happy', 'Happy', '0.9993', '2026-03-27 05:24:31'),
(190, 2, 'Angry', 'Angry', 'Sad', '0.9991', '2026-03-27 05:24:39'),
(191, 2, 'Sad', NULL, 'Neutral', '0', '2026-03-27 05:30:00'),
(192, 2, 'Sad', NULL, 'Neutral', '0', '2026-03-27 05:35:06'),
(193, 2, 'Sad', NULL, 'Neutral', '0', '2026-03-27 05:42:02'),
(194, 2, 'Sad', NULL, 'Neutral', '0', '2026-03-27 05:44:58'),
(195, 2, 'Angry', NULL, 'Neutral', '0', '2026-03-27 05:48:37'),
(196, 2, 'Excited', NULL, 'Neutral', '0', '2026-03-27 05:48:55'),
(197, 2, 'Neutral', NULL, 'Neutral', '0', '2026-03-27 06:55:39'),
(198, 2, 'Happy', NULL, 'Neutral', '0', '2026-03-27 06:56:00'),
(199, 18, 'Happy', NULL, 'Neutral', '0', '2026-03-27 07:26:45'),
(200, 2, 'Happy', NULL, 'Neutral', '0', '2026-03-27 09:04:40');

-- --------------------------------------------------------

--
-- Table structure for table `friendships`
--

CREATE TABLE `friendships` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  `status` varchar(20) DEFAULT 'accepted',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `friendships`
--

INSERT INTO `friendships` (`id`, `user_id`, `friend_id`, `status`, `created_at`) VALUES
(1, 8, 1, 'accepted', '2026-03-16 08:04:20'),
(2, 1, 8, 'accepted', '2026-03-16 08:04:20'),
(3, 8, 10, 'accepted', '2026-03-18 04:40:04'),
(4, 10, 8, 'accepted', '2026-03-18 04:40:04'),
(5, 15, 2, 'accepted', '2026-03-23 03:48:57'),
(6, 2, 15, 'accepted', '2026-03-23 03:48:57'),
(7, 15, 1, 'accepted', '2026-03-23 03:49:04'),
(8, 1, 15, 'accepted', '2026-03-23 03:49:04'),
(9, 15, 4, 'accepted', '2026-03-23 03:49:09'),
(10, 4, 15, 'accepted', '2026-03-23 03:49:09'),
(11, 2, 7, 'accepted', '2026-03-24 04:11:18'),
(12, 7, 2, 'accepted', '2026-03-24 04:11:18'),
(13, 17, 2, 'accepted', '2026-03-25 06:41:26'),
(14, 2, 17, 'accepted', '2026-03-25 06:41:26'),
(15, 17, 1, 'accepted', '2026-03-25 06:41:30'),
(16, 1, 17, 'accepted', '2026-03-25 06:41:30');

-- --------------------------------------------------------

--
-- Table structure for table `meditation_library`
--

CREATE TABLE `meditation_library` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `technique` varchar(100) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meditation_library`
--

INSERT INTO `meditation_library` (`id`, `title`, `category`, `technique`, `duration`, `level`, `description`) VALUES
(21, 'Deep Breath Reset', 'Breathing Meditation', 'Breath Awareness', 5, 'Beginner', 'Short breathing exercise to calm the mind'),
(22, 'Calm Breathing Journey', 'Breathing Meditation', 'Breath Awareness', 10, 'Beginner', 'Guided breathing meditation for relaxation'),
(23, 'Ocean Breath Awareness', 'Breathing Meditation', 'Breath Awareness', 10, 'Intermediate', 'Breathing meditation inspired by ocean rhythm'),
(24, 'Relaxing Breath Cycle', 'Breathing Meditation', 'Breath Awareness', 15, 'Advanced', 'Deep breathing cycles to release tension'),
(25, 'Cosmic Calm Journey', 'Mindfulness Meditation', 'Mind Observation', 10, 'Beginner', 'Mindfulness journey through calm awareness'),
(26, 'Mind Balance Session', 'Mindfulness Meditation', 'Mind Observation', 10, 'Beginner', 'Balance thoughts and emotions'),
(27, 'Present Moment Awareness', 'Mindfulness Meditation', 'Mind Observation', 10, 'Intermediate', 'Focus attention on the present moment'),
(28, 'Inner Awareness', 'Mindfulness Meditation', 'Mind Observation', 15, 'Advanced', 'Deep inner awareness meditation'),
(29, 'Full Body Relaxation', 'Body Scan Meditation', 'Body Scan', 10, 'Beginner', 'Scan body sensations and release tension'),
(30, 'Grounding Body Scan', 'Body Scan Meditation', 'Body Scan', 10, 'Intermediate', 'Ground yourself through body awareness'),
(31, 'Deep Release Session', 'Body Scan Meditation', 'Body Scan', 15, 'Advanced', 'Release stress from every part of the body'),
(32, 'Grateful Heart Practice', 'Gratitude Meditation', 'Gratitude Reflection', 10, 'Beginner', 'Focus on gratitude and appreciation'),
(33, 'Joyful Reflection', 'Gratitude Meditation', 'Gratitude Reflection', 10, 'Intermediate', 'Reflect on joyful experiences'),
(34, 'Inner Appreciation', 'Gratitude Meditation', 'Gratitude Reflection', 15, 'Advanced', 'Deep gratitude meditation'),
(35, 'Compassion Flow', 'Loving-kindness Meditation', 'Loving Kindness', 10, 'Beginner', 'Send compassion to yourself and others'),
(36, 'Kindness Expansion', 'Loving-kindness Meditation', 'Loving Kindness', 10, 'Intermediate', 'Expand kindness to the world'),
(37, 'Heart Opening Session', 'Loving-kindness Meditation', 'Loving Kindness', 15, 'Advanced', 'Open your heart to compassion'),
(38, 'Sleep Wind Down', 'Sleep Meditation', 'Relaxation', 10, 'Beginner', 'Relax before sleep'),
(39, 'Deep Sleep Meditation', 'Sleep Meditation', 'Relaxation', 15, 'Intermediate', 'Prepare your mind for deep sleep'),
(40, 'Night Calm Journey', 'Sleep Meditation', 'Relaxation', 15, 'Advanced', 'Guided meditation for peaceful sleep');

-- --------------------------------------------------------

--
-- Table structure for table `meditation_sessions`
--

CREATE TABLE `meditation_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `goal` varchar(100) DEFAULT NULL,
  `mood_before` varchar(50) DEFAULT NULL,
  `stress_before` int(11) DEFAULT NULL,
  `experience_level` varchar(50) DEFAULT NULL,
  `session_name` varchar(150) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `techniques` varchar(255) DEFAULT NULL,
  `match_score` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'generated',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `mood_after` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meditation_sessions`
--

INSERT INTO `meditation_sessions` (`id`, `user_id`, `goal`, `mood_before`, `stress_before`, `experience_level`, `session_name`, `duration`, `techniques`, `match_score`, `status`, `start_time`, `end_time`, `created_at`, `mood_after`, `notes`, `started_at`, `completed_at`) VALUES
(1, 1, 'Feel Happier', NULL, NULL, 'Beginner', 'Cosmic Calm Journey', 0, 'AI Generated', 85, 'completed', '2026-03-04 05:36:18', '2026-03-04 05:36:21', '2026-03-04 05:36:18', NULL, NULL, NULL, NULL),
(2, 1, 'Increase Calm', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 0, 'AI Generated', 85, 'completed', '2026-03-04 05:58:09', '2026-03-04 05:58:11', '2026-03-04 05:58:09', NULL, NULL, NULL, NULL),
(3, 1, 'Sleep Better', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 0, 'AI Generated', 85, 'completed', '2026-03-04 05:58:58', '2026-03-04 05:59:03', '2026-03-04 05:58:58', NULL, NULL, NULL, NULL),
(4, 1, 'Improve Focus', NULL, NULL, 'Intermediate', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-04 06:14:15', '2026-03-04 06:14:18', '2026-03-04 06:14:15', NULL, NULL, NULL, NULL),
(5, 1, 'Sleep Better', NULL, NULL, 'Intermediate', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-04 06:23:08', '2026-03-04 06:23:12', '2026-03-04 06:23:08', NULL, NULL, NULL, NULL),
(6, 1, 'Feel Happier', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 06:36:37', '2026-03-04 06:36:40', '2026-03-04 06:36:37', NULL, NULL, NULL, NULL),
(7, 1, 'Increase Calm', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-04 06:43:05', '2026-03-04 06:43:09', '2026-03-04 06:43:06', NULL, NULL, NULL, NULL),
(8, 1, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-04 06:48:18', '2026-03-04 06:48:25', '2026-03-04 06:48:18', NULL, NULL, NULL, NULL),
(9, 1, 'Increase Calm', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 06:52:27', '2026-03-04 06:52:30', '2026-03-04 06:52:27', NULL, NULL, NULL, NULL),
(10, 1, 'Increase Calm', NULL, NULL, 'Beginner', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 06:57:45', '2026-03-04 06:57:47', '2026-03-04 06:57:45', NULL, NULL, NULL, NULL),
(11, 1, 'Increase Calm', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 07:15:21', '2026-03-04 07:15:23', '2026-03-04 07:15:21', NULL, NULL, NULL, NULL),
(12, 1, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 07:28:52', '2026-03-04 07:28:54', '2026-03-04 07:28:52', NULL, NULL, NULL, NULL),
(13, 1, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 07:40:33', '2026-03-04 07:40:37', '2026-03-04 07:40:33', NULL, NULL, NULL, NULL),
(14, 1, 'Feel Happier', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 07:46:18', '2026-03-04 07:46:20', '2026-03-04 07:46:18', NULL, NULL, NULL, NULL),
(15, 1, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 07:53:39', '2026-03-04 07:53:42', '2026-03-04 07:53:39', NULL, NULL, NULL, NULL),
(16, 1, 'Build Mindfulness', NULL, NULL, 'Intermediate', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-04 08:00:08', '2026-03-04 08:00:10', '2026-03-04 08:00:08', NULL, NULL, NULL, NULL),
(17, 1, 'Library Session', NULL, NULL, 'General', 'Morning Focus', 1, 'Library', 100, 'completed', '2026-03-04 08:00:34', '2026-03-04 08:00:36', '2026-03-04 08:00:34', NULL, NULL, NULL, NULL),
(18, 1, 'Library Session', NULL, NULL, 'General', 'Micro Calm', 1, 'Library', 100, 'completed', '2026-03-04 08:02:37', '2026-03-04 08:02:43', '2026-03-04 08:02:37', NULL, NULL, NULL, NULL),
(19, 1, 'Increase Calm', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 08:37:31', '2026-03-04 08:37:33', '2026-03-04 08:37:31', NULL, NULL, NULL, NULL),
(20, 1, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-04 08:50:49', '2026-03-04 08:50:51', '2026-03-04 08:50:49', NULL, NULL, NULL, NULL),
(21, 1, 'Increase Calm', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-04 08:56:29', '2026-03-04 08:56:36', '2026-03-04 08:56:29', NULL, NULL, NULL, NULL),
(22, 1, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-04 09:09:01', '2026-03-04 09:09:03', '2026-03-04 09:09:01', NULL, NULL, NULL, NULL),
(23, 1, 'Increase Calm', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-04 09:19:32', '2026-03-04 09:19:33', '2026-03-04 09:19:32', NULL, NULL, NULL, NULL),
(24, 2, 'Improve Focus', NULL, NULL, 'Advanced', 'Mind Balance Session', 10, 'AI Generated', 75, 'completed', '2026-03-06 03:40:02', '2026-03-10 05:26:39', '2026-03-06 03:40:02', NULL, NULL, NULL, NULL),
(25, 1, 'Feel Happier', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-10 03:44:02', '2026-03-10 03:44:04', '2026-03-10 03:44:02', NULL, NULL, NULL, NULL),
(26, 2, 'Sleep Better', NULL, NULL, 'Beginner', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-10 05:26:39', '2026-03-10 05:26:41', '2026-03-10 05:26:39', NULL, NULL, NULL, NULL),
(27, 2, 'Library Session', NULL, NULL, 'General', 'Micro Calm', 1, 'Library', 100, 'completed', '2026-03-10 06:45:25', '2026-03-10 06:45:27', '2026-03-10 06:45:25', NULL, NULL, NULL, NULL),
(28, 2, 'Improve Focus', NULL, NULL, 'Beginner', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-11 03:45:19', '2026-03-11 03:45:25', '2026-03-11 03:45:19', NULL, NULL, NULL, NULL),
(29, 2, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-11 03:45:52', '2026-03-11 03:45:54', '2026-03-11 03:45:52', NULL, NULL, NULL, NULL),
(30, 2, 'Increase Calm', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-11 06:57:32', '2026-03-11 06:57:37', '2026-03-11 06:57:32', NULL, NULL, NULL, NULL),
(31, 2, 'Sleep Better', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-11 07:11:11', '2026-03-11 07:11:15', '2026-03-11 07:11:11', NULL, NULL, NULL, NULL),
(32, 2, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 15, 'AI Generated', 85, 'completed', '2026-03-11 07:11:35', '2026-03-11 07:33:03', '2026-03-11 07:11:35', NULL, NULL, NULL, NULL),
(33, 2, 'Feel Happier', NULL, NULL, 'Advanced', 'Mind Balance Session', 10, 'AI Generated', 75, 'completed', '2026-03-11 07:33:03', '2026-03-11 07:52:00', '2026-03-11 07:33:03', NULL, NULL, NULL, NULL),
(34, 2, 'Sleep Better', NULL, NULL, 'Intermediate', 'Cosmic Calm Journey', 15, 'AI Generated', 85, 'completed', '2026-03-11 07:52:00', '2026-03-11 07:52:21', '2026-03-11 07:52:00', NULL, NULL, NULL, NULL),
(35, 2, 'Sleep Better', NULL, NULL, 'Intermediate', 'Cosmic Calm Journey', 15, 'AI Generated', 85, 'completed', '2026-03-11 07:52:21', '2026-03-11 08:09:08', '2026-03-11 07:52:21', NULL, NULL, NULL, NULL),
(36, 2, 'Sleep Better', NULL, NULL, 'Intermediate', 'Mind Balance Session', 10, 'AI Generated', 75, 'completed', '2026-03-11 08:09:08', '2026-03-11 08:23:07', '2026-03-11 08:09:08', NULL, NULL, NULL, NULL),
(37, 2, 'Feel Happier', NULL, NULL, 'Advanced', 'Mind Balance Session', 10, 'AI Generated', 75, 'completed', '2026-03-11 08:23:07', '2026-03-11 08:23:14', '2026-03-11 08:23:07', NULL, NULL, NULL, NULL),
(38, 2, 'Feel Happier', NULL, NULL, 'Advanced', 'Mind Balance Session', 10, 'AI Generated', 75, 'completed', '2026-03-11 08:23:14', '2026-03-11 08:43:14', '2026-03-11 08:23:14', NULL, NULL, NULL, NULL),
(39, 2, 'Increase Calm', NULL, NULL, 'Intermediate', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-11 08:43:14', '2026-03-11 08:43:16', '2026-03-11 08:43:14', NULL, NULL, NULL, NULL),
(40, 2, 'Improve Focus', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-12 03:17:08', '2026-03-12 03:17:11', '2026-03-12 03:17:08', NULL, NULL, NULL, NULL),
(41, 2, 'Library Session', NULL, NULL, 'General', 'Morning Focus', 1, 'Library', 100, 'completed', '2026-03-12 08:10:40', '2026-03-12 08:10:47', '2026-03-12 08:10:40', NULL, NULL, NULL, NULL),
(42, 2, 'Library Session', NULL, NULL, 'General', 'Mind Balance', 1, 'Library', 100, 'completed', '2026-03-12 08:23:53', '2026-03-12 08:23:58', '2026-03-12 08:23:53', NULL, NULL, NULL, NULL),
(43, 2, 'Setup', NULL, NULL, 'Intermediate', 'Initial Setup', 0, 'None', 0, 'setup', NULL, NULL, '2026-03-12 09:00:09', NULL, NULL, NULL, NULL),
(44, 2, 'Reduce Stress', NULL, NULL, 'Beginner', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 04:18:19', '2026-03-13 04:18:24', '2026-03-13 04:18:19', NULL, NULL, NULL, NULL),
(45, 2, 'Sleep Better', NULL, NULL, 'Beginner', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 04:19:27', '2026-03-13 04:19:31', '2026-03-13 04:19:27', NULL, NULL, NULL, NULL),
(46, 2, 'Improve Focus', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 04:20:15', '2026-03-13 04:20:17', '2026-03-13 04:20:15', NULL, NULL, NULL, NULL),
(47, 2, 'Feel Happier', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 04:54:02', '2026-03-13 04:54:04', '2026-03-13 04:54:02', NULL, NULL, NULL, NULL),
(48, 2, 'Increase Calm', NULL, NULL, 'Beginner', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-13 04:54:21', '2026-03-13 04:54:23', '2026-03-13 04:54:21', NULL, NULL, NULL, NULL),
(49, 2, 'Sleep Better', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 04:55:02', '2026-03-13 04:55:03', '2026-03-13 04:55:02', NULL, NULL, NULL, NULL),
(50, 2, 'Reduce Stress', NULL, NULL, 'Beginner', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-13 05:14:18', '2026-03-13 05:14:28', '2026-03-13 05:14:18', NULL, NULL, NULL, NULL),
(51, 2, 'Library Session', NULL, NULL, 'General', 'Breathe & Release', 1, 'Library', 100, 'completed', '2026-03-13 05:14:42', '2026-03-13 05:14:58', '2026-03-13 05:14:42', NULL, NULL, NULL, NULL),
(52, 2, 'Reduce Stress', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 05:30:47', '2026-03-13 05:30:48', '2026-03-13 05:30:47', NULL, NULL, NULL, NULL),
(53, 2, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-13 05:30:59', '2026-03-13 05:31:01', '2026-03-13 05:30:59', NULL, NULL, NULL, NULL),
(54, 2, 'Feel Happier', NULL, NULL, 'Beginner', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 05:31:15', '2026-03-13 05:31:17', '2026-03-13 05:31:15', NULL, NULL, NULL, NULL),
(55, 2, 'Improve Focus', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-13 05:31:56', '2026-03-13 05:31:58', '2026-03-13 05:31:56', NULL, NULL, NULL, NULL),
(56, 2, 'Reduce Stress', NULL, NULL, 'Beginner', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 06:16:15', '2026-03-13 06:16:17', '2026-03-13 06:16:15', NULL, NULL, NULL, NULL),
(57, 2, 'Improve Focus', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 06:16:32', '2026-03-13 06:16:34', '2026-03-13 06:16:32', NULL, NULL, NULL, NULL),
(58, 2, 'Sleep Better', NULL, NULL, 'Advanced', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 06:16:47', '2026-03-13 06:16:48', '2026-03-13 06:16:47', NULL, NULL, NULL, NULL),
(59, 2, 'Reduce Stress', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 06:36:55', '2026-03-13 06:36:57', '2026-03-13 06:36:55', NULL, NULL, NULL, NULL),
(60, 2, 'Increase Calm', NULL, NULL, 'Intermediate', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-13 06:37:08', '2026-03-13 06:37:10', '2026-03-13 06:37:08', NULL, NULL, NULL, NULL),
(61, 2, 'Build Mindfulness', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-13 06:37:24', '2026-03-13 06:37:26', '2026-03-13 06:37:24', NULL, NULL, NULL, NULL),
(62, 2, 'Feel Happier', NULL, NULL, 'Intermediate', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-13 06:37:38', '2026-03-13 06:37:40', '2026-03-13 06:37:38', NULL, NULL, NULL, NULL),
(63, 2, 'Sleep Better', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 06:58:54', '2026-03-13 06:58:55', '2026-03-13 06:58:54', NULL, NULL, NULL, NULL),
(64, 2, 'Increase Calm', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-13 06:59:07', '2026-03-13 06:59:09', '2026-03-13 06:59:07', NULL, NULL, NULL, NULL),
(65, 2, 'Feel Happier', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 07:06:54', '2026-03-13 07:06:55', '2026-03-13 07:06:54', NULL, NULL, NULL, NULL),
(66, 2, 'Build Mindfulness', NULL, NULL, 'Beginner', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 07:07:12', '2026-03-13 07:07:14', '2026-03-13 07:07:12', NULL, NULL, NULL, NULL),
(67, 2, 'Reduce Stress', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 07:27:56', '2026-03-13 07:27:58', '2026-03-13 07:27:56', NULL, NULL, NULL, NULL),
(68, 2, 'Increase Calm', NULL, NULL, 'Advanced', 'Cosmic Calm Journey', 1, 'AI Generated', 85, 'completed', '2026-03-13 07:28:08', '2026-03-13 07:28:09', '2026-03-13 07:28:08', NULL, NULL, NULL, NULL),
(69, 2, 'Feel Happier', NULL, NULL, 'Intermediate', 'Mind Balance Session', 1, 'AI Generated', 75, 'completed', '2026-03-13 09:05:30', '2026-03-13 09:05:38', '2026-03-13 09:05:30', NULL, NULL, NULL, NULL),
(70, 5, 'Breathing Meditation', NULL, NULL, 'General', 'Deep Breath Reset', 1, 'AI Generated', 100, 'completed', '2026-03-13 09:27:24', '2026-03-13 09:27:29', '2026-03-13 09:27:24', NULL, NULL, NULL, NULL),
(71, 8, 'Improve Focus', 'Anxious', NULL, 'Intermediate', 'Steady Mind Bridge', 10, 'Mindful Breathing', 85, 'started', NULL, NULL, '2026-03-14 07:30:04', NULL, NULL, '2026-03-14 02:00:04', NULL),
(72, 8, 'Sleep Better', 'Anxious', NULL, 'Advanced', 'Worry-Free Night', 15, 'Mindful Breathing', 85, 'started', NULL, NULL, '2026-03-14 07:33:26', NULL, NULL, '2026-03-14 02:03:26', NULL),
(73, 8, 'Feel Happier', 'Excited', NULL, 'Intermediate', 'Radiant Joy Flow', 10, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-14 07:58:10', 'Relaxed', NULL, '2026-03-14 02:28:10', '2026-03-14 02:28:13'),
(74, 8, 'Sleep Better', 'Excited', NULL, 'Beginner', 'Soft Landing', 5, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-14 08:00:31', 'Relaxed', NULL, '2026-03-14 02:30:31', '2026-03-14 02:30:33'),
(75, 2, 'Grounded Energy', 'Neutral', NULL, 'Beginner', 'Grounded Energy', 5, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-14 16:52:08', 'Relaxed', NULL, '2026-03-14 11:22:08', '2026-03-14 11:22:11'),
(76, 8, 'Increase Calm', 'Anxious', NULL, 'Intermediate', 'Anchor in the Storm', 10, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-15 06:29:01', 'Relaxed', NULL, '2026-03-15 00:59:01', '2026-03-15 00:59:03'),
(77, 8, 'Increase Calm', 'Excited', NULL, 'Advanced', 'Gentle Descent', 15, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-15 06:41:58', 'Relaxed', NULL, '2026-03-15 01:11:58', '2026-03-15 01:11:59'),
(78, 8, 'Increase Calm', 'Happy', NULL, 'Intermediate', 'Serene Glow', 10, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-15 06:54:57', 'Relaxed', NULL, '2026-03-15 01:24:57', '2026-03-15 01:24:59'),
(79, 8, 'Reduce Stress', 'Anxious', NULL, 'Intermediate', 'Safe Harbor Session', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-16 05:29:35', 'Relaxed', '', '2026-03-15 23:59:35', '2026-03-15 23:59:38'),
(80, 8, 'Improve Focus', 'Happy', NULL, 'Advanced', 'Peak Performance Flow', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-16 06:14:07', 'Relaxed', '', '2026-03-16 00:44:07', '2026-03-16 00:44:29'),
(81, 8, 'Increase Calm', 'Excited', NULL, 'Advanced', 'Gentle Descent', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-16 06:59:09', 'Relaxed', '', '2026-03-16 01:29:09', '2026-03-16 01:29:32'),
(82, 8, 'Sleep Better', 'Happy', NULL, 'Intermediate', 'Peaceful Sunset', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-17 03:03:24', 'Relaxed', '', '2026-03-16 21:33:24', '2026-03-16 21:33:26'),
(83, 10, 'Reduce Stress', 'Neutral', NULL, 'Intermediate', 'Pure Awareness', 10, 'Mindful Breathing', 100, 'started', NULL, NULL, '2026-03-17 04:55:58', NULL, NULL, '2026-03-16 23:25:57', NULL),
(84, 10, 'Improve Focus', 'Neutral', NULL, 'Intermediate', 'Pure Awareness', 10, 'Mindful Breathing', 100, 'started', NULL, NULL, '2026-03-17 04:56:46', NULL, NULL, '2026-03-16 23:26:46', NULL),
(85, 10, 'Increase Calm', 'Neutral', NULL, 'Beginner', 'Joyful Reflection', 5, 'Gratitude Meditation', 98, 'started', NULL, NULL, '2026-03-17 07:16:57', NULL, NULL, '2026-03-17 01:46:57', NULL),
(86, 10, 'Increase Calm', 'Neutral', NULL, 'Intermediate', 'Inner Appreciation', 10, 'Gratitude Meditation', 88, 'completed', NULL, NULL, '2026-03-17 07:18:15', 'Neutral', NULL, '2026-03-17 01:48:15', '2026-03-17 01:49:10'),
(87, 10, 'Increase Calm', 'Neutral', NULL, 'Advanced', 'Inner Appreciation', 15, 'Gratitude Meditation', 93, 'completed', NULL, NULL, '2026-03-17 07:24:51', 'Neutral', NULL, '2026-03-17 01:54:51', '2026-03-17 01:55:00'),
(88, 10, 'Improve Focus', 'Neutral', NULL, 'Intermediate', 'Inner Awareness', 10, 'Mindfulness Meditation', 85, 'completed', NULL, NULL, '2026-03-17 07:44:36', 'Happy', NULL, '2026-03-17 02:14:36', '2026-03-17 02:15:03'),
(89, 10, 'Improve Focus', 'Neutral', NULL, 'Intermediate', 'Present Moment Awareness', 10, 'Mindfulness Meditation', 93, 'completed', NULL, NULL, '2026-03-17 07:53:26', 'Neutral', NULL, '2026-03-17 02:23:26', '2026-03-17 02:23:44'),
(90, 10, 'Improve Focus', 'Neutral', NULL, 'Intermediate', 'Present Moment Awareness', 10, 'Mindfulness Meditation', 87, 'completed', NULL, NULL, '2026-03-17 08:37:31', 'Focused', NULL, '2026-03-17 03:07:31', '2026-03-17 03:08:57'),
(91, 10, 'Reduce Stress', 'Neutral', NULL, 'Intermediate', 'Mind Balance Session', 10, 'Mindfulness Meditation', 92, 'completed', NULL, NULL, '2026-03-17 09:12:29', 'Anxious', NULL, '2026-03-17 03:42:29', '2026-03-17 03:42:41'),
(92, 8, 'Improve Focus', 'Angry', NULL, 'Intermediate', 'Clarity Through Calm', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-18 03:24:13', 'Relaxed', '', '2026-03-17 21:54:13', '2026-03-17 21:54:30'),
(93, 8, 'improve_focus', 'neutral', NULL, 'beginner', 'Deep Breath Reset', 5, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-18 04:18:36', NULL, NULL, '2026-03-17 22:48:36', NULL),
(94, 8, 'Sleep Better', 'Neutral', NULL, 'Intermediate', 'Grateful Heart Practice', 10, 'Gratitude Meditation', 98, 'completed', NULL, NULL, '2026-03-18 05:01:14', 'Calm', NULL, '2026-03-17 23:31:14', '2026-03-17 23:31:26'),
(95, 8, 'Improve Focus', 'Neutral', NULL, 'Intermediate', 'Joyful Reflection', 10, 'Gratitude Meditation', 93, 'completed', NULL, NULL, '2026-03-18 07:03:11', 'Calm', NULL, '2026-03-18 01:33:11', '2026-03-18 01:33:24'),
(96, 8, 'Reduce Stress', 'Neutral', NULL, 'Intermediate', 'Mind Balance Session', 1, 'Mindfulness Meditation', 87, 'completed', NULL, NULL, '2026-03-18 08:20:22', 'Focused', NULL, '2026-03-18 02:50:22', '2026-03-18 02:50:34'),
(97, 8, 'Sleep Better', 'Anxious', NULL, 'Intermediate', 'Worry-Free Night', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-19 03:39:08', 'Relaxed', '', '2026-03-18 22:09:08', '2026-03-18 22:09:49'),
(98, 8, 'Sleep Better', 'Happy', NULL, 'Beginner', 'Peaceful Sunset', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-19 16:23:37', 'Relaxed', '', '2026-03-19 10:53:37', '2026-03-19 10:53:57'),
(99, 8, 'Feel Happier', 'Sad', NULL, 'Intermediate', 'Sunrise Within', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-19 16:24:18', 'Relaxed', '', '2026-03-19 10:54:18', '2026-03-19 10:54:29'),
(100, 15, 'improve_focus', 'neutral', NULL, 'beginner', 'Deep Breath Reset', 5, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-23 03:50:43', NULL, NULL, '2026-03-22 22:20:43', NULL),
(101, 15, 'Reduce Stress', 'Neutral', NULL, 'Beginner', 'Pure Awareness', 1, 'Mindful Breathing', 100, 'completed', NULL, NULL, '2026-03-23 07:41:59', 'Neutral', '', '2026-03-23 02:11:59', '2026-03-23 02:12:06'),
(102, 15, 'Increase Calm', 'Anxious', NULL, 'Intermediate', 'Anchor in the Storm', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-23 07:52:51', 'Relaxed', '', '2026-03-23 02:22:51', '2026-03-23 02:23:08'),
(103, 15, 'Reduce Stress', 'Happy', NULL, 'Beginner', 'Joyful Stillness', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-23 08:03:06', 'Relaxed', '', '2026-03-23 02:33:06', '2026-03-23 02:33:11'),
(104, 2, 'Improve Focus', 'Happy', NULL, 'Intermediate', 'Peak Performance Flow', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-24 04:09:50', 'Relaxed', '', '2026-03-23 22:39:50', '2026-03-23 22:39:54'),
(105, 16, 'Reduce Stress', 'Neutral', NULL, 'Intermediate', 'Default Session', 10, 'Error', 1, 'started', NULL, NULL, '2026-03-24 04:30:23', NULL, NULL, '2026-03-23 23:00:23', NULL),
(106, 16, 'Increase Calm', 'Excited', NULL, 'Advanced', 'Gentle Descent', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-24 04:34:20', 'Relaxed', '', '2026-03-23 23:04:20', '2026-03-23 23:04:31'),
(107, 16, 'Reduce Stress', 'Sad', NULL, 'Beginner', 'Gentle Healing Flow', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-24 04:55:47', 'Relaxed', '', '2026-03-23 23:25:47', '2026-03-23 23:25:50'),
(108, 16, 'Improve Focus', 'Anxious', NULL, 'Intermediate', 'Steady Mind Bridge', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-24 04:56:03', 'Relaxed', '', '2026-03-23 23:26:03', '2026-03-23 23:26:05'),
(109, 16, 'Improve Focus', 'Anxious', NULL, 'Intermediate', 'Steady Mind Bridge', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-24 05:01:47', 'Relaxed', '', '2026-03-23 23:31:47', '2026-03-23 23:31:50'),
(110, 16, 'Reduce Stress', 'Neutral', NULL, 'Beginner', 'Zen Harmony', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-24 05:02:02', 'Relaxed', '', '2026-03-23 23:32:02', '2026-03-23 23:32:04'),
(111, 16, 'Reduce Stress', 'Anxious', NULL, 'Beginner', 'Safe Harbor Session', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-24 05:02:23', 'Relaxed', '', '2026-03-23 23:32:23', '2026-03-23 23:32:47'),
(112, 16, 'Increase Calm', 'Sad', NULL, 'Intermediate', 'Still Waters', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-24 05:02:56', 'Relaxed', '', '2026-03-23 23:32:56', '2026-03-23 23:33:24'),
(113, 16, 'Reduce Stress', 'Neutral', NULL, 'Intermediate', 'Default Session', 10, 'Error', 1, 'started', NULL, NULL, '2026-03-24 08:28:02', NULL, NULL, '2026-03-24 02:58:02', NULL),
(114, 16, 'improve_focus', 'neutral', NULL, 'beginner', 'Deep Breath Reset', 5, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-24 09:12:47', NULL, NULL, '2026-03-24 03:42:47', NULL),
(115, 16, 'Build Mindfulness', 'Neutral', NULL, 'Advanced', 'Deep Breath Reset', 1, 'Breath Awareness', 1, 'completed', NULL, NULL, '2026-03-24 09:13:22', 'Neutral', '', '2026-03-24 03:43:22', '2026-03-24 03:43:32'),
(116, 15, 'reduce_stress', 'Neutral', NULL, 'Beginner', 'Deep Breath Reset', 5, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-25 03:48:53', NULL, NULL, '2026-03-24 22:18:53', NULL),
(117, 15, 'reduce_stress', 'Neutral', NULL, 'Beginner', 'Calm Breathing Journey', 5, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-25 03:48:59', NULL, NULL, '2026-03-24 22:18:59', NULL),
(118, 15, 'reduce_stress', 'Neutral', NULL, 'Intermediate', 'Ocean Breath Awareness', 10, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-25 03:49:01', NULL, NULL, '2026-03-24 22:19:01', NULL),
(119, 15, 'reduce_stress', 'Neutral', NULL, 'Advanced', 'Relaxing Breath Cycle', 15, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-25 03:49:04', NULL, NULL, '2026-03-24 22:19:04', NULL),
(120, 15, 'feel_happier', 'Neutral', NULL, 'Advanced', 'Inner Appreciation', 15, 'Gratitude Reflection', 90, 'started', NULL, NULL, '2026-03-25 03:49:10', NULL, NULL, '2026-03-24 22:19:10', NULL),
(121, 15, 'feel_happier', 'Neutral', NULL, 'Intermediate', 'Kindness Expansion', 10, 'Loving Kindness', 90, 'started', NULL, NULL, '2026-03-25 03:49:11', NULL, NULL, '2026-03-24 22:19:11', NULL),
(122, 15, 'sleep_better', 'Neutral', NULL, 'Beginner', 'Sleep Wind Down', 5, 'Relaxation', 90, 'started', NULL, NULL, '2026-03-25 03:49:16', NULL, NULL, '2026-03-24 22:19:16', NULL),
(123, 15, 'reduce_stress', 'Neutral', NULL, 'Intermediate', 'Ocean Breath Awareness', 10, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-25 03:49:21', NULL, NULL, '2026-03-24 22:19:21', NULL),
(124, 15, 'build_mindfulness', 'Neutral', NULL, 'Beginner', 'Mind Balance Session', 5, 'Mind Observation', 90, 'started', NULL, NULL, '2026-03-25 03:49:25', NULL, NULL, '2026-03-24 22:19:25', NULL),
(125, 15, 'sleep_better', 'Neutral', NULL, 'Beginner', 'Sleep Wind Down', 5, 'Relaxation', 90, 'started', NULL, NULL, '2026-03-25 03:49:28', NULL, NULL, '2026-03-24 22:19:28', NULL),
(126, 15, 'reduce_stress', 'Neutral', NULL, 'Intermediate', 'Ocean Breath Awareness', 9, 'Breath Awareness', 90, 'completed', NULL, NULL, '2026-03-25 03:51:20', 'Relaxed', '', '2026-03-24 22:21:20', '2026-03-24 22:31:22'),
(127, 16, 'Improve Focus', 'Anxious', NULL, 'Intermediate', 'Steady Mind Bridge', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-25 04:44:18', 'Relaxed', '', '2026-03-24 23:14:18', '2026-03-24 23:14:54'),
(128, 16, 'Build Mindfulness', 'Excited', NULL, 'Advanced', 'Mindful Energy', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-25 04:45:11', 'Relaxed', '', '2026-03-24 23:15:11', '2026-03-24 23:15:43'),
(129, 16, 'reduce_stress', 'Neutral', NULL, 'Intermediate', 'Ocean Breath Awareness', 1, 'Breath Awareness', 90, 'completed', NULL, NULL, '2026-03-25 04:47:07', 'Relaxed', '', '2026-03-24 23:17:07', '2026-03-24 23:17:46'),
(130, 16, 'Sleep Better', 'Sad', NULL, 'Beginner', 'Nighttime Comfort', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-25 04:48:54', 'Relaxed', '', '2026-03-24 23:18:54', '2026-03-24 23:18:57'),
(131, 15, 'Feel Happier', 'Happy', NULL, 'Intermediate', 'Joy Amplifier', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-25 05:17:41', 'Relaxed', '', '2026-03-25 05:17:41', '2026-03-25 05:17:44'),
(132, 15, 'Feel Happier', 'Angry', NULL, 'Intermediate', 'Peace & Positivity', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-25 05:18:10', 'Relaxed', '', '2026-03-25 05:18:10', '2026-03-25 05:18:12'),
(133, 17, 'Reduce Stress', 'Neutral', NULL, 'Intermediate', 'Deep Breath Reset', 1, 'Breath Awareness', 1, 'completed', NULL, NULL, '2026-03-25 05:23:40', 'Neutral', '', '2026-03-25 05:23:40', '2026-03-25 05:23:46'),
(134, 17, 'improve_focus', 'neutral', NULL, 'beginner', 'Deep Breath Reset', 5, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-25 07:09:12', NULL, NULL, '2026-03-25 07:09:12', NULL),
(135, 17, 'Reduce Stress', 'Neutral', NULL, 'Beginner', 'Deep Breath Reset', 1, 'Breath Awareness', 1, 'completed', NULL, NULL, '2026-03-25 07:26:53', 'Neutral', NULL, '2026-03-25 07:26:53', '2026-03-25 07:27:03'),
(136, 17, 'Reduce Stress', 'Neutral', NULL, 'Intermediate', 'Deep Breath Reset', 1, 'Breath Awareness', 1, 'completed', NULL, NULL, '2026-03-25 08:26:00', 'Focused', NULL, '2026-03-25 08:26:00', '2026-03-25 08:26:14'),
(137, 15, 'Reduce Stress', 'Happy', NULL, 'Beginner', 'Joyful Stillness', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-27 02:47:30', 'Relaxed', '', '2026-03-27 02:47:30', '2026-03-27 02:47:35'),
(138, 15, 'Sleep Better', 'Happy', NULL, 'Intermediate', 'Peaceful Sunset', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-27 02:47:51', 'Relaxed', '', '2026-03-27 02:47:51', '2026-03-27 02:47:53'),
(139, 2, 'Increase Calm', 'Neutral', NULL, 'Intermediate', 'Deep Stillness', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-27 02:48:42', 'Relaxed', '', '2026-03-27 02:48:42', '2026-03-27 02:48:44'),
(140, 2, 'Increase Calm', 'Anxious', NULL, 'Advanced', 'Anchor in the Storm', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-27 02:52:25', 'Relaxed', '', '2026-03-27 02:52:25', '2026-03-27 02:52:27'),
(141, 2, 'Sleep Better', 'Angry', NULL, 'Beginner', 'Release & Rest', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-27 03:02:42', 'Relaxed', '', '2026-03-27 03:02:42', '2026-03-27 03:02:44'),
(142, 2, 'Sleep Better', 'Anxious', NULL, 'Intermediate', 'Worry-Free Night', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-27 03:03:43', 'Relaxed', '', '2026-03-27 03:03:43', '2026-03-27 03:03:46'),
(143, 2, 'Increase Calm', 'Neutral', NULL, 'Intermediate', 'Deep Stillness', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-27 03:13:06', 'Relaxed', '', '2026-03-27 03:13:06', '2026-03-27 03:13:08'),
(144, 2, 'Sleep Better', 'Angry', NULL, 'Intermediate', 'Release & Rest', 1, 'Mindful Breathing', 85, 'completed', NULL, NULL, '2026-03-27 03:29:20', 'Relaxed', '', '2026-03-27 03:29:20', '2026-03-27 03:29:22'),
(145, 2, 'reduce_stress', 'Neutral', NULL, 'Beginner', 'Calm Breathing Journey', 5, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-27 04:04:11', NULL, NULL, '2026-03-27 04:04:11', NULL),
(146, 2, 'Improve Focus', 'Angry', NULL, 'Intermediate', 'Deep Breath Reset', 10, 'Breath Awareness', 1, 'started', NULL, NULL, '2026-03-27 04:34:24', NULL, NULL, '2026-03-27 04:34:24', NULL),
(147, 2, 'improve_focus', 'neutral', NULL, 'beginner', 'Deep Breath Reset', 5, 'Breath Awareness', 90, 'started', NULL, NULL, '2026-03-27 05:11:06', NULL, NULL, '2026-03-27 05:11:05', NULL),
(148, 2, 'Improve Focus', 'Angry', NULL, 'Intermediate', 'Recovery Session', 10, 'Mindful Breathing', 1, 'started', NULL, NULL, '2026-03-27 05:19:55', NULL, NULL, '2026-03-27 05:19:55', NULL),
(149, 2, 'Build Mindfulness', 'Sad', NULL, 'Intermediate', 'Recovery Session', 10, 'Mindful Breathing', 1, 'started', NULL, NULL, '2026-03-27 05:35:09', NULL, NULL, '2026-03-27 05:35:09', NULL),
(150, 2, 'stress', 'Neutral', NULL, 'Beginner', 'Deep Breath Reset', 1, 'Breathing Meditation', 1, 'completed', NULL, NULL, '2026-03-27 06:55:45', 'Neutral', '', '2026-03-27 06:55:45', '2026-03-27 06:55:50'),
(151, 2, 'happy', 'Happy', NULL, 'Beginner', 'Gratitude Flow', 1, 'Gratitude Visualization', 1, 'completed', NULL, NULL, '2026-03-27 06:56:06', 'Neutral', '', '2026-03-27 06:56:06', '2026-03-27 06:56:12'),
(152, 2, 'happy', 'Happy', NULL, 'Beginner', 'Gratitude Flow', 5, 'Gratitude Visualization', 1, 'started', NULL, NULL, '2026-03-27 09:04:43', NULL, NULL, '2026-03-27 09:04:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `message`, `is_read`, `created_at`) VALUES
(1, 8, 1, 'Hi', 0, '2026-03-17 02:54:55'),
(2, 8, 1, 'Hiii', 0, '2026-03-17 02:55:14'),
(3, 8, 1, 'Let\'s meditate now! Join me', 0, '2026-03-17 02:56:48'),
(4, 8, 1, 'Your streak is amazing! Keep going!', 0, '2026-03-17 03:10:29'),
(5, 8, 1, 'Your streak is amazing! Keep going!', 0, '2026-03-17 03:16:35'),
(6, 8, 1, 'Join me for Joyful Stillness — let\'s meditate together!', 0, '2026-03-17 03:16:40'),
(7, 8, 1, 'Join me for Joyful Stillness — let\'s meditate together!', 0, '2026-03-17 03:16:41'),
(8, 8, 1, 'Your streak is amazing! Keep going!', 0, '2026-03-17 03:16:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `enable_notifications` tinyint(1) DEFAULT 1,
  `profile_image` varchar(255) DEFAULT NULL,
  `data_sharing_consent` tinyint(1) DEFAULT 0,
  `reset_otp` varchar(6) DEFAULT NULL,
  `otp_created_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone_number`, `password`, `enable_notifications`, `profile_image`, `data_sharing_consent`, `reset_otp`, `otp_created_at`, `created_at`) VALUES
(1, 'Srinu', 'srinivasvellaturi61@gmail.com', '+919880040441', 'Srinu@0000', 1, 'http://127.0.0.1:8000/uploads/profile_1_1774410269.png', 0, NULL, NULL, '2026-03-04 05:35:34'),
(2, 'Devaa', 'punugotideva618@gmail.com', '+917993537243', 'Deva@0625', 1, 'http://192.168.137.203:8000/uploads/profile_2_1774599049.jpg', 1, '6410', '2026-03-27 04:06:02', '2026-03-06 03:11:53'),
(3, 'Malli', 'mallireddy794@gmail.com', '+917013740820', 'Malli@1111', 0, NULL, 0, NULL, NULL, '2026-03-10 03:42:40'),
(4, 'PUSHPA', 'srik29924@gmail.com', '+917729047460', 'Pushpa@123', 1, NULL, 0, NULL, NULL, '2026-03-12 05:35:15'),
(5, 'punugotideva', 'punugotideva9@gmail.com', '+917993537243', 'Deva@9999', 1, NULL, 0, NULL, NULL, '2026-03-13 03:27:07'),
(6, 'Star', 'starll33344@gmail.com', '+917993537243', 'Star@0000', 0, NULL, 0, NULL, NULL, '2026-03-14 06:40:26'),
(7, 'Deva01', 'punugotideviprasad22@gmail.com', '+918978467846', 'Deva@2222', 0, NULL, 0, NULL, NULL, '2026-03-14 06:53:11'),
(8, 'Deva', 'punugotideva0@gmail.com', '+917993537243', 'Deva@3333', 1, 'http://10.200.255.103:8000/uploads/profile_8_1774323111.jpg', 0, '5624', '2026-03-24 03:33:11', '2026-03-14 07:00:41'),
(9, 'DEVI PRASAD', 'deva45221000@gmail.com', '+9107993537243', 'Deva@12345', 1, NULL, 0, NULL, NULL, '2026-03-16 07:42:28'),
(10, 'HELLO', 'mahendrakandula77@gmail.com', '+917981628670', 'Mahi@1234', 1, 'http://127.0.0.1:8000/uploads/profile_10_1773722744.jpg', 1, NULL, NULL, '2026-03-17 03:40:10'),
(14, 'Deva22', 'narutouzumaki45221@gmail.com', '+917993537243', 'Deva@1234', 0, NULL, 0, NULL, NULL, '2026-03-20 06:50:47'),
(15, 'Punugoti', 'devapunugoti9@gmail.com', '+917729047460', 'Deva@9999', 1, 'http://10.51.216.103:8000/uploads/profile_15_1774410654.jpg', 0, NULL, NULL, '2026-03-23 03:45:59'),
(16, 'Devaa', 'punugotideva00@gmail.com', '+917993537243', 'Deva@7777', 0, NULL, 0, NULL, NULL, '2026-03-24 04:27:52'),
(17, 'Vishal', 'vishal21804@gmail.com', '+917993537243', 'Vishal@0000', 1, 'http://127.0.0.1:8000/uploads/profile_17_1774420947.png', 0, NULL, NULL, '2026-03-25 03:43:08'),
(18, 'TestUser', 'testuser123@gmail.com', '+919876543210', 'Password123!', 1, NULL, 0, NULL, NULL, '2026-03-27 07:18:36');

-- --------------------------------------------------------

--
-- Table structure for table `user_goals`
--

CREATE TABLE `user_goals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `goal_type` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `experience` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_goals`
--

INSERT INTO `user_goals` (`id`, `user_id`, `goal_type`, `created_at`, `experience`) VALUES
(1, 5, 'Improve Focus', '2026-03-13 03:34:27', NULL),
(14, 10, 'Reduce Stress', '2026-03-17 09:12:22', 'Intermediate'),
(18, 8, 'Reduce Stress', '2026-03-18 08:20:09', 'Intermediate'),
(22, 15, 'Improve Focus', '2026-03-23 07:50:02', 'Intermediate'),
(28, 16, 'Build Mindfulness', '2026-03-24 09:13:15', 'Advanced'),
(33, 17, 'Improve Focus', '2026-03-25 08:36:01', 'Intermediate'),
(56, 2, 'happy', '2026-03-27 06:55:58', 'Beginner');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_plans`
--
ALTER TABLE `ai_plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `challenges`
--
ALTER TABLE `challenges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challenge_participants`
--
ALTER TABLE `challenge_participants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `challenge_id` (`challenge_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `checkins`
--
ALTER TABLE `checkins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `emotion_logs`
--
ALTER TABLE `emotion_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `friendships`
--
ALTER TABLE `friendships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `friend_id` (`friend_id`);

--
-- Indexes for table `meditation_library`
--
ALTER TABLE `meditation_library`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meditation_sessions`
--
ALTER TABLE `meditation_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_goals`
--
ALTER TABLE `user_goals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ai_plans`
--
ALTER TABLE `ai_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT for table `challenges`
--
ALTER TABLE `challenges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `challenge_participants`
--
ALTER TABLE `challenge_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `checkins`
--
ALTER TABLE `checkins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `emotion_logs`
--
ALTER TABLE `emotion_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT for table `friendships`
--
ALTER TABLE `friendships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `meditation_library`
--
ALTER TABLE `meditation_library`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `meditation_sessions`
--
ALTER TABLE `meditation_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `user_goals`
--
ALTER TABLE `user_goals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ai_plans`
--
ALTER TABLE `ai_plans`
  ADD CONSTRAINT `ai_plans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `challenge_participants`
--
ALTER TABLE `challenge_participants`
  ADD CONSTRAINT `challenge_participants_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`),
  ADD CONSTRAINT `challenge_participants_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `checkins`
--
ALTER TABLE `checkins`
  ADD CONSTRAINT `checkins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `emotion_logs`
--
ALTER TABLE `emotion_logs`
  ADD CONSTRAINT `emotion_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `friendships`
--
ALTER TABLE `friendships`
  ADD CONSTRAINT `friendships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `friendships_ibfk_2` FOREIGN KEY (`friend_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `meditation_sessions`
--
ALTER TABLE `meditation_sessions`
  ADD CONSTRAINT `meditation_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_goals`
--
ALTER TABLE `user_goals`
  ADD CONSTRAINT `user_goals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
