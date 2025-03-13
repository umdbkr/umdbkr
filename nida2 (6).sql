-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost
-- Üretim Zamanı: 12 Mar 2025, 23:42:05
-- Sunucu sürümü: 8.0.17
-- PHP Sürümü: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `nida2`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admin_logs`
--

CREATE TABLE `admin_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `details` text,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `admin_logs`
--

INSERT INTO `admin_logs` (`id`, `user_id`, `action`, `details`, `ip_address`, `created_at`) VALUES
(1, 2, 'login', NULL, '::1', '2025-03-08 23:00:03'),
(2, 2, 'login', NULL, '::1', '2025-03-09 02:16:13'),
(3, 2, 'login', NULL, '176.55.162.6', '2025-03-10 16:20:05'),
(4, 2, 'logout', NULL, '::1', '2025-03-11 08:07:05'),
(5, 2, 'login', NULL, '::1', '2025-03-11 08:07:58'),
(6, 2, 'login', NULL, '::1', '2025-03-11 18:34:49'),
(7, 2, 'logout', NULL, '::1', '2025-03-12 17:29:08'),
(8, 2, 'login', NULL, '::1', '2025-03-12 18:07:37'),
(9, 2, 'logout', NULL, '::1', '2025-03-12 18:27:40'),
(10, 2, 'login', NULL, '::1', '2025-03-12 18:30:07'),
(11, 2, 'logout', NULL, '::1', '2025-03-12 18:39:38'),
(12, 2, 'login', NULL, '::1', '2025-03-12 18:39:57');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` enum('super_admin','content_admin','reports_admin','admin','editor') NOT NULL DEFAULT 'content_admin',
  `permissions` text,
  `access_level` enum('low','medium','high','full') NOT NULL DEFAULT 'low',
  `last_login` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `admin_users`
--

INSERT INTO `admin_users` (`id`, `user_id`, `role`, `permissions`, `access_level`, `last_login`) VALUES
(1, 1, 'admin', NULL, 'full', NULL),
(2, 2, 'admin', NULL, 'low', '2025-03-11 18:30:39');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `status` enum('present','absent','late','excused') NOT NULL DEFAULT 'present',
  `notes` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `blog_categories`
--

INSERT INTO `blog_categories` (`id`, `name`, `slug`, `description`, `parent_id`) VALUES
(1, 'Haberler', 'haberler', 'Okul ile ilgili haberler ve duyurular', NULL),
(2, 'Etkinlikler', 'etkinlikler', 'Konserler ve etkinlikler hakkında bilgiler', NULL),
(3, 'Müzik Eğitimi', 'muzik-egitimi', 'Müzik eğitimi ile ilgili makaleler', NULL),
(4, 'Enstrümanlar', 'enstrumanlar', 'Enstrümanlar hakkında bilgiler', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `blog_comments`
--

CREATE TABLE `blog_comments` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `author_name` varchar(100) DEFAULT NULL,
  `author_email` varchar(100) DEFAULT NULL,
  `content` text NOT NULL,
  `status` enum('approved','pending','spam') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `blog_posts`
--

CREATE TABLE `blog_posts` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `excerpt` text,
  `featured_image` varchar(255) DEFAULT NULL,
  `status` enum('published','draft','pending') NOT NULL DEFAULT 'draft',
  `visibility` enum('public','private') NOT NULL DEFAULT 'public',
  `author_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `published_at` datetime DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `view_count` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `blog_posts`
--

