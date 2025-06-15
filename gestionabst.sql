-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2025 at 03:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gestionabst`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add Utilisateur personnalisé', 6, 'add_customuser'),
(22, 'Can change Utilisateur personnalisé', 6, 'change_customuser'),
(23, 'Can delete Utilisateur personnalisé', 6, 'delete_customuser'),
(24, 'Can view Utilisateur personnalisé', 6, 'view_customuser'),
(25, 'Can add Classe', 7, 'add_classe'),
(26, 'Can change Classe', 7, 'change_classe'),
(27, 'Can delete Classe', 7, 'delete_classe'),
(28, 'Can view Classe', 7, 'view_classe'),
(29, 'Can add Élève', 8, 'add_eleve'),
(30, 'Can change Élève', 8, 'change_eleve'),
(31, 'Can delete Élève', 8, 'delete_eleve'),
(32, 'Can view Élève', 8, 'view_eleve'),
(33, 'Can add Enseignement', 9, 'add_enseignement'),
(34, 'Can change Enseignement', 9, 'change_enseignement'),
(35, 'Can delete Enseignement', 9, 'delete_enseignement'),
(36, 'Can view Enseignement', 9, 'view_enseignement'),
(37, 'Can add Matière', 10, 'add_matiere'),
(38, 'Can change Matière', 10, 'change_matiere'),
(39, 'Can delete Matière', 10, 'delete_matiere'),
(40, 'Can view Matière', 10, 'view_matiere'),
(41, 'Can add Log SMS', 11, 'add_smslog'),
(42, 'Can change Log SMS', 11, 'change_smslog'),
(43, 'Can delete Log SMS', 11, 'delete_smslog'),
(44, 'Can view Log SMS', 11, 'view_smslog'),
(45, 'Can add Séance', 12, 'add_seance'),
(46, 'Can change Séance', 12, 'change_seance'),
(47, 'Can delete Séance', 12, 'delete_seance'),
(48, 'Can view Séance', 12, 'view_seance'),
(49, 'Can add Note', 13, 'add_note'),
(50, 'Can change Note', 13, 'change_note'),
(51, 'Can delete Note', 13, 'delete_note'),
(52, 'Can view Note', 13, 'view_note'),
(53, 'Can add Présence', 14, 'add_presence'),
(54, 'Can change Présence', 14, 'change_presence'),
(55, 'Can delete Présence', 14, 'delete_presence'),
(56, 'Can view Présence', 14, 'view_presence');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-06-03 21:18:49.077796', '1', 'Malaye Doumbia (Administrateur)', 2, '[{\"changed\": {\"fields\": [\"Type d\'utilisateur\", \"T\\u00e9l\\u00e9phone\"]}}]', 6, 1),
(2, '2025-06-03 22:40:40.821280', '2', '  (Enseignant)', 1, '[{\"added\": {}}]', 6, 1),
(3, '2025-06-03 22:41:11.522802', '2', 'SEGBE SOUMAHORO (Enseignant)', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email\"]}}]', 6, 1),
(4, '2025-06-03 23:22:16.826944', '1', 'MATHEMATIQUE (MATHS)', 1, '[{\"added\": {}}]', 10, 1),
(5, '2025-06-03 23:23:09.137353', '2', 'FRANCAIS (FRAN)', 1, '[{\"added\": {}}]', 10, 1),
(6, '2025-06-03 23:23:32.780054', '1', '6EM1 - 6EME', 1, '[{\"added\": {}}]', 7, 1),
(7, '2025-06-03 23:23:48.668534', '2', '6EM2 - 6EME', 1, '[{\"added\": {}}]', 7, 1),
(8, '2025-06-03 23:23:56.417347', '3', '5EME1 - 5EME', 1, '[{\"added\": {}}]', 7, 1),
(9, '2025-06-03 23:24:04.395253', '4', '5EME2 - 5EME', 1, '[{\"added\": {}}]', 7, 1),
(10, '2025-06-03 23:24:21.051293', '5', '4EME1 - 4EME', 1, '[{\"added\": {}}]', 7, 1),
(11, '2025-06-03 23:24:33.582460', '6', '4EME2 - 4EME', 1, '[{\"added\": {}}]', 7, 1),
(12, '2025-06-03 23:24:41.379928', '7', '3EME1 - 3EME', 1, '[{\"added\": {}}]', 7, 1),
(13, '2025-06-03 23:24:51.601758', '8', '3EME2 - 3EME', 1, '[{\"added\": {}}]', 7, 1),
(14, '2025-06-07 11:15:21.301807', '3', '  (Enseignant)', 1, '[{\"added\": {}}]', 6, 1),
(15, '2025-06-07 11:16:29.591763', '3', 'IBRAHIMA FOFANA (Enseignant)', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email\"]}}]', 6, 1),
(16, '2025-06-10 23:14:01.686561', '1', '6EME1', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 7, 1),
(17, '2025-06-10 23:14:13.258177', '2', '6EME2', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 7, 1),
(18, '2025-06-10 23:16:23.279859', '3', 'HISTOIRE GEOGRAPHIE (HIST-GEO)', 1, '[{\"added\": {}}]', 10, 1),
(19, '2025-06-11 11:51:26.473267', '1', 'IBRAHIMA FOFANA (Enseignant) - MATHEMATIQUE (MATHS) - 6EME1 - 2025-06-11 08:00:00', 1, '[{\"added\": {}}]', 12, 1),
(20, '2025-06-11 11:52:00.662437', '2', 'SEGBE SOUMAHORO (Enseignant) - FRANCAIS (FRAN) - 6EME2 - 2025-06-11 09:00:00', 1, '[{\"added\": {}}]', 12, 1),
(21, '2025-06-11 11:53:09.466473', '3', 'IBRAHIMA FOFANA (Enseignant) - MATHEMATIQUE (MATHS) - 6EME2 - 2025-06-11 09:00:00', 1, '[{\"added\": {}}]', 12, 1),
(22, '2025-06-11 12:09:17.239518', '3', 'IBRAHIMA FOFANA (Enseignant) - MATHEMATIQUE (MATHS) - 6EME2 - 2025-06-11 12:00:00', 2, '[{\"changed\": {\"fields\": [\"Heure debut\", \"Heure fin\"]}}]', 12, 1),
(23, '2025-06-14 23:21:53.076032', '3', 'KOUAKOU Jean Marc (19627056H)', 2, '[{\"changed\": {\"fields\": [\"T\\u00e9l\\u00e9phone parent\"]}}]', 8, 1),
(24, '2025-06-14 23:22:32.334473', '12', 'DOUMBIA Malaye - IBRAHIMA FOFANA (Enseignant) - MATHEMATIQUE (MATHS) - 6EME1 - 2025-06-11 08:00:00 - Absent', 1, '[{\"added\": {}}]', 14, 1),
(25, '2025-06-14 23:25:49.031594', '4', 'OUATTARA Ami (20161516Z)', 2, '[{\"changed\": {\"fields\": [\"T\\u00e9l\\u00e9phone parent\"]}}]', 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(7, 'gestionAbst', 'classe'),
(6, 'gestionAbst', 'customuser'),
(8, 'gestionAbst', 'eleve'),
(9, 'gestionAbst', 'enseignement'),
(10, 'gestionAbst', 'matiere'),
(13, 'gestionAbst', 'note'),
(14, 'gestionAbst', 'presence'),
(12, 'gestionAbst', 'seance'),
(11, 'gestionAbst', 'smslog'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-06-03 21:15:52.938841'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-06-03 21:15:52.975298'),
(3, 'auth', '0001_initial', '2025-06-03 21:15:53.146177'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-06-03 21:15:53.189399'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-06-03 21:15:53.201108'),
(6, 'auth', '0004_alter_user_username_opts', '2025-06-03 21:15:53.207663'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-06-03 21:15:53.213783'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-06-03 21:15:53.216410'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-06-03 21:15:53.221604'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-06-03 21:15:53.226382'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-06-03 21:15:53.231375'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-06-03 21:15:53.240206'),
(13, 'auth', '0011_update_proxy_permissions', '2025-06-03 21:15:53.247097'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-06-03 21:15:53.251801'),
(15, 'gestionAbst', '0001_initial', '2025-06-03 21:15:53.928871'),
(16, 'admin', '0001_initial', '2025-06-03 21:15:54.032701'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-06-03 21:15:54.043424'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-06-03 21:15:54.058165'),
(19, 'sessions', '0001_initial', '2025-06-03 21:15:54.109598'),
(20, 'gestionAbst', '0002_customuser_created_at_customuser_updated_at_and_more', '2025-06-07 18:26:37.248533'),
(21, 'gestionAbst', '0003_alter_classe_options_remove_classe_description_and_more', '2025-06-08 11:40:25.849532'),
(22, 'gestionAbst', '0004_alter_presence_options_and_more', '2025-06-14 23:06:45.899365');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('112w8kixy59obsjvmgw535d3m12nvf7t', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPKou:vSIDL0_s5MZ81t-aZgc59i02MnlaLhqQ6Lt8S-DhDjI', '2025-06-11 13:44:44.488859'),
('1daou1dqowe6negze064zdtx14m5ev1i', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uP8zf:dN3y3PJ8d0BryrgBw79X2cHBT8vDn8XVqdmgleOH9SM', '2025-06-11 01:07:03.973118'),
('1qfulbckw9n08zsjiiy72nk6ujy2zul8', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNtTg:FYowfWo4vB13J01SrXf6PaMZSyFp8dtU4B0QlS6XRNU', '2025-06-07 14:20:52.385329'),
('28ta6me8d1b8p1pmo5vw4vmz9557v2nt', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOHsG:4-Wx3Tyiyy5KuMAnajIXrrItkMRy3S_JX64_BIOWXL0', '2025-06-08 16:23:52.332135'),
('2lb3iidftd82db9r87u3ws0a7lbpqdta', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPAOZ:OAVEy5rax_cVCWV9c_fR6xG5Eh4crlT2aLqJ_k9gswE', '2025-06-11 02:36:51.574365'),
('34rc8wgq6e2hdrsn59aftlqlc3p4nl54', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPAS5:4Ys3HCGba3zHMvWknwQdBL_ypna82PMW7x_dVOEbNcY', '2025-06-11 02:40:29.491945'),
('4j59356w1owg8zvjipzfj1m6bh92vsok', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uOcoL:IxwEWIeboM8y0xbiMKLgv6k-xqLxBVTrWoIugfTJQmA', '2025-06-09 14:45:13.748588'),
('4ttvitwx60m4i8zq69jrl8t84qujils2', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOQwJ:_XD0N5-TXl83kLvmPl3cmK0ssj6yx4lNjV0o6JnlVt0', '2025-06-09 02:04:39.468950'),
('52ze53fqwlqtfzkfu35o9gvnfow9q1ym', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOb68:FbWhpsbWNZKVo_67uKm0KwdTi4GOSOzHtjxJCa64-QU', '2025-06-09 12:55:28.435904'),
('5ecl7hyauvrgk65ryqt2mx8hxruiz3ux', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uP9xT:HFkxVyXZIfN4WdfPMJhzFGDYi1srCXfsIrbvKYUVy6w', '2025-06-11 02:08:51.986853'),
('5kvz0ypm3r2wao4atrf9zstkijik3cto', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOFKP:EZ65aSo8U_6EBgSf0EYozFyNDR5np-UMDCJX2N3k3Yo', '2025-06-08 13:40:45.368283'),
('5skm1nc6qntj6ewhdckrwt45525wwslz', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uP9Xn:XpU05CvYoDMikG-L0vPqvIXChY6Th_DgCfgQ24idZpI', '2025-06-11 01:42:19.990121'),
('6i5zelk0ypyxho2ot93f3xccy5ylgoaa', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOPHC:8nvGFs8JarmO6mQDml3I6p_AycSOALNCsvxB-m3jCpo', '2025-06-09 00:18:06.274870'),
('742o4pavtn6b61v3amtep7rxsn7wt856', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOQrw:tbi0655rCAgTAnTnO6OxISItbHdBT5LcfKDBWY9dnjk', '2025-06-09 02:00:08.750770'),
('74olv9uf829wmbmfsds7tzr6tvbcoowi', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uPNbs:JSfhZd0wbxMoAFebT8j0UC1rKb3z6KSWJfuP7jf6KD0', '2025-06-11 16:43:28.113394'),
('8xnabh58i02ffhf04s2ispiqlk36kcu7', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOI8g:TWF_Vu90hLu9K94gHNuv085jQCfBeuXIh2d5Wl1NjXQ', '2025-06-08 16:40:50.994714'),
('91oxrncnf2v22zsth70e2d3pknqairmb', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uOcXR:0OQZPS13XFtuW1dPSSBX1zEglGYMW8dLzo7qxjNaAHM', '2025-06-09 14:27:45.415593'),
('92yvi8qb2kqsod0jxlilgkwrtl52lkuy', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOQyH:rT_wVMldTiq-3lN21KraS0sm_I8zf8XeBxkmZyzSRmY', '2025-06-09 02:06:41.539954'),
('93fwo3qjjfh1usmw0rt17wbof7uwf08f', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uObU5:nM86pYTYqOaKA3CpvbmbIbr4TFY8MrJ-41PYRXUnpmQ', '2025-06-09 13:20:13.572919'),
('9cadwfh7c0ih2atnybol1jgotr2jz339', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uQMV7:RAdd-Zv4DHJl5JeE2mAjSFfZ9xXjbjO46DBREX-y0Ug', '2025-06-14 09:44:33.280157'),
('9ld7icl3cso3mbdxah7f69mbkjwf76r8', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNve1:pmHbZMIZcz5s5U0K2cuD7X1wOhr-zvTy1IGNsZ1tMe8', '2025-06-07 16:39:41.035338'),
('9tqob5u6habffrymizbcppceggivusa3', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOvMX:_f3HZdH_tS98FyvrEKTiADkBOMH4ORCLkLuyFpJCXyc', '2025-06-10 10:33:45.620041'),
('aw7cb1cf7dyhdwoh48n9afm9svqhj9qe', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNg7P:vhh_LzpBJj7xOFbLTw5OYESHOekVLgarcNQ354Ab-9g', '2025-06-07 00:04:59.115863'),
('aycwkrw5hz9b0oq6mtkjoi2hx7qqtr25', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uP8d2:IRpHvlT0JbSRt47EkHrtpeZg_NY59_yccKJy6d3Wkzc', '2025-06-11 00:43:40.104618'),
('c1m05i7xx14w6n2ve51xu80oywmotoow', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uPmiD:lsLMhAwuX2TJ02LwZKjF7V_83xA2jSxEYDj2yyle468', '2025-06-12 19:31:41.082724'),
('c3mkaxxpb39s8jaud9gh40higq7oakyo', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uO1zk:Nymxqi1za82dtPXReQPLVzLxAb6oZFoIII7uewkT4is', '2025-06-07 23:26:32.718099'),
('ckxwmbi1liz63hx0ph499to5uq553nt8', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOvIX:aYFIqP_4DOYFMq6udYo5Ek6XjygUDnO6MNVYI9JTl48', '2025-06-10 10:29:37.686416'),
('cs89o3or39hi25re4krogiphrlc4p4jn', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOe1Q:Ho2NppDB3oPMaiYHrouIebhMnSpoLG0JjYGQDSniUy8', '2025-06-09 16:02:48.777180'),
('dx1zwn1sgr7qn96kq4hj9lct2ynt8155', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOgYP:TaGOvIwC6kBgINwyBsgNAHngbIytmMAAxNPhT8a0xJM', '2025-06-09 18:45:01.927751'),
('dyfgota8jd5j46ga1n9pty9lmmjofp2j', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOb31:0jL95s13tHY_KMBG7P8Y6UF74eOjJ05SCSxDiqMsW3o', '2025-06-09 12:52:15.202740'),
('dz6j1g30o12kmbaq6whjlshtkqkw2r92', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNyHP:0CcrgBXp_fmTFb0_asVx46MzOJHpBxpPNtCzSGXFVvk', '2025-06-07 19:28:31.060636'),
('e1h0uqxtew73fd1syo7gdsqd0do9tprk', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOkaW:46khjkCka-U6AHdmylBdierRh3VqtIj3SSb0KJITAnQ', '2025-06-09 23:03:28.836823'),
('e1zuipt2p3xq38edkzbknhn8psbpspqt', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPLVh:sUX_VAYXaBEtiNCbmbWBp6K4POVN02BvvcC7iYIq2bI', '2025-06-11 14:28:57.321192'),
('efd33hqsn2g8x2zvvpsvvqgl8hgyqzsq', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uPmwC:Tg0JO2btQYZVOT-M2PXPSdxJ0sbsOBUCFc3ajYoi_zw', '2025-06-12 19:46:08.991320'),
('ehqb9dqjnasmi8w8btzup6pef9x3z1kx', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNgH7:3OVVUSIwEcBAaDQL6bOGRoRDFRX3A64NZwxjq80K5mo', '2025-06-07 00:15:01.219471'),
('erh3y35qr0tryu3l4kcrwvm1i4pmstgw', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOgY2:EarC115UlTO0GYi7ZaE2Is4w3u5f23QtnLqmZGGlu9I', '2025-06-09 18:44:38.190586'),
('f7twmbxq216gnx1ht94y0gk8kkxcubut', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uOcwL:4yi2PvbholjZvVaY9afV9r4OrcmFbk9NIfpEN_FlnWQ', '2025-06-09 14:53:29.167876'),
('frgdgs3k0qxzc7lyi2wamgoy7cmodkaw', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uP99W:UaiKo_Y8jjSQvARQ_lQs4uMLN2ptD41cUq2icRpDzl4', '2025-06-11 01:17:14.371189'),
('fuhd22ylbce5ggvojj8smw9scxxajs4j', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOQ7o:Cb53NDCvwCz9Grh2zOeFe7KyEGyrA4mboi1i4qFN2kA', '2025-06-09 01:12:28.757435'),
('gpxsmuna1moeqktlwijf8k4u854zvwz7', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOEYW:vBOs_3tUNtIbDjISg_qxeW3HIo9T3P8aivItPqztANg', '2025-06-08 12:51:16.902782'),
('gv6a991yykafejowkb8yiuxv09wc0ep1', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOI8K:BWOndbFfHaZLkRGRt96MYNVgzk64H6zjzRkI6MS-4BM', '2025-06-08 16:40:28.368203'),
('h9dnscmj849xekhhkep11frjdz8mwl1z', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPMJT:WzLeAOy_AEPfQ40vlo_xV860JF5azkAWzOCs_mJHIBY', '2025-06-11 15:20:23.070309'),
('hc52z1uwu7tm11amgu3blefpto5vq7wb', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNtVV:Dktr9a0eX5x2sgAvZiY7sBGEIy-2GIBtsAa1zflTv4Y', '2025-06-07 14:22:45.131882'),
('hebsa0ia1u7bg88jzskqt5fu7nuid63e', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNpiD:YOFmrWe4i7vKPnvY__-SDbn7_PGRo_-5AV4WdEDptmc', '2025-06-07 10:19:37.906154'),
('i5pu3wcglso0y50vj853cnjphpeabrhr', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOb4C:Ulr-BbpUEMp_RpCs87Nn05NTN1pjgOLhJJ-lV3u-HE4', '2025-06-09 12:53:28.035852'),
('ipz7x52u3yr81gz8b91vu37152pqls4z', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uPO1N:g6JJ2MckdC1vWIPIze4KJ1rEwJ08TkdobHH5XiVRIi0', '2025-06-11 17:09:49.681626'),
('itd3jfbbzbxc1qct41nf4j5pwf15fx3k', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNBqv:YCq3iTo5HDQNZ6vhbSCBuC6swFGlcBSdMWyOvuWwISg', '2025-06-05 15:45:57.123270'),
('ixqew5ntnleu0cghf0tplvgco24jbm22', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uO2RU:1SR_ZsqTWycsW3O__T_jfttq8QmM9UkYA03x4bm7erE', '2025-06-07 23:55:12.644072'),
('j4t2ttrmrj38k7rikptil5pvq8tu0ub2', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOFKg:f0Z1HFCd6pTxln9E4BuSCnluAnL3MTPvaVk7NQr18P8', '2025-06-08 13:41:02.128212'),
('k1knrfc0bkcen15qv72g7uv8mbkftofh', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPKbv:eWrOX6Lab__JASoeN2zgRUMwIQfIscG_bCwmi3aNOx8', '2025-06-11 13:31:19.374755'),
('k8tz6vs9gpc8eo04wyz16fdi7amz1oak', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPLQc:-eWV3icKPtn7iKexf034nlZBSCku1eAxwzmx_7u93-M', '2025-06-11 14:23:42.932855'),
('kfl8wosj8bjkc0lllcehvqrdkcrv8jh6', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNpR0:UzIDFSmCdlYNT6reqtObm8X5qYU02BBwjYCIRdIgEwg', '2025-06-07 10:01:50.457691'),
('l4x4kjeofd5o9rpf37flnpx9h1l0qyxf', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uObMF:xjyDNVX85oiEGq4Lh5t62CEJvU8Dp8lt_KAV_DMEAzw', '2025-06-09 13:12:07.600355'),
('li4scb4qlhx11aza82fh4cb44a9nexwg', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uO2ef:m-3glWKvMhdg51vQStGJuEKPjN-iF5NoLyhCeL1DMGM', '2025-06-08 00:08:49.849985'),
('m55tco4zswvcnzru1wg1uua5hub60nze', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uQcCi:rpZ0u_iQQrQ9ZiQLmi2l6uB6EpLBsoqWYh5IrA-QKxM', '2025-06-15 02:30:36.771807'),
('n7qs4sv2t69hdr6tagdwerp8rbs7wffp', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNpjZ:9QgcNoTbKtPBWzi1b2Ig_v0yAswT0pytEwzRiosrX5M', '2025-06-07 10:21:01.051094'),
('nf1hooj1su5xgrit3ishtmx16lxlntrx', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPLPN:GOt0JuqyPpNzinZH5qO6KTXHf4Vzu0vnQhZQsg6b1_k', '2025-06-11 14:22:25.667007'),
('nrkkg2o9bml0jx6ozjamy4o7ekrllljc', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uOcyq:OyCQYOkJvlMM7XlWtLCrTylgEhLzGAmfdt-SGsU1ZBI', '2025-06-09 14:56:04.684940'),
('nw78owvl0ko4eaia9twlx7uw46rn97r2', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPJHU:lXzFTXPsvlKWjRyBL1Bmzb-PIGgPrNLxlYwC4oSHqic', '2025-06-11 12:06:08.655486'),
('o7pwgc437hu3iox8iu53w8swh0eh5f03', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNqWA:JzvrjiHJLcUwTvzAZwrGxdgb9aqOKH2jYFgJmRQuqAI', '2025-06-07 11:11:14.336929'),
('om5dw4527ohiorjcfikgkkqjtsirfpnh', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uOxhV:lc1-usYhIQJ9o76ew1PF0Br-iav61T0berhrexCXjp8', '2025-06-10 13:03:33.184433'),
('omvf325w1jbsukfq0xeozdjmqby0dna0', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNrfW:smZOgmSeUMfmWaW8xaeeW_TR-n9AJiO90whw7q2RK8I', '2025-06-07 12:24:58.576238'),
('p21yv7qob48thwwntolwyotiel51wqxq', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOQZY:EhaNi979L9q5us9dyEGs40kDjYF2JsVKxO6k1ChxpHI', '2025-06-09 01:41:08.732133'),
('ppabow19jebpbko7fo33if91akg80037', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uOcio:VztKbDnR9MPS0tCjaPgVDCgvUgPos6shVQGJ7rlSqOY', '2025-06-09 14:39:30.557677'),
('r6donxeocm8ko6lipyqtenpgmcq8xsr4', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uObCC:8_-vOSITHgm-uJvzWjKvKr0RtjanLEM-PxznfeyzyqE', '2025-06-09 13:01:44.637213'),
('r8hifbefa37vphr10b6wcl1yilejst9v', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNpFF:QywphhEHg4ehgazz697aK2wsdVKF_ZsPNVvrETHKMJ0', '2025-06-07 09:49:41.960621'),
('rx2qagfpsl0rp0cfm39vlmpgezhs0hqp', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uPK8e:zM0X8RVn1YkKvI3VCPTlLpyaUaVshQe9QFfp5CcE_DE', '2025-06-11 13:01:04.601422'),
('s6opcwcczsig5v5ora6ql50cda2bbi3s', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uPL7V:nAkRWT7hQ48YU-G6Rm_Px8rjJoMmPxmW-obYK2REdfM', '2025-06-11 14:03:57.714331'),
('s9sfxeezi1hx6i3ivkwil9cif0hmd18z', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNpwO:oYXOgKKgon1_V727oz_ynXryLpVlWb2LvEsNcA0lFKI', '2025-06-07 10:34:16.654814'),
('sk1009ybx1ds0tfbgkc5l4ttq65y6sdl', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uO0ZS:lytVunsQi2MTaSuBKPlXyb-Wecr0vscb5Q1jacIrbZI', '2025-06-07 21:55:18.104541'),
('susv8edz4m4hcjeyvd04y3jx6ls3dfbd', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOEpn:Q3-5ovx9KgJg3dhOLJTO79tp4mcgSwuFK_6BwAI3nZw', '2025-06-08 13:09:07.155161'),
('sw06jul4ppilaaw7k4p98kao4pegjtuy', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNBsU:k4OQIjizny4TfglJR1UfnBrnUKqryNFYeRwbBxkZbI8', '2025-06-05 15:47:34.598495'),
('tao5kbef84cf53q77hrdy1s5eol6kpse', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNtWH:wQzxjGu-ZT4D7DH-n0-YK9MX5pTEqusCGSRMsL6QIqc', '2025-06-07 14:23:33.043144'),
('thqdz1a90dwzmm489yqjzbf2pfxa451c', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOaz7:ACqmeQMUKdKZAikfg8v7MhLyp4CISOXeKEdO2O10r2U', '2025-06-09 12:48:13.444739'),
('uc0xrywc4raspvram7wj7opa9vu342no', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uMb3E:WqZ1DjzO4wBnQKIx5uHEZnwjSYLS_ilGb3yCyHFKJcQ', '2025-06-04 00:28:12.619990'),
('vmw8wp98dlpxoeomiu5g5gkn7f8a08xo', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOZwS:gkGR897Qxvvn5c_mxQNzojI4Sti7kolFud3BWtZzfo4', '2025-06-09 11:41:24.228371'),
('vu194hke4q81dswrxturv02h22c1ra33', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uOc9v:nC1ngs_MFJH-a2MoziarvHaKLlYmTh20uHjq3GU6M5Q', '2025-06-09 14:03:27.132210'),
('vytf5dizv3ut2v5o34n6zie0a1xb3e27', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOLE5:TSBxpZ0xMWWWM0msWaKIC04fxTAaqRQU2V3awGgJuPw', '2025-06-08 19:58:37.576827'),
('wcgw0vh4rurigsxo5jv1lf5kkgow5g5u', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOFAY:F7A-XATJZvikHPBR6CxIHHfaBcAN-SzMOIn1Aos21YU', '2025-06-08 13:30:34.106500'),
('wjvhqq0uxzgpzmsbx7edyrfduwolt4gn', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOHXi:JLjgGiVBVoXsUNYKJ4ir5p94qXm0HzrIFAoc4LC5fmk', '2025-06-08 16:02:38.851500'),
('xdt05soy2dkjkj2zkxogn7vbswmzu281', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOgQr:yt-kOhODEevDrNFjg9SlimshDjpU5l3H4D46I050wjA', '2025-06-09 18:37:13.477353'),
('xg4sk528l4rgwkqci5hixfwh32rw6lmw', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uOxRj:Fu0fDh3jwqOe4U7GZ4GZWRfkk2ZN_vXoK5mEZF3jxxY', '2025-06-10 12:47:15.536230'),
('xs4y7ccl4iho50aayvf2d303fce4a166', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOgaX:V514Zh1W2ILHh2z6aMPKU6mpYME6EFk3_hNKr4_Z5bs', '2025-06-09 18:47:13.497386'),
('xsg22kk8fi7bmnhqkaw7bub0t9lp7xv2', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPLX8:sKY2b-x1nzjIkF4vHuV6llV3aCWjZsDnr3kJk_pJeQQ', '2025-06-11 14:30:26.403766'),
('xucn1aa22e74h6zmpad41e80vw6wc2p8', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uNqHr:uVKcDt_sGEQlS39fqMguKqcjQ5K-gR9O8BlG_Or5oQA', '2025-06-07 10:56:27.630374'),
('y67o3slly7u2hdsks0kd99e0y7ajj0t9', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOCiz:DKr49S1QzD0F_hDYth4Vb6BGp8Fowf1-s6QPAGrLV9s', '2025-06-08 10:53:57.152034'),
('ydtii8yz9bd0of5r0qmqwaojh16xuyjo', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uPNpq:h409cg_szqNpqIHtyj3k3hZfP_eO-H4puHKLCqniRYY', '2025-06-11 16:57:54.696173'),
('yfbn058w9r88o3ph4cf781by2id4b9bw', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPMKI:kb2I5hOEvob68wDeVOxPonh8cwfp1K-rOS77nEPLFc4', '2025-06-11 15:21:14.684780'),
('yq4iabqm1kgm1965necb4ro5jcnc1zbq', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uQVzR:xRh2LjumUG_53qWMrD5S7tmveaNfiwP4Rkz1n1GM7nk', '2025-06-14 19:52:29.779701'),
('yxri9pvcocho9k7wt5wdeaybnuf6f46b', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOPGO:UgxLtM7nVeyPlP79gA3TMzClNLJQgKTkGwnv9CJw6q4', '2025-06-09 00:17:16.346987'),
('z32vdhr9ks7ps5ddloag4ufuo8euvwiv', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uOcpJ:_vD58kImK6jU0RqGmFU-GAV983vn8DmJ_giX4E_p5E8', '2025-06-09 14:46:13.310798'),
('zi224u9ql8jbuwjwrkh29nfce4dsv4tc', '.eJxVjEsOAiEQBe_C2hAiTAMu3XsG0nTTMmogmc9q4t11klno9lXV21TCdalpncuURlYXZdXpd8tIz9J2wA9s966pt2Uas94VfdBZ3zqX1_Vw_w4qzvVbI3FAbxwPTCIWkFw8i2QhKBGicAjego3eZTMAkB9iAcmAwROhcer9ARQ2OL0:1uPKcf:-QruLf4HjhTONkq8hQ-rwwa5dRS3D14RMXPwF4RCfsc', '2025-06-11 13:32:05.533252'),
('zjrkdzha2sd6cu1c97tb9yiq2s1aiczu', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uOClc:7ZOITmenCUqVyW8vGYAGGbkfyCudVMMlNIuVKGqVXH4', '2025-06-08 10:56:40.331862'),
('zm0s0yhhstk204kokuky6fl56exbpfvo', '.eJxVjDsOwyAQBe9CHSE-i4CU6XMGtMASnEQgGbuycvfYkouknZn3NhZwXWpYB81hyuzKJLv8sojpRe0Q-Ynt0XnqbZmnyI-En3bwe8_0vp3t30HFUfe1IRLWFouoorHemJIkkRfOFyuSdgVcigBaKuW0AJMdYrY7M0WhB2CfL-L3N7U:1uPOk6:aRGjkrymVSfQrRf4TbZm4yR7XK1jF4xXLjfnZMlQ7C8', '2025-06-11 17:56:02.977429');

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_classe`
--