INSERT INTO `blog_posts` (`id`, `title`, `slug`, `content`, `excerpt`, `featured_image`, `status`, `visibility`, `author_id`, `created_at`, `updated_at`, `published_at`, `category_id`, `user_id`, `is_featured`, `view_count`) VALUES
(2, 'Bağlama Dersleri', 'baglama-dersleri', '<p><strong>Bağlama Kursu: Geleneksel Türk Müziğinin Kapılarını Aralayın</strong></p><p>Bağlama, Türk halk müziğinin en önemli enstrümanlarından biridir. Hem amatör hem de profesyonel müzisyenler için büyük bir anlam taşıyan bu enstrüman, Anadolu’nun kültürel mirasını taşıyan bir köprüdür. Eğer siz de bağlama çalmayı öğrenmek ve bu eşsiz müzik geleneğini keşfetmek istiyorsanız, bir bağlama kursuna katılmak harika bir başlangıç olabilir.</p><h3>Bağlama Kursuna Katılmanın Avantajları</h3><p>Bağlama kursuna katılmak, hem müzikal hem de kişisel gelişiminiz açısından birçok avantaj sunar:</p><p><strong>Temel Müzik Bilgisi Kazanımı:</strong> Kurslarda nota bilgisi, ritim ve armoni gibi müziğin temel yapı taşlarını öğrenebilirsiniz.</p><p><strong>Bağlama Çalma Teknikleri:</strong> Parmak pozisyonları, tezene (mızrap) kullanımı ve yaygın akorları öğrenerek bağlamada ustalaşabilirsiniz.</p><p><strong>Türk Halk Müziği Kültürünü Keşfetme:</strong> Bağlama, halk müziği ile iç içe bir enstrümandır. Kurs sürecinde halk müziğinin önemli eserlerini çalmayı öğrenebilirsiniz.</p><p><strong>El-Göz Koordinasyonunu Geliştirme:</strong> Enstrüman çalmak, el ve göz koordinasyonunu geliştirerek zihinsel aktiviteyi artırır.</p><p><strong>Sosyal Bir Ortamda Öğrenme:</strong> Kursa katılarak müzikle ilgilenen yeni insanlarla tanışabilir, grup çalışmaları yaparak deneyimlerinizi paylaşabilirsiniz.</p><h3>Bağlama Kursu Seçerken Nelere Dikkat Etmelisiniz?</h3><p>Bağlama kursu seçerken şu faktörleri göz önünde bulundurmanız önemlidir:</p><p><strong>Eğitmenin Deneyimi:</strong> Eğitmenin hem müzikal yetkinliği hem de öğretme becerisi önemlidir.</p><p><strong>Kurs İçeriği:</strong> Kursun içeriğinin başlangıç seviyesinden ileri seviyeye kadar kapsamlı olması gerekir.</p><p><strong>Derslerin Yapısı:</strong> Bireysel mi yoksa grup dersi mi olduğu, ders süresi ve sıklığı gibi konulara dikkat edilmelidir.</p><p><strong>Fiziksel ve Online Seçenekler:</strong> Kursların yüz yüze mi yoksa online olarak mı verildiğini değerlendirebilirsiniz.</p><p><strong>Fiyat ve Ulaşılabilirlik:</strong> Kursun bütçenize uygun olup olmadığı ve konumunun sizin için ulaşılabilir olup olmadığı da önemli bir kriterdir.</p><h3>Bağlama Çalmaya Başlamak İçin İpuçları</h3><p>Bağlama öğrenme sürecinizi daha verimli hale getirmek için şu ipuçlarını göz önünde bulundurabilirsiniz:</p><p><strong>Düzenli Çalışın:</strong> Her gün belirli bir süre pratik yaparak el alışkanlığınızı geliştirin.</p><p><strong>Metronom Kullanın:</strong> Ritim duygunuzu geliştirmek için metronomla çalışmayı deneyin.</p><p><strong>Kolay Parçalarla Başlayın:</strong> İlk etapta basit türkülerle başlayıp, zamanla repertuvarınızı genişletebilirsiniz.</p><p><strong>Motivasyonunuzu Yüksek Tutun:</strong> Süreç içerisinde zorlanabilirsiniz, ancak sabırlı olmak ve müziğin keyfini çıkarmak önemlidir.</p><p><strong>Birlikte Çalın:</strong> Müzik gruplarına katılarak veya başka enstrüman çalan arkadaşlarınızla çalışarak öğrenme sürecinizi daha eğlenceli hale getirebilirsiniz.</p><p>Bağlama kursu, müzikle iç içe olmak isteyen herkes için harika bir fırsattır. Siz de geleneksel Türk müziğini daha yakından tanımak ve bu eşsiz enstrümanı çalmayı öğrenmek istiyorsanız, hemen bir bağlama kursuna katılabilirsiniz!</p><p>Müziğin büyülü dünyasında keyifli bir yolculuğa çıkmaya hazır mısınız?</p>', 'Bağlama, Türk halk müziğinin en önemli enstrümanlarından biridir. Hem amatör hem de profesyonel müzisyenler için büyük bir anlam taşıyan bu enstrüman, Anadolu’nun kültürel mirasını taşıyan bir köprüdür. Eğer siz de bağlama çalmayı öğrenmek ve bu eşsiz müzik geleneğini keşfetmek istiyorsanız, bir bağlama kursuna katılmak harika bir başlangıç olabilir.', 'uploads/blog/67cd9da5b1fa1.jpg', 'published', 'public', 2, '2025-03-09 16:54:45', '2025-03-11 17:31:20', '2025-03-09 16:54:45', 4, 2, 1, 11),
(3, 'Müzik Eğitiminin Çocukların Zihinsel Gelişimine Katkıları', 'm-zik-e-itiminin-ocuklar-n-zihinsel-geli-imine-katk-lar', '<p><strong>Müzik Eğitiminin Çocukların Zihinsel Gelişimine Katkıları</strong></p><p>Müzik eğitimi, çocukların akademik başarısından duygusal zekâsına kadar pek çok alanda olumlu etkiler yaratmaktadır. Yapılan araştırmalar, erken yaşta müzikle tanışan çocukların zihinsel becerilerinde belirgin gelişmeler olduğunu ortaya koymaktadır. İşte müzik eğitiminin çocukların zihinsel gelişimine katkıları:</p><p><strong>1. Hafıza ve Konsantrasyonu Güçlendirir</strong><br>Müzik eğitimi, çocukların hafızalarını güçlendirerek öğrenme süreçlerini hızlandırır. Nota okuma, şarkı sözlerini ezberleme ve ritim çalışmaları, zihinsel esneklik ve konsantrasyonu artırır. Bu süreç, özellikle okul başarısında büyük bir avantaj sağlar.</p><p><strong>2. Dil ve İletişim Becerilerini Geliştirir</strong><br>Müzik eğitimi alan çocukların dil becerileri daha hızlı gelişir. Şarkı söylemek ve enstrüman çalmak, çocukların kelime dağarcığını genişletmesine ve fonetik farkındalık kazanmasına yardımcı olur. Ayrıca, iki dili aynı anda öğrenme sürecini kolaylaştırabilir.</p><p><strong>3. Problem Çözme ve Matematiksel Düşünme Yetisini Güçlendirir</strong><br>Müzik ve matematik arasında güçlü bir bağ bulunmaktadır. Ritim çalışmaları, sayısal düşünme becerilerini geliştirirken, nota değerleri ve ölçü çalışmaları çocukların matematiksel kavramları anlamalarına yardımcı olur. Müzik eğitimi, analitik düşünme yeteneğini artırarak problem çözme becerilerini destekler.</p><p><strong>4. Yaratıcılığı ve Hayal Gücünü Destekler</strong><br>Müzik, çocukların yaratıcı düşünmesini teşvik eder. Beste yapmak, doğaçlama çalmak veya farklı enstrümanları keşfetmek, çocukların hayal güçlerini geliştirir ve kendilerini daha iyi ifade etmelerini sağlar. Yaratıcılığı teşvik eden bu süreç, çocukların sanatsal yeteneklerini de ortaya çıkarmalarına yardımcı olur.</p><p><strong>5. Sosyal ve Duygusal Gelişimi Destekler</strong><br>Müzik eğitimi, grup çalışmasını teşvik eder ve çocukların sosyal becerilerini geliştirmesine yardımcı olur. Orkestra veya koro gibi müzik topluluklarında yer almak, ekip çalışması ve empati becerilerini artırır. Aynı zamanda, müzik yapmak duygusal ifadeyi kolaylaştırarak çocukların kendilerini daha iyi ifade etmelerini sağlar.</p><p><strong>6. Özgüveni Artırır</strong><br>Bir enstrümanı çalmayı öğrenmek veya sahneye çıkıp şarkı söylemek, çocukların özgüven kazanmalarına yardımcı olur. Başarı hissi, çocukların kendilerine olan inançlarını artırırken, zorluklarla başa çıkma becerilerini de güçlendirir.</p><p><strong>Sonuç</strong><br>Müzik eğitimi, çocukların zihinsel, duygusal ve sosyal gelişimine büyük katkılar sağlar. Hafıza, konsantrasyon, dil becerileri, matematiksel düşünme yetisi, yaratıcılık ve özgüven gibi alanlarda olumlu etkiler yaratan müzik, çocukların gelecekte daha başarılı ve mutlu bireyler olmalarına yardımcı olur. Bu nedenle, çocukların erken yaşta müzikle tanışması büyük önem taşımaktadır.</p>', 'Müzik eğitimi, çocukların zihinsel, duygusal ve sosyal gelişimine büyük katkılar sağlar. Hafıza, konsantrasyon, dil becerileri, matematiksel düşünme yetisi, yaratıcılık ve özgüven gibi alanlarda olumlu etkiler yaratan müzik, çocukların gelecekte daha başarılı ve mutlu bireyler olmalarına yardımcı olur. Bu nedenle, çocukların erken yaşta müzikle tanışması büyük önem taşımaktadır.', 'uploads/blog/67d0f7a012000.jpg', 'published', 'public', 2, '2025-03-12 05:55:28', '2025-03-12 05:55:53', '2025-03-12 05:55:28', 3, 2, 0, 1);

--
-- Tetikleyiciler `blog_posts`
--
DELIMITER $$
CREATE TRIGGER `sync_blog_user_ids` BEFORE INSERT ON `blog_posts` FOR EACH ROW BEGIN
    IF NEW.user_id IS NOT NULL AND NEW.author_id IS NULL THEN
        SET NEW.author_id = NEW.user_id;
    ELSEIF NEW.author_id IS NOT NULL AND NEW.user_id IS NULL THEN
        SET NEW.user_id = NEW.author_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `blog_post_categories`
--

CREATE TABLE `blog_post_categories` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `blog_post_tags`
--

CREATE TABLE `blog_post_tags` (
  `post_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `blog_post_tags`
--

INSERT INTO `blog_post_tags` (`post_id`, `tag_id`) VALUES
(2, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `blog_tags`
--

CREATE TABLE `blog_tags` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `blog_tags`
--

INSERT INTO `blog_tags` (`id`, `name`, `slug`, `created_at`) VALUES
(1, 'bağlama kursu', 'baglama-kursu', '2025-03-09 16:47:47'),
(2, 'saz kursu', 'saz-kursu', '2025-03-09 16:47:51');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('new','read','replied','archived') NOT NULL DEFAULT 'new',
  `read_by` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `duration` int(11) DEFAULT NULL COMMENT 'Dakika cinsinden',
  `level` enum('beginner','intermediate','advanced','all') NOT NULL DEFAULT 'all',
  `max_students` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('active','inactive','upcoming') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `courses`
--

INSERT INTO `courses` (`id`, `category_id`, `name`, `slug`, `description`, `image`, `price`, `duration`, `level`, `max_students`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Bağlama', 'ba-lama', 'Başlangıç Seviye Dersleri', '67cce1a4dce94_course.jpg', '12000.00', 259200, 'all', NULL, '2025-01-01', '2026-01-01', 'active', '2025-03-09 03:32:36', '2025-03-09 03:46:31');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `course_categories`
--

CREATE TABLE `course_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text,
  `icon` varchar(50) DEFAULT NULL,
  `order_num` int(11) DEFAULT '0',
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `course_categories`
--

INSERT INTO `course_categories` (`id`, `name`, `slug`, `description`, `icon`, `order_num`, `parent_id`) VALUES
(1, 'Piyano', 'piyano', 'Piyano dersleri', 'piano', 0, NULL),
(2, 'Gitar', 'gitar', 'Gitar dersleri', 'guitar', 0, NULL),
(3, 'Keman', 'keman', 'Keman dersleri', 'violin', 0, NULL),
(4, 'Şan', 'san', 'Şan dersleri', 'microphone', 0, NULL),
(5, 'Bateri', 'bateri', 'Bateri dersleri', 'drum', 0, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `course_instructors`
--

CREATE TABLE `course_instructors` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `course_instructors`
--

INSERT INTO `course_instructors` (`id`, `course_id`, `instructor_id`, `is_main`) VALUES
(4, 1, 1, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `course_sessions`
--

CREATE TABLE `course_sessions` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `capacity` int(11) DEFAULT NULL,
  `room` varchar(50) DEFAULT NULL,
  `notes` text,
  `status` enum('scheduled','ongoing','completed','cancelled') NOT NULL DEFAULT 'scheduled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `enrollments`
--

CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `enrollment_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('active','completed','cancelled','pending') NOT NULL DEFAULT 'pending',
  `payment_status` enum('paid','partial','pending','free') NOT NULL DEFAULT 'pending',
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `paid_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `enrollments`
--

INSERT INTO `enrollments` (`id`, `student_id`, `course_id`, `enrollment_date`, `status`, `payment_status`, `total_amount`, `paid_amount`, `discount`, `notes`) VALUES
(1, 10, 1, '2025-03-09 00:00:00', 'active', 'paid', '12000.00', '12000.00', '0.00', ''),
(2, 11, 1, '2025-03-09 00:00:00', 'active', 'partial', '12000.00', '2000.00', '0.00', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text,
  `location` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `max_participants` int(11) DEFAULT NULL,
  `status` enum('scheduled','ongoing','completed','cancelled') NOT NULL DEFAULT 'scheduled',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `events`
--

INSERT INTO `events` (`id`, `title`, `slug`, `description`, `location`, `image`, `start_date`, `end_date`, `is_public`, `max_participants`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(3, 'Ramazan Bayramı Konseri', 'ramazan-bayram-konseri', 'Lorem ipsum, Lorem ipsum, Lorem ipsum, Lorem ipsum, Lorem ipsum, Lorem ipsum, Lorem ipsum, Lorem ipsum, Lorem ipsum, Lorem ipsum,', 'İstanbul', 'uploads/events/1741493489_unnamed.jpg', '2025-03-09 09:00:00', '2025-03-11 17:00:00', 1, 500, 'scheduled', 2, '2025-03-09 07:03:58', '2025-03-09 07:11:29');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `event_participants`
--

CREATE TABLE `event_participants` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `registered_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('registered','attended','cancelled','waiting') NOT NULL DEFAULT 'registered',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `galleries`
--

CREATE TABLE `galleries` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text,
  `cover_image` varchar(255) DEFAULT NULL,
  `type` enum('photo','video','mixed') NOT NULL DEFAULT 'photo',
  `status` enum('published','draft') NOT NULL DEFAULT 'published',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `galleries`
--

INSERT INTO `galleries` (`id`, `title`, `slug`, `description`, `cover_image`, `type`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 'Dersten Görüntüler', 'dersten-g-r-nt-ler', '', 'uploads/gallery/142e1fbbffe51b9c7788d28124291d0c.jpg', 'photo', 'published', 2, '2025-03-09 18:12:18', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `gallery_items`
--

CREATE TABLE `gallery_items` (
  `id` int(11) NOT NULL,
  `gallery_id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text,
  `file_path` varchar(255) NOT NULL,
  `file_type` enum('image','video') NOT NULL DEFAULT 'image',
  `thumbnail` varchar(255) DEFAULT NULL,
  `order_num` int(11) DEFAULT '0',
  `visibility` enum('visible','hidden') NOT NULL DEFAULT 'visible',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `gallery_items`
--

INSERT INTO `gallery_items` (`id`, `gallery_id`, `title`, `description`, `file_path`, `file_type`, `thumbnail`, `order_num`, `visibility`, `created_at`, `updated_at`) VALUES
(2, 2, 'Ders', '', 'uploads/gallery/3289aeeaa45aa59da4ae2fba317b659c.jpg', 'image', 'uploads/gallery/thumbs/3289aeeaa45aa59da4ae2fba317b659c.jpg', 0, 'visible', '2025-03-09 18:13:27', NULL),
(3, 2, 'Deneme2', '', 'uploads/gallery/dab2c711148206ed2216edd4eca7f71e.jpg', 'image', 'uploads/gallery/thumbs/dab2c711148206ed2216edd4eca7f71e.jpg', 0, 'visible', '2025-03-09 18:46:01', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `home_content`
--

CREATE TABLE `home_content` (
  `id` int(11) NOT NULL,
  `section_name` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text,
  `content` text,
  `button_text` varchar(100) DEFAULT NULL,
  `button_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `home_content`
--

INSERT INTO `home_content` (`id`, `section_name`, `title`, `subtitle`, `content`, `button_text`, `button_link`, `image`, `status`, `created_at`) VALUES
(1, 'hero_section', 'Müziğin Büyülü Dünyasına Hoş Geldiniz', 'Kaliteli müzik eğitimi için doğru adrestesiniz', 'Profesyonel eğitmenlerimiz ve modern eğitim yöntemlerimizle müzik yolculuğunuzda size rehberlik ediyoruz.', 'Hemen Başlayın', 'kayit-ol.php', NULL, 'active', '2025-03-11 14:57:36'),
(2, 'about_section', 'Nida Müzik Okulu', 'Müzik Eğitiminde 15 Yıllık Tecrübe', 'Müzik, ruhun en derin duygularını ifade etmenin en güçlü yollarından biridir. Nida Müzik Merkezi olarak, sanatı herkes için ulaşılabilir kılmak ve müzik tutkusunu yaymak amacıyla yola çıktık.\r\n\r\nUzman eğitmen kadromuz ve geniş müfredatımız ile her yaştan ve her seviyeden müziksevere hitap ediyoruz. İster yeni başlayan olun ister deneyimli bir müzisyen, sizlere en iyi eğitimi sunarak müzikal yolculuğunuzda rehberlik ediyoruz.\r\n\r\nMerkezimizde piyano, gitar, keman, bağlama, bateri, yan flüt ve daha birçok enstrüman eğitimi verilmektedir. Ayrıca, ses eğitimi ve solfej derslerimizle müzikal gelişiminize katkıda bulunuyoruz. Bireysel derslerimizin yanı sıra, grup çalışmaları ve atölyelerle sosyal bir öğrenme ortamı sunuyoruz.\r\n\r\nMüzik sevgisini paylaşmak ve herkesin kendi melodisini keşfetmesine yardımcı olmak için buradayız. Nida Müzik Merkezi olarak, sizleri de bu büyülü dünyanın bir parçası olmaya davet ediyoruz!', '', '', 'homepage_67d0e0c7d4fb3.jpg', 'active', '2025-03-11 14:57:36'),
(3, 'features_section', 'Neden Bizi Seçmelisiniz?', 'Size en iyi müzik eğitimini sunmak için buradayız', NULL, 'Detaylı Bilgi', 'hakkimizda.php', NULL, 'active', '2025-03-11 14:57:36'),
(4, 'cta_section', 'Hayalinizdeki Enstrümanı Çalmayı Öğrenin', 'Nida Müzik Okulu\'nun profesyonel eğitmenleri ile müzik yolculuğunuza başlayın.', NULL, 'Hemen Kaydolun', 'kayit-ol.php', NULL, 'active', '2025-03-11 14:57:36'),
(5, 'slider_piano', 'Piyano Eğitimi', 'Klasik müziğin büyülü dünyası', '...', 'Detaylı Bilgi', 'kurslar.php?cat=piyano', 'piano.jpg', 'active', '2025-03-12 00:43:25'),
(6, 'slider_guitar', 'Gitar Dersleri', 'Modern müziğin ritmi', '...', 'Detaylı Bilgi', 'kurslar.php?cat=gitar', 'guitar.jpg', 'active', '2025-03-12 00:43:25'),
(7, 'slider_violin', 'Keman Eğitimi', 'Klasik eğitim', '...', 'Detaylı Bilgi', 'kurslar.php?cat=keman', 'violin.jpg', 'active', '2025-03-12 00:43:25');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `instructors`
--

CREATE TABLE `instructors` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `speciality` varchar(100) DEFAULT NULL,
  `bio` text,
  `specialty` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `social_media` text COMMENT 'JSON formatında sosyal medya linkleri',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `instructors`
--

INSERT INTO `instructors` (`id`, `user_id`, `speciality`, `bio`, `specialty`, `email`, `photo`, `website`, `social_media`, `status`) VALUES
(1, 7, NULL, 'Nida Kuriş, bağlama eğitimi veren bir müzik öğretmeni ve müzisyendir. Türk halk müziği ve bağlama konusunda derin bir bilgiye sahip olan Kuriş, müzikseverlere enstrümanın inceliklerini ve geleneksel müzik kültürünü aktarmaktadır. Kendisinin bağlama üzerindeki ustalığı, hem sahne performanslarında hem de öğretmenlik kariyerinde kendini göstermektedir. Öğrencilerine sadece teknik beceriler kazandırmakla kalmaz, aynı zamanda Türk müziğinin ruhunu da onlara öğretir. Müzik öğretmeni olarak, bağlama ile ilgili çeşitli konserler düzenler ve atölye çalışmaları yaparak bu sanatı yaymaya çalışır.', 'Bağlama, Gitar ve Ud', 'nidakuris@gmail.com', '', '', '', 'active'),
(2, 8, 'Web Tasarım', 'Web Tasarım Developer', 'Web Tasarım', 'admin11@nidamuzik.com', NULL, 'https://vworm.com', 'https://instagram.com/umdbkr\r\nhttps://facebook.com/umdbkr', 'active');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `instruments`
--

CREATE TABLE `instruments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `status` enum('available','maintenance','loaned') NOT NULL DEFAULT 'available',
  `acquisition_date` date DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `instrument_loans`
--

CREATE TABLE `instrument_loans` (
  `id` int(11) NOT NULL,
  `instrument_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `loan_date` datetime NOT NULL,
  `expected_return_date` datetime NOT NULL,
  `actual_return_date` datetime DEFAULT NULL,
  `status` enum('active','returned','overdue') NOT NULL DEFAULT 'active',
  `notes` text,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('new','read','replied','spam','archived') NOT NULL DEFAULT 'new',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `messages`
--

INSERT INTO `messages` (`id`, `name`, `email`, `phone`, `subject`, `message`, `ip_address`, `is_read`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Ahmet Yılmaz', 'ahmet@example.com', '5551234567', 'Keman Dersleri Hakkında', 'Merhaba, keman dersleri hakkında detaylı bilgi almak istiyorum. Fiyatlar ve ders saatleri nelerdir?', '127.0.0.1', 0, 'new', '2025-03-08 17:17:32', NULL),
(2, 'Ayşe Demir', 'ayse@example.com', '5559876543', 'Piyano Kursu Kaydı', 'İlkokul 3. sınıfa giden kızım için piyano kursu düşünüyoruz. Hangi gün ve saatlerde dersler mevcut? Teşekkürler.', '127.0.0.1', 0, 'new', '2025-03-09 05:17:32', NULL),
(3, 'Mehmet Kaya', 'mehmet@example.com', '5553334444', 'Yetişkin Gitar Eğitimi', 'Yetişkinler için başlangıç seviyesi gitar dersleri için bilgi almak istiyorum. Daha önce hiç çalmadım.', '127.0.0.1', 1, 'read', '2025-03-09 14:17:32', '2025-03-09 17:21:51');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `excerpt` text,
  `status` enum('published','draft') NOT NULL DEFAULT 'draft',
  `page_order` int(11) DEFAULT '0',
  `show_in_menu` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` int(11) DEFAULT NULL,
  `template` varchar(50) DEFAULT 'default',
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text,
  `featured_image` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `page_components` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `pages`
--

INSERT INTO `pages` (`id`, `title`, `slug`, `content`, `excerpt`, `status`, `page_order`, `show_in_menu`, `parent_id`, `template`, `meta_title`, `meta_description`, `featured_image`, `created_at`, `updated_at`, `page_components`) VALUES
(1, 'Hakkımızda', 'hakkimizda', '<h2>Hakkımızda</h2><p>Nida Müzik Okulu olarak 2005 yılından bu yana müzik eğitimi vermekteyiz. Profesyonel kadromuz ve modern eğitim yöntemlerimizle öğrencilerimize en iyi müzik eğitimini sunmayı amaçlıyoruz.</p>', 'Nida Müzik Okulu hakkında bilgi.', 'published', 1, 1, NULL, 'default', NULL, NULL, NULL, '2025-03-09 17:08:13', NULL, NULL),
(2, 'Sıkça Sorulan Sorular', 'sikca-sorulan-sorular', '<h2>Sıkça Sorulan Sorular</h2><div class=\"faq-item\"><h4>Hangi yaşta müzik eğitimine başlanabilir?</h4><p>Müzik eğitimine her yaşta başlanabilir. Ancak genellikle çocuklar için 6-7 yaş idealdir.</p></div><div class=\"faq-item\"><h4>Enstrüman seçiminde nelere dikkat etmeliyim?</h4><p>Enstrüman seçerken çocuğunuzun fiziksel özellikleri, ilgi alanları ve müzikal yatkınlıklarını göz önünde bulundurmanız faydalı olacaktır.</p></div>', 'Müzik eğitimi hakkında sıkça sorulan sorular ve cevapları.', 'published', 2, 1, NULL, 'faq', NULL, NULL, NULL, '2025-03-09 17:08:13', NULL, NULL),
(3, 'Gizlilik Politikası', 'gizlilik-politikasi', '<h2>Gizlilik Politikası</h2><p>Bu gizlilik politikası, Nida Müzik Okulu\'nun kişisel verilerinizi nasıl topladığını, kullandığını ve koruduğunu açıklar.</p>', 'Nida Müzik Okulu gizlilik politikası.', 'published', 3, 0, NULL, 'default', NULL, NULL, NULL, '2025-03-09 17:08:13', NULL, NULL),
(4, 'SSS', 'sss', '<p>Deneme İçerik</p>', '', 'published', 0, 0, NULL, 'faq', '', '', '', '2025-03-09 18:48:14', NULL, NULL),
(5, 'Eğitmenlerimiz', 'egitmenlerimiz', '', NULL, 'published', 0, 0, NULL, 'instructors', NULL, NULL, NULL, '2025-03-10 15:13:39', NULL, NULL),
(6, 'Deneme Sayfa', 'd', '<p>Deneme İçerik</p>', '', 'draft', 0, 0, NULL, 'instructors', '', '', '', '2025-03-11 04:55:59', '2025-03-13 01:24:18', '[{\"id\":\"temp_c8l5mvb4r\",\"component_type\":\"instructor\",\"title\":\"Umut BAKIR\",\"subtitle\":\"Bağlama Eğitmeni\",\"content\":\"hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum\",\"image\":\"uploads/instructors/temp_1741657976811.jpg\",\"attributes\":\"{\\\"speciality\\\":\\\"Kısa ve Uzun Sap Bağlama\\\",\\\"social_facebook\\\":\\\"\\\",\\\"social_instagram\\\":\\\"\\\",\\\"social_twitter\\\":\\\"\\\",\\\"social_youtube\\\":\\\"\\\",\\\"background_color\\\":\\\"purple\\\"}\",\"order_num\":0}]');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `page_components`
--

CREATE TABLE `page_components` (
  `id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `component_type` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `content` text,
  `image` varchar(255) DEFAULT NULL,
  `attributes` text,
  `order_num` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `page_components`
--

INSERT INTO `page_components` (`id`, `page_id`, `component_type`, `title`, `subtitle`, `content`, `image`, `attributes`, `order_num`, `created_at`) VALUES
(1, 6, 'instructor', 'Umut BAKIR', 'Bağlama Eğitmeni', 'hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum hakkında yazısı lorem ipsum', 'uploads/instructors/temp_1741657976811.jpg', '{\"speciality\":\"Kısa ve Uzun Sap Bağlama\",\"social_facebook\":\"\",\"social_instagram\":\"\",\"social_twitter\":\"\",\"social_youtube\":\"\",\"background_color\":\"purple\"}', 0, '2025-03-11 01:55:59');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `enrollment_id` int(11) DEFAULT NULL,
  `student_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','completed','cancelled') DEFAULT 'completed',
  `payment_method` enum('cash','credit_card','bank_transfer','other') NOT NULL DEFAULT 'cash',
  `notes` text,
  `receipt_number` varchar(50) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `payments`
--

INSERT INTO `payments` (`id`, `enrollment_id`, `student_id`, `amount`, `payment_date`, `status`, `payment_method`, `notes`, `receipt_number`, `created_by`) VALUES
(1, 1, 10, '12000.00', '2025-03-09 00:00:00', 'completed', 'cash', '', NULL, 2),
(2, 2, 11, '2000.00', '2025-03-09 00:00:00', 'completed', 'bank_transfer', '', NULL, 2);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `capacity` int(11) DEFAULT NULL,
  `floor` varchar(20) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `equipment` text,
  `status` enum('available','maintenance','booked') NOT NULL DEFAULT 'available',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `room_bookings`
--

CREATE TABLE `room_bookings` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `status` enum('confirmed','pending','cancelled') NOT NULL DEFAULT 'pending',
  `notes` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `key` varchar(100) NOT NULL,
  `value` text,
  `type` enum('text','textarea','number','image','checkbox','color','select') NOT NULL DEFAULT 'text',
  `options` text,
  `category` varchar(50) NOT NULL DEFAULT 'general',
  `title` varchar(255) NOT NULL,
  `description` text,
  `display_order` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `type`, `options`, `category`, `title`, `description`, `display_order`, `created_at`, `updated_at`) VALUES
(1, 'site_title', 'Nida Müzik Okulu', 'text', NULL, 'general', 'Site Başlığı', 'Sitenin genel başlığı', 10, '2025-03-09 07:24:16', NULL),
(2, 'site_description', 'Müzik eğitiminde en iyisi', 'textarea', NULL, 'general', 'Site Açıklaması', 'Sitenin kısa açıklaması', 20, '2025-03-09 07:24:16', NULL),
(3, 'site_email', 'info@nidamuzik.com', 'text', NULL, 'general', 'Site E-posta', 'İletişim için kullanılacak e-posta adresi', 30, '2025-03-09 07:24:16', NULL),
(4, 'site_phone', '+90 212 123 4567', 'text', NULL, 'general', 'Site Telefon', 'İletişim için kullanılacak telefon numarası', 40, '2025-03-09 07:24:16', NULL),
(5, 'site_address', 'Karadeniz Caddesi, Güvercintepe, Akkiraz Sk. No:29 Kat.1 D.2, 34494 Başakşehir/İstanbul', 'textarea', NULL, 'general', 'Site Adresi', 'Fiziksel adres bilgileri', 50, '2025-03-09 07:24:16', '2025-03-13 01:53:05'),
(6, 'site_logo', '', 'image', NULL, 'general', 'Site Logosu', 'Site genelinde kullanılacak logo (PNG, JPG)', 60, '2025-03-09 07:24:16', NULL),
(7, 'site_favicon', '', 'image', NULL, 'general', 'Site Favicon', 'Tarayıcı sekmesi için favicon (ICO, PNG)', 70, '2025-03-09 07:24:16', NULL),
(8, 'site_theme_color', '#3498db', 'color', NULL, 'general', 'Site Tema Rengi', 'Ana tema rengi', 80, '2025-03-09 07:24:16', NULL),
(9, 'meta_title', 'Nida Müzik Okulu - Müzik Eğitiminde En İyisi', 'text', NULL, 'meta', 'Meta Başlık', 'SEO için sayfa başlığı', 10, '2025-03-09 07:24:16', NULL),
(10, 'meta_description', 'Nida Müzik Okulu profesyonel müzik eğitimi veren bir kurumdur.', 'textarea', NULL, 'meta', 'Meta Açıklama', 'SEO için sayfa açıklaması', 20, '2025-03-09 07:24:16', NULL),
(11, 'meta_keywords', 'müzik, müzik okulu, müzik kursu, piyano, gitar, keman', 'textarea', NULL, 'meta', 'Meta Anahtar Kelimeler', 'SEO için anahtar kelimeler (virgülle ayrılmış)', 30, '2025-03-09 07:24:16', NULL),
(12, 'meta_author', 'Nida Müzik Okulu', 'text', NULL, 'meta', 'Meta Yazar', 'Sitenin yazar bilgisi', 40, '2025-03-09 07:24:16', NULL),
(13, 'google_analytics_id', '', 'text', NULL, 'analytics', 'Google Analytics ID', 'GA izleme kodu (UA-XXXXX-Y veya G-XXXXXXX)', 10, '2025-03-09 07:24:16', NULL),
(14, 'enable_analytics', '0', 'checkbox', NULL, 'analytics', 'Analytics Etkinleştir', 'Google Analytics izlemeyi etkinleştir', 20, '2025-03-09 07:24:16', NULL),
(15, 'facebook_url', '', 'text', NULL, 'social', 'Facebook URL', 'Facebook sayfa linki', 10, '2025-03-09 07:24:16', NULL),
(16, 'instagram_url', 'https://www.instagram.com/nidamuzikmerkezi/', 'text', NULL, 'social', 'Instagram URL', 'Instagram profil linki', 20, '2025-03-09 07:24:16', '2025-03-13 01:29:11'),
(17, 'twitter_url', '', 'text', NULL, 'social', 'Twitter URL', 'Twitter profil linki', 30, '2025-03-09 07:24:16', NULL),
(18, 'youtube_url', '', 'text', NULL, 'social', 'YouTube URL', 'YouTube kanal linki', 40, '2025-03-09 07:24:16', NULL),
(19, 'enable_social_share', '1', 'checkbox', NULL, 'social', 'Sosyal Paylaşım Butonları', 'Sayfalarda sosyal medya paylaşım butonlarını göster', 50, '2025-03-09 07:24:16', NULL),
(20, 'generate_sitemap', '1', 'checkbox', NULL, 'sitemap', 'Site Haritası Oluştur', 'Otomatik sitemap.xml oluştur', 10, '2025-03-09 07:24:16', NULL),
(21, 'sitemap_frequency', 'weekly', 'select', 'daily,weekly,monthly', 'sitemap', 'Güncelleme Sıklığı', 'Site haritası güncelleme sıklığı', 20, '2025-03-09 07:24:16', NULL),
(22, 'robots_txt_content', 'User-agent: *\nAllow: /', 'textarea', NULL, 'sitemap', 'robots.txt İçeriği', 'robots.txt dosyasının içeriği', 30, '2025-03-09 07:24:16', NULL),
(23, 'footer_about', 'Müzik, ruhun en derin duygularını ifade etmenin en güçlü yollarından biridir. Nida Müzik Merkezi olarak, sanatı herkes için ulaşılabilir kılmak ve müzik tutkusunu yaymak amacıyla yola çıktık. Uzman eğitmen kadromuz ve geniş müfredatımız ile her yaştan ve her seviyeden müziksevere hitap ediyoruz.', 'textarea', NULL, 'general', 'Footer Hakkımızda Yazısı', 'Footer alanında görüntülenecek kısa tanıtım yazısı', 90, '2025-03-13 01:49:50', '2025-03-13 01:50:52'),
(24, 'working_hours_weekday', '09:00 - 20:00', 'text', NULL, 'general', 'Hafta İçi Çalışma Saatleri', 'Pazartesi-Cuma arası çalışma saatleri', 100, '2025-03-13 01:49:50', NULL),
(25, 'working_hours_saturday', '10:00 - 18:00', 'text', NULL, 'general', 'Cumartesi Çalışma Saatleri', 'Cumartesi günü çalışma saatleri', 110, '2025-03-13 01:49:50', NULL),
(26, 'working_hours_sunday', '10:00 - 18:00 </br>  Pazartesi Kapalı', 'text', NULL, 'general', 'Pazar Çalışma Saatleri', 'Pazar günü çalışma saatleri', 120, '2025-03-13 01:49:50', '2025-03-13 01:52:24');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `birth_date` date DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `parent_name` varchar(100) DEFAULT NULL,
  `parent_phone` varchar(20) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `students`
--

INSERT INTO `students` (`id`, `name`, `email`, `phone`, `address`, `birth_date`, `gender`, `photo`, `registration_date`, `parent_name`, `parent_phone`, `status`, `notes`) VALUES
(10, 'Umut BAKIR', 'umut.tbmyo@gmail.com', '(506) 122-8719', 'güvercintepe mah', '1995-08-27', NULL, NULL, '2025-01-01', '', '', 'active', ''),
(11, 'Kaelen BAKIR', 'kaelen@gmail.com', '05061228719', 'Güvercintepe Mah Şentepe Sk No:106 D:1 Başakşehir / İstanbul', '1994-05-01', 'female', 'uploads/67cccd837c681.jpg', '2024-02-01', '', '', 'active', ''),
(12, 'Mehmet Eymen CAN', 'safakcan@gmail.com', '05413792370', '', '2012-05-14', 'male', '', '2025-01-01', 'Şafak CAN', '', 'active', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `type` enum('user','student','instructor','admin') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone`, `address`, `status`, `created_at`, `updated_at`, `type`) VALUES
(1, 'Admin User', 'admin@nidamuzik.com', '$2y$10$dXJ6YjV1VkJhR3hBWisxQui/nZ7mSYYCAq1YexRmdbfEPG8JrJM/2', '5551234567', '', 'active', '2025-03-08 22:53:13', '2025-03-13 01:21:41', 'admin'),
(2, 'umut', 'admin1@nidamuzik.com', '$2y$10$6Uu86MTVVp9D08M2akaA9OVVx44qK9frqc.AteGjHfKnUWJh6GOue', '5551234567', NULL, 'active', '2025-03-08 22:59:44', '2025-03-09 15:41:50', 'admin'),
(7, 'Nida KURİŞ', 'nidakuris@gmail.com', '', '05005550000', NULL, 'active', '2025-03-09 02:56:45', NULL, 'instructor'),
(8, 'Umut BAKIR', 'admin11@nidamuzik.com', '', '05061228719', NULL, 'active', '2025-03-10 18:37:24', NULL, 'instructor');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `user_tokens`
--

CREATE TABLE `user_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `token_type` enum('remember','reset','verification') NOT NULL DEFAULT 'remember',
  `expire_date` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_student` (`session_id`,`student_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Tablo için indeksler `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Tablo için indeksler `blog_comments`
--
ALTER TABLE `blog_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `author_id` (`author_id`),
  ADD KEY `fk_blog_posts_category` (`category_id`),
  ADD KEY `fk_blog_posts_user` (`user_id`);

--
-- Tablo için indeksler `blog_post_categories`
--
ALTER TABLE `blog_post_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `post_category` (`post_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Tablo için indeksler `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  ADD PRIMARY KEY (`post_id`,`tag_id`),
  ADD KEY `fk_blog_post_tags_tag` (`tag_id`);

--
-- Tablo için indeksler `blog_tags`
--
ALTER TABLE `blog_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Tablo için indeksler `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `read_by` (`read_by`);

--
-- Tablo için indeksler `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `category_id` (`category_id`);

--
-- Tablo için indeksler `course_categories`
--
ALTER TABLE `course_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Tablo için indeksler `course_instructors`
--
ALTER TABLE `course_instructors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_instructor` (`course_id`,`instructor_id`),
  ADD KEY `instructor_id` (`instructor_id`);

--
-- Tablo için indeksler `course_sessions`
--
ALTER TABLE `course_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `instructor_id` (`instructor_id`);

--
-- Tablo için indeksler `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Tablo için indeksler `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `created_by` (`created_by`);

--
-- Tablo için indeksler `event_participants`
--
ALTER TABLE `event_participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `event_user` (`event_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `created_by` (`created_by`);

--
-- Tablo için indeksler `gallery_items`
--
ALTER TABLE `gallery_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gallery_id` (`gallery_id`);

--
-- Tablo için indeksler `home_content`
--
ALTER TABLE `home_content`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `section_name` (`section_name`);

--
-- Tablo için indeksler `instructors`
--
ALTER TABLE `instructors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `instruments`
--
ALTER TABLE `instruments`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `instrument_loans`
--
ALTER TABLE `instrument_loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instrument_id` (`instrument_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Tablo için indeksler `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `is_read` (`is_read`);

--
-- Tablo için indeksler `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Tablo için indeksler `page_components`
--
ALTER TABLE `page_components`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_id_idx` (`page_id`);

--
-- Tablo için indeksler `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enrollment_id` (`enrollment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Tablo için indeksler `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `room_bookings`
--
ALTER TABLE `room_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`);

--
-- Tablo için indeksler `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Tablo için indeksler `user_tokens`
--
ALTER TABLE `user_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Tablo için AUTO_INCREMENT değeri `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `blog_comments`
--
ALTER TABLE `blog_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `blog_posts`
--
ALTER TABLE `blog_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `blog_post_categories`
--
ALTER TABLE `blog_post_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `blog_tags`
--
ALTER TABLE `blog_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `course_categories`
--
ALTER TABLE `course_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `course_instructors`
--
ALTER TABLE `course_instructors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `course_sessions`
--
ALTER TABLE `course_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `event_participants`
--
ALTER TABLE `event_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `gallery_items`
--
ALTER TABLE `gallery_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `home_content`
--
ALTER TABLE `home_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Tablo için AUTO_INCREMENT değeri `instructors`
--
ALTER TABLE `instructors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `instruments`
--
ALTER TABLE `instruments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `instrument_loans`
--
ALTER TABLE `instrument_loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `page_components`
--
ALTER TABLE `page_components`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `room_bookings`
--
ALTER TABLE `room_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Tablo için AUTO_INCREMENT değeri `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Tablo için AUTO_INCREMENT değeri `user_tokens`
--
ALTER TABLE `user_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD CONSTRAINT `admin_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `admin_users`
--
ALTER TABLE `admin_users`
  ADD CONSTRAINT `admin_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `course_sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD CONSTRAINT `blog_categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `blog_categories` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `blog_comments`
--
ALTER TABLE `blog_comments`
  ADD CONSTRAINT `blog_comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_comments_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `blog_comments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `blog_comments_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD CONSTRAINT `blog_posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_blog_posts_category` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_blog_posts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `blog_post_categories`
--
ALTER TABLE `blog_post_categories`
  ADD CONSTRAINT `blog_post_categories_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_post_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  ADD CONSTRAINT `fk_blog_post_tags_post` FOREIGN KEY (`post_id`) REFERENCES `blog_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_blog_post_tags_tag` FOREIGN KEY (`tag_id`) REFERENCES `blog_tags` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD CONSTRAINT `contact_messages_ibfk_1` FOREIGN KEY (`read_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `course_categories` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `course_categories`
--
ALTER TABLE `course_categories`
  ADD CONSTRAINT `course_categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `course_categories` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `course_instructors`
--
ALTER TABLE `course_instructors`
  ADD CONSTRAINT `course_instructors_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_instructors_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `course_sessions`
--
ALTER TABLE `course_sessions`
  ADD CONSTRAINT `course_sessions_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_sessions_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `event_participants`
--
ALTER TABLE `event_participants`
  ADD CONSTRAINT `event_participants_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_participants_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `galleries`
--
ALTER TABLE `galleries`
  ADD CONSTRAINT `galleries_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `gallery_items`
--
ALTER TABLE `gallery_items`
  ADD CONSTRAINT `gallery_items_gallery_id_fk` FOREIGN KEY (`gallery_id`) REFERENCES `galleries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `gallery_items_ibfk_1` FOREIGN KEY (`gallery_id`) REFERENCES `galleries` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `instructors`
--
ALTER TABLE `instructors`
  ADD CONSTRAINT `instructors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `instrument_loans`
--
ALTER TABLE `instrument_loans`
  ADD CONSTRAINT `instrument_loans_ibfk_1` FOREIGN KEY (`instrument_id`) REFERENCES `instruments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `instrument_loans_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `instrument_loans_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `pages_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `pages` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `page_components`
--
ALTER TABLE `page_components`
  ADD CONSTRAINT `fk_page_components_page_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `room_bookings`
--
ALTER TABLE `room_bookings`
  ADD CONSTRAINT `room_bookings_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `room_bookings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `user_tokens`
--
ALTER TABLE `user_tokens`
  ADD CONSTRAINT `user_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