CREATE TABLE `gestionabst_classe` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `niveau` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `capacite_max` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gestionabst_classe`
--

INSERT INTO `gestionabst_classe` (`id`, `nom`, `niveau`, `created_at`, `capacite_max`) VALUES
(1, '6EME1', '6EME', '2025-06-03 23:23:32.779659', 30),
(2, '6EME2', '6EME', '2025-06-03 23:23:48.667642', 30),
(3, '5EME1', '5EME', '2025-06-03 23:23:56.417004', 30),
(4, '5EME2', '5EME', '2025-06-03 23:24:04.394813', 30),
(5, '4EME1', '4EME', '2025-06-03 23:24:21.050841', 30),
(6, '4EME2', '4EME', '2025-06-03 23:24:33.582005', 30),
(7, '3EME1', '3EME', '2025-06-03 23:24:41.379391', 30),
(8, '3EME2', '3EME', '2025-06-03 23:24:51.601003', 30);

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_customuser`
--

CREATE TABLE `gestionabst_customuser` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `user_type` varchar(10) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gestionabst_customuser`
--

INSERT INTO `gestionabst_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `user_type`, `phone_number`, `email`, `created_at`, `updated_at`) VALUES
(1, 'pbkdf2_sha256$600000$jFvQVXtqWt7vmEtypJVH5Z$tAMJAaE6OiIE4gpnLDQxHg4B1q6qkhNKL5vuFkRBCWg=', '2025-06-15 01:28:13.081981', 1, 'Mr.Robot', 'Malaye', 'Doumbia', 1, 1, '2025-06-03 21:17:47.000000', 'admin', '+2250768275973', 'ecole@gmail.com', '2025-06-07 18:26:37.173676', '2025-06-07 18:26:37.192174'),
(2, 'pbkdf2_sha256$600000$NDwWmQKWrMEwA9vhrtMwt5$SIlJ3+NcwEoin+5BASkwnyHa7VGHACBbRGRmOKlX8IA=', NULL, 0, 'SOUMAHORO', 'SEGBE', 'SOUMAHORO', 0, 1, '2025-06-03 22:40:40.000000', 'teacher', '+2250556287988', 'segbe@gmail.com', '2025-06-07 18:26:37.173676', '2025-06-07 18:26:37.192174'),
(3, 'pbkdf2_sha256$600000$7t9XbkrVRONFtJbAgil2Dp$3Wha12hhaKMR3IF34aNRf83JL45xZSLR3jiw7XzrKdM=', '2025-06-15 00:49:32.701035', 0, 'BRAHIMA', 'IBRAHIMA', 'FOFANA', 0, 1, '2025-06-07 11:15:20.000000', 'teacher', '0503435800', 'fof@gmail.com', '2025-06-07 18:26:37.173676', '2025-06-07 18:26:37.192174'),
(4, 'pbkdf2_sha256$600000$Eh8rBh97KaRm1Eef2NXfUy$Bebi3pSbBD9rdzW7S8RzEEBBlNMllleco7TX9FNgxYU=', NULL, 0, 'PAUL', 'JEAN', 'PAUL', 1, 1, '2025-06-08 22:56:32.409166', 'admin', '+2250554647935', 'paul@gmail.com', '2025-06-08 22:56:32.947167', '2025-06-08 22:56:32.947176'),
(5, 'pbkdf2_sha256$600000$1X5G8bX4KLZbuey21fnGEI$gF5y9wkrAomUZzUDdjZCA8wlYbWVcBiOAMTeeJnANbQ=', NULL, 0, 'SIAKA', 'FOFANA', 'SIAKA', 0, 1, '2025-06-08 23:06:07.291452', 'teacher', '+2250574267601', 'siaka@gmail.com', '2025-06-08 23:06:07.616942', '2025-06-08 23:06:07.616955');

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_customuser_groups`
--

CREATE TABLE `gestionabst_customuser_groups` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_customuser_user_permissions`
--

CREATE TABLE `gestionabst_customuser_user_permissions` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_eleve`
--

CREATE TABLE `gestionabst_eleve` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenoms` varchar(100) NOT NULL,
  `date_naissance` date NOT NULL,
  `matricule` varchar(20) NOT NULL,
  `nom_parent` varchar(100) NOT NULL,
  `telephone_parent` varchar(15) NOT NULL,
  `email_parent` varchar(254) DEFAULT NULL,
  `actif` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `classe_id` bigint(20) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ;

--
-- Dumping data for table `gestionabst_eleve`
--

INSERT INTO `gestionabst_eleve` (`id`, `nom`, `prenoms`, `date_naissance`, `matricule`, `nom_parent`, `telephone_parent`, `email_parent`, `actif`, `created_at`, `classe_id`, `updated_at`) VALUES
(2, 'DOUMBIA', 'Malaye', '2007-12-02', '10100891Z', 'DOUMBIA ZOUMANA', '+2250554647935', 'doumbia@gmail.com', 1, '2025-06-08 12:32:09.993748', 1, '2025-06-08 12:32:09.993789'),
(3, 'KOUAKOU', 'Jean Marc', '2007-05-07', '19627056H', 'KOUAKOU KOUASSI JOSUE', '+2250758483084', 'josue@gmail.com', 1, '2025-06-08 15:56:20.423415', 2, '2025-06-14 23:21:53.074221'),
(4, 'OUATTARA', 'Ami', '2001-01-01', '20161516Z', 'OUATTARA DIATA', '+2250554647935', 'diata@gmail.com', 1, '2025-06-10 23:12:43.030264', 2, '2025-06-14 23:25:49.029876');

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_enseignement`
--

CREATE TABLE `gestionabst_enseignement` (
  `id` bigint(20) NOT NULL,
  `annee_scolaire` varchar(9) NOT NULL,
  `classe_id` bigint(20) NOT NULL,
  `enseignant_id` bigint(20) NOT NULL,
  `matiere_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gestionabst_enseignement`
--

INSERT INTO `gestionabst_enseignement` (`id`, `annee_scolaire`, `classe_id`, `enseignant_id`, `matiere_id`) VALUES
(2, '2024-2025', 1, 2, 2),
(1, '2024-2025', 2, 2, 2),
(7, '2024-2025', 3, 2, 2),
(5, '2024-2025', 1, 3, 1),
(9, '2024-2025', 1, 3, 3),
(6, '2024-2025', 2, 3, 1),
(3, '2024-2025', 3, 3, 1),
(4, '2024-2025', 4, 3, 1),
(8, '2024-2025', 5, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_matiere`
--

CREATE TABLE `gestionabst_matiere` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `code` varchar(10) NOT NULL,
  `coefficient` decimal(3,1) NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gestionabst_matiere`
--

INSERT INTO `gestionabst_matiere` (`id`, `nom`, `code`, `coefficient`, `description`) VALUES
(1, 'MATHEMATIQUE', 'MATHS', 3.0, ''),
(2, 'FRANCAIS', 'FRAN', 4.0, ''),
(3, 'HISTOIRE GEOGRAPHIE', 'HIST-GEO', 2.0, '');

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_note`
--

CREATE TABLE `gestionabst_note` (
  `id` bigint(20) NOT NULL,
  `type_note` varchar(15) NOT NULL,
  `valeur` decimal(4,2) NOT NULL,
  `note_sur` decimal(4,2) NOT NULL,
  `date_evaluation` date NOT NULL,
  `description` varchar(200) NOT NULL,
  `sms_envoye` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `eleve_id` bigint(20) NOT NULL,
  `enseignement_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_presence`
--

CREATE TABLE `gestionabst_presence` (
  `id` bigint(20) NOT NULL,
  `statut` varchar(10) NOT NULL,
  `remarque` longtext NOT NULL,
  `sms_envoye` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `eleve_id` bigint(20) NOT NULL,
  `seance_id` bigint(20) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gestionabst_presence`
--

INSERT INTO `gestionabst_presence` (`id`, `statut`, `remarque`, `sms_envoye`, `created_at`, `eleve_id`, `seance_id`, `updated_at`) VALUES
(1, 'absent', '', 0, '2025-06-11 12:51:58.165157', 3, 4, '2025-06-14 23:06:45.815569'),
(2, 'present', '', 0, '2025-06-11 12:51:58.165236', 4, 4, '2025-06-14 23:06:45.815569'),
(3, 'retard', '', 0, '2025-06-11 13:02:56.305224', 2, 5, '2025-06-14 23:06:45.815569'),
(4, 'absent', '', 0, '2025-06-11 13:33:07.422515', 3, 6, '2025-06-14 23:06:45.815569'),
(5, 'absent', '', 0, '2025-06-11 13:33:07.422654', 4, 6, '2025-06-14 23:06:45.815569'),
(6, 'present', '', 0, '2025-06-11 14:06:18.460721', 3, 7, '2025-06-14 23:06:45.815569'),
(7, 'present', '', 0, '2025-06-11 14:06:18.460791', 4, 7, '2025-06-14 23:06:45.815569'),
(8, 'absent', '', 0, '2025-06-11 15:37:12.982849', 3, 8, '2025-06-14 23:06:45.815569'),
(9, 'retard', '', 0, '2025-06-11 15:37:12.982878', 4, 8, '2025-06-14 23:06:45.815569'),
(10, 'absent', '', 0, '2025-06-12 17:37:43.473680', 3, 9, '2025-06-14 23:06:45.815569'),
(11, 'present', '', 0, '2025-06-12 17:37:43.473748', 4, 9, '2025-06-14 23:06:45.815569'),
(12, 'absent', '', 1, '2025-06-14 23:22:32.330069', 2, 1, '2025-06-14 23:22:32.330098'),
(13, 'absent', '', 0, '2025-06-14 23:26:39.431775', 3, 10, '2025-06-14 23:26:39.431795'),
(14, 'absent', '', 0, '2025-06-14 23:26:39.431821', 4, 10, '2025-06-14 23:26:39.431827'),
(15, 'absent', '', 0, '2025-06-14 23:26:52.127118', 3, 11, '2025-06-14 23:26:52.127171'),
(16, 'absent', '', 0, '2025-06-14 23:26:52.127195', 4, 11, '2025-06-14 23:26:52.127204'),
(17, 'absent', '', 0, '2025-06-14 23:40:23.606083', 3, 12, '2025-06-14 23:40:23.606235'),
(18, 'absent', '', 0, '2025-06-14 23:40:23.606257', 4, 12, '2025-06-14 23:40:23.606264'),
(19, 'absent', '', 0, '2025-06-15 00:00:49.059030', 3, 13, '2025-06-15 00:00:49.059051'),
(20, 'absent', '', 0, '2025-06-15 00:00:49.059069', 4, 13, '2025-06-15 00:00:49.059076'),
(21, 'absent', '', 0, '2025-06-15 00:06:51.112169', 3, 14, '2025-06-15 00:06:51.112185'),
(22, 'absent', '', 0, '2025-06-15 00:06:51.112198', 4, 14, '2025-06-15 00:06:51.112203'),
(23, 'absent', '', 0, '2025-06-15 00:35:02.619418', 3, 15, '2025-06-15 00:35:02.619473'),
(24, 'absent', '', 0, '2025-06-15 00:35:02.619534', 4, 15, '2025-06-15 00:35:02.619557'),
(25, 'absent', '', 0, '2025-06-15 00:49:56.185235', 3, 16, '2025-06-15 00:49:56.185257'),
(26, 'absent', '', 0, '2025-06-15 00:49:56.185272', 4, 16, '2025-06-15 00:49:56.185278'),
(27, 'absent', '', 1, '2025-06-15 01:13:05.806436', 3, 17, '2025-06-15 01:13:05.806455'),
(28, 'absent', '', 1, '2025-06-15 01:13:05.806468', 4, 17, '2025-06-15 01:13:05.806473'),
(29, 'absent', '', 1, '2025-06-15 01:27:44.417760', 2, 18, '2025-06-15 01:27:44.417793');

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_seance`
--

CREATE TABLE `gestionabst_seance` (
  `id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `heure_debut` time(6) NOT NULL,
  `heure_fin` time(6) NOT NULL,
  `description` longtext NOT NULL,
  `appel_fait` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `enseignement_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gestionabst_seance`
--

INSERT INTO `gestionabst_seance` (`id`, `date`, `heure_debut`, `heure_fin`, `description`, `appel_fait`, `created_at`, `enseignement_id`) VALUES
(1, '2025-06-11', '08:00:00.000000', '09:00:00.000000', '', 1, '2025-06-11 11:51:26.462322', 5),
(2, '2025-06-11', '09:00:00.000000', '10:00:00.000000', '', 1, '2025-06-11 11:52:00.657447', 1),
(3, '2025-06-11', '12:00:00.000000', '13:00:00.000000', '', 1, '2025-06-11 11:53:09.463100', 6),
(4, '2025-06-11', '09:00:00.000000', '10:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-11 12:51:58.153889', 6),
(5, '2025-06-11', '13:00:00.000000', '14:00:00.000000', 'Cours de HISTOIRE GEOGRAPHIE - 6EME1', 1, '2025-06-11 13:02:56.295471', 9),
(6, '2025-06-11', '13:00:00.000000', '14:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-11 13:33:07.411392', 6),
(7, '2025-06-11', '10:00:00.000000', '11:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-11 14:06:18.450251', 6),
(8, '2025-06-11', '15:00:00.000000', '16:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-11 15:37:12.978179', 6),
(9, '2025-06-12', '10:00:00.000000', '11:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-12 17:37:43.464662', 6),
(10, '2025-06-14', '14:00:00.000000', '15:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 0, '2025-06-14 23:26:39.426981', 6),
(11, '2025-06-14', '16:00:00.000000', '17:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 0, '2025-06-14 23:26:52.120590', 6),
(12, '2025-06-14', '13:00:00.000000', '14:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-14 23:40:23.599379', 6),
(13, '2025-06-15', '11:00:00.000000', '12:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-15 00:00:49.051333', 6),
(14, '2025-06-15', '10:00:00.000000', '11:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-15 00:06:51.105931', 6),
(15, '2025-06-15', '16:00:00.000000', '17:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-15 00:35:02.609374', 6),
(16, '2025-06-15', '08:00:00.000000', '09:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-15 00:49:56.176115', 6),
(17, '2025-06-15', '09:00:00.000000', '10:00:00.000000', 'Cours de MATHEMATIQUE - 6EME2', 1, '2025-06-15 01:13:05.799395', 6),
(18, '2025-06-15', '10:00:00.000000', '11:00:00.000000', 'Cours de MATHEMATIQUE - 6EME1', 1, '2025-06-15 01:27:44.411172', 5);

-- --------------------------------------------------------

--
-- Table structure for table `gestionabst_smslog`
--

CREATE TABLE `gestionabst_smslog` (
  `id` bigint(20) NOT NULL,
  `destinataire` varchar(15) NOT NULL,
  `message` longtext NOT NULL,
  `statut` varchar(10) NOT NULL,
  `type_message` varchar(20) NOT NULL,
  `reference_id` varchar(50) NOT NULL,
  `erreur_detail` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `sent_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gestionabst_smslog`
--

INSERT INTO `gestionabst_smslog` (`id`, `destinataire`, `message`, `statut`, `type_message`, `reference_id`, `erreur_detail`, `created_at`, `sent_at`) VALUES
(1, '+2250758483084', 'Bonjour KOUAKOU KOUASSI JOSUE,\n        \nVotre enfant KOUAKOU Jean Marc a été marqué(e) ABSENT(E) le 14/06/2025 de 13:00:00 à 14:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-14 23:40:24.201819', NULL),
(2, '+2250554647935', 'Bonjour OUATTARA DIATA,\n        \nVotre enfant OUATTARA Ami a été marqué(e) ABSENT(E) le 14/06/2025 de 13:00:00 à 14:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-14 23:40:24.750080', NULL),
(3, '+2250758483084', 'Bonjour KOUAKOU KOUASSI JOSUE,\n        \nVotre enfant KOUAKOU Jean Marc a été marqué(e) ABSENT(E) le 15/06/2025 de 11:00:00 à 12:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-15 00:00:49.562439', NULL),
(4, '+2250554647935', 'Bonjour OUATTARA DIATA,\n        \nVotre enfant OUATTARA Ami a été marqué(e) ABSENT(E) le 15/06/2025 de 11:00:00 à 12:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-15 00:00:50.075801', NULL),
(5, '+2250758483084', 'Bonjour KOUAKOU KOUASSI JOSUE,\n        \nVotre enfant KOUAKOU Jean Marc a été marqué(e) ABSENT(E) le 15/06/2025 de 10:00:00 à 11:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-15 00:06:51.654248', NULL),
(6, '+2250554647935', 'Bonjour OUATTARA DIATA,\n        \nVotre enfant OUATTARA Ami a été marqué(e) ABSENT(E) le 15/06/2025 de 10:00:00 à 11:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-15 00:06:52.153696', NULL),
(7, '+2250758483084', 'Bonjour KOUAKOU KOUASSI JOSUE,\n        \nVotre enfant KOUAKOU Jean Marc a été marqué(e) ABSENT(E) le 15/06/2025 de 16:00:00 à 17:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-15 00:35:03.174271', NULL),
(8, '+2250554647935', 'Bonjour OUATTARA DIATA,\n        \nVotre enfant OUATTARA Ami a été marqué(e) ABSENT(E) le 15/06/2025 de 16:00:00 à 17:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-15 00:35:03.696185', NULL),
(9, '+2250758483084', 'Bonjour KOUAKOU KOUASSI JOSUE,\n        \nVotre enfant KOUAKOU Jean Marc a été marqué(e) ABSENT(E) le 15/06/2025 de 08:00:00 à 09:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-15 00:49:56.663660', NULL),
(10, '+2250554647935', 'Bonjour OUATTARA DIATA,\n        \nVotre enfant OUATTARA Ami a été marqué(e) ABSENT(E) le 15/06/2025 de 08:00:00 à 09:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'erreur', 'absence', 'presence_None', 'Impossible d\'obtenir le token d\'accès', '2025-06-15 00:49:57.474205', NULL),
(11, '+2250758483084', 'Bonjour KOUAKOU KOUASSI JOSUE,\n        \nVotre enfant KOUAKOU Jean Marc a été marqué(e) ABSENT(E) le 15/06/2025 de 09:00:00 à 10:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'envoye', 'absence', 'presence_None', '', '2025-06-15 01:13:06.111722', '2025-06-15 01:13:07.502649'),
(12, '+2250554647935', 'Bonjour OUATTARA DIATA,\n        \nVotre enfant OUATTARA Ami a été marqué(e) ABSENT(E) le 15/06/2025 de 09:00:00 à 10:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nÉcole - Système de gestion', 'envoye', 'absence', 'presence_None', '', '2025-06-15 01:13:07.510867', '2025-06-15 01:13:08.429551'),
(13, '+2250554647935', 'Bonjour DOUMBIA ZOUMANA,\n        \nVotre enfant DOUMBIA Malaye a été marqué(e) ABSENT(E) le 15/06/2025 de 10:00:00 à 11:00:00 en MATHEMATIQUE avec IBRAHIMA FOFANA.\n\nEcole connectée - Collège Privé KOROKO', 'envoye', 'absence', 'presence_None', '', '2025-06-15 01:27:45.021757', '2025-06-15 01:27:46.426620');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_gestionAbst_customuser_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `gestionabst_classe`
--
ALTER TABLE `gestionabst_classe`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nom` (`nom`);

--
-- Indexes for table `gestionabst_customuser`
--
ALTER TABLE `gestionabst_customuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `gestionabst_customuser_groups`
--
ALTER TABLE `gestionabst_customuser_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gestionAbst_customuser_g_customuser_id_group_id_3f94892c_uniq` (`customuser_id`,`group_id`),
  ADD KEY `gestionAbst_customuser_groups_group_id_3e385137_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `gestionabst_customuser_user_permissions`
--
ALTER TABLE `gestionabst_customuser_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gestionAbst_customuser_u_customuser_id_permission_0dfccbe7_uniq` (`customuser_id`,`permission_id`),
  ADD KEY `gestionAbst_customus_permission_id_b7c7c4c1_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `gestionabst_eleve`
--
ALTER TABLE `gestionabst_eleve`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricule` (`matricule`),
  ADD KEY `gestionAbst_matricu_93c7c3_idx` (`matricule`),
  ADD KEY `gestionAbst_nom_743369_idx` (`nom`,`prenoms`),
  ADD KEY `gestionAbst_classe__07fa9f_idx` (`classe_id`,`actif`),
  ADD KEY `gestionAbst_created_be33f0_idx` (`created_at`);

--
-- Indexes for table `gestionabst_enseignement`
--
ALTER TABLE `gestionabst_enseignement`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gestionAbst_enseignement_enseignant_id_classe_id__34973ba2_uniq` (`enseignant_id`,`classe_id`,`matiere_id`,`annee_scolaire`),
  ADD KEY `gestionAbst_enseigne_matiere_id_ff8818a0_fk_gestionAb` (`matiere_id`),
  ADD KEY `gestionAbst_enseigne_classe_id_518e2338_fk_gestionAb` (`classe_id`);

--
-- Indexes for table `gestionabst_matiere`
--
ALTER TABLE `gestionabst_matiere`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nom` (`nom`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `gestionabst_note`
--
ALTER TABLE `gestionabst_note`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gestionAbst_note_eleve_id_e12a413e_fk_gestionAbst_eleve_id` (`eleve_id`),
  ADD KEY `gestionAbst_note_enseignement_id_bf850cf9_fk_gestionAb` (`enseignement_id`);

--
-- Indexes for table `gestionabst_presence`
--
ALTER TABLE `gestionabst_presence`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gestionAbst_presence_seance_id_eleve_id_28e0b336_uniq` (`seance_id`,`eleve_id`),
  ADD KEY `gestionAbst_presence_eleve_id_c077e4fc_fk_gestionAbst_eleve_id` (`eleve_id`);

--
-- Indexes for table `gestionabst_seance`
--
ALTER TABLE `gestionabst_seance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gestionAbst_seance_enseignement_id_ce592b75_fk_gestionAb` (`enseignement_id`);

--
-- Indexes for table `gestionabst_smslog`
--
ALTER TABLE `gestionabst_smslog`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `gestionabst_classe`
--
ALTER TABLE `gestionabst_classe`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `gestionabst_customuser`
--
ALTER TABLE `gestionabst_customuser`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `gestionabst_customuser_groups`
--
ALTER TABLE `gestionabst_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gestionabst_customuser_user_permissions`
--
ALTER TABLE `gestionabst_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gestionabst_eleve`
--
ALTER TABLE `gestionabst_eleve`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gestionabst_enseignement`
--
ALTER TABLE `gestionabst_enseignement`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `gestionabst_matiere`
--
ALTER TABLE `gestionabst_matiere`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gestionabst_note`
--
ALTER TABLE `gestionabst_note`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gestionabst_presence`
--
ALTER TABLE `gestionabst_presence`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `gestionabst_seance`
--
ALTER TABLE `gestionabst_seance`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `gestionabst_smslog`
--
ALTER TABLE `gestionabst_smslog`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_gestionAbst_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `gestionabst_customuser` (`id`);

--
-- Constraints for table `gestionabst_customuser_groups`
--
ALTER TABLE `gestionabst_customuser_groups`
  ADD CONSTRAINT `gestionAbst_customus_customuser_id_767bb2b3_fk_gestionAb` FOREIGN KEY (`customuser_id`) REFERENCES `gestionabst_customuser` (`id`),
  ADD CONSTRAINT `gestionAbst_customuser_groups_group_id_3e385137_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `gestionabst_customuser_user_permissions`
--
ALTER TABLE `gestionabst_customuser_user_permissions`
  ADD CONSTRAINT `gestionAbst_customus_customuser_id_766e6b30_fk_gestionAb` FOREIGN KEY (`customuser_id`) REFERENCES `gestionabst_customuser` (`id`),
  ADD CONSTRAINT `gestionAbst_customus_permission_id_b7c7c4c1_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Constraints for table `gestionabst_eleve`
--
ALTER TABLE `gestionabst_eleve`
  ADD CONSTRAINT `gestionAbst_eleve_classe_id_22e93661_fk_gestionAbst_classe_id` FOREIGN KEY (`classe_id`) REFERENCES `gestionabst_classe` (`id`);

--
-- Constraints for table `gestionabst_enseignement`
--
ALTER TABLE `gestionabst_enseignement`
  ADD CONSTRAINT `gestionAbst_enseigne_classe_id_518e2338_fk_gestionAb` FOREIGN KEY (`classe_id`) REFERENCES `gestionabst_classe` (`id`),
  ADD CONSTRAINT `gestionAbst_enseigne_enseignant_id_79bd63c2_fk_gestionAb` FOREIGN KEY (`enseignant_id`) REFERENCES `gestionabst_customuser` (`id`),
  ADD CONSTRAINT `gestionAbst_enseigne_matiere_id_ff8818a0_fk_gestionAb` FOREIGN KEY (`matiere_id`) REFERENCES `gestionabst_matiere` (`id`);

--
-- Constraints for table `gestionabst_note`
--
ALTER TABLE `gestionabst_note`
  ADD CONSTRAINT `gestionAbst_note_eleve_id_e12a413e_fk_gestionAbst_eleve_id` FOREIGN KEY (`eleve_id`) REFERENCES `gestionabst_eleve` (`id`),
  ADD CONSTRAINT `gestionAbst_note_enseignement_id_bf850cf9_fk_gestionAb` FOREIGN KEY (`enseignement_id`) REFERENCES `gestionabst_enseignement` (`id`);

--
-- Constraints for table `gestionabst_presence`
--
ALTER TABLE `gestionabst_presence`
  ADD CONSTRAINT `gestionAbst_presence_eleve_id_c077e4fc_fk_gestionAbst_eleve_id` FOREIGN KEY (`eleve_id`) REFERENCES `gestionabst_eleve` (`id`),
  ADD CONSTRAINT `gestionAbst_presence_seance_id_51a89d1b_fk_gestionAbst_seance_id` FOREIGN KEY (`seance_id`) REFERENCES `gestionabst_seance` (`id`);

--
-- Constraints for table `gestionabst_seance`
--
ALTER TABLE `gestionabst_seance`
  ADD CONSTRAINT `gestionAbst_seance_enseignement_id_ce592b75_fk_gestionAb` FOREIGN KEY (`enseignement_id`) REFERENCES `gestionabst_enseignement` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
