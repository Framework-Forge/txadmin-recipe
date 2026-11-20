-- Forge Project: banco padrao para INSTALACAO NOVA.
-- Gerado em 2026-11-08 a partir dos recursos instalados e do esquema auditado.
-- Selecione antes um banco vazio. Este arquivo nao cria usuarios nem define senhas.
-- Nenhum personagem, conta, saldo, chave ou dado privado do backup foi incluido.
-- CREATE IF NOT EXISTS nao substitui migracoes de um banco existente.
-- Dialeto validado: MySQL 8.4 e MariaDB 10.11/11.8. Outras linhas exigem teste.
-- A instalacao exige permissao para criar tabelas e os dois triggers do MDT.
-- Consulte Docs/database/PADRAO-INSTALACAO-20261108.md para os testes e limites.

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;


-- bank_accounts_new | resources/[standalone]/Renewed-Banking/Renewed-Banking.sql:1
CREATE TABLE IF NOT EXISTS `bank_accounts_new` (
  `id` varchar(50) NOT NULL,
  `amount` int DEFAULT 0,
  `transactions` longtext DEFAULT ('[]'),
  `auth` longtext DEFAULT ('[]'),
  `isFrozen` int DEFAULT 0,
  `creator` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge-crafting | resources/[forge]/[forge-scripts]/forge-crafting/sv_db.lua:110
CREATE TABLE IF NOT EXISTS `forge-crafting` (
  `craft_id` int NOT NULL AUTO_INCREMENT,
  `craft_name` varchar(50) DEFAULT NULL,
  `crafting` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `blipdata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `jobs` longtext DEFAULT NULL,
  `model_slug` varchar(50) DEFAULT 'default',
  PRIMARY KEY (`craft_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge-crafting-bench-models | resources/[forge]/[forge-scripts]/forge-crafting/sv_db.lua:122
CREATE TABLE IF NOT EXISTS `forge-crafting-bench-models` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) NOT NULL UNIQUE,
  `label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `center_offset` longtext NOT NULL,
  `scale` float NOT NULL DEFAULT 1.0,
  `anim_dict` varchar(100) NOT NULL DEFAULT 'anim@amb@board_room@diagram_blueprints@',
  `anim_name` varchar(100) NOT NULL DEFAULT 'idle_01_amy_skater_01',
  `anim_offset` longtext NOT NULL,
  `cam_offset` longtext NOT NULL,
  `weapon_offset` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge-crafting-items | resources/[forge]/[forge-scripts]/forge-crafting/sv_db.lua:139
CREATE TABLE IF NOT EXISTS `forge-crafting-items` (
  `craft_id` int DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `item_label` varchar(50) DEFAULT NULL,
  `recipe` longtext DEFAULT NULL,
  `time` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `model` longtext DEFAULT NULL,
  `anim` longtext DEFAULT NULL,
  `level` int DEFAULT NULL,
  `xp` int DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge-crafting-player-skills | resources/[forge]/[forge-scripts]/forge-crafting/sv_db.lua:154
CREATE TABLE IF NOT EXISTS `forge-crafting-player-skills` (
  `identifier` varchar(64) NOT NULL,
  `skill` varchar(50) NOT NULL DEFAULT 'crafting',
  `xp` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`, `skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge-crafting-recipe-catalog | resources/[forge]/[forge-scripts]/forge-crafting/sv_db.lua:215
CREATE TABLE IF NOT EXISTS `forge-crafting-recipe-catalog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item` varchar(50) NOT NULL UNIQUE,
  `item_label` varchar(100) NOT NULL,
  `recipe` longtext NOT NULL,
  `time` int NOT NULL DEFAULT 5,
  `amount` int NOT NULL DEFAULT 1,
  `model` varchar(100) DEFAULT NULL,
  `anim` varchar(100) DEFAULT NULL,
  `level` int DEFAULT 0,
  `xp` int DEFAULT 10,
  `category` varchar(50) DEFAULT 'Geral',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_dk_document_copies | resources/[forge]/[forge-scripts]/forge-dk/server/store.lua:31
CREATE TABLE IF NOT EXISTS `forge_dk_document_copies` (
  copy_id VARCHAR(64) NOT NULL PRIMARY KEY,
  serial VARCHAR(64) NOT NULL,
  status VARCHAR(16) NOT NULL,
  snapshot LONGTEXT NOT NULL,
  fee BIGINT NOT NULL,
  account VARCHAR(16) NOT NULL,
  created_at BIGINT NOT NULL,
  INDEX document_serial (serial)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_dk_documents | resources/[forge]/[forge-scripts]/forge-dk/server/store.lua:17
CREATE TABLE IF NOT EXISTS `forge_dk_documents` (
  serial VARCHAR(64) NOT NULL PRIMARY KEY,
  owner_identifier VARCHAR(64) NOT NULL,
  type_key VARCHAR(64) NOT NULL,
  subject_key VARCHAR(96) NOT NULL,
  scope_key VARCHAR(255) NOT NULL UNIQUE,
  kind VARCHAR(16) NOT NULL,
  status VARCHAR(16) NOT NULL,
  copies INT UNSIGNED NOT NULL DEFAULT 0,
  snapshot LONGTEXT NOT NULL,
  created_at BIGINT NOT NULL,
  expires_at BIGINT NOT NULL DEFAULT 0,
  INDEX owner_type (owner_identifier, type_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_garage_meter_fines | resources/[forge]/[forge-scripts]/forge-garage/server/parking.lua:329
CREATE TABLE IF NOT EXISTS `forge_garage_meter_fines` (
  id VARCHAR(100) PRIMARY KEY,
  plate VARCHAR(50) NOT NULL,
  garage VARCHAR(120),
  meter_id VARCHAR(80),
  amount INT NOT NULL,
  created_at BIGINT NOT NULL,
  active TINYINT DEFAULT 1,
  delivered TINYINT DEFAULT 0,
  reference VARCHAR(120),
  location VARCHAR(160),
  occurred_time CHAR(5),
  INDEX(plate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_garage_meter_sessions | resources/[forge]/[forge-scripts]/forge-garage/server/parking.lua:327
CREATE TABLE IF NOT EXISTS `forge_garage_meter_sessions` (
  plate VARCHAR(50) PRIMARY KEY,
  payload LONGTEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_garage_parking_debts | resources/[forge]/[forge-scripts]/forge-garage/server/db_update.lua:24
CREATE TABLE IF NOT EXISTS `forge_garage_parking_debts` (
  plate varchar(50) NOT NULL,
  garage varchar(120) DEFAULT NULL,
  meter_id varchar(80) DEFAULT NULL,
  amount int NOT NULL DEFAULT 0,
  active tinyint NOT NULL DEFAULT 1,
  session_parked_at bigint DEFAULT NULL,
  session_charged_at bigint DEFAULT NULL,
  reported_at bigint DEFAULT NULL,
  report_reference varchar(120) DEFAULT NULL,
  updated_at bigint NOT NULL,
  PRIMARY KEY (plate),
  KEY active (active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_garage_parking_sessions | resources/[forge]/[forge-scripts]/forge-garage/server/db_update.lua:14
CREATE TABLE IF NOT EXISTS `forge_garage_parking_sessions` (
  plate varchar(50) NOT NULL,
  garage varchar(120) NOT NULL,
  meter_id varchar(80) DEFAULT NULL,
  parked_at bigint NOT NULL,
  paid_until bigint DEFAULT NULL,
  updated_at bigint NOT NULL,
  PRIMARY KEY (plate),
  KEY garage (garage)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_phone_app_security | resources/[voice]/forge-npwd-banking/server/main.lua:36
CREATE TABLE IF NOT EXISTS `forge_phone_app_security` (
  device_id varchar(36) NOT NULL,
  app_id varchar(64) NOT NULL,
  pin_hash char(64) NOT NULL,
  pin_salt varchar(64) NOT NULL,
  pin_length tinyint unsigned NOT NULL,
  fail_count smallint unsigned NOT NULL DEFAULT 0,
  locked_until timestamp NULL DEFAULT NULL,
  created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (device_id, app_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_phone_profiles | resources/[voice]/forge-npwd/import.sql:14
CREATE TABLE IF NOT EXISTS `forge_phone_profiles` (
  `profile_id` char(36) NOT NULL,
  `settings` longtext NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_police_containment_objects | resources/[standalone]/forge-police/server/police_tools.lua:605
CREATE TABLE IF NOT EXISTS `forge_police_containment_objects` (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  object_type VARCHAR(50) NOT NULL,
  owner VARCHAR(100) NOT NULL,
  bucket INT NOT NULL DEFAULT 0,
  x DOUBLE NOT NULL,
  y DOUBLE NOT NULL,
  z DOUBLE NOT NULL,
  rx DOUBLE NOT NULL DEFAULT 0,
  ry DOUBLE NOT NULL DEFAULT 0,
  rz DOUBLE NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_forge_police_containment_bucket (bucket)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_police_speed_radars | resources/[standalone]/forge-police/server/speed_radars.lua:187
CREATE TABLE IF NOT EXISTS `forge_police_speed_radars` (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  kind VARCHAR(12) NOT NULL,
  label VARCHAR(80) NOT NULL,
  model VARCHAR(80) NOT NULL,
  speed_limit INT NOT NULL,
  law_up_to_20 VARCHAR(50) NOT NULL,
  law_up_to_50 VARCHAR(50) NOT NULL,
  law_over_50 VARCHAR(50) NOT NULL,
  x DOUBLE NOT NULL,
  y DOUBLE NOT NULL,
  z DOUBLE NOT NULL,
  rx DOUBLE NOT NULL DEFAULT 0,
  ry DOUBLE NOT NULL DEFAULT 0,
  rz DOUBLE NOT NULL DEFAULT 0,
  bucket INT NOT NULL DEFAULT 0,
  created_by VARCHAR(100),
  created_at BIGINT NOT NULL,
  INDEX(kind)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_police_vehicle_citations | resources/[standalone]/forge-police/server/vehicle_citations.lua:118
CREATE TABLE IF NOT EXISTS `forge_police_vehicle_citations` (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  external_id VARCHAR(100) NOT NULL UNIQUE,
  plate VARCHAR(50) NOT NULL,
  kind VARCHAR(20) NOT NULL,
  description VARCHAR(255) NOT NULL,
  location VARCHAR(120),
  amount INT NOT NULL,
  issued_at BIGINT NOT NULL,
  status VARCHAR(20) NOT NULL,
  edited_by VARCHAR(60),
  edited_at BIGINT,
  INDEX(plate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_police_vehicle_clamps | resources/[standalone]/forge-police/server/police_tools.lua:657
CREATE TABLE IF NOT EXISTS `forge_police_vehicle_clamps` (
  vehicle_id INT UNSIGNED NOT NULL PRIMARY KEY,
  bone VARCHAR(32) NOT NULL,
  officer VARCHAR(100),
  applied_at BIGINT NOT NULL,
  INDEX(applied_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- fuel_stations | resources/[vehicle_system]/cdn-fuel/assets/sql/cdn-fuel.sql:2
CREATE TABLE IF NOT EXISTS `fuel_stations` (
  `location` int NOT NULL,
  `owned` int DEFAULT 0,
  `owner` varchar(50) DEFAULT '0',
  `fuel` int DEFAULT 100000,
  `fuelprice` int DEFAULT 3,
  `balance` int DEFAULT 0,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- housing_enterprises | resources/[housing]/ps-housing/server/enterprises.lua:53
CREATE TABLE IF NOT EXISTS `housing_enterprises` (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  kind VARCHAR(20) NOT NULL,
  name VARCHAR(100) NOT NULL,
  access_data LONGTEXT NOT NULL,
  revision INT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- housing_hotel_stays | resources/[housing]/ps-housing/server/hotel.lua:223
CREATE TABLE IF NOT EXISTS `housing_hotel_stays` (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  property_id INT NOT NULL,
  active_slot INT NULL,
  citizenid VARCHAR(64) NOT NULL,
  request_id VARCHAR(100) NOT NULL,
  status VARCHAR(24) NOT NULL,
  duration_seconds INT NOT NULL,
  total BIGINT NOT NULL,
  payment_account VARCHAR(8) NOT NULL,
  payout_id VARCHAR(32) NULL,
  reception LONGTEXT NOT NULL,
  created_at BIGINT NOT NULL,
  start_at BIGINT NULL,
  expires_at BIGINT NULL,
  UNIQUE KEY hotel_active_room(active_slot),
  UNIQUE KEY hotel_request(request_id),
  KEY hotel_expiry(status,expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- management_outfits | resources/[clothing]/illenium-appearance/sql/management_outfits.sql:1
CREATE TABLE IF NOT EXISTS `management_outfits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `minrank` int NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT 'Cool Outfit',
  `gender` varchar(50) NOT NULL DEFAULT 'male',
  `model` varchar(50) DEFAULT NULL,
  `props` text DEFAULT NULL,
  `components` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_audit_logs | resources/[standalone]/forge-police/sql/qbx.sql:4162
CREATE TABLE IF NOT EXISTS `mdt_audit_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `actor_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actor_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `entity_type` (`entity_type`),
  KEY `entity_id` (`entity_id`),
  KEY `actor_citizenid` (`actor_citizenid`),
  KEY `action` (`action`),
  KEY `created_at` (`created_at`),
  KEY `idx_entity_lookup` (`entity_type`, `entity_id`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_awards | resources/[standalone]/forge-police/sql/qbx.sql:4507
CREATE TABLE IF NOT EXISTS `mdt_awards` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon` varchar(50) NOT NULL DEFAULT 'emoji_events',
  `category` varchar(50) NOT NULL DEFAULT 'general',
  `goal_type` varchar(50) NOT NULL,
  `goal_amount` int unsigned NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_bulletin_categories | resources/[standalone]/forge-police/sql/qbx.sql:5116
CREATE TABLE IF NOT EXISTS `mdt_bulletin_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `job` varchar(50) NOT NULL,
  `value` varchar(48) NOT NULL,
  `label` varchar(48) NOT NULL,
  `icon` varchar(48) NOT NULL DEFAULT 'label',
  `color` varchar(7) NOT NULL DEFAULT '#6B7280',
  `sort_order` int NOT NULL DEFAULT 0,
  `is_default` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_mdt_bulletin_categories_job_value` (`job`,`value`),
  KEY `idx_mdt_bulletin_categories_job` (`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_bulletin_posts | resources/[standalone]/forge-police/sql/qbx.sql:5130
CREATE TABLE IF NOT EXISTS `mdt_bulletin_posts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `author` varchar(100) DEFAULT NULL,
  `author_rank` varchar(50) DEFAULT NULL,
  `category` varchar(48) NOT NULL DEFAULT 'general',
  `priority` enum('urgent','high','normal','low') NOT NULL DEFAULT 'normal',
  `pinned` tinyint NOT NULL DEFAULT 0,
  `job` varchar(50) NOT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_mdt_bulletin_posts_job` (`job`,`pinned`),
  KEY `idx_mdt_bulletin_posts_job_category` (`job`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_bulletins | resources/[standalone]/forge-police/sql/qbx.sql:11
CREATE TABLE IF NOT EXISTS `mdt_bulletins` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_cameras | resources/[standalone]/forge-police/sql/qbx.sql:4220
CREATE TABLE IF NOT EXISTS `mdt_cameras` (
  `cam_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cam_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cam_type` enum('placed','store','bank','jewelry','government','medical','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'placed',
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'security_cam_03',
  `coords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rotation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `feed_coords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Decoupled camera feed position (what the operator sees). NULL = use prop coords',
  `feed_rotation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Decoupled camera feed rotation. NULL = use prop rotation + heading offset',
  `feed_fov` float DEFAULT NULL COMMENT 'Decoupled camera feed FOV. NULL = default FOV',
  `rotation_limits` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Limites de giro vertical e horizontal da câmera',
  `image` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `can_rotate` BOOLEAN NOT NULL DEFAULT TRUE,
  `is_online` BOOLEAN NOT NULL DEFAULT TRUE,
  `spawns_model` BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'TRUE = spawns 3D model (player-placed), FALSE = virtual camera (uses existing world model)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`cam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_cases | resources/[standalone]/forge-police/sql/qbx.sql:4043
CREATE TABLE IF NOT EXISTS `mdt_cases` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `case_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('open','in_progress','closed') NOT NULL DEFAULT 'open',
  `priority` enum('low','medium','high') NOT NULL DEFAULT 'medium',
  `assigned_department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `case_number` (`case_number`),
  KEY `status` (`status`),
  KEY `assigned_department` (`assigned_department`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_charge_categories | resources/[standalone]/forge-police/server/backend/charges.lua:23
CREATE TABLE IF NOT EXISTS `mdt_charge_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `sort_order` int unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_charge_tags | resources/[standalone]/forge-police/server/backend/charges.lua:42
CREATE TABLE IF NOT EXISTS `mdt_charge_tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `color` varchar(7) NOT NULL DEFAULT '#f97316',
  `sort_order` int unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_court_cases | resources/[standalone]/forge-police/sql/qbx.sql:4904
CREATE TABLE IF NOT EXISTS `mdt_court_cases` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `case_number` varchar(30) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `summary` text DEFAULT NULL,
  `status` enum('pending','scheduled','in_trial','closed','dismissed','appealed') NOT NULL DEFAULT 'pending',
  `case_type` enum('criminal','civil','appeal','motion') NOT NULL DEFAULT 'criminal',
  `presiding_judge` varchar(50) DEFAULT NULL,
  `presiding_judge_name` varchar(100) DEFAULT NULL,
  `prosecutor` varchar(50) DEFAULT NULL,
  `prosecutor_name` varchar(100) DEFAULT NULL,
  `defense_attorney` varchar(50) DEFAULT NULL,
  `defense_attorney_name` varchar(100) DEFAULT NULL,
  `defendant_citizenid` varchar(50) DEFAULT NULL,
  `defendant_name` varchar(100) DEFAULT NULL,
  `hearing_date` datetime DEFAULT NULL,
  `filed_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `closed_date` datetime DEFAULT NULL,
  `linked_mdt_case_id` int unsigned DEFAULT NULL,
  `referred_from_report_id` int unsigned DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_by_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_defendant` (`defendant_citizenid`),
  KEY `idx_hearing_date` (`hearing_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_court_orders | resources/[standalone]/forge-police/sql/qbx.sql:4936
CREATE TABLE IF NOT EXISTS `mdt_court_orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_number` varchar(30) NOT NULL DEFAULT '',
  `court_case_id` int unsigned DEFAULT NULL,
  `type` enum('restraining_order','subpoena','bail_conditions','search_warrant','arrest_warrant','other') NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `target_citizenid` varchar(50) DEFAULT NULL,
  `target_name` varchar(100) DEFAULT NULL,
  `status` enum('active','expired','revoked') NOT NULL DEFAULT 'active',
  `issued_by` varchar(50) NOT NULL,
  `issued_by_name` varchar(100) DEFAULT NULL,
  `effective_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `expiry_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_court_case` (`court_case_id`),
  KEY `idx_target` (`target_citizenid`),
  KEY `idx_status` (`status`),
  KEY `idx_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_custom_licenses | resources/[standalone]/forge-police/sql/qbx.sql:4530
CREATE TABLE IF NOT EXISTS `mdt_custom_licenses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_license_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_fto_competencies | resources/[standalone]/forge-police/sql/qbx.sql:4647
CREATE TABLE IF NOT EXISTS `mdt_fto_competencies` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `job` varchar(50) NOT NULL DEFAULT 'police',
  `name` varchar(200) NOT NULL,
  `category` varchar(100) DEFAULT 'General',
  `sort_order` int unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `job` (`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_fto_phases | resources/[standalone]/forge-police/sql/qbx.sql:4636
CREATE TABLE IF NOT EXISTS `mdt_fto_phases` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `job` varchar(50) NOT NULL DEFAULT 'police',
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `duration_days` int unsigned DEFAULT 0,
  `sort_order` int unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `job` (`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_ia_complaints | resources/[standalone]/forge-police/sql/qbx.sql:4560
CREATE TABLE IF NOT EXISTS `mdt_ia_complaints` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `complaint_number` varchar(20) NOT NULL,
  `complainant_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `complainant_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `complainant_phone` varchar(20) DEFAULT NULL,
  `officer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `officer_badge` varchar(20) DEFAULT NULL,
  `category` enum('misconduct','excessive_force','corruption','negligence','discrimination','other') NOT NULL DEFAULT 'other',
  `description` text NOT NULL,
  `incident_date` varchar(20) DEFAULT NULL,
  `incident_location` varchar(200) DEFAULT NULL,
  `witnesses` text DEFAULT NULL,
  `evidence` text DEFAULT NULL,
  `status` enum('open','under_review','investigated','sustained','exonerated','unfounded','closed') NOT NULL DEFAULT 'open',
  `assigned_to` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_to_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `complaint_number` (`complaint_number`),
  KEY `status` (`status`),
  KEY `assigned_to` (`assigned_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_legal_documents | resources/[standalone]/forge-police/sql/qbx.sql:4960
CREATE TABLE IF NOT EXISTS `mdt_legal_documents` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `court_case_id` int unsigned DEFAULT NULL,
  `type` enum('brief','motion','ruling','opinion','plea_deal','sentencing','other') NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext DEFAULT NULL,
  `status` enum('draft','filed','approved','rejected') NOT NULL DEFAULT 'draft',
  `author_citizenid` varchar(50) NOT NULL,
  `author_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_court_case` (`court_case_id`),
  KEY `idx_author` (`author_citizenid`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_officer_status | resources/[standalone]/forge-police/sql/qbx.sql:5052
CREATE TABLE IF NOT EXISTS `mdt_officer_status` (
  `citizenid` varchar(64) NOT NULL,
  `status` varchar(32) NOT NULL DEFAULT 'active',
  `note` varchar(120) DEFAULT NULL,
  `job_type` varchar(10) NOT NULL DEFAULT 'police',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`citizenid`),
  KEY `idx_mdt_officer_status_job` (`job_type`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_patrols | resources/[standalone]/forge-police/sql/qbx.sql:5032
CREATE TABLE IF NOT EXISTS `mdt_patrols` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `color` varchar(7) NOT NULL DEFAULT '#3B82F6',
  `member_ids` longtext DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT 0,
  `zone_points` longtext DEFAULT NULL,
  `job_type` varchar(10) NOT NULL DEFAULT 'police',
  PRIMARY KEY (`id`),
  KEY `idx_mdt_patrols_job_sort` (`job_type`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_penal_code_tags | resources/[standalone]/forge-police/server/backend/charges.lua:51
CREATE TABLE IF NOT EXISTS `mdt_penal_code_tags` (
  `charge_code` varchar(50) NOT NULL,
  `tag_id` int unsigned NOT NULL,
  PRIMARY KEY (`charge_code`,`tag_id`),
  KEY `tag_id` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_penal_codes | resources/[standalone]/forge-police/sql/qbx.sql:54
CREATE TABLE IF NOT EXISTS `mdt_penal_codes` (
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_class` enum('felony','misdemeanor','infraction') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `months` int unsigned NOT NULL DEFAULT 0,
  `fine` int unsigned NOT NULL DEFAULT 0,
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`code`),
  KEY `label` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_permission_roles | resources/[standalone]/forge-police/sql/qbx.sql:92
CREATE TABLE IF NOT EXISTS `mdt_permission_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `job` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `grade` int unsigned NOT NULL,
  `permissions` json NOT NULL,
  `updated_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_grade` (`job`,`grade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_ppr | resources/[standalone]/forge-police/sql/qbx.sql:4599
CREATE TABLE IF NOT EXISTS `mdt_ppr` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ppr_number` varchar(20) NOT NULL DEFAULT '',
  `officer_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `officer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` enum('positive','coaching','disciplinary') NOT NULL DEFAULT 'coaching',
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `incident_date` varchar(20) DEFAULT NULL,
  `incident_location` varchar(200) DEFAULT NULL,
  `linked_report_id` int unsigned DEFAULT NULL,
  `linked_case_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ppr_number` (`ppr_number`),
  KEY `officer_citizenid` (`officer_citizenid`),
  KEY `author_citizenid` (`author_citizenid`),
  KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_profiles | resources/[standalone]/forge-police/sql/qbx.sql:17
CREATE TABLE IF NOT EXISTS `mdt_profiles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `callsign` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `badge_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rank` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profilepicture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certifications` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `last_logout_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid` (`citizenid`),
  UNIQUE KEY `callsign` (`callsign`),
  KEY `badge_number` (`badge_number`),
  KEY `idx_department` (`department`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_report_templates | resources/[standalone]/forge-police/sql/qbx.sql:4488
CREATE TABLE IF NOT EXISTS `mdt_report_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `job_type` VARCHAR(50) NULL DEFAULT 'all',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_reports | resources/[standalone]/forge-police/sql/qbx.sql:3942
CREATE TABLE IF NOT EXISTS `mdt_reports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contentyjs` longblob DEFAULT NULL,
  `contentplaintext` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authorplaintext` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datecreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateupdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lawyer_requested` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_author` (`author`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_settings | resources/[standalone]/forge-police/sql/qbx.sql:1
CREATE TABLE IF NOT EXISTS `mdt_settings` (
  `value` longtext DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `key` varchar(100) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_sop_acknowledgements | resources/[standalone]/forge-police/sql/qbx.sql:4771
CREATE TABLE IF NOT EXISTS `mdt_sop_acknowledgements` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `job` varchar(50) NOT NULL,
  `version` int unsigned NOT NULL,
  `agreed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid_job` (`citizenid`, `job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_sop_categories | resources/[standalone]/forge-police/sql/qbx.sql:4734
CREATE TABLE IF NOT EXISTS `mdt_sop_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `job` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `icon` varchar(50) DEFAULT 'description',
  `sort_order` int unsigned DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `job` (`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_sop_settings | resources/[standalone]/forge-police/sql/qbx.sql:4759
CREATE TABLE IF NOT EXISTS `mdt_sop_settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `job` varchar(50) NOT NULL,
  `mission_statement` text DEFAULT NULL,
  `introduction` text DEFAULT NULL,
  `version` int unsigned DEFAULT 0,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `job` (`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_tags | resources/[standalone]/forge-police/sql/qbx.sql:4393
CREATE TABLE IF NOT EXISTS `mdt_tags` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `type` ENUM('report','officer','citizen') NOT NULL DEFAULT 'citizen',
  `color` VARCHAR(7) NOT NULL DEFAULT '#6b7280',
  `job_type` VARCHAR(10) NOT NULL DEFAULT 'all',
  `description` VARCHAR(120) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_tag_name_job` (`name`, `job_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_warrant_requests | resources/[standalone]/forge-police/sql/qbx.sql:4979
CREATE TABLE IF NOT EXISTS `mdt_warrant_requests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `citizen_name` varchar(100) NOT NULL DEFAULT '',
  `requesting_officer` varchar(50) NOT NULL,
  `officer_name` varchar(100) NOT NULL DEFAULT '',
  `charges` text DEFAULT NULL,
  `reason` text NOT NULL,
  `linked_report_id` int unsigned DEFAULT NULL,
  `status` enum('pending','approved','denied','closed') NOT NULL DEFAULT 'pending',
  `reviewer_citizenid` varchar(50) DEFAULT NULL,
  `reviewer_name` varchar(100) DEFAULT NULL,
  `review_reason` text DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_citizenid` (`citizenid`),
  KEY `idx_status` (`status`),
  KEY `idx_requesting_officer` (`requesting_officer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_warrant_reviews | resources/[standalone]/forge-police/sql/qbx.sql:5001
CREATE TABLE IF NOT EXISTS `mdt_warrant_reviews` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `warrant_request_id` int unsigned NOT NULL,
  `reviewer_citizenid` varchar(50) NOT NULL,
  `reviewer_name` varchar(100) DEFAULT NULL,
  `decision` enum('approved','denied') NOT NULL,
  `reason` text DEFAULT NULL,
  `reviewed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_warrant_request` (`warrant_request_id`),
  KEY `idx_reviewer` (`reviewer_citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_calls | resources/[voice]/forge-npwd/import.sql:234
CREATE TABLE IF NOT EXISTS `npwd_calls` (
  `id`          int      NOT NULL AUTO_INCREMENT,
  `identifier`  varchar(48)  DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `transmitter` varchar(255) NOT NULL,
  `receiver`    varchar(255) NOT NULL,
  `is_accepted` tinyint   DEFAULT 0,
  `isAnonymous` tinyint   NOT NULL DEFAULT 0,
  `start`       varchar(255) DEFAULT NULL,
  end           varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_darkchat_channels | resources/[voice]/forge-npwd/import.sql:257
CREATE TABLE IF NOT EXISTS `npwd_darkchat_channels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `channel_identifier` VARCHAR(191) NOT NULL COLLATE utf8mb4_unicode_ci,
  `label` VARCHAR(255) NULL DEFAULT '' COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `darkchat_channels_channel_identifier_uindex` (`channel_identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_marketplace_listings | resources/[voice]/forge-npwd/import.sql:164
CREATE TABLE IF NOT EXISTS `npwd_marketplace_listings` (
  `id`          int      NOT NULL AUTO_INCREMENT,
  `identifier`  varchar(48)           DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `username`    varchar(255)          DEFAULT NULL,
  `name`        varchar(50)           DEFAULT NULL,
  `number`      varchar(255) NOT NULL,
  `title`       varchar(255)          DEFAULT NULL,
  `url`         varchar(255)          DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `createdAt`   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt`   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reported`    tinyint      NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_match_profiles | resources/[voice]/forge-npwd/import.sql:123
CREATE TABLE IF NOT EXISTS `npwd_match_profiles` (
  `id`            int          NOT NULL AUTO_INCREMENT,
  `identifier`    varchar(48)  NOT NULL COLLATE utf8mb4_unicode_ci,
  `name`          varchar(90)  NOT NULL,
  `image`         varchar(255) NOT NULL,
  `bio`           varchar(512)          DEFAULT NULL,
  `location`      varchar(45)           DEFAULT NULL,
  `job`           varchar(45)           DEFAULT NULL,
  `tags`          varchar(255) NOT NULL DEFAULT '',
  `voiceMessage`  varchar(512)         DEFAULT NULL,
  `createdAt`     timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt`     timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier_UNIQUE` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_messages | resources/[voice]/forge-npwd/import.sql:194
CREATE TABLE IF NOT EXISTS `npwd_messages` (
  `id`              int      NOT NULL AUTO_INCREMENT,
  `message`         varchar(512) NOT NULL COLLATE utf8mb4_unicode_ci,
  `user_identifier` varchar(48)  NOT NULL COLLATE utf8mb4_unicode_ci,
  `conversation_id` varchar(512) NOT NULL,
  `isRead`          tinyint   NOT NULL DEFAULT 0,
  `createdAt`       timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `updatedAt`       timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
  `visible`         tinyint   NOT NULL DEFAULT 1,
  `author`          varchar(255) NOT NULL,
  `is_embed`        tinyint   NOT NULL default 0,
  `embed`           varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_identifier` (`user_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_messages_conversations | resources/[voice]/forge-npwd/import.sql:211
CREATE TABLE IF NOT EXISTS `npwd_messages_conversations` (
  `id`                INT      NOT NULL AUTO_INCREMENT,
  `conversation_list` VARCHAR(225) NOT NULL COLLATE utf8mb4_unicode_ci,
  `label`             VARCHAR(60)  NULL     DEFAULT '' COLLATE utf8mb4_unicode_ci,
  `createdAt`         TIMESTAMP    NOT NULL DEFAULT current_timestamp(),
  `updatedAt`         TIMESTAMP    NOT NULL DEFAULT current_timestamp(),
  `last_message_id`   INT      NULL     DEFAULT NULL,
  `is_group_chat`     TINYINT   NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_notes | resources/[voice]/forge-npwd/import.sql:154
CREATE TABLE IF NOT EXISTS `npwd_notes` (
  `id`         int      NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48)  NOT NULL COLLATE utf8mb4_unicode_ci,
  `title`      varchar(255) NOT NULL,
  `content`    varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_phone_contacts | resources/[voice]/forge-npwd/import.sql:82
CREATE TABLE IF NOT EXISTS `npwd_phone_contacts` (
  `id`         int      NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48)           DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `avatar`     varchar(255)          DEFAULT NULL,
  `number`     varchar(20)           DEFAULT NULL,
  `display`    varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_phone_gallery | resources/[voice]/forge-npwd/import.sql:248
CREATE TABLE IF NOT EXISTS `npwd_phone_gallery` (
  `id`         int      NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `image`      varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_twitter_profiles | resources/[voice]/forge-npwd/import.sql:68
CREATE TABLE IF NOT EXISTS `npwd_twitter_profiles` (
  `id`           int         NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(90) NOT NULL,
  `identifier`   varchar(48) NOT NULL COLLATE utf8mb4_unicode_ci,
  `avatar_url`   varchar(255)         DEFAULT 'https://i.fivemanage.com/images/3ClWwmpwkFhL.png',
  `createdAt`    timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt`    timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_name_UNIQUE` (`profile_name`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ox_doorlock | resources/[ox]/ox_doorlock/sql/ox_doorlock.sql:1
CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ox_inventory | resources/[ox]/ox_inventory/modules/mysql/server.lua:55
CREATE TABLE IF NOT EXISTS `ox_inventory` (
  `owner` varchar(60) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `owner` (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- pinel_whitelist | resources/[forge]/[forge-scripts]/forge-core/kernel/server/whitelist/service.lua:302
CREATE TABLE IF NOT EXISTS `pinel_whitelist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `citizen` varchar(50) NOT NULL,
  `fivem` varchar(80) DEFAULT NULL,
  `added_by` varchar(80) DEFAULT NULL,
  `discord` varchar(80) DEFAULT NULL,
  `name` varchar(120) DEFAULT NULL,
  `license` varchar(80) DEFAULT NULL,
  `whitelisted_at` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizen` (`citizen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- pinel_whitelist_answers | resources/[forge]/[forge-scripts]/forge-core/kernel/server/whitelist/service.lua:309
CREATE TABLE IF NOT EXISTS `pinel_whitelist_answers` (
  `citizen` varchar(50) NOT NULL,
  `answers` longtext DEFAULT NULL,
  `submitted_at` int DEFAULT NULL,
  PRIMARY KEY (`citizen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- pinel_whitelist_config | resources/[forge]/[forge-scripts]/forge-core/kernel/server/whitelist/service.lua:308
CREATE TABLE IF NOT EXISTS `pinel_whitelist_config` (
  `id` int NOT NULL,
  `config` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- player_mails | resources/[forge]/[forge-scripts]/forge-core/backups/database/database_20260905_161426_both.sql:1984
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint DEFAULT 0,
  `mailid` int DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- player_outfit_codes | resources/[clothing]/illenium-appearance/sql/player_outfit_codes.sql:10
CREATE TABLE IF NOT EXISTS `player_outfit_codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `outfitid` int NOT NULL,
  `code` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_player_outfit_codes_player_outfits` (`outfitid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- player_outfits | resources/[clothing]/illenium-appearance/sql/player_outfits.sql:8
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` text DEFAULT NULL,
  `components` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid_outfitname_model` (`citizenid`,`outfitname`,`model`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- player_transactions | resources/[standalone]/Renewed-Banking/Renewed-Banking.sql:11
CREATE TABLE IF NOT EXISTS `player_transactions` (
  `id` varchar(50) NOT NULL,
  `isFrozen` int DEFAULT 0,
  `transactions` longtext DEFAULT ('[]'),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- players | resources/[forge]/[forge-scripts]/forge-core/backups/database/database_20260905_161426_both.sql:2098
CREATE TABLE IF NOT EXISTS `players` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int unsigned DEFAULT NULL,
  `citizenid` varchar(50) NOT NULL,
  `cid` int DEFAULT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_logged_out` timestamp NULL DEFAULT NULL,
  `last_property` varchar(255) DEFAULT NULL,
  `skills` longtext DEFAULT NULL,
  PRIMARY KEY (`citizenid`),
  KEY `id` (`id`),
  KEY `last_updated` (`last_updated`),
  KEY `license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- playerskins | resources/[clothing]/illenium-appearance/sql/playerskins.sql:1
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- police_impound | resources/[forge]/[forge-scripts]/forge-garage/sql/qb.sql:11
CREATE TABLE IF NOT EXISTS `police_impound` (
  `citizenid` varchar(50) NOT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `vehicle` longtext DEFAULT NULL,
  `props` longtext DEFAULT NULL,
  `owner` longtext DEFAULT NULL,
  `officer` longtext DEFAULT NULL,
  `date` longtext NOT NULL,
  `fine` bigint DEFAULT 0,
  `paid` tinyint DEFAULT 0,
  `garage` longtext NOT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `deformation` longtext DEFAULT NULL,
  bank_invoice_id varchar(120) DEFAULT NULL,
  KEY `idx_police_impound_plate` (`plate`),
  KEY `idx_police_impound_citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- pr_carkeys | resources/[vehicle_system]/pr_carkeys/install/pr_carkeys.sql:6
CREATE TABLE IF NOT EXISTS `pr_carkeys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `barcode` varchar(20) NOT NULL COMMENT 'Código de barras único da chave (metadata)',
  `citizenid` varchar(50) NOT NULL COMMENT 'CitizenID do dono da chave',
  `plate` varchar(15) NOT NULL COMMENT 'Placa do veículo',
  `key_type` varchar(20) NOT NULL DEFAULT 'permanent' COMMENT 'permanent | temporary | single_use',
  `sound` varchar(50) NOT NULL DEFAULT 'lock' COMMENT 'Nome do som configurado',
  `motor` tinyint NOT NULL DEFAULT 0 COMMENT '1 = liga motor ao destrancar',
  `level` varchar(20) NOT NULL DEFAULT 'original' COMMENT 'original | copy',
  `distance` float NOT NULL DEFAULT 5 COMMENT 'Distância do sinal (metros)',
  `expires_at` bigint DEFAULT NULL COMMENT 'Timestamp UNIX de expiração (apenas temporary)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`),
  KEY `idx_barcode` (`barcode`),
  KEY `idx_citizenid` (`citizenid`),
  KEY `idx_plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- pr_elevator_elevator | resources/[standalone]/pr_elevator/shared/import.sql:1
CREATE TABLE IF NOT EXISTS `pr_elevator_elevator` (
  `id`              int          NOT NULL AUTO_INCREMENT,
  `name`            varchar(50)      DEFAULT NULL                 COMMENT 'Nome do elevador',
  `type`            varchar(50)      NOT NULL DEFAULT 'public'    COMMENT 'Tipo de acesso legado',
  `job`             varchar(50)      DEFAULT NULL                 COMMENT 'Emprego/gang legado',
  `job_grade`       int          DEFAULT 0                    COMMENT 'Nivel de cargo minimo legado',
  `password`        varchar(50)      DEFAULT NULL                 COMMENT 'Senha legada',
  `access_key`      varchar(50)      DEFAULT NULL                 COMMENT 'Chave de acesso legada',
  `citizenid`       varchar(50)      DEFAULT NULL                 COMMENT 'CitizenID legado',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ps_dispatch_settings | resources/[standalone]/ps-dispatch/server/settings.lua:263
CREATE TABLE IF NOT EXISTS `ps_dispatch_settings` (
  `id` TINYINT UNSIGNED NOT NULL PRIMARY KEY,
  `settings` LONGTEXT NOT NULL,
  `updated_by` VARCHAR(64) NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- qbx_character_slot_blocks | resources/[forge]/[forge-scripts]/forge-core/kernel/server/character_slots.lua:92
CREATE TABLE IF NOT EXISTS `qbx_character_slot_blocks` (
  `user_id` int UNSIGNED NOT NULL,
  `slot_id` tinyint UNSIGNED NOT NULL,
  `blocked_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`, `slot_id`),
  KEY `idx_qbx_character_slot_blocks_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- qbx_character_slot_settings | resources/[forge]/[forge-scripts]/forge-core/kernel/server/character_slots.lua:82
CREATE TABLE IF NOT EXISTS `qbx_character_slot_settings` (
  `id` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `settings` longtext NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- qbx_character_slots | resources/[forge]/[forge-scripts]/forge-core/kernel/server/character_slots.lua:87
CREATE TABLE IF NOT EXISTS `qbx_character_slots` (
  `user_id` int UNSIGNED NOT NULL,
  `slot_id` tinyint UNSIGNED NOT NULL,
  `acquired_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`, `slot_id`),
  KEY `idx_qbx_character_slots_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- qbx_character_terms_acceptance | resources/[forge]/[forge-scripts]/forge-core/kernel/server/character_slots.lua:97
CREATE TABLE IF NOT EXISTS `qbx_character_terms_acceptance` (
  `user_id` int UNSIGNED NOT NULL,
  `terms_version` varchar(40) NOT NULL,
  `accepted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`, `terms_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- renewed_account_members | resources/[standalone]/Renewed-Banking/Renewed-Banking.sql:48
CREATE TABLE IF NOT EXISTS `renewed_account_members` (
  `account_id` varchar(60) NOT NULL,
  `member_cid` varchar(60) NOT NULL,
  `member_name` varchar(120) NOT NULL,
  `can_withdraw` tinyint NOT NULL DEFAULT 0,
  `can_transfer` tinyint NOT NULL DEFAULT 0,
  `can_pay_invoices` tinyint NOT NULL DEFAULT 0,
  `created_at` bigint NOT NULL,
  `updated_at` bigint NOT NULL,
  PRIMARY KEY (`account_id`,`member_cid`),
  KEY `idx_renewed_member` (`member_cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- renewed_invoice_settings | resources/[standalone]/Renewed-Banking/Renewed-Banking.sql:42
CREATE TABLE IF NOT EXISTS `renewed_invoice_settings` (
  `id` tinyint unsigned NOT NULL,
  `settings` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- renewed_invoices | resources/[standalone]/Renewed-Banking/Renewed-Banking.sql:18
CREATE TABLE IF NOT EXISTS `renewed_invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(120) DEFAULT NULL,
  `recipient` varchar(60) NOT NULL,
  `issuer_resource` varchar(80) NOT NULL,
  `issuer` varchar(120) NOT NULL,
  `receiver_account` varchar(50) DEFAULT NULL,
  `title` varchar(120) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `principal` int unsigned NOT NULL,
  `interest_rate` decimal(8,4) NOT NULL DEFAULT 0,
  `interest_interval` enum('hour','day') NOT NULL DEFAULT 'day',
  `due_at` bigint NOT NULL,
  `status` enum('active','processing','paid','cancelled') NOT NULL DEFAULT 'active',
  `metadata` longtext DEFAULT NULL,
  `created_at` bigint NOT NULL,
  `paid_at` bigint DEFAULT NULL,
  `paid_amount` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_invoice_external` (`issuer_resource`,`external_id`),
  KEY `idx_invoice_recipient_status` (`recipient`,`status`),
  KEY `idx_invoice_due` (`due_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- users | resources/[forge]/[forge-scripts]/forge-core/kernel/server/storage.lua:22
CREATE TABLE IF NOT EXISTS `users` (
  `userId` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `license2` varchar(50) DEFAULT NULL,
  `fivem` varchar(20) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- vehicle_parts | resources/[vehicle_system]/pr_mileage/server/server.lua:63
CREATE TABLE IF NOT EXISTS `vehicle_parts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `plate` varchar(10) NOT NULL COMMENT 'Placa do veiculo',
  `part` varchar(64) NOT NULL COMMENT 'Identificador da peca',
  `stage` tinyint NOT NULL DEFAULT 1 COMMENT 'Nivel/estagio da peca',
  `installed_km` INT UNSIGNED NOT NULL DEFAULT 0,
  `durability` INT UNSIGNED NOT NULL DEFAULT 0,
  `citizen_id` varchar(64) DEFAULT NULL COMMENT 'CitizenID de quem instalou',
  `installed_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Data e hora da instalacao',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_plate_part` (`plate`,`part`),
  KEY `idx_plate` (`plate`),
  KEY `idx_citizen_id` (`citizen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- warns | resources/[Scripts-para-remover]/pinel-admin/compat/qbcore.lua:31
CREATE TABLE IF NOT EXISTS `warns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `license` varchar(50) NOT NULL,
  `reason` text NOT NULL,
  `warnedby` varchar(50) NOT NULL,
  `warnedtime` bigint NOT NULL DEFAULT (unix_timestamp()),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- xt_prison | resources/[standalone]/xt-prison/modules/server/db.lua:17
CREATE TABLE IF NOT EXISTS `xt_prison` (
  `identifier` varchar(100) NOT NULL,
  `jailtime` int NOT NULL DEFAULT 0,
  `sentence` LONGTEXT NULL DEFAULT NULL,
  `status` VARCHAR(16) NOT NULL DEFAULT 'free',
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- xt_prison_items | resources/[standalone]/xt-prison/modules/server/db.lua:29
CREATE TABLE IF NOT EXISTS `xt_prison_items` (
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  UNIQUE KEY `owner` (`owner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- xt_prison_settings | resources/[standalone]/xt-prison/modules/server/db.lua:39
CREATE TABLE IF NOT EXISTS `xt_prison_settings` (
  id VARCHAR(50) NOT NULL,
  data LONGTEXT NOT NULL,
  updated_at TIMESTAMP NOT NULL
                DEFAULT CURRENT_TIMESTAMP
                ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_phone_devices | resources/[voice]/forge-npwd/import.sql:37
CREATE TABLE IF NOT EXISTS `forge_phone_devices` (
  `device_id` char(36) NOT NULL,
  `profile_id` char(36) NOT NULL,
  `serial_number` varchar(32) NOT NULL,
  `registered_owner_citizenid` varchar(50) NOT NULL,
  `current_user_citizenid` varchar(50) NULL DEFAULT NULL,
  `pin_hash` varchar(128) NULL DEFAULT NULL,
  `pin_salt` varchar(64) NULL DEFAULT NULL,
  `pin_length` tinyint unsigned NULL DEFAULT NULL,
  `pin_fail_count` smallint unsigned NOT NULL DEFAULT 0,
  `pin_locked_until` timestamp NULL DEFAULT NULL,
  `pin_updated_at` timestamp NULL DEFAULT NULL,
  `model` varchar(32) NOT NULL,
  `color` varchar(24) NOT NULL,
  `schema_version` smallint unsigned NOT NULL DEFAULT 1,
  `status` varchar(16) NOT NULL DEFAULT 'active',
  `blocked_at` timestamp NULL DEFAULT NULL,
  `replaced_by_device_id` char(36) NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_activated_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`device_id`),
  UNIQUE KEY `uq_forge_phone_devices_serial` (`serial_number`),
  KEY `idx_forge_phone_devices_owner` (`registered_owner_citizenid`),
  KEY `idx_forge_phone_devices_current_user` (`current_user_citizenid`),
  KEY `idx_forge_phone_devices_profile_status` (`profile_id`, `status`),
  CONSTRAINT `fk_forge_phone_devices_profile`
        FOREIGN KEY (`profile_id`) REFERENCES `forge_phone_profiles` (`profile_id`)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- forge_phone_lines | resources/[voice]/forge-npwd/import.sql:22
CREATE TABLE IF NOT EXISTS `forge_phone_lines` (
  `line_id` char(36) NOT NULL,
  `profile_id` char(36) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `uq_forge_phone_lines_number` (`phone_number`),
  UNIQUE KEY `uq_forge_phone_lines_profile` (`profile_id`),
  CONSTRAINT `fk_forge_phone_lines_profile`
        FOREIGN KEY (`profile_id`) REFERENCES `forge_phone_profiles` (`profile_id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- housing_hotel_keys | resources/[housing]/ps-housing/server/hotel.lua:231
CREATE TABLE IF NOT EXISTS `housing_hotel_keys` (
  stay_id BIGINT UNSIGNED NOT NULL,
  citizenid VARCHAR(64) NOT NULL,
  PRIMARY KEY(stay_id,citizenid),
  CONSTRAINT housing_hotel_key_stay FOREIGN KEY(stay_id) REFERENCES housing_hotel_stays(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_arrests | resources/[standalone]/forge-police/sql/qbx.sql:4029
CREATE TABLE IF NOT EXISTS `mdt_arrests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reportid` int unsigned NOT NULL,
  `citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `officer_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `officer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `reportid` (`reportid`),
  KEY `citizenid` (`citizenid`),
  CONSTRAINT `FK_mdt_arrests_reports` FOREIGN KEY (`reportid`) REFERENCES `mdt_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_mdt_arrests_profiles` FOREIGN KEY (`citizenid`) REFERENCES `mdt_profiles` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_bolos | resources/[standalone]/forge-police/sql/qbx.sql:4282
CREATE TABLE IF NOT EXISTS `mdt_bolos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('citizen','vehicle','weapon','property','other') NOT NULL DEFAULT 'citizen',
  `subject_id` varchar(50) NOT NULL COMMENT 'citizenid, plate, serial, etc depending on type',
  `subject_name` varchar(100) DEFAULT NULL COMMENT 'Full name, vehicle model, weapon type, etc',
  `reportId` int unsigned DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('active','inactive','resolved') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `subject_id` (`subject_id`),
  KEY `status` (`status`),
  KEY `reportId` (`reportId`),
  CONSTRAINT `FK_mdt_bolos_reports` FOREIGN KEY (`reportId`) REFERENCES `mdt_reports` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_case_attachments | resources/[standalone]/forge-police/sql/qbx.sql:4075
CREATE TABLE IF NOT EXISTS `mdt_case_attachments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `case_id` int unsigned NOT NULL,
  `type` enum('photo','document','other') NOT NULL DEFAULT 'document',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `FK_mdt_case_attachments_cases` FOREIGN KEY (`case_id`) REFERENCES `mdt_cases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_case_notes | resources/[standalone]/forge-police/sql/qbx.sql:4088
CREATE TABLE IF NOT EXISTS `mdt_case_notes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `case_id` int unsigned NOT NULL,
  `content` text NOT NULL,
  `author_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `FK_mdt_case_notes_cases` FOREIGN KEY (`case_id`) REFERENCES `mdt_cases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_case_officers | resources/[standalone]/forge-police/sql/qbx.sql:4061
CREATE TABLE IF NOT EXISTS `mdt_case_officers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `case_id` int unsigned NOT NULL,
  `citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('primary','assisting','supervisor') NOT NULL DEFAULT 'assisting',
  `assigned_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  KEY `citizenid` (`citizenid`),
  CONSTRAINT `FK_mdt_case_officers_cases` FOREIGN KEY (`case_id`) REFERENCES `mdt_cases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_mdt_case_officers_profiles` FOREIGN KEY (`citizenid`) REFERENCES `mdt_profiles` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_case_reports | resources/[standalone]/forge-police/sql/qbx.sql:4100
CREATE TABLE IF NOT EXISTS `mdt_case_reports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `case_id` int unsigned NOT NULL,
  `report_id` int unsigned NOT NULL,
  `linked_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linked_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_case_report` (`case_id`, `report_id`),
  KEY `case_id` (`case_id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `FK_case_reports_cases` FOREIGN KEY (`case_id`) REFERENCES `mdt_cases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_case_reports_reports` FOREIGN KEY (`report_id`) REFERENCES `mdt_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_citizen_licenses | resources/[standalone]/forge-police/sql/qbx.sql:4539
CREATE TABLE IF NOT EXISTS `mdt_citizen_licenses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `license_id` int unsigned NOT NULL,
  `active` tinyint NOT NULL DEFAULT 1,
  `granted_by` varchar(50) DEFAULT NULL,
  `granted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_citizen_license` (`citizenid`, `license_id`),
  KEY `citizenid` (`citizenid`),
  KEY `license_id` (`license_id`),
  CONSTRAINT `FK_mdt_citizen_licenses_custom` FOREIGN KEY (`license_id`) REFERENCES `mdt_custom_licenses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_court_hearings | resources/[standalone]/forge-police/sql/qbx.sql:5068
CREATE TABLE IF NOT EXISTS `mdt_court_hearings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `category` enum('court','training','meeting','other') NOT NULL DEFAULT 'court',
  `hearing_type` enum('arraignment','trial','sentencing','appeal','motion','hearing','other') NOT NULL DEFAULT 'trial',
  `case_id` int unsigned DEFAULT NULL,
  `warrant_reportid` int unsigned DEFAULT NULL,
  `defendant_cid` varchar(50) DEFAULT NULL,
  `defendant_name` varchar(100) DEFAULT NULL,
  `scheduled_at` datetime NOT NULL,
  `duration_minutes` int NOT NULL DEFAULT 30,
  `location` varchar(255) DEFAULT NULL,
  `judge_cid` varchar(50) DEFAULT NULL,
  `judge_name` varchar(100) DEFAULT NULL,
  `status` enum('scheduled','in_session','completed','adjourned','cancelled') NOT NULL DEFAULT 'scheduled',
  `notes` text DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_by_name` varchar(100) DEFAULT NULL,
  `job_type` varchar(10) NOT NULL DEFAULT 'police',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_mdt_court_hearings_schedule` (`job_type`,`scheduled_at`),
  KEY `idx_mdt_court_hearings_status` (`status`),
  KEY `idx_mdt_court_hearings_case` (`case_id`),
  CONSTRAINT `FK_mdt_court_hearings_cases` FOREIGN KEY (`case_id`) REFERENCES `mdt_cases` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_evidence_items | resources/[standalone]/forge-police/sql/qbx.sql:4114
CREATE TABLE IF NOT EXISTS `mdt_evidence_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `case_id` int unsigned DEFAULT NULL,
  `report_id` int unsigned DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stash_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stored` tinyint NOT NULL DEFAULT 0,
  `last_holder` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  KEY `report_id` (`report_id`),
  KEY `last_holder` (`last_holder`),
  CONSTRAINT `FK_mdt_evidence_items_cases` FOREIGN KEY (`case_id`) REFERENCES `mdt_cases` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_mdt_evidence_items_reports` FOREIGN KEY (`report_id`) REFERENCES `mdt_reports` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_fto_assignments | resources/[standalone]/forge-police/sql/qbx.sql:4657
CREATE TABLE IF NOT EXISTS `mdt_fto_assignments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `fto_number` varchar(20) NOT NULL DEFAULT '',
  `trainee_citizenid` varchar(50) NOT NULL,
  `trainee_name` varchar(100) NOT NULL,
  `trainer_citizenid` varchar(50) NOT NULL,
  `trainer_name` varchar(100) NOT NULL,
  `current_phase_id` int unsigned DEFAULT NULL,
  `status` enum('active','completed','failed','suspended') NOT NULL DEFAULT 'active',
  `start_date` varchar(20) DEFAULT NULL,
  `end_date` varchar(20) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `fto_number` (`fto_number`),
  KEY `trainee_citizenid` (`trainee_citizenid`),
  KEY `trainer_citizenid` (`trainer_citizenid`),
  KEY `status` (`status`),
  KEY `current_phase_id` (`current_phase_id`),
  CONSTRAINT `FK_fto_assignments_phase` FOREIGN KEY (`current_phase_id`) REFERENCES `mdt_fto_phases` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_ia_notes | resources/[standalone]/forge-police/sql/qbx.sql:4585
CREATE TABLE IF NOT EXISTS `mdt_ia_notes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` int unsigned NOT NULL,
  `content` text NOT NULL,
  `author_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `complaint_id` (`complaint_id`),
  CONSTRAINT `FK_ia_notes_complaints` FOREIGN KEY (`complaint_id`) REFERENCES `mdt_ia_complaints` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_impound | resources/[standalone]/forge-police/sql/qbx.sql:4298
CREATE TABLE IF NOT EXISTS `mdt_impound` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `vehicleid` int NOT NULL,
  `status` enum('active','released') NOT NULL DEFAULT 'active',
  `plate` varchar(16) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `lot` varchar(32) DEFAULT NULL,
  `linkedreport` int unsigned DEFAULT NULL,
  `fee` int NOT NULL DEFAULT 0,
  `fee_paid` tinyint NOT NULL DEFAULT 0,
  `hold_type` enum('immediate','timed','indefinite') NOT NULL DEFAULT 'immediate',
  `hold_until` int DEFAULT NULL,
  `hold_label` varchar(64) DEFAULT NULL,
  `officer_citizenid` varchar(50) DEFAULT NULL,
  `officer_name` varchar(100) DEFAULT NULL,
  `time` int NOT NULL DEFAULT 0,
  `released_at` int DEFAULT NULL,
  `released_by_citizenid` varchar(50) DEFAULT NULL,
  `released_by_name` varchar(100) DEFAULT NULL,
  `override_reason` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicleid` (`vehicleid`),
  KEY `linkedreport` (`linkedreport`),
  KEY `idx_impound_status` (`status`, `time`),
  KEY `idx_impound_plate` (`plate`),
  CONSTRAINT `FK_mdt_impound_reports` FOREIGN KEY (`linkedreport`) REFERENCES `mdt_reports` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_messages | resources/[standalone]/forge-police/sql/qbx.sql:37
CREATE TABLE IF NOT EXISTS `mdt_messages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sender_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_citizenid` (`sender_citizenid`),
  KEY `receiver_citizenid` (`receiver_citizenid`),
  CONSTRAINT `FK_mdt_messages_sender` FOREIGN KEY (`sender_citizenid`) REFERENCES `mdt_profiles` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_mdt_messages_receiver` FOREIGN KEY (`receiver_citizenid`) REFERENCES `mdt_profiles` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_ppr_notes | resources/[standalone]/forge-police/sql/qbx.sql:4622
CREATE TABLE IF NOT EXISTS `mdt_ppr_notes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ppr_id` int unsigned NOT NULL,
  `content` text NOT NULL,
  `author_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ppr_id` (`ppr_id`),
  CONSTRAINT `FK_ppr_notes_ppr` FOREIGN KEY (`ppr_id`) REFERENCES `mdt_ppr` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_profile_sessions | resources/[standalone]/forge-police/sql/qbx.sql:3928
CREATE TABLE IF NOT EXISTS `mdt_profile_sessions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` int unsigned NOT NULL,
  `citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` int DEFAULT NULL,
  `login_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `logout_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id` (`profile_id`),
  KEY `citizenid` (`citizenid`),
  KEY `idx_profile_logout` (`profile_id`, `logout_at`),
  CONSTRAINT `FK_mdt_profile_sessions_profiles` FOREIGN KEY (`profile_id`) REFERENCES `mdt_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_profiles_clocking | resources/[standalone]/forge-police/sql/qbx.sql:3895
CREATE TABLE IF NOT EXISTS `mdt_profiles_clocking` (
  `profileId` int unsigned NOT NULL,
  `clockindate` timestamp NOT NULL DEFAULT current_timestamp(),
  `clockoutdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  KEY `FK_mdt_profiles_clocking_mdt_profiles` (`profileId`),
  CONSTRAINT `FK_mdt_profiles_clocking_mdt_profiles` FOREIGN KEY (`profileId`) REFERENCES `mdt_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_profiles_gallery | resources/[standalone]/forge-police/sql/qbx.sql:3903
CREATE TABLE IF NOT EXISTS `mdt_profiles_gallery` (
  `profileId` int unsigned NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datecreated` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `FK_mdt_profiles_gallery_mdt_profiles` (`profileId`),
  CONSTRAINT `FK_mdt_profiles_gallery_mdt_profiles` FOREIGN KEY (`profileId`) REFERENCES `mdt_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_profiles_identifiers | resources/[standalone]/forge-police/sql/qbx.sql:3912
CREATE TABLE IF NOT EXISTS `mdt_profiles_identifiers` (
  `profileId` int unsigned NOT NULL,
  `content` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `FK_mdt_profiles_identifiers_mdt_profiles` (`profileId`),
  CONSTRAINT `FK_mdt_profiles_identifiers_mdt_profiles` FOREIGN KEY (`profileId`) REFERENCES `mdt_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_profiles_tags | resources/[standalone]/forge-police/sql/qbx.sql:3920
CREATE TABLE IF NOT EXISTS `mdt_profiles_tags` (
  `profileId` int unsigned NOT NULL,
  `tag` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `unique_profile_tag` (`profileId`, `tag`),
  KEY `FK_mdt_profiles_tags_mdt_profiles` (`profileId`),
  CONSTRAINT `FK_mdt_profiles_tags_mdt_profiles` FOREIGN KEY (`profileId`) REFERENCES `mdt_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_report_vehicles | resources/[standalone]/forge-police/sql/qbx.sql:4475
CREATE TABLE IF NOT EXISTS `mdt_report_vehicles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reportid` int unsigned NOT NULL,
  `plate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mdt_report_vehicles_mdt_reports` (`reportid`),
  KEY `idx_report_vehicles_plate` (`plate`),
  CONSTRAINT `FK_mdt_report_vehicles_mdt_reports` FOREIGN KEY (`reportid`) REFERENCES `mdt_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_reports_charges | resources/[standalone]/forge-police/sql/qbx.sql:3956
CREATE TABLE IF NOT EXISTS `mdt_reports_charges` (
  `reportid` int unsigned NOT NULL,
  `citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `count` int unsigned NOT NULL DEFAULT 1,
  `time` int unsigned DEFAULT NULL,
  `fine` int unsigned DEFAULT NULL,
  KEY `FK_mdt_reports_charges_mdt_reports` (`reportid`),
  KEY `FK_mdt_reports_charges_mdt_penal_codes` (`charge`),
  KEY `idx_charges_citizenid` (`citizenid`),
  CONSTRAINT `FK_mdt_reports_charges_mdt_reports` FOREIGN KEY (`reportid`) REFERENCES `mdt_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_reports_evidence | resources/[standalone]/forge-police/sql/qbx.sql:3970
CREATE TABLE IF NOT EXISTS `mdt_reports_evidence` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reportid` int unsigned NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stored` tinyint NOT NULL DEFAULT 0,
  title VARCHAR(255) NOT NULL DEFAULT '',
  images LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mdt_reports_evidence_mdt_reports` (`reportid`),
  CONSTRAINT `FK_mdt_reports_evidence_mdt_reports` FOREIGN KEY (`reportid`) REFERENCES `mdt_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_reports_involved | resources/[standalone]/forge-police/sql/qbx.sql:3982
CREATE TABLE IF NOT EXISTS `mdt_reports_involved` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reportid` int unsigned NOT NULL,
  `citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mdt_reports_involved_mdt_reports` (`reportid`),
  KEY `idx_involved_citizenid` (`citizenid`),
  CONSTRAINT `FK_mdt_reports_involved_mdt_reports` FOREIGN KEY (`reportid`) REFERENCES `mdt_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_reports_restrictions | resources/[standalone]/forge-police/sql/qbx.sql:3994
CREATE TABLE IF NOT EXISTS `mdt_reports_restrictions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reportid` int unsigned NOT NULL,
  `type` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mdt_reports_restrictions_mdt_reports` (`reportid`),
  CONSTRAINT `FK_mdt_reports_restrictions_mdt_reports` FOREIGN KEY (`reportid`) REFERENCES `mdt_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_reports_tags | resources/[standalone]/forge-police/sql/qbx.sql:4004
CREATE TABLE IF NOT EXISTS `mdt_reports_tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reportid` int unsigned NOT NULL,
  `tag` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mdt_reports_tags_mdt_reports` (`reportid`),
  CONSTRAINT `FK_mdt_reports_tags_mdt_reports` FOREIGN KEY (`reportid`) REFERENCES `mdt_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_reports_warrants | resources/[standalone]/forge-police/sql/qbx.sql:4013
CREATE TABLE IF NOT EXISTS `mdt_reports_warrants` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `reportid` int unsigned NOT NULL,
  `citizenid` varchar(50) NOT NULL DEFAULT '',
  `felonies` int unsigned NOT NULL DEFAULT 0,
  `misdemeanors` int unsigned NOT NULL DEFAULT 0,
  `infractions` int unsigned NOT NULL DEFAULT 0,
  `expirydate` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_warrant` (`reportid`, `citizenid`),
  KEY `FK_mdt_reports_warrants_mdt_reports` (`reportid`),
  KEY `FK_mdt_reports_warrants_mdt_profiles` (`citizenid`),
  CONSTRAINT `FK_mdt_reports_warrants_mdt_profiles` FOREIGN KEY (`citizenid`) REFERENCES `mdt_profiles` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_mdt_reports_warrants_mdt_reports` FOREIGN KEY (`reportid`) REFERENCES `mdt_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_sop_sections | resources/[standalone]/forge-police/sql/qbx.sql:4746
CREATE TABLE IF NOT EXISTS `mdt_sop_sections` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `sort_order` int unsigned DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `FK_sop_sections_category` FOREIGN KEY (`category_id`) REFERENCES `mdt_sop_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_weapons | resources/[standalone]/forge-police/sql/qbx.sql:4189
CREATE TABLE IF NOT EXISTS `mdt_weapons` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `serial` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `scratched` tinyint NOT NULL DEFAULT 0,
  `owner` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `information` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weaponClass` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weaponModel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flags` JSON DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_serial` (`serial`),
  KEY `FK_mdt_weapons_mdt_profiles` (`owner`),
  CONSTRAINT `FK_mdt_weapons_mdt_profiles` FOREIGN KEY (`owner`) REFERENCES `mdt_profiles` (`citizenid`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_darkchat_channel_members | resources/[voice]/forge-npwd/import.sql:269
CREATE TABLE IF NOT EXISTS `npwd_darkchat_channel_members` (
  `channel_id` INT NOT NULL,
  `user_identifier` VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci,
  `is_owner` TINYINT NOT NULL DEFAULT '0',
  KEY `npwd_darkchat_channel_members_npwd_darkchat_channels_id_fk` (`channel_id`) USING BTREE,
  CONSTRAINT `npwd_darkchat_channel_members_npwd_darkchat_channels_id_fk` FOREIGN KEY (`channel_id`) REFERENCES `npwd_darkchat_channels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_darkchat_messages | resources/[voice]/forge-npwd/import.sql:280
CREATE TABLE IF NOT EXISTS `npwd_darkchat_messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `channel_id` INT NOT NULL,
  `message` VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci,
  `user_identifier` VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  `is_image` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `darkchat_messages_darkchat_channels_id_fk` (`channel_id`) USING BTREE,
  CONSTRAINT `darkchat_messages_darkchat_channels_id_fk` FOREIGN KEY (`channel_id`) REFERENCES `npwd_darkchat_channels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_match_views | resources/[voice]/forge-npwd/import.sql:140
CREATE TABLE IF NOT EXISTS `npwd_match_views` (
  `id`         int         NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) NOT NULL COLLATE utf8mb4_unicode_ci,
  `profile`    int         NOT NULL,
  `liked`      tinyint              DEFAULT '0',
  `createdAt`  timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt`  timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `match_profile_idx` (`profile`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `match_profile` FOREIGN KEY (`profile`) REFERENCES `npwd_match_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_messages_participants | resources/[voice]/forge-npwd/import.sql:223
CREATE TABLE IF NOT EXISTS `npwd_messages_participants` (
  `id`              INT      NOT NULL AUTO_INCREMENT,
  `conversation_id` INT      NOT NULL,
  `participant`     VARCHAR(225) NOT NULL COLLATE utf8mb4_unicode_ci,
  `unread_count`    INT      NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `message_participants_npwd_messages_conversations_id_fk` (`conversation_id`) USING BTREE,
  CONSTRAINT `message_participants_npwd_messages_conversations_id_fk` FOREIGN KEY (`conversation_id`) REFERENCES `npwd_messages_conversations` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_twitter_tweets | resources/[voice]/forge-npwd/import.sql:93
CREATE TABLE IF NOT EXISTS `npwd_twitter_tweets` (
  `id`         INT       NOT NULL AUTO_INCREMENT,
  `message`    VARCHAR(1000) NOT NULL COLLATE utf8mb4_unicode_ci,
  `createdAt`  TIMESTAMP     NOT NULL DEFAULT current_timestamp(),
  `updatedAt`  TIMESTAMP     NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `likes`      INT       NOT NULL DEFAULT '0',
  `identifier` VARCHAR(48)   NOT NULL COLLATE utf8mb4_unicode_ci,
  `visible`    TINYINT    NOT NULL DEFAULT '1',
  `images`     VARCHAR(1000) NULL     DEFAULT '' COLLATE utf8mb4_unicode_ci,
  `retweet`    INT       NULL     DEFAULT NULL,
  `profile_id` INT       NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `npwd_twitter_tweets_npwd_twitter_profiles_id_fk` (`profile_id`) USING BTREE,
  CONSTRAINT `npwd_twitter_tweets_npwd_twitter_profiles_id_fk` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- player_groups | resources/[forge]/[forge-scripts]/forge-core/backups/database/database_20260905_161426_both.sql:1954
CREATE TABLE IF NOT EXISTS `player_groups` (
  `citizenid` varchar(50) NOT NULL,
  `group` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `grade` tinyint unsigned NOT NULL,
  PRIMARY KEY (`citizenid`,`type`,`group`),
  CONSTRAINT `fk_citizenid` FOREIGN KEY (`citizenid`) REFERENCES `players` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- player_vehicles | resources/[forge]/[forge-scripts]/forge-garage/sql/qb.sql:37
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int DEFAULT 1,
  `depotprice` int NOT NULL DEFAULT 0,
  `drivingdistance` int DEFAULT NULL,
  `status` text DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  `mileage` float NOT NULL DEFAULT 0,
  `balance` int NOT NULL DEFAULT 0,
  `paymentamount` int NOT NULL DEFAULT 0,
  `paymentsleft` int NOT NULL DEFAULT 0,
  `financetime` int NOT NULL DEFAULT 0,
  `vehicle_name` longtext DEFAULT NULL,
  `deformation` longtext DEFAULT NULL,
  `parking_coords` varchar(255) DEFAULT NULL,
  `mdt_vehicle_information` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mdt_vehicle_points` int NOT NULL DEFAULT 0,
  `mdt_vehicle_status` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'valid',
  `mdt_vehicle_stolen` tinyint NOT NULL DEFAULT 0,
  `mdt_vehicle_boloactive` tinyint NOT NULL DEFAULT 0,
  `mdt_vehicle_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`),
  KEY `FK_playervehicles_players` (`citizenid`),
  CONSTRAINT `FK_playervehicles_players` FOREIGN KEY (`citizenid`) REFERENCES `players` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE,
  KEY `idx_player_vehicles_plate` (`plate`),
  KEY `idx_player_vehicles_license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- pr_elevator_floor | resources/[standalone]/pr_elevator/shared/import.sql:13
CREATE TABLE IF NOT EXISTS `pr_elevator_floor` (
  `id`               int         NOT NULL AUTO_INCREMENT     COMMENT 'ID do andar - 1 id por andar!',
  `elevator_id`      int         NOT NULL                    COMMENT 'ID do elevador',
  `name`             varchar(50)     NOT NULL DEFAULT 'Andar'    COMMENT 'Nome de exibicao do andar (ex: T, S1)',
  `floor`            int         DEFAULT 0                   COMMENT 'Ordem/Numero do andar',
  `distance`         float           DEFAULT 2.0                 COMMENT 'Distancia necessaria para interagir com o elevador',
  `theme_color`      varchar(50)     DEFAULT NULL                COMMENT 'Cor do tema',
  `theme_background` varchar(50)     DEFAULT NULL                COMMENT 'Cor do fundo do tema',
  `coords`           json            DEFAULT NULL                COMMENT 'Coordenadas de spawn',
  `interact_coords`  json            DEFAULT NULL                COMMENT 'Payload de interacao: vector3 legado ou prop DUI',
  `access_type`      varchar(50)     NOT NULL DEFAULT 'public'   COMMENT 'Tipo de acesso do andar',
  `access_job`       varchar(50)     DEFAULT NULL                COMMENT 'Emprego/gang do andar',
  `access_job_grade` int         DEFAULT 0                   COMMENT 'Nivel minimo do emprego/gang',
  `access_password`  varchar(50)     DEFAULT NULL                COMMENT 'Senha do andar',
  `access_key`       varchar(50)     DEFAULT NULL                COMMENT 'Metadata/chave do cartao',
  `access_item`      varchar(50)     DEFAULT NULL                COMMENT 'Item de cartao exigido',
  `access_citizenid` varchar(50)     DEFAULT NULL                COMMENT 'CitizenID permitido no andar',
  PRIMARY KEY (`id`),
  KEY `fk_elevator_floor_elevator` (`elevator_id`),
  CONSTRAINT `fk_elevator_floor_elevator` FOREIGN KEY (`elevator_id`) REFERENCES `pr_elevator_elevator` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- properties | resources/[housing]/ps-housing/README - INSTALL INSTRUCTIONS/QBOX/properties.sql:3
CREATE TABLE IF NOT EXISTS `properties` (
  `property_id` int NOT NULL AUTO_INCREMENT,
  `owner_citizenid` varchar(50) NULL,
  `street` VARCHAR(100) NULL,
  `region` VARCHAR(100) NULL,
  `description` LONGTEXT NULL,
  `has_access` JSON NULL DEFAULT (JSON_ARRAY()),
  `extra_imgs` JSON NULL DEFAULT (JSON_ARRAY()),
  `furnitures` JSON NULL DEFAULT (JSON_ARRAY()),
  `for_sale` boolean NOT NULL DEFAULT 1,
  `price` int NOT NULL DEFAULT 0,
  `shell` varchar(50) NOT NULL,
  `apartment` varchar(50) NULL DEFAULT NULL,
  `door_data` JSON NULL DEFAULT NULL,
  `garage_data` JSON NULL DEFAULT NULL,
  `zone_data` JSON NULL DEFAULT NULL,
  `admin_access` JSON NULL DEFAULT (JSON_ARRAY()),
  `tax_data` JSON NULL DEFAULT (JSON_OBJECT()),
  `house_object` longtext DEFAULT NULL,
  purchase_price BIGINT NULL,
  sold_at BIGINT NULL,
  category VARCHAR(20) NULL,
  `enterprise_id` INT NULL,
  `unit_number` VARCHAR(32) NULL,
  `unit_floor` INT NULL,
  `hourly_rate` BIGINT NULL,
  `daily_rate` BIGINT NULL,
  PRIMARY KEY (`property_id`),
  UNIQUE KEY `UQ_owner_apartment` (`owner_citizenid`,`apartment`),
  CONSTRAINT `FK_owner_citizenid` FOREIGN KEY (`owner_citizenid`) REFERENCES `players` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE KEY `housing_enterprise_unit` (`enterprise_id`, `unit_number`),
  CONSTRAINT `housing_enterprise_fk` FOREIGN KEY (`enterprise_id`) REFERENCES `housing_enterprises` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_court_attendees | resources/[standalone]/forge-police/sql/qbx.sql:5095
CREATE TABLE IF NOT EXISTS `mdt_court_attendees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `hearing_id` int unsigned NOT NULL,
  `citizenid` varchar(50) NOT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `role` enum('prosecutor','defense','officer','witness','judge','trainee','instructor','attendee') NOT NULL DEFAULT 'officer',
  `notified_at` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_mdt_court_attendees_hearing_cid` (`hearing_id`,`citizenid`),
  KEY `idx_mdt_court_attendees_citizen` (`citizenid`),
  CONSTRAINT `FK_mdt_court_attendees_hearing` FOREIGN KEY (`hearing_id`) REFERENCES `mdt_court_hearings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_evidence_custody | resources/[standalone]/forge-police/sql/qbx.sql:4137
CREATE TABLE IF NOT EXISTS `mdt_evidence_custody` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `evidence_id` int unsigned NOT NULL,
  `from_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` enum('collected','transferred','stored','released','updated','viewed') NOT NULL DEFAULT 'collected',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `evidence_id` (`evidence_id`),
  CONSTRAINT `FK_mdt_evidence_custody_items` FOREIGN KEY (`evidence_id`) REFERENCES `mdt_evidence_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_evidence_images | resources/[standalone]/forge-police/sql/qbx.sql:4150
CREATE TABLE IF NOT EXISTS `mdt_evidence_images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `evidence_id` int unsigned NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `evidence_id` (`evidence_id`),
  CONSTRAINT `FK_mdt_evidence_images_items` FOREIGN KEY (`evidence_id`) REFERENCES `mdt_evidence_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_fto_dors | resources/[standalone]/forge-police/sql/qbx.sql:4680
CREATE TABLE IF NOT EXISTS `mdt_fto_dors` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `assignment_id` int unsigned NOT NULL,
  `phase_id` int unsigned DEFAULT NULL,
  `author_citizenid` varchar(50) NOT NULL,
  `author_name` varchar(100) NOT NULL,
  `shift_date` varchar(20) NOT NULL,
  `overall_rating` int unsigned NOT NULL DEFAULT 3,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `assignment_id` (`assignment_id`),
  KEY `phase_id` (`phase_id`),
  CONSTRAINT `FK_fto_dors_assignment` FOREIGN KEY (`assignment_id`) REFERENCES `mdt_fto_assignments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_fto_dors_phase` FOREIGN KEY (`phase_id`) REFERENCES `mdt_fto_phases` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_weapon_ownership_history | resources/[standalone]/forge-police/sql/qbx.sql:4204
CREATE TABLE IF NOT EXISTS `mdt_weapon_ownership_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `serial` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weapon_model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weapon_class` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `information` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_mdt_weapon_history_serial` (`serial`),
  KEY `idx_mdt_weapon_history_owner` (`owner`),
  CONSTRAINT `FK_mdt_weapon_history_weapons` FOREIGN KEY (`serial`) REFERENCES `mdt_weapons` (`serial`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_twitter_likes | resources/[voice]/forge-npwd/import.sql:110
CREATE TABLE IF NOT EXISTS `npwd_twitter_likes` (
  `id`         int NOT NULL AUTO_INCREMENT,
  `profile_id` int NOT NULL,
  `tweet_id`   int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`profile_id`,`tweet_id`),
  KEY `profile_idx` (`profile_id`),
  KEY `tweet_idx` (`tweet_id`),
  CONSTRAINT `profile` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`),
  CONSTRAINT `tweet` FOREIGN KEY (`tweet_id`) REFERENCES `npwd_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- npwd_twitter_reports | resources/[voice]/forge-npwd/import.sql:181
CREATE TABLE IF NOT EXISTS `npwd_twitter_reports` (
  `id`         int NOT NULL AUTO_INCREMENT,
  `profile_id` int NOT NULL,
  `tweet_id`   int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`profile_id`,`tweet_id`),
  KEY `profile_idx` (`profile_id`),
  KEY `tweet_idx` (`tweet_id`),
  CONSTRAINT `report_profile` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`),
  CONSTRAINT `report_tweet` FOREIGN KEY (`tweet_id`) REFERENCES `npwd_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- mdt_fto_dor_ratings | resources/[standalone]/forge-police/sql/qbx.sql:4697
CREATE TABLE IF NOT EXISTS `mdt_fto_dor_ratings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `dor_id` int unsigned NOT NULL,
  `competency_id` int unsigned NOT NULL,
  `rating` int unsigned NOT NULL DEFAULT 3,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dor_id` (`dor_id`),
  KEY `competency_id` (`competency_id`),
  CONSTRAINT `FK_fto_dor_ratings_dor` FOREIGN KEY (`dor_id`) REFERENCES `mdt_fto_dors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_fto_dor_ratings_competency` FOREIGN KEY (`competency_id`) REFERENCES `mdt_fto_competencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dados iniciais dos recursos (catalogos/configuracao, sem dados de jogadores).

INSERT IGNORE INTO `mdt_settings` (`key`, `value`) VALUES
('jail_fines', '{"reductionOffers":[10,25,50],"maxFineAmount":100000}');

INSERT IGNORE INTO `mdt_penal_codes`
(`code`, `label`, `charge_class`, `months`, `fine`, `color`, `description`, `category`)
VALUES

('V.C. 1001','Estacionar em Local Proibido','infraction',0,130,'#15f943',
'Estacionar veículo em local onde a sinalização ou regulamentação proíba o estacionamento.',
'Veículos e Trânsito'),

('V.C. 1002','Estacionar Sobre a Calçada','infraction',0,195,'#15f943',
'Estacionar veículo sobre calçada, passeio público ou área destinada exclusivamente à circulação de pedestres.',
'Veículos e Trânsito'),

('V.C. 1003','Bloqueio de Garagem ou Acesso','infraction',0,130,'#15f943',
'Estacionar veículo impedindo ou dificultando a entrada ou saída de garagem, propriedade ou acesso autorizado.',
'Veículos e Trânsito'),

('V.C. 1004','Estacionar em Vaga Reservada','infraction',0,293,'#15f943',
'Estacionar em vaga reservada ou especial sem possuir autorização para sua utilização.',
'Veículos e Trânsito'),

('V.C. 1005','Obstrução da Circulação por Estacionamento','infraction',0,195,'#15f943',
'Estacionar veículo de forma a obstruir ou prejudicar a circulação normal de outros veículos.',
'Veículos e Trânsito'),

('V.C. 1006','Abandono de Veículo em Via Pública','infraction',0,195,'#15f943',
'Abandonar veículo em via pública de forma irregular ou prejudicando o trânsito.',
'Veículos e Trânsito'),

('V.C. 1007','Parada Irregular no Meio da Via','infraction',0,130,'#15f943',
'Parar veículo no meio da via sem motivo justificável, emergência ou necessidade relacionada ao trânsito.',
'Veículos e Trânsito'),

('V.C. 1008','Parar Sobre Faixa de Pedestres','infraction',0,130,'#15f943',
'Parar veículo sobre faixa destinada à travessia de pedestres.',
'Veículos e Trânsito'),

('V.C. 1009','Avanço de Sinal Vermelho','infraction',0,293,'#15f943',
'Avançar sinal vermelho de semáforo ou dispositivo equivalente de controle de tráfego.',
'Veículos e Trânsito'),

('V.C. 1010','Desrespeito à Parada Obrigatória','infraction',0,293,'#15f943',
'Deixar de realizar parada obrigatória diante de placa, sinalização ou dispositivo que determine a parada.',
'Veículos e Trânsito'),

('V.C. 1011','Desobediência à Ordem de Agente de Trânsito','infraction',0,195,'#15f943',
'Deixar de cumprir determinação legítima de agente público responsável pelo controle ou fiscalização do trânsito.',
'Veículos e Trânsito'),

('V.C. 1012','Condução na Contramão','infraction',0,195,'#15f943',
'Conduzir veículo no sentido contrário ao fluxo regulamentado da via.',
'Veículos e Trânsito'),

('V.C. 1013','Conversão Proibida','infraction',0,195,'#15f943',
'Realizar conversão em local onde a manobra seja proibida pela sinalização ou regulamentação.',
'Veículos e Trânsito'),

('V.C. 1014','Retorno em Local Proibido','infraction',0,195,'#15f943',
'Realizar retorno em local onde a manobra seja proibida ou represente risco ao trânsito.',
'Veículos e Trânsito'),

('V.C. 1015','Condução Sobre Calçada ou Área de Pedestres','infraction',0,880,'#15f943',
'Conduzir veículo sobre calçada, passeio público ou espaço destinado exclusivamente a pedestres sem justificativa.',
'Veículos e Trânsito'),

('V.C. 1016','Ultrapassagem em Local Proibido','infraction',0,1467,'#15f943',
'Realizar ultrapassagem em trecho, faixa ou situação onde a manobra seja proibida.',
'Veículos e Trânsito'),

('V.C. 1017','Ultrapassagem Pelo Acostamento','infraction',0,1467,'#15f943',
'Utilizar acostamento ou área não destinada à circulação regular para realizar ultrapassagem.',
'Veículos e Trânsito'),

('V.C. 1018','Forçar Passagem Entre Veículos','infraction',0,2935,'#15f943',
'Forçar passagem entre veículos ou contra fluxo contrário, colocando terceiros em situação de risco.',
'Veículos e Trânsito'),

('V.C. 1019','Não Dar Preferência ao Pedestre','infraction',0,195,'#15f943',
'Deixar de conceder preferência de passagem a pedestre quando exigido pelas regras de trânsito.',
'Veículos e Trânsito'),

('V.C. 1020','Direção Ameaçadora','felony',5,293,'#f9b115',
'Conduzir veículo de forma deliberadamente ameaçadora contra pedestres, ciclistas ou outros veículos.',
'Veículos e Trânsito'),

('V.C. 1021','Excesso de Velocidade Até 20%','infraction',0,130,'#15f943',
'Conduzir veículo acima do limite regulamentado da via em percentual de até vinte por cento.',
'Veículos e Trânsito'),

('V.C. 1022','Excesso de Velocidade de 20% a 50%','infraction',0,195,'#15f943',
'Conduzir veículo acima do limite regulamentado da via em percentual superior a vinte e de até cinquenta por cento.',
'Veículos e Trânsito'),

('V.C. 1023','Excesso de Velocidade Superior a 50%','infraction',0,880,'#15f943',
'Conduzir veículo em velocidade superior a cinquenta por cento acima do limite regulamentado da via.',
'Veículos e Trânsito'),

('V.C. 1024','Velocidade Incompatível com o Local','infraction',0,195,'#15f943',
'Conduzir veículo em velocidade incompatível com as condições da via, fluxo, visibilidade ou segurança do local.',
'Veículos e Trânsito'),

('V.C. 1025','Arrancada Brusca ou Manobra Perigosa','infraction',0,2935,'#15f943',
'Realizar arrancada brusca, aceleração agressiva ou outra manobra deliberadamente perigosa em via pública.',
'Veículos e Trânsito'),

('V.C. 1026','Drift ou Derrapagem em Via Pública','infraction',0,2935,'#15f943',
'Provocar intencionalmente derrapagem, deslizamento ou drift em via pública, colocando o trânsito em risco.',
'Veículos e Trânsito'),

('V.C. 1027','Manobra Perigosa','infraction',0,2935,'#15f943',
'Realizar manobra com veículo capaz de gerar risco relevante a pedestres, passageiros ou demais condutores.',
'Veículos e Trânsito'),

('V.C. 1028','Empinar Motocicleta','infraction',0,293,'#15f943',
'Conduzir motocicleta utilizando apenas uma roda ou realizando manobra semelhante em via pública.',
'Veículos e Trânsito'),

('V.C. 1029','Disputa de Corrida ou Racha','felony',15,2935,'#f9b115',
'Participar de corrida, disputa automobilística ou competição de velocidade não autorizada em via pública.',
'Veículos e Trânsito'),

('V.C. 1030','Organização de Corrida Ilegal','felony',20,2935,'#f9b115',
'Promover, organizar ou coordenar corrida, racha ou competição automobilística ilegal em via pública.',
'Veículos e Trânsito'),

('V.C. 1031','Participação em Competição Automobilística Ilegal','felony',10,2935,'#f9b115',
'Participar de evento ou competição automobilística não autorizada realizada em via pública.',
'Veículos e Trânsito'),

('V.C. 1032','Bloqueio de Via para Evento Ilegal','misdemeanor',10,5869,'#f91521',
'Bloquear ou restringir deliberadamente via pública para realização de corrida, encontro ou evento automobilístico ilegal.',
'Veículos e Trânsito'),

('V.C. 1033','Condução Sob Influência de Álcool','felony',15,2935,'#f9b115',
'Conduzir veículo sob influência de bebida alcoólica em condições capazes de comprometer a capacidade de direção.',
'Veículos e Trânsito'),

('V.C. 1034','Condução Sob Influência de Drogas','felony',20,2935,'#f9b115',
'Conduzir veículo sob influência de droga ou substância psicoativa capaz de comprometer a capacidade de direção.',
'Veículos e Trânsito'),

('V.C. 1035','Conduzir Sem Habilitação','infraction',0,880,'#15f943',
'Conduzir veículo automotor sem possuir habilitação válida exigida para a categoria correspondente.',
'Veículos e Trânsito'),

('V.C. 1036','Conduzir com Habilitação Suspensa ou Cassada','felony',5,880,'#f9b115',
'Conduzir veículo enquanto o direito de dirigir estiver suspenso, cassado ou legalmente impedido.',
'Veículos e Trânsito'),

('V.C. 1037','Conduzir Veículo Sem Placa','infraction',0,293,'#15f943',
'Conduzir veículo sem placa de identificação obrigatória ou sem elemento necessário para sua identificação.',
'Veículos e Trânsito'),

('V.C. 1038','Uso de Placa Falsa ou Adulterada','felony',20,5000,'#f9b115',
'Utilizar, instalar ou manter em circulação veículo com placa falsa, clonada, adulterada ou pertencente a outro veículo.',
'Veículos e Trânsito'),

('V.C. 1039','Condução de Veículo Roubado ou Furtado','felony',35,7500,'#f9b115',
'Conduzir ou manter sob posse veículo com conhecimento de que seja produto de roubo ou furto.',
'Veículos e Trânsito'),

('V.C. 1040','Adulteração de Identificação Veicular','felony',30,7500,'#f9b115',
'Adulterar, remover, substituir ou modificar elemento utilizado para identificação oficial de veículo.',
'Veículos e Trânsito'),

('V.C. 1041','Fuga de Abordagem Policial','felony',20,5000,'#f9b115',
'Utilizar veículo para fugir deliberadamente de ordem legítima de parada ou abordagem realizada por autoridade policial.',
'Veículos e Trânsito'),

('V.C. 1042','Rompimento de Bloqueio Policial','felony',15,293,'#f9b115',
'Romper, atravessar ou desobedecer bloqueio policial ou ponto de fiscalização devidamente estabelecido.',
'Veículos e Trânsito'),

('V.C. 1043','Uso de Veículo para Ameaçar Terceiros','felony',30,7500,'#f9b115',
'Utilizar veículo deliberadamente como instrumento para ameaçar, intimidar, ferir ou colocar terceiros em grave risco.',
'Veículos e Trânsito'),

('V.C. 1044','Evasão do Local de Acidente','felony',10,1467,'#f9b115',
'Abandonar ou evadir-se do local de acidente de trânsito com objetivo de evitar responsabilização ou identificação.',
'Veículos e Trânsito'),

('V.C. 1045','Omissão de Socorro em Acidente','felony',20,1467,'#f9b115',
'Deixar injustificadamente de prestar ou solicitar assistência necessária após envolvimento em acidente com pessoa ferida.',
'Veículos e Trânsito'),

('V.C. 1046','Transporte de Drogas Ilícitas em Veículo','felony',50,10000,'#f9b115',
'Transportar ou ocultar substâncias ilícitas dentro de veículo com conhecimento de sua existência.',
'Veículos e Trânsito'),

('V.C. 1047','Veículo Utilizado para Tráfico de Drogas','felony',70,15000,'#f9b115',
'Utilizar veículo para transportar, distribuir, entregar ou auxiliar atividade relacionada ao tráfico de substâncias ilícitas.',
'Veículos e Trânsito'),

('V.C. 1048','Transporte de Armamento Ilegal','felony',60,12500,'#f9b115',
'Transportar ou ocultar em veículo arma, armamento ou munição cuja posse ou circulação seja ilegal.',
'Veículos e Trânsito'),

('V.C. 1049','Veículo Utilizado na Prática de Crime','felony',40,10000,'#f9b115',
'Utilizar veículo como meio, instrumento, apoio ou mecanismo de fuga durante a prática de atividade criminosa.',
'Veículos e Trânsito'),

('V.C. 1050','Bloqueio Veicular de Operação Policial','felony',30,7500,'#f9b115',
'Utilizar veículo deliberadamente para bloquear, impedir, dificultar ou interferir em operação ou perseguição policial.',
'Veículos e Trânsito');

INSERT IGNORE INTO `mdt_penal_code_tags`
(`charge_code`, `tag_id`)
VALUES

 ('V.C. 1001', 8),

 ('V.C. 1002', 8),

 ('V.C. 1003', 8),

 ('V.C. 1004', 8),

 ('V.C. 1005', 8),

 ('V.C. 1006', 8),

 ('V.C. 1007', 8),

 ('V.C. 1008', 8),

 ('V.C. 1009', 8),

 ('V.C. 1010', 8),

 ('V.C. 1011', 8),

 ('V.C. 1012', 8),

 ('V.C. 1013', 8),

 ('V.C. 1014', 8),

 ('V.C. 1015', 8),

 ('V.C. 1016', 8),

 ('V.C. 1017', 8),

 ('V.C. 1018', 8),

 ('V.C. 1019', 8),

 ('V.C. 1020', 3),
('V.C. 1020', 8),

 ('V.C. 1021', 8),

 ('V.C. 1022', 8),

 ('V.C. 1023', 8),

 ('V.C. 1024', 8),

 ('V.C. 1025', 8),

 ('V.C. 1026', 8),

 ('V.C. 1027', 8),

 ('V.C. 1028', 8),

 ('V.C. 1029', 3),
('V.C. 1029', 8),

 ('V.C. 1030', 3),
('V.C. 1030', 8),

 ('V.C. 1031', 3),
('V.C. 1031', 8),

 ('V.C. 1032', 2),
('V.C. 1032', 8),

 ('V.C. 1033', 3),
('V.C. 1033', 8),

 ('V.C. 1034', 3),
('V.C. 1034', 8),

 ('V.C. 1035', 8),

 ('V.C. 1036', 3),
('V.C. 1036', 8),

 ('V.C. 1037', 8),

 ('V.C. 1038', 3),
('V.C. 1038', 8),

 ('V.C. 1039', 3),
('V.C. 1039', 5),
('V.C. 1039', 6),

 ('V.C. 1040', 3),
('V.C. 1040', 8),

 ('V.C. 1041', 3),
('V.C. 1041', 8),

 ('V.C. 1042', 3),
('V.C. 1042', 8),

 ('V.C. 1043', 3),
('V.C. 1043', 8),

 ('V.C. 1044', 3),
('V.C. 1044', 8),

 ('V.C. 1045', 3),
('V.C. 1045', 8),

 ('V.C. 1046', 3),

 ('V.C. 1047', 3),

 ('V.C. 1048', 3),

 ('V.C. 1049', 3),

 ('V.C. 1050', 3),
('V.C. 1050', 8);

INSERT IGNORE INTO `mdt_penal_codes`
(`code`, `label`, `charge_class`, `months`, `fine`, `color`, `description`, `category`)
VALUES

('C.O.P. 2001','Perturbação do Sossego','misdemeanor',2,500,'#f91521',
'Perturbar injustificadamente o sossego de terceiros por meio de gritaria, algazarra, som excessivo ou comportamento semelhante.',
'Civil e Ordem Pública'),

('C.O.P. 2002','Perturbação da Ordem Pública','misdemeanor',3,750,'#f91521',
'Provocar tumulto, confusão ou comportamento desordeiro capaz de prejudicar a tranquilidade ou a ordem em espaço público.',
'Civil e Ordem Pública'),

('C.O.P. 2003','Desordem em Local Público','misdemeanor',3,750,'#f91521',
'Adotar comportamento desordeiro em rua, praça, estabelecimento ou outro local de acesso público, causando perturbação relevante.',
'Civil e Ordem Pública'),

('C.O.P. 2004','Provocação de Tumulto','misdemeanor',5,1000,'#f91521',
'Iniciar, incentivar ou contribuir deliberadamente para tumulto ou desordem envolvendo várias pessoas.',
'Civil e Ordem Pública'),

('C.O.P. 2005','Aglomeração com Recusa de Dispersão','misdemeanor',5,1000,'#f91521',
'Permanecer em aglomeração que esteja causando risco ou grave desordem após ordem legítima de dispersão.',
'Civil e Ordem Pública'),

('C.O.P. 2006','Obstrução de Via ou Passagem Pública','infraction',0,500,'#15f943',
'Bloquear injustificadamente via, calçada, passagem ou outro espaço destinado à circulação pública.',
'Civil e Ordem Pública'),

('C.O.P. 2007','Obstrução de Entrada ou Saída','infraction',0,500,'#15f943',
'Bloquear injustificadamente entrada, saída, portão ou acesso de estabelecimento, residência ou instalação.',
'Civil e Ordem Pública'),

('C.O.P. 2008','Invasão de Propriedade Privada','misdemeanor',7,1500,'#f91521',
'Entrar ou permanecer deliberadamente em propriedade privada sem autorização do proprietário ou responsável.',
'Civil e Ordem Pública'),

('C.O.P. 2009','Recusa em Deixar Propriedade Privada','misdemeanor',5,1000,'#f91521',
'Recusar-se a deixar propriedade privada após determinação legítima do proprietário, responsável ou pessoa autorizada.',
'Civil e Ordem Pública'),

('C.O.P. 2010','Invasão de Área Restrita','misdemeanor',10,2000,'#f91521',
'Entrar ou permanecer sem autorização em área devidamente identificada como restrita ou de acesso controlado.',
'Civil e Ordem Pública'),

('C.O.P. 2011','Invasão de Instalação Governamental','felony',20,4000,'#f9b115',
'Entrar ou permanecer sem autorização em área restrita de instalação governamental, policial ou administrativa.',
'Civil e Ordem Pública'),

('C.O.P. 2012','Invasão de Área de Emergência','misdemeanor',8,1500,'#f91521',
'Entrar ou permanecer injustificadamente em área isolada em razão de acidente, incêndio, operação policial ou emergência.',
'Civil e Ordem Pública'),

('C.O.P. 2013','Desobediência a Ordem Legal','misdemeanor',7,1500,'#f91521',
'Recusar-se deliberadamente a cumprir ordem legítima emitida por autoridade pública no exercício de suas funções.',
'Civil e Ordem Pública'),

('C.O.P. 2014','Resistência Não Violenta','misdemeanor',10,2000,'#f91521',
'Resistir ou dificultar de forma não violenta abordagem, detenção ou procedimento legal realizado por autoridade competente.',
'Civil e Ordem Pública'),

('C.O.P. 2015','Resistência à Prisão','felony',15,3000,'#f9b115',
'Resistir deliberadamente ao cumprimento de prisão ou detenção legal mediante força física, fuga ativa ou oposição relevante.',
'Civil e Ordem Pública'),

('C.O.P. 2016','Obstrução do Trabalho de Agente Público','misdemeanor',10,2000,'#f91521',
'Impedir, atrasar ou dificultar deliberadamente o exercício legítimo das funções de agente público.',
'Civil e Ordem Pública'),

('C.O.P. 2017','Interferência em Abordagem Policial','misdemeanor',10,2000,'#f91521',
'Interferir injustificadamente em abordagem, revista, detenção ou outro procedimento policial envolvendo terceiros.',
'Civil e Ordem Pública'),

('C.O.P. 2018','Interferência em Operação Policial','felony',20,4000,'#f9b115',
'Interferir deliberadamente em operação policial de forma capaz de impedir, comprometer ou dificultar sua execução.',
'Civil e Ordem Pública'),

('C.O.P. 2019','Interferência em Serviço de Emergência','misdemeanor',10,2000,'#f91521',
'Dificultar deliberadamente atuação de bombeiros, paramédicos ou outros profissionais durante atendimento de emergência.',
'Civil e Ordem Pública'),

('C.O.P. 2020','Interferência em Cena de Crime','felony',20,5000,'#f9b115',
'Entrar, alterar, manipular ou interferir deliberadamente em local preservado como cena de crime ou investigação.',
'Civil e Ordem Pública'),

('C.O.P. 2021','Remoção de Barreira ou Isolamento Oficial','misdemeanor',8,1500,'#f91521',
'Remover, deslocar ou inutilizar barreira, fita ou equipamento de isolamento colocado por autoridade competente.',
'Civil e Ordem Pública'),

('C.O.P. 2022','Falsa Identificação','misdemeanor',10,2000,'#f91521',
'Fornecer deliberadamente nome, identificação ou informação pessoal falsa a autoridade durante procedimento oficial.',
'Civil e Ordem Pública'),

('C.O.P. 2023','Uso Indevido da Identidade de Terceiro','felony',20,5000,'#f9b115',
'Utilizar intencionalmente identidade ou dados de outra pessoa com objetivo de enganar terceiros, obter vantagem ou evitar responsabilização.',
'Civil e Ordem Pública'),

('C.O.P. 2024','Falsidade para Obtenção de Benefício','felony',25,7500,'#f9b115',
'Utilizar informação, declaração ou identidade falsa com objetivo de obter dinheiro, bem, serviço, benefício ou vantagem indevida.',
'Civil e Ordem Pública'),

('C.O.P. 2025','Falsa Comunicação de Crime','misdemeanor',12,2500,'#f91521',
'Comunicar deliberadamente a autoridade ocorrência criminosa que sabe não ter acontecido.',
'Civil e Ordem Pública'),

('C.O.P. 2026','Falsa Comunicação de Emergência','misdemeanor',12,2500,'#f91521',
'Acionar deliberadamente serviço de emergência comunicando situação inexistente.',
'Civil e Ordem Pública'),

('C.O.P. 2027','Falso Alarme','misdemeanor',10,2000,'#f91521',
'Provocar deliberadamente falso alarme capaz de gerar pânico, evacuação ou mobilização indevida de serviços públicos.',
'Civil e Ordem Pública'),

('C.O.P. 2028','Uso Abusivo de Serviço de Emergência','infraction',0,1000,'#15f943',
'Utilizar serviço de emergência de forma deliberadamente abusiva ou para finalidade incompatível com sua função.',
'Civil e Ordem Pública'),

('C.O.P. 2029','Fingir Ser Agente Público','felony',30,7500,'#f9b115',
'Apresentar-se falsamente como policial, agente público ou integrante de serviço oficial com intenção de exercer autoridade ou obter vantagem.',
'Civil e Ordem Pública'),

('C.O.P. 2030','Uso Indevido de Uniforme ou Distintivo Oficial','felony',20,5000,'#f9b115',
'Utilizar sem autorização uniforme, distintivo, identificação ou símbolo oficial capaz de induzir terceiros a acreditar que o usuário exerce função pública.',
'Civil e Ordem Pública'),

('C.O.P. 2031','Posse Indevida de Equipamento Oficial','misdemeanor',10,2500,'#f91521',
'Possuir sem autorização equipamento de uso oficial de órgão público ou serviço de emergência sem justificativa legítima.',
'Civil e Ordem Pública'),

('C.O.P. 2032','Vandalismo','misdemeanor',10,2000,'#f91521',
'Danificar, quebrar, pichar ou deteriorar deliberadamente patrimônio pertencente a terceiro.',
'Civil e Ordem Pública'),

('C.O.P. 2033','Dano ao Patrimônio Público','felony',20,5000,'#f9b115',
'Danificar deliberadamente prédio, veículo, equipamento, mobiliário ou outro patrimônio pertencente ao poder público.',
'Civil e Ordem Pública'),

('C.O.P. 2034','Dano a Equipamento de Emergência','felony',25,7500,'#f9b115',
'Danificar, inutilizar ou interferir deliberadamente em equipamento destinado à segurança ou atendimento de emergência.',
'Civil e Ordem Pública'),

('C.O.P. 2035','Descarte Irregular de Resíduos','infraction',0,500,'#15f943',
'Descartar lixo, resíduos ou materiais em via pública ou local não autorizado.',
'Civil e Ordem Pública'),

('C.O.P. 2036','Queima Irregular em Área Pública','infraction',0,750,'#15f943',
'Realizar fogueira ou queima não autorizada em área pública ou urbana.',
'Civil e Ordem Pública'),

('C.O.P. 2037','Lançamento Perigoso de Objetos','misdemeanor',5,1000,'#f91521',
'Lançar objeto em via ou espaço público de maneira capaz de causar dano, acidente ou risco a terceiros.',
'Civil e Ordem Pública'),

('C.O.P. 2038','Embriaguez com Perturbação Pública','misdemeanor',5,1000,'#f91521',
'Encontrar-se sob efeito de álcool em espaço público e, em razão disso, provocar desordem, risco ou perturbação relevante.',
'Civil e Ordem Pública'),

('C.O.P. 2039','Consumo de Álcool em Local Proibido','infraction',0,500,'#15f943',
'Consumir bebida alcoólica em local onde seu consumo esteja expressamente proibido pelas normas da cidade.',
'Civil e Ordem Pública'),

('C.O.P. 2040','Comportamento Agressivo em Público','misdemeanor',7,1500,'#f91521',
'Adotar comportamento deliberadamente hostil ou agressivo capaz de causar temor ou perturbação relevante a terceiros.',
'Civil e Ordem Pública'),

('C.O.P. 2041','Intimidação','misdemeanor',10,2000,'#f91521',
'Intimidar deliberadamente outra pessoa mediante comportamento, palavras ou ações capazes de gerar temor razoável.',
'Civil e Ordem Pública'),

('C.O.P. 2042','Ameaça','felony',15,3000,'#f9b115',
'Ameaçar pessoa de causar mal injusto e relevante de maneira capaz de produzir temor razoável.',
'Civil e Ordem Pública'),

('C.O.P. 2043','Coação','felony',20,5000,'#f9b115',
'Constranger pessoa mediante ameaça, intimidação ou violência a fazer, deixar de fazer ou tolerar algo contra sua vontade.',
'Civil e Ordem Pública'),

('C.O.P. 2044','Perseguição Insistente','felony',20,4000,'#f9b115',
'Perseguir reiteradamente pessoa, restringindo sua liberdade ou causando temor por sua segurança.',
'Civil e Ordem Pública'),

('C.O.P. 2045','Assédio ou Importunação Persistente','misdemeanor',10,2000,'#f91521',
'Importunar, seguir ou abordar reiteradamente pessoa após manifestação clara de que a conduta é indesejada.',
'Civil e Ordem Pública'),

('C.O.P. 2046','Solicitação Agressiva de Dinheiro ou Bens','misdemeanor',5,1000,'#f91521',
'Solicitar dinheiro, bens ou vantagem utilizando intimidação, perseguição, ameaça ou impedimento da passagem.',
'Civil e Ordem Pública'),

('C.O.P. 2047','Fraude na Solicitação de Doações','felony',15,5000,'#f9b115',
'Utilizar história, identidade, instituição ou finalidade deliberadamente falsa para induzir terceiros a realizar doação ou entregar valores.',
'Civil e Ordem Pública'),

('C.O.P. 2048','Obtenção de Serviço Mediante Fraude','felony',15,5000,'#f9b115',
'Obter serviço, acesso ou benefício mediante fraude, falsa identidade ou outro meio enganoso com intenção de não cumprir a obrigação correspondente.',
'Civil e Ordem Pública'),

('C.O.P. 2049','Apropriação de Bem Encontrado','misdemeanor',7,1500,'#f91521',
'Apropriar-se deliberadamente de bem encontrado pertencente a terceiro sem adotar medida razoável para devolução quando seu proprietário puder ser identificado.',
'Civil e Ordem Pública'),

('C.O.P. 2050','Subtração de Bem em Situação de Desordem','felony',20,5000,'#f9b115',
'Subtrair bem pertencente a terceiro aproveitando-se de tumulto, emergência, acidente ou situação de desordem pública.',
'Civil e Ordem Pública');

INSERT IGNORE INTO `mdt_penal_code_tags`
(`charge_code`, `tag_id`)
VALUES

  ('C.O.P. 2001', 2),

  ('C.O.P. 2002', 2),

  ('C.O.P. 2003', 2),

  ('C.O.P. 2004', 2),

  ('C.O.P. 2005', 2),

  ('C.O.P. 2006', 8),

  ('C.O.P. 2007', 8),

  ('C.O.P. 2008', 2),

  ('C.O.P. 2009', 2),

  ('C.O.P. 2010', 2),

  ('C.O.P. 2011', 3),

  ('C.O.P. 2012', 2),
('C.O.P. 2012', 8),

  ('C.O.P. 2013', 2),

  ('C.O.P. 2014', 2),

  ('C.O.P. 2015', 3),

  ('C.O.P. 2016', 2),

  ('C.O.P. 2017', 2),

  ('C.O.P. 2018', 3),

  ('C.O.P. 2019', 2),

  ('C.O.P. 2020', 3),

  ('C.O.P. 2021', 2),
('C.O.P. 2021', 8),

  ('C.O.P. 2022', 2),

  ('C.O.P. 2023', 3),
('C.O.P. 2023', 7),

  ('C.O.P. 2024', 3),
('C.O.P. 2024', 7),

  ('C.O.P. 2025', 2),

  ('C.O.P. 2026', 2),

  ('C.O.P. 2027', 2),

  ('C.O.P. 2028', 8),

  ('C.O.P. 2029', 3),
('C.O.P. 2029', 7),

  ('C.O.P. 2030', 3),
('C.O.P. 2030', 7),

  ('C.O.P. 2031', 2),

  ('C.O.P. 2032', 2),

  ('C.O.P. 2033', 3),

  ('C.O.P. 2034', 3),

  ('C.O.P. 2035', 8),

  ('C.O.P. 2036', 8),

  ('C.O.P. 2037', 2),

  ('C.O.P. 2038', 2),

  ('C.O.P. 2039', 8),

  ('C.O.P. 2040', 2),

  ('C.O.P. 2041', 2),

  ('C.O.P. 2042', 3),

  ('C.O.P. 2043', 3),

  ('C.O.P. 2044', 3),

  ('C.O.P. 2045', 2),

  ('C.O.P. 2046', 2),

  ('C.O.P. 2047', 3),
('C.O.P. 2047', 7),

  ('C.O.P. 2048', 3),
('C.O.P. 2048', 7),

  ('C.O.P. 2049', 2),
('C.O.P. 2049', 6),

  ('C.O.P. 2050', 3),
('C.O.P. 2050', 6);

INSERT IGNORE INTO `mdt_penal_codes`
(`code`, `label`, `charge_class`, `months`, `fine`, `color`, `description`, `category`)
VALUES

('P.C. 3001','Agressão Simples','misdemeanor',7,1500,'#f91521',
'Agredir fisicamente outra pessoa causando lesão de pequena gravidade, sem emprego de arma ou circunstância agravante.',
'Crimes Penais'),

('P.C. 3002','Lesão Corporal','felony',15,3000,'#f9b115',
'Ofender deliberadamente a integridade corporal ou a saúde de outra pessoa causando lesão relevante.',
'Crimes Penais'),

('P.C. 3003','Lesão Corporal Grave','felony',30,6000,'#f9b115',
'Causar deliberadamente lesão grave, incapacitante ou que represente risco significativo à vida da vítima.',
'Crimes Penais'),

('P.C. 3004','Lesão Corporal com Arma','felony',35,7500,'#f9b115',
'Agredir ou ferir outra pessoa utilizando arma de fogo, arma branca ou outro instrumento potencialmente letal.',
'Crimes Penais'),

('P.C. 3005','Agressão em Grupo','felony',25,5000,'#f9b115',
'Participar juntamente com duas ou mais pessoas de agressão deliberada contra uma vítima.',
'Crimes Penais'),

('P.C. 3006','Ameaça','misdemeanor',10,2000,'#f91521',
'Ameaçar outra pessoa de causar mal injusto e relevante de modo capaz de produzir temor razoável.',
'Crimes Penais'),

('P.C. 3007','Ameaça com Arma','felony',20,4000,'#f9b115',
'Ameaçar ou intimidar outra pessoa utilizando arma ou instrumento capaz de causar morte ou lesão grave.',
'Crimes Penais'),

('P.C. 3008','Intimidação Criminal','misdemeanor',12,2500,'#f91521',
'Utilizar ameaça, perseguição ou comportamento intimidatório para provocar temor ou constranger outra pessoa.',
'Crimes Penais'),

('P.C. 3009','Coação','felony',20,4000,'#f9b115',
'Constranger alguém mediante violência ou grave ameaça a realizar, deixar de realizar ou tolerar determinada conduta.',
'Crimes Penais'),

('P.C. 3010','Coação Mediante Arma','felony',30,6000,'#f9b115',
'Constranger outra pessoa mediante ameaça ou violência utilizando arma de fogo, arma branca ou instrumento equivalente.',
'Crimes Penais'),

('P.C. 3011','Perseguição','felony',20,3500,'#f9b115',
'Perseguir reiteradamente outra pessoa causando temor, restringindo sua liberdade ou perturbando gravemente sua privacidade.',
'Crimes Penais'),

('P.C. 3012','Sequestro','felony',50,10000,'#f9b115',
'Privar deliberadamente outra pessoa de sua liberdade mediante força, ameaça, fraude ou retenção contra sua vontade.',
'Crimes Penais'),

('P.C. 3013','Sequestro Agravado','felony',80,17500,'#f9b115',
'Praticar sequestro mediante uso de arma, violência grave, participação de múltiplos autores ou prolongada privação de liberdade.',
'Crimes Penais'),

('P.C. 3014','Cárcere Privado','felony',40,7500,'#f9b115',
'Manter pessoa confinada, presa ou impedida de deixar determinado local contra sua vontade.',
'Crimes Penais'),

('P.C. 3015','Tomada de Refém','felony',90,20000,'#f9b115',
'Manter pessoa sob domínio ou privação de liberdade com objetivo de exigir condição, vantagem ou impedir ação de terceiros.',
'Crimes Penais'),

('P.C. 3016','Tortura','felony',90,20000,'#f9b115',
'Submeter pessoa intencionalmente a sofrimento físico ou mental grave com finalidade de punição, intimidação, obtenção de informação ou confissão.',
'Crimes Penais'),

('P.C. 3017','Maus-Tratos','felony',20,3500,'#f9b115',
'Submeter pessoa sob responsabilidade, autoridade ou cuidado a tratamento cruel, abusivo ou incompatível com sua segurança.',
'Crimes Penais'),

('P.C. 3018','Abandono de Pessoa Vulnerável','felony',25,5000,'#f9b115',
'Abandonar pessoa que esteja sob responsabilidade do agente e que não possua condições adequadas de proteger-se dos riscos decorrentes do abandono.',
'Crimes Penais'),

('P.C. 3019','Omissão de Socorro','misdemeanor',10,2000,'#f91521',
'Deixar injustificadamente de prestar ou solicitar auxílio possível a pessoa em situação evidente de grave perigo.',
'Crimes Penais'),

('P.C. 3020','Exposição da Vida de Terceiro a Perigo','felony',20,4000,'#f9b115',
'Praticar deliberadamente conduta que exponha outra pessoa a risco concreto e relevante de morte ou lesão grave.',
'Crimes Penais'),

('P.C. 3021','Incitação à Violência','felony',20,4000,'#f9b115',
'Incentivar deliberadamente terceiros a praticar violência contra pessoa ou grupo determinado.',
'Crimes Penais'),

('P.C. 3022','Participação em Briga Generalizada','misdemeanor',10,2000,'#f91521',
'Participar voluntariamente de confronto físico envolvendo diversas pessoas e capaz de causar lesões ou grave desordem.',
'Crimes Penais'),

('P.C. 3023','Incêndio Criminoso','felony',45,10000,'#f9b115',
'Provocar deliberadamente incêndio em imóvel, veículo ou estrutura colocando patrimônio ou pessoas em risco.',
'Crimes Penais'),

('P.C. 3024','Incêndio Criminoso com Risco à Vida','felony',70,15000,'#f9b115',
'Provocar deliberadamente incêndio em circunstâncias capazes de colocar diretamente uma ou mais pessoas em grave risco de morte.',
'Crimes Penais'),

('P.C. 3025','Explosão Criminosa','felony',70,17500,'#f9b115',
'Provocar deliberadamente explosão capaz de causar destruição relevante, lesões ou risco à vida de terceiros.',
'Crimes Penais'),

('P.C. 3026','Colocação Deliberada de Pessoa em Perigo','felony',25,5000,'#f9b115',
'Criar intencionalmente situação concreta de perigo grave para outra pessoa, ainda que não ocorra efetiva lesão.',
'Crimes Penais'),

('P.C. 3027','Envenenamento','felony',60,12500,'#f9b115',
'Administrar deliberadamente substância tóxica ou prejudicial a outra pessoa com intenção de causar dano à saúde.',
'Crimes Penais'),

('P.C. 3028','Envenenamento com Intenção de Matar','felony',100,25000,'#f9b115',
'Administrar deliberadamente substância tóxica ou letal a outra pessoa com intenção de provocar sua morte.',
'Crimes Penais'),

('P.C. 3029','Tentativa de Homicídio','felony',90,22500,'#f9b115',
'Praticar ato diretamente destinado a causar a morte de outra pessoa, não ocorrendo o resultado por circunstância alheia à vontade do agente.',
'Crimes Penais'),

('P.C. 3030','Tentativa de Homicídio Qualificado','felony',110,30000,'#f9b115',
'Tentar causar deliberadamente a morte de outra pessoa mediante circunstância especialmente grave, emboscada, crueldade ou outro meio qualificado.',
'Crimes Penais'),

('P.C. 3031','Homicídio Culposo','felony',45,10000,'#f9b115',
'Causar a morte de outra pessoa sem intenção de matar, em razão de imprudência, negligência ou imperícia relevante.',
'Crimes Penais'),

('P.C. 3032','Homicídio Doloso','felony',100,30000,'#f9b115',
'Causar deliberadamente a morte de outra pessoa com intenção de matar ou assumindo conscientemente o risco do resultado.',
'Crimes Penais'),

('P.C. 3033','Homicídio Qualificado','felony',120,50000,'#f9b115',
'Causar deliberadamente a morte de outra pessoa mediante circunstância especialmente grave, crueldade, emboscada ou recurso que dificulte sua defesa.',
'Crimes Penais'),

('P.C. 3034','Homicídio por Motivo Torpe','felony',120,50000,'#f9b115',
'Causar deliberadamente a morte de outra pessoa motivado por pagamento, recompensa ou razão especialmente desprezível.',
'Crimes Penais'),

('P.C. 3035','Homicídio Mediante Emboscada','felony',120,50000,'#f9b115',
'Causar deliberadamente a morte de outra pessoa mediante emboscada, surpresa ou recurso destinado a impedir ou dificultar sua defesa.',
'Crimes Penais'),

('P.C. 3036','Homicídio Mediante Crueldade','felony',120,50000,'#f9b115',
'Causar deliberadamente a morte de outra pessoa utilizando meio cruel ou capaz de provocar sofrimento desnecessário.',
'Crimes Penais'),

('P.C. 3037','Homicídio Múltiplo','felony',120,75000,'#f9b115',
'Causar deliberadamente a morte de duas ou mais pessoas durante o mesmo contexto criminoso.',
'Crimes Penais'),

('P.C. 3038','Participação em Homicídio','felony',90,25000,'#f9b115',
'Auxiliar, incentivar, facilitar ou participar conscientemente da execução de homicídio cometido por outra pessoa.',
'Crimes Penais'),

('P.C. 3039','Contratação de Homicídio','felony',120,75000,'#f9b115',
'Contratar, pagar, oferecer recompensa ou solicitar a terceiro a execução deliberada da morte de outra pessoa.',
'Crimes Penais'),

('P.C. 3040','Execução de Homicídio por Recompensa','felony',120,75000,'#f9b115',
'Causar deliberadamente a morte de outra pessoa em troca de dinheiro, benefício, recompensa ou promessa de vantagem.',
'Crimes Penais'),

('P.C. 3041','Ocultação de Pessoa Sequestrada','felony',50,10000,'#f9b115',
'Ocultar deliberadamente pessoa privada ilegalmente de liberdade ou auxiliar na manutenção de seu cativeiro.',
'Crimes Penais'),

('P.C. 3042','Auxílio a Sequestro','felony',40,7500,'#f9b115',
'Auxiliar conscientemente planejamento, execução, transporte, vigilância ou manutenção de pessoa sequestrada.',
'Crimes Penais'),

('P.C. 3043','Privação de Liberdade mediante Fraude','felony',35,7500,'#f9b115',
'Utilizar engano ou fraude para levar pessoa a situação em que seja posteriormente impedida de deixar determinado local.',
'Crimes Penais'),

('P.C. 3044','Administração de Substância sem Consentimento','felony',25,5000,'#f9b115',
'Administrar deliberadamente droga, medicamento ou outra substância capaz de alterar a consciência ou capacidade física de alguém sem seu consentimento.',
'Crimes Penais'),

('P.C. 3045','Violação Grave de Domicílio','felony',20,4000,'#f9b115',
'Invadir residência de terceiro mediante violência, ameaça, arrombamento ou com intenção de praticar outro crime.',
'Crimes Penais'),

('P.C. 3046','Confinamento mediante Ameaça','felony',30,6000,'#f9b115',
'Impedir pessoa de abandonar determinado local mediante ameaça grave, intimidação ou demonstração de força.',
'Crimes Penais'),

('P.C. 3047','Uso de Pessoa como Escudo Humano','felony',80,20000,'#f9b115',
'Utilizar pessoa contra sua vontade como proteção contra disparos, captura, intervenção policial ou ataque de terceiros.',
'Crimes Penais'),

('P.C. 3048','Colocação de Refém em Risco de Morte','felony',100,30000,'#f9b115',
'Expor deliberadamente pessoa mantida como refém a situação concreta e imediata de morte ou lesão gravíssima.',
'Crimes Penais'),

('P.C. 3049','Tentativa de Lesão Corporal Grave','felony',20,4000,'#f9b115',
'Praticar ato deliberadamente destinado a provocar lesão corporal grave, sem que o resultado se concretize.',
'Crimes Penais'),

('P.C. 3050','Participação em Agressão Criminosa','felony',15,3000,'#f9b115',
'Auxiliar, incentivar ou facilitar conscientemente agressão criminosa praticada por outra pessoa.',
'Crimes Penais');

INSERT IGNORE INTO `mdt_penal_code_tags`
(`charge_code`, `tag_id`)
VALUES

  ('P.C. 3001', 2),

  ('P.C. 3002', 3),

  ('P.C. 3003', 3),

  ('P.C. 3004', 3),

  ('P.C. 3005', 3),

  ('P.C. 3006', 2),

  ('P.C. 3007', 3),

  ('P.C. 3008', 2),

  ('P.C. 3009', 3),

  ('P.C. 3010', 3),

  ('P.C. 3011', 3),

  ('P.C. 3012', 3),

  ('P.C. 3013', 3),

  ('P.C. 3014', 3),

  ('P.C. 3015', 3),

  ('P.C. 3016', 3),

  ('P.C. 3017', 3),

  ('P.C. 3018', 3),

  ('P.C. 3019', 2),

  ('P.C. 3020', 3),

  ('P.C. 3021', 3),

  ('P.C. 3022', 2),

  ('P.C. 3023', 3),

  ('P.C. 3024', 3),

  ('P.C. 3025', 3),

  ('P.C. 3026', 3),

  ('P.C. 3027', 3),

  ('P.C. 3028', 3),
('P.C. 3028', 4),

  ('P.C. 3029', 3),
('P.C. 3029', 4),

  ('P.C. 3030', 3),
('P.C. 3030', 4),

  ('P.C. 3031', 3),
('P.C. 3031', 4),

  ('P.C. 3032', 3),
('P.C. 3032', 4),

  ('P.C. 3033', 3),
('P.C. 3033', 4),

  ('P.C. 3034', 3),
('P.C. 3034', 4),

  ('P.C. 3035', 3),
('P.C. 3035', 4),

  ('P.C. 3036', 3),
('P.C. 3036', 4),

  ('P.C. 3037', 3),
('P.C. 3037', 4),

  ('P.C. 3038', 3),
('P.C. 3038', 4),

  ('P.C. 3039', 3),
('P.C. 3039', 4),

  ('P.C. 3040', 3),
('P.C. 3040', 4),

  ('P.C. 3041', 3),

  ('P.C. 3042', 3),

  ('P.C. 3043', 3),

  ('P.C. 3044', 3),

  ('P.C. 3045', 3),

  ('P.C. 3046', 3),

  ('P.C. 3047', 3),

  ('P.C. 3048', 3),

  ('P.C. 3049', 3),

  ('P.C. 3050', 3);

INSERT IGNORE INTO `mdt_penal_codes`
(`code`, `label`, `charge_class`, `months`, `fine`, `color`, `description`, `category`)
VALUES

('PAT. 4001','Furto Simples','felony',15,3000,'#f9b115',
'Subtrair para si ou para terceiro bem móvel pertencente a outra pessoa, sem emprego de violência ou grave ameaça.',
'Crimes Patrimoniais'),

('PAT. 4002','Furto de Pequeno Valor','misdemeanor',7,1500,'#f91521',
'Subtrair bem móvel de pequeno valor pertencente a terceiro, sem emprego de violência ou grave ameaça.',
'Crimes Patrimoniais'),

('PAT. 4003','Furto Qualificado','felony',25,5000,'#f9b115',
'Praticar furto mediante arrombamento, destruição de obstáculo, fraude, abuso de confiança ou outro meio especialmente elaborado.',
'Crimes Patrimoniais'),

('PAT. 4004','Furto em Residência','felony',30,6000,'#f9b115',
'Subtrair bem pertencente a terceiro no interior de residência, apartamento ou propriedade utilizada como moradia.',
'Crimes Patrimoniais'),

('PAT. 4005','Furto em Estabelecimento Comercial','felony',20,4000,'#f9b115',
'Subtrair mercadoria, dinheiro ou outro bem pertencente a estabelecimento comercial sem emprego de violência.',
'Crimes Patrimoniais'),

('PAT. 4006','Furto de Veículo','felony',35,7500,'#f9b115',
'Subtrair veículo automotor pertencente a terceiro sem emprego de violência ou grave ameaça.',
'Crimes Patrimoniais'),

('PAT. 4007','Furto de Motocicleta','felony',30,6000,'#f9b115',
'Subtrair motocicleta pertencente a terceiro sem emprego de violência ou grave ameaça.',
'Crimes Patrimoniais'),

('PAT. 4008','Furto de Peças de Veículo','felony',20,4000,'#f9b115',
'Subtrair rodas, componentes, equipamentos ou outras peças instaladas em veículo pertencente a terceiro.',
'Crimes Patrimoniais'),

('PAT. 4009','Furto de Carga','felony',35,8000,'#f9b115',
'Subtrair mercadorias ou bens transportados como carga sem emprego direto de violência contra pessoa.',
'Crimes Patrimoniais'),

('PAT. 4010','Furto de Equipamento Público','felony',30,7500,'#f9b115',
'Subtrair equipamento, material ou bem pertencente a órgão ou serviço público.',
'Crimes Patrimoniais'),

('PAT. 4011','Furto mediante Abuso de Confiança','felony',25,5000,'#f9b115',
'Subtrair bem pertencente a terceiro aproveitando-se de relação de confiança, emprego, acesso autorizado ou responsabilidade concedida.',
'Crimes Patrimoniais'),

('PAT. 4012','Furto mediante Fraude','felony',30,6500,'#f9b115',
'Utilizar fraude ou artifício para possibilitar ou facilitar a subtração de bem pertencente a terceiro.',
'Crimes Patrimoniais'),

('PAT. 4013','Tentativa de Furto','misdemeanor',10,2000,'#f91521',
'Iniciar deliberadamente a subtração de bem pertencente a terceiro sem consumar o furto por circunstância alheia à vontade do agente.',
'Crimes Patrimoniais'),

('PAT. 4014','Roubo Simples','felony',35,7500,'#f9b115',
'Subtrair bem pertencente a outra pessoa mediante violência, ameaça ou intimidação.',
'Crimes Patrimoniais'),

('PAT. 4015','Roubo à Mão Armada','felony',55,12500,'#f9b115',
'Subtrair bem pertencente a terceiro mediante emprego ou exibição de arma para ameaçar ou dominar a vítima.',
'Crimes Patrimoniais'),

('PAT. 4016','Roubo com Violência','felony',50,10000,'#f9b115',
'Subtrair bem pertencente a terceiro utilizando violência física contra a vítima.',
'Crimes Patrimoniais'),

('PAT. 4017','Roubo em Residência','felony',55,12500,'#f9b115',
'Invadir ou permanecer em residência com objetivo de subtrair bens mediante violência ou grave ameaça aos ocupantes.',
'Crimes Patrimoniais'),

('PAT. 4018','Roubo a Estabelecimento Comercial','felony',45,10000,'#f9b115',
'Subtrair dinheiro, mercadorias ou outros bens de estabelecimento comercial mediante violência ou grave ameaça.',
'Crimes Patrimoniais'),

('PAT. 4019','Roubo de Veículo','felony',55,12500,'#f9b115',
'Subtrair veículo pertencente a terceiro mediante violência, ameaça ou intimidação contra seu proprietário ou ocupante.',
'Crimes Patrimoniais'),

('PAT. 4020','Roubo de Carga','felony',60,15000,'#f9b115',
'Subtrair carga ou mercadorias em transporte mediante violência, ameaça ou domínio sobre motorista ou responsáveis.',
'Crimes Patrimoniais'),

('PAT. 4021','Roubo a Caixa Eletrônico','felony',55,15000,'#f9b115',
'Subtrair ou tentar subtrair valores existentes em caixa eletrônico mediante rompimento, violência ou método criminoso equivalente.',
'Crimes Patrimoniais'),

('PAT. 4022','Roubo a Banco','felony',80,25000,'#f9b115',
'Subtrair valores, bens ou ativos pertencentes a instituição bancária mediante violência, ameaça ou ação criminosa organizada.',
'Crimes Patrimoniais'),

('PAT. 4023','Roubo de Valores em Transporte','felony',70,20000,'#f9b115',
'Subtrair dinheiro ou valores durante transporte, escolta ou movimentação mediante violência ou grave ameaça.',
'Crimes Patrimoniais'),

('PAT. 4024','Roubo em Grupo','felony',60,15000,'#f9b115',
'Praticar roubo com participação consciente de duas ou mais pessoas atuando conjuntamente.',
'Crimes Patrimoniais'),

('PAT. 4025','Tentativa de Roubo','felony',30,6000,'#f9b115',
'Iniciar execução de roubo mediante violência ou grave ameaça sem conseguir efetivar a subtração pretendida.',
'Crimes Patrimoniais'),

('PAT. 4026','Latrocínio','felony',120,75000,'#f9b115',
'Provocar a morte de pessoa durante ou em razão da prática de roubo patrimonial.',
'Crimes Patrimoniais'),

('PAT. 4027','Tentativa de Latrocínio','felony',100,50000,'#f9b115',
'Praticar roubo acompanhado de conduta diretamente destinada a causar a morte da vítima, não ocorrendo o resultado morte.',
'Crimes Patrimoniais'),

('PAT. 4028','Extorsão','felony',40,10000,'#f9b115',
'Constranger pessoa mediante violência ou grave ameaça a entregar dinheiro, bem, direito ou vantagem econômica.',
'Crimes Patrimoniais'),

('PAT. 4029','Extorsão mediante Arma','felony',55,15000,'#f9b115',
'Constranger pessoa mediante utilização de arma para obter dinheiro, bem ou vantagem econômica indevida.',
'Crimes Patrimoniais'),

('PAT. 4030','Extorsão mediante Sequestro','felony',90,30000,'#f9b115',
'Privar pessoa de sua liberdade com objetivo de exigir pagamento, resgate ou vantagem patrimonial.',
'Crimes Patrimoniais'),

('PAT. 4031','Apropriação Indébita','felony',20,5000,'#f9b115',
'Apropriar-se deliberadamente de dinheiro ou bem recebido legitimamente, passando a tratá-lo como próprio sem autorização.',
'Crimes Patrimoniais'),

('PAT. 4032','Apropriação de Bem Encontrado','misdemeanor',7,1500,'#f91521',
'Apropriar-se de bem encontrado pertencente a terceiro quando for possível identificar ou localizar seu proprietário.',
'Crimes Patrimoniais'),

('PAT. 4033','Desvio de Bem Confiado','felony',25,6000,'#f9b115',
'Desviar, vender, ocultar ou utilizar em benefício próprio bem confiado para guarda, transporte ou administração.',
'Crimes Patrimoniais'),

('PAT. 4034','Estelionato','felony',30,7500,'#f9b115',
'Obter vantagem econômica ilícita induzindo ou mantendo outra pessoa em erro mediante fraude ou artifício.',
'Crimes Patrimoniais'),

('PAT. 4035','Estelionato mediante Falsa Identidade','felony',35,10000,'#f9b115',
'Utilizar identidade falsa ou identidade de terceiro para induzir vítima em erro e obter vantagem patrimonial.',
'Crimes Patrimoniais'),

('PAT. 4036','Fraude em Compra ou Venda','felony',25,6000,'#f9b115',
'Enganar deliberadamente comprador ou vendedor sobre bem, preço, pagamento ou condições de negócio para obter vantagem indevida.',
'Crimes Patrimoniais'),

('PAT. 4037','Fraude em Serviço','felony',20,5000,'#f9b115',
'Obter ou fornecer serviço mediante engano deliberado com intenção de obter vantagem patrimonial ilícita.',
'Crimes Patrimoniais'),

('PAT. 4038','Golpe de Falso Pagamento','felony',30,7500,'#f9b115',
'Apresentar pagamento, comprovante ou transferência falsa com objetivo de obter produto, dinheiro ou serviço.',
'Crimes Patrimoniais'),

('PAT. 4039','Fraude Bancária','felony',45,12500,'#f9b115',
'Utilizar fraude, dados falsos ou meio enganoso para movimentar, obter ou desviar valores pertencentes a instituição financeira ou terceiro.',
'Crimes Patrimoniais'),

('PAT. 4040','Fraude com Cartão ou Meio de Pagamento','felony',35,10000,'#f9b115',
'Utilizar cartão, conta, credencial ou meio de pagamento de forma fraudulenta para obter vantagem patrimonial.',
'Crimes Patrimoniais'),

('PAT. 4041','Fraude em Empréstimo','felony',30,7500,'#f9b115',
'Utilizar informações ou documentos falsos para obter empréstimo, crédito ou vantagem financeira.',
'Crimes Patrimoniais'),

('PAT. 4042','Fraude em Seguro','felony',30,7500,'#f9b115',
'Criar, simular ou alterar situação com objetivo de receber indevidamente pagamento ou benefício decorrente de seguro.',
'Crimes Patrimoniais'),

('PAT. 4043','Venda Fraudulenta de Bem','felony',30,7500,'#f9b115',
'Vender ou oferecer bem inexistente, pertencente a terceiro ou cuja situação seja deliberadamente ocultada para obter vantagem econômica.',
'Crimes Patrimoniais'),

('PAT. 4044','Receptação','felony',25,6000,'#f9b115',
'Adquirir, receber, transportar, ocultar ou manter bem sabendo que é produto de crime patrimonial.',
'Crimes Patrimoniais'),

('PAT. 4045','Receptação de Veículo','felony',35,10000,'#f9b115',
'Adquirir, receber, ocultar ou manter veículo sabendo que é produto de roubo ou furto.',
'Crimes Patrimoniais'),

('PAT. 4046','Comercialização de Produto Roubado ou Furtado','felony',35,10000,'#f9b115',
'Vender, trocar ou distribuir conscientemente bem proveniente de roubo ou furto.',
'Crimes Patrimoniais'),

('PAT. 4047','Dano ao Patrimônio Privado','misdemeanor',10,2500,'#f91521',
'Destruir, danificar ou inutilizar deliberadamente bem pertencente a outra pessoa.',
'Crimes Patrimoniais'),

('PAT. 4048','Dano Patrimonial Grave','felony',25,7500,'#f9b115',
'Destruir ou danificar deliberadamente patrimônio de elevado valor ou causar prejuízo econômico significativo.',
'Crimes Patrimoniais'),

('PAT. 4049','Destruição de Veículo de Terceiro','felony',25,7500,'#f9b115',
'Destruir, incendiar ou inutilizar deliberadamente veículo pertencente a terceiro.',
'Crimes Patrimoniais'),

('PAT. 4050','Ocultação ou Destruição de Bem para Fraudar Proprietário','felony',30,10000,'#f9b115',
'Ocultar, destruir, transferir ou simular situação envolvendo bem patrimonial com objetivo de enganar proprietário ou terceiro e obter vantagem econômica.',
'Crimes Patrimoniais');

INSERT IGNORE INTO `mdt_penal_code_tags`
(`charge_code`, `tag_id`)
VALUES

  ('PAT. 4001', 3),
('PAT. 4001', 6),

  ('PAT. 4002', 2),
('PAT. 4002', 6),

  ('PAT. 4003', 3),
('PAT. 4003', 6),

  ('PAT. 4004', 3),
('PAT. 4004', 6),

  ('PAT. 4005', 3),
('PAT. 4005', 6),

  ('PAT. 4006', 3),
('PAT. 4006', 6),

  ('PAT. 4007', 3),
('PAT. 4007', 6),

  ('PAT. 4008', 3),
('PAT. 4008', 6),

  ('PAT. 4009', 3),
('PAT. 4009', 6),

  ('PAT. 4010', 3),
('PAT. 4010', 6),

  ('PAT. 4011', 3),
('PAT. 4011', 6),

  ('PAT. 4012', 3),
('PAT. 4012', 6),
('PAT. 4012', 7),

  ('PAT. 4013', 2),
('PAT. 4013', 6),

  ('PAT. 4014', 3),
('PAT. 4014', 5),

  ('PAT. 4015', 3),
('PAT. 4015', 5),

  ('PAT. 4016', 3),
('PAT. 4016', 5),

  ('PAT. 4017', 3),
('PAT. 4017', 5),

  ('PAT. 4018', 3),
('PAT. 4018', 5),

  ('PAT. 4019', 3),
('PAT. 4019', 5),

  ('PAT. 4020', 3),
('PAT. 4020', 5),

  ('PAT. 4021', 3),
('PAT. 4021', 5),

  ('PAT. 4022', 3),
('PAT. 4022', 5),

  ('PAT. 4023', 3),
('PAT. 4023', 5),

  ('PAT. 4024', 3),
('PAT. 4024', 5),

  ('PAT. 4025', 3),
('PAT. 4025', 5),

  ('PAT. 4026', 3),
('PAT. 4026', 5),
('PAT. 4026', 4),

  ('PAT. 4027', 3),
('PAT. 4027', 5),
('PAT. 4027', 4),

  ('PAT. 4028', 3),

  ('PAT. 4029', 3),

  ('PAT. 4030', 3),

  ('PAT. 4031', 3),

  ('PAT. 4032', 2),
('PAT. 4032', 6),

  ('PAT. 4033', 3),

  ('PAT. 4034', 3),
('PAT. 4034', 7),

  ('PAT. 4035', 3),
('PAT. 4035', 7),

  ('PAT. 4036', 3),
('PAT. 4036', 7),

  ('PAT. 4037', 3),
('PAT. 4037', 7),

  ('PAT. 4038', 3),
('PAT. 4038', 7),

  ('PAT. 4039', 3),
('PAT. 4039', 7),

  ('PAT. 4040', 3),
('PAT. 4040', 7),

  ('PAT. 4041', 3),
('PAT. 4041', 7),

  ('PAT. 4042', 3),
('PAT. 4042', 7),

  ('PAT. 4043', 3),
('PAT. 4043', 7),

  ('PAT. 4044', 3),
('PAT. 4044', 5),
('PAT. 4044', 6),

  ('PAT. 4045', 3),
('PAT. 4045', 5),
('PAT. 4045', 6),

  ('PAT. 4046', 3),
('PAT. 4046', 5),
('PAT. 4046', 6),

  ('PAT. 4047', 2),

  ('PAT. 4048', 3),

  ('PAT. 4049', 3),

  ('PAT. 4050', 3),
('PAT. 4050', 7);

INSERT IGNORE INTO `mdt_penal_codes`
(`code`, `label`, `charge_class`, `months`, `fine`, `color`, `description`, `category`)
VALUES

('A.M. 5001','Posse Irregular de Arma de Fogo','misdemeanor',10,2500,'#f91521',
'Manter arma de fogo em residência, propriedade ou local sob responsabilidade do agente sem registro, autorização ou documentação exigida pelas normas da cidade.',
'Armas e Munições'),

('A.M. 5002','Posse Irregular de Arma Registrada em Nome de Terceiro','misdemeanor',12,3000,'#f91521',
'Manter sob posse arma de fogo regularmente registrada, porém pertencente a terceiro, sem autorização legítima para sua guarda.',
'Armas e Munições'),

('A.M. 5003','Posse de Arma com Registro Vencido','infraction',0,1500,'#15f943',
'Manter arma de fogo cujo registro, licença ou documentação obrigatória esteja vencida, sem indício de utilização criminosa.',
'Armas e Munições'),

('A.M. 5004','Posse de Arma em Local Não Autorizado','misdemeanor',8,2000,'#f91521',
'Manter arma de fogo em local não autorizado pela licença ou registro aplicável.',
'Armas e Munições'),

('A.M. 5005','Arma Registrada sem Comprovação de Propriedade','infraction',0,1000,'#15f943',
'Não apresentar comprovação válida de registro ou propriedade de arma encontrada em local sob responsabilidade do agente.',
'Armas e Munições'),

('A.M. 5006','Porte Ilegal de Arma de Fogo','felony',25,6000,'#f9b115',
'Transportar, carregar ou portar arma de fogo em via pública ou local de acesso público sem autorização válida para porte.',
'Armas e Munições'),

('A.M. 5007','Porte de Arma com Licença Vencida','misdemeanor',10,2500,'#f91521',
'Portar arma de fogo em espaço público utilizando autorização de porte vencida ou irregular.',
'Armas e Munições'),

('A.M. 5008','Porte de Arma Fora das Condições Autorizadas','misdemeanor',10,2500,'#f91521',
'Portar arma de fogo em situação, local ou condição expressamente vedada pela autorização concedida.',
'Armas e Munições'),

('A.M. 5009','Porte Oculto Ilegal de Arma','felony',25,6500,'#f9b115',
'Portar deliberadamente arma de fogo de forma oculta sem autorização legal para porte.',
'Armas e Munições'),

('A.M. 5010','Porte Ostensivo Ilegal de Arma','felony',20,5500,'#f9b115',
'Portar ou exibir arma de fogo ostensivamente em espaço público sem autorização compatível.',
'Armas e Munições'),

('A.M. 5011','Porte de Arma em Área Restrita','felony',30,7500,'#f9b115',
'Ingressar ou permanecer armado sem autorização em instalação policial, governamental, hospitalar ou outra área oficialmente restrita.',
'Armas e Munições'),

('A.M. 5012','Porte de Arma Durante Evento Público','felony',20,5000,'#f9b115',
'Portar arma de fogo sem autorização específica durante evento, reunião ou situação de grande concentração de pessoas.',
'Armas e Munições'),

('A.M. 5013','Porte de Arma Sob Influência de Álcool','felony',25,6000,'#f9b115',
'Portar arma de fogo enquanto estiver sob influência de álcool em condição capaz de comprometer discernimento ou segurança.',
'Armas e Munições'),

('A.M. 5014','Porte de Arma Sob Influência de Drogas','felony',30,7500,'#f9b115',
'Portar arma de fogo enquanto estiver sob influência de substância psicoativa capaz de comprometer discernimento ou segurança.',
'Armas e Munições'),

('A.M. 5015','Posse de Arma com Numeração Suprimida','felony',40,10000,'#f9b115',
'Possuir arma de fogo cuja numeração, marcação ou elemento oficial de identificação tenha sido removido, raspado ou inutilizado.',
'Armas e Munições'),

('A.M. 5016','Porte de Arma com Numeração Suprimida','felony',50,12500,'#f9b115',
'Portar arma de fogo em espaço público com número de série ou identificação oficial adulterada, removida ou suprimida.',
'Armas e Munições'),

('A.M. 5017','Adulteração de Número de Série de Arma','felony',55,15000,'#f9b115',
'Raspar, remover, alterar, substituir ou adulterar deliberadamente número de série ou identificação oficial de arma de fogo.',
'Armas e Munições'),

('A.M. 5018','Posse de Arma Furtada','felony',40,10000,'#f9b115',
'Possuir, guardar ou manter arma de fogo sabendo ou devendo razoavelmente saber que é produto de furto.',
'Armas e Munições'),

('A.M. 5019','Posse de Arma Roubada','felony',45,12500,'#f9b115',
'Possuir, guardar ou manter arma de fogo sabendo ou devendo razoavelmente saber que é produto de roubo.',
'Armas e Munições'),

('A.M. 5020','Porte de Arma Furtada ou Roubada','felony',55,15000,'#f9b115',
'Portar arma de fogo em espaço público sabendo que o armamento é produto de roubo ou furto.',
'Armas e Munições'),

('A.M. 5021','Empréstimo Irregular de Arma','misdemeanor',12,3000,'#f91521',
'Entregar ou emprestar arma de fogo a pessoa não autorizada a possuir ou portar aquele armamento.',
'Armas e Munições'),

('A.M. 5022','Cessão de Arma a Pessoa Não Habilitada','felony',20,5000,'#f9b115',
'Fornecer, ceder ou disponibilizar arma de fogo a pessoa sem autorização legal ou capacidade exigida para seu uso.',
'Armas e Munições'),

('A.M. 5023','Entrega de Arma a Pessoa Intoxicada','felony',30,7500,'#f9b115',
'Entregar conscientemente arma de fogo a pessoa sob efeito evidente de álcool ou drogas.',
'Armas e Munições'),

('A.M. 5024','Negligência na Guarda de Arma','misdemeanor',8,2000,'#f91521',
'Deixar arma de fogo armazenada de maneira negligente, permitindo acesso indevido ou criando risco relevante a terceiros.',
'Armas e Munições'),

('A.M. 5025','Abandono de Arma de Fogo','felony',15,4000,'#f9b115',
'Abandonar deliberadamente arma de fogo em local público ou acessível a terceiros sem providenciar sua guarda adequada.',
'Armas e Munições'),

('A.M. 5026','Perda de Arma sem Comunicação','infraction',0,1500,'#15f943',
'Deixar de comunicar em prazo razoável a perda, extravio ou desaparecimento de arma regularmente registrada.',
'Armas e Munições'),

('A.M. 5027','Posse Irregular de Munição','misdemeanor',5,1500,'#f91521',
'Possuir munição de arma de fogo sem autorização compatível ou sem vínculo legítimo com arma regularmente possuída.',
'Armas e Munições'),

('A.M. 5028','Porte Irregular de Munição','misdemeanor',7,2000,'#f91521',
'Transportar munição em espaço público sem autorização ou justificativa legítima.',
'Armas e Munições'),

('A.M. 5029','Posse de Munição de Calibre Não Autorizado','felony',15,4000,'#f9b115',
'Possuir munição de calibre ou categoria cuja aquisição ou posse não esteja autorizada ao agente.',
'Armas e Munições'),

('A.M. 5030','Posse de Grande Quantidade de Munição sem Autorização','felony',20,5000,'#f9b115',
'Manter quantidade anormalmente elevada de munições sem autorização, origem legítima ou justificativa compatível.',
'Armas e Munições'),

('A.M. 5031','Comércio Ilegal de Munições','felony',45,12500,'#f9b115',
'Vender, trocar, fornecer ou distribuir munições sem autorização legal.',
'Armas e Munições'),

('A.M. 5032','Comércio Ilegal de Armas','felony',60,17500,'#f9b115',
'Vender, comprar para revenda, trocar ou distribuir armas de fogo sem autorização legal.',
'Armas e Munições'),

('A.M. 5033','Tráfico de Armas','felony',90,30000,'#f9b115',
'Participar de atividade organizada destinada à aquisição, transporte, armazenamento ou distribuição ilegal de armas de fogo.',
'Armas e Munições'),

('A.M. 5034','Tráfico de Munições','felony',75,25000,'#f9b115',
'Participar de atividade organizada destinada à aquisição, transporte ou distribuição ilegal de munições.',
'Armas e Munições'),

('A.M. 5035','Fabricação Ilegal de Arma de Fogo','felony',70,22500,'#f9b115',
'Fabricar, montar ou produzir arma de fogo sem licença ou autorização competente.',
'Armas e Munições'),

('A.M. 5036','Modificação Ilegal de Arma','felony',40,10000,'#f9b115',
'Modificar deliberadamente mecanismo ou características de arma de fogo de forma proibida ou destinada a dificultar sua identificação.',
'Armas e Munições'),

('A.M. 5037','Conversão Ilegal de Arma','felony',55,15000,'#f9b115',
'Alterar arma ou dispositivo para modificar ilegalmente sua capacidade de disparo ou categoria de funcionamento.',
'Armas e Munições'),

('A.M. 5038','Fabricação Ilegal de Munição','felony',45,12500,'#f9b115',
'Produzir ou montar munições sem autorização, licença ou controle exigido.',
'Armas e Munições'),

('A.M. 5039','Documentação Falsa de Arma','felony',35,10000,'#f9b115',
'Criar, utilizar, apresentar ou manter documento falso destinado a aparentar registro, propriedade ou autorização legítima de arma.',
'Armas e Munições'),

('A.M. 5040','Fraude para Obtenção de Porte ou Registro','felony',40,12500,'#f9b115',
'Utilizar declaração, documento, identidade ou informação falsa para obter registro, licença ou autorização relacionada a arma de fogo.',
'Armas e Munições'),

('A.M. 5041','Exibição Ameaçadora de Arma','felony',20,5000,'#f9b115',
'Exibir, apontar ou manipular arma de fogo de maneira deliberadamente intimidatória sem justificativa legítima.',
'Armas e Munições'),

('A.M. 5042','Apontar Arma contra Terceiro','felony',30,7500,'#f9b115',
'Apontar deliberadamente arma de fogo contra outra pessoa sem situação legítima de defesa ou atuação autorizada.',
'Armas e Munições'),

('A.M. 5043','Disparo de Arma em Local Público','felony',30,7500,'#f9b115',
'Efetuar disparo de arma de fogo em via ou local público sem justificativa legítima, independentemente de atingir pessoa.',
'Armas e Munições'),

('A.M. 5044','Disparo Negligente de Arma','felony',20,5000,'#f9b115',
'Efetuar disparo de arma de fogo por imprudência, negligência ou manuseio inadequado, criando risco a terceiros.',
'Armas e Munições'),

('A.M. 5045','Disparo Intencional em Direção a Pessoa','felony',70,20000,'#f9b115',
'Efetuar deliberadamente disparo de arma de fogo na direção de outra pessoa, sem que seja possível comprovar resultado morte.',
'Armas e Munições'),

('A.M. 5046','Tentativa de Homicídio com Arma de Fogo','felony',100,30000,'#f9b115',
'Utilizar arma de fogo com intenção direta de causar a morte de outra pessoa, não ocorrendo o resultado por circunstância alheia à vontade do agente.',
'Armas e Munições'),

('A.M. 5047','Homicídio com Arma de Fogo','felony',120,50000,'#f9b115',
'Causar deliberadamente a morte de outra pessoa mediante utilização de arma de fogo.',
'Armas e Munições'),

('A.M. 5048','Disparo contra Veículo Ocupado','felony',65,17500,'#f9b115',
'Efetuar deliberadamente disparo contra veículo sabendo ou tendo razoável conhecimento de que há pessoas em seu interior.',
'Armas e Munições'),

('A.M. 5049','Disparo contra Residência Ocupada','felony',65,17500,'#f9b115',
'Efetuar deliberadamente disparos contra residência ou imóvel sabendo que existem pessoas em seu interior.',
'Armas e Munições'),

('A.M. 5050','Uso de Arma na Prática de Crime','felony',35,10000,'#f9b115',
'Portar, exibir ou utilizar arma de fogo como instrumento para facilitar, garantir ou executar outra atividade criminosa.',
'Armas e Munições'),

('A.M. 5051','Fornecimento de Arma para Prática de Crime','felony',45,12500,'#f9b115',
'Fornecer conscientemente arma de fogo a terceiro sabendo que será utilizada na prática de atividade criminosa.',
'Armas e Munições'),

('A.M. 5052','Ocultação de Arma Utilizada em Crime','felony',30,7500,'#f9b115',
'Ocultar, transportar, destruir ou esconder arma sabendo que ela foi utilizada em atividade criminosa.',
'Armas e Munições'),

('A.M. 5053','Destruição ou Alteração de Arma para Ocultar Evidência','felony',40,10000,'#f9b115',
'Destruir, desmontar ou modificar arma utilizada em crime com objetivo de impedir sua identificação ou perícia.',
'Armas e Munições'),

('A.M. 5054','Falsa Comunicação de Furto ou Roubo de Arma','felony',25,7500,'#f9b115',
'Comunicar falsamente furto, roubo ou desaparecimento de arma com objetivo de ocultar sua transferência, venda, perda ou utilização irregular.',
'Armas e Munições'),

('A.M. 5055','Arsenal Ilegal','felony',85,30000,'#f9b115',
'Manter sob posse ou controle conjunto relevante de armas e munições ilegais em quantidade incompatível com uso pessoal autorizado.',
'Armas e Munições');

INSERT IGNORE INTO `mdt_penal_code_tags`
(`charge_code`, `tag_id`)
VALUES

  ('A.M. 5001', 2),

  ('A.M. 5002', 2),

  ('A.M. 5003', 8),

  ('A.M. 5004', 2),

  ('A.M. 5005', 8),

  ('A.M. 5006', 3),

  ('A.M. 5007', 2),
('A.M. 5007', 8),

  ('A.M. 5008', 2),
('A.M. 5008', 8),

  ('A.M. 5009', 3),

  ('A.M. 5010', 3),

  ('A.M. 5011', 3),

  ('A.M. 5012', 3),

  ('A.M. 5013', 3),

  ('A.M. 5014', 3),

  ('A.M. 5015', 3),

  ('A.M. 5016', 3),

  ('A.M. 5017', 3),

  ('A.M. 5018', 3),
('A.M. 5018', 6),

  ('A.M. 5019', 3),
('A.M. 5019', 5),

  ('A.M. 5020', 3),
('A.M. 5020', 5),
('A.M. 5020', 6),

  ('A.M. 5021', 2),

  ('A.M. 5022', 3),

  ('A.M. 5023', 3),

  ('A.M. 5024', 2),

  ('A.M. 5025', 3),

  ('A.M. 5026', 8),

  ('A.M. 5027', 2),

  ('A.M. 5028', 2),

  ('A.M. 5029', 3),

  ('A.M. 5030', 3),

  ('A.M. 5031', 3),

  ('A.M. 5032', 3),

  ('A.M. 5033', 3),

  ('A.M. 5034', 3),

  ('A.M. 5035', 3),

  ('A.M. 5036', 3),

  ('A.M. 5037', 3),

  ('A.M. 5038', 3),

  ('A.M. 5039', 3),
('A.M. 5039', 7),

  ('A.M. 5040', 3),
('A.M. 5040', 7),

  ('A.M. 5041', 3),

  ('A.M. 5042', 3),

  ('A.M. 5043', 3),

  ('A.M. 5044', 3),

  ('A.M. 5045', 3),

  ('A.M. 5046', 3),
('A.M. 5046', 4),

  ('A.M. 5047', 3),
('A.M. 5047', 4),

  ('A.M. 5048', 3),

  ('A.M. 5049', 3),

  ('A.M. 5050', 3),

  ('A.M. 5051', 3),

  ('A.M. 5052', 3),

  ('A.M. 5053', 3),

  ('A.M. 5054', 3),
('A.M. 5054', 7),
('A.M. 5054', 5),
('A.M. 5054', 6),

  ('A.M. 5055', 3);

INSERT IGNORE INTO `mdt_penal_codes`
(`code`, `label`, `charge_class`, `months`, `fine`, `color`, `description`, `category`)
VALUES

('D.S.I. 6001','Posse de Pequena Quantidade de Substância Ilícita','misdemeanor',5,1500,'#f91521',
'Possuir pequena quantidade de substância ilícita destinada aparentemente a consumo pessoal, sem indício de comercialização.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6002','Posse de Substância Ilícita','felony',10,3000,'#f9b115',
'Possuir quantidade relevante de substância ilícita sem autorização ou justificativa legítima.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6003','Posse de Múltiplas Substâncias Ilícitas','felony',15,4000,'#f9b115',
'Possuir simultaneamente duas ou mais substâncias ilícitas distintas em quantidade relevante.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6004','Posse de Substância Ilícita em Área Pública','misdemeanor',7,2000,'#f91521',
'Portar ou manter substância ilícita em praça, rua, estabelecimento ou outro local de acesso público.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6005','Posse de Substância Ilícita em Área Restrita','felony',20,5000,'#f9b115',
'Portar substância ilícita em instalação policial, governamental, hospitalar ou outra área oficialmente restrita.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6006','Posse de Grande Quantidade de Substância Ilícita','felony',35,10000,'#f9b115',
'Possuir quantidade elevada de substância ilícita incompatível com simples consumo pessoal.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6007','Consumo de Substância Ilícita em Via Pública','misdemeanor',5,1500,'#f91521',
'Consumir substância ilícita em via pública ou local de acesso coletivo.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6008','Consumo de Substância Ilícita em Área Restrita','felony',15,4000,'#f9b115',
'Consumir substância ilícita em instalação ou área onde sua presença represente risco adicional à segurança.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6009','Consumo de Substância Ilícita Durante Atividade Profissional de Risco','felony',20,5000,'#f9b115',
'Consumir ou permanecer sob efeito de substância ilícita durante atividade profissional capaz de colocar terceiros em risco.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6010','Posse de Substância Ilícita para Distribuição','felony',35,10000,'#f9b115',
'Possuir substância ilícita em circunstâncias compatíveis com intenção de distribuição, entrega ou comercialização.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6011','Venda de Substância Ilícita','felony',50,15000,'#f9b115',
'Vender ou comercializar substância ilícita a outra pessoa.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6012','Distribuição de Substância Ilícita','felony',45,12500,'#f9b115',
'Distribuir, fornecer ou entregar substância ilícita, ainda que sem recebimento direto de pagamento.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6013','Tráfico de Drogas','felony',70,25000,'#f9b115',
'Participar de atividade organizada ou habitual de comercialização, distribuição ou fornecimento de substâncias ilícitas.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6014','Tráfico de Drogas em Grande Escala','felony',100,40000,'#f9b115',
'Participar de operação de tráfico envolvendo grande quantidade, estrutura organizada ou ampla distribuição de substâncias ilícitas.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6015','Tráfico de Múltiplas Substâncias','felony',90,35000,'#f9b115',
'Comercializar ou distribuir de forma organizada diferentes tipos de substâncias ilícitas.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6016','Transporte de Substância Ilícita','felony',35,10000,'#f9b115',
'Transportar conscientemente substância ilícita para terceiro, grupo ou atividade criminosa.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6017','Transporte de Grande Quantidade de Drogas','felony',60,20000,'#f9b115',
'Transportar conscientemente grande quantidade de substância ilícita destinada à distribuição ou comercialização.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6018','Ocultação de Substância Ilícita','felony',25,7500,'#f9b115',
'Ocultar deliberadamente substância ilícita com objetivo de impedir sua localização, apreensão ou identificação.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6019','Armazenamento de Drogas para Terceiros','felony',35,10000,'#f9b115',
'Guardar conscientemente substâncias ilícitas pertencentes a terceiro ou organização criminosa.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6020','Manutenção de Depósito de Substâncias Ilícitas','felony',55,17500,'#f9b115',
'Manter imóvel ou local destinado ao armazenamento relevante de substâncias ilícitas para distribuição.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6021','Fornecimento de Local para Tráfico','felony',40,12500,'#f9b115',
'Disponibilizar conscientemente imóvel, estabelecimento ou propriedade para comercialização ou distribuição de drogas.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6022','Financiamento de Atividade de Tráfico','felony',70,25000,'#f9b115',
'Fornecer dinheiro ou recursos conscientemente destinados à manutenção ou expansão de atividade de tráfico de drogas.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6023','Administração de Atividade de Tráfico','felony',80,30000,'#f9b115',
'Coordenar, dirigir, organizar ou administrar conscientemente atividade destinada ao tráfico de substâncias ilícitas.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6024','Intermediação de Venda de Drogas','felony',35,10000,'#f9b115',
'Intermediar contato, negociação, pagamento ou entrega entre fornecedor e comprador de substância ilícita.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6025','Tentativa de Venda de Substância Ilícita','felony',30,7500,'#f9b115',
'Iniciar negociação ou ato diretamente destinado à comercialização de droga sem que a venda seja concluída.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6026','Oferta de Substância Ilícita','misdemeanor',10,3000,'#f91521',
'Oferecer substância ilícita a outra pessoa, ainda que a entrega ou venda não se concretize.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6027','Indução ao Consumo de Substância Ilícita','felony',20,5000,'#f9b115',
'Induzir, pressionar ou incentivar deliberadamente outra pessoa a consumir substância ilícita.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6028','Fornecimento de Droga sem Consentimento','felony',50,15000,'#f9b115',
'Administrar ou fornecer substância ilícita a pessoa sem seu conhecimento ou consentimento.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6029','Administração de Substância com Intenção de Incapacitar','felony',65,20000,'#f9b115',
'Administrar deliberadamente substância a outra pessoa com objetivo de reduzir sua capacidade de reação, consciência ou resistência.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6030','Administração de Substância com Intenção de Matar','felony',100,35000,'#f9b115',
'Administrar deliberadamente substância tóxica ou ilícita a outra pessoa com intenção direta de causar sua morte.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6031','Morte Causada por Administração Intencional de Substância','felony',120,50000,'#f9b115',
'Causar deliberadamente a morte de outra pessoa mediante administração de substância tóxica, ilícita ou adulterada.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6032','Venda de Substância Adulterada como Droga','felony',40,12500,'#f9b115',
'Vender substância adulterada, falsa ou diferente daquela anunciada com objetivo de obter vantagem econômica ilícita.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6033','Fraude na Comercialização de Substância','felony',35,10000,'#f9b115',
'Utilizar engano, falsa identidade, falsa quantidade ou informação fraudulenta para obter vantagem em negociação envolvendo substância ilícita.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6034','Venda Fictícia de Substância Ilícita','felony',30,7500,'#f9b115',
'Receber dinheiro ou vantagem prometendo entregar substância ilícita inexistente ou que não pretende fornecer.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6035','Falsificação de Receita ou Autorização Médica','felony',30,7500,'#f9b115',
'Criar, alterar ou utilizar documento médico falso para obter medicamento ou substância controlada.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6036','Uso Fraudulento de Receita de Terceiro','felony',25,6000,'#f9b115',
'Utilizar receita, autorização ou documento médico pertencente a terceiro para obter substância controlada.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6037','Obtenção Fraudulenta de Medicamento Controlado','felony',30,7500,'#f9b115',
'Obter medicamento controlado mediante declaração falsa, documento fraudulento ou outro meio enganoso.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6038','Posse Ilegal de Medicamento Controlado','misdemeanor',8,2000,'#f91521',
'Possuir medicamento ou substância controlada sem prescrição, autorização ou justificativa legítima exigida.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6039','Venda Ilegal de Medicamento Controlado','felony',40,12500,'#f9b115',
'Vender ou fornecer medicamento controlado sem autorização legal.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6040','Desvio de Medicamento Controlado','felony',35,10000,'#f9b115',
'Desviar medicamento controlado pertencente a hospital, farmácia, serviço médico ou terceiro para uso ou distribuição ilícita.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6041','Furto de Medicamento Controlado','felony',30,7500,'#f9b115',
'Subtrair medicamento ou substância controlada pertencente a hospital, farmácia, serviço médico ou terceiro.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6042','Roubo de Medicamento Controlado','felony',50,15000,'#f9b115',
'Subtrair medicamento ou substância controlada mediante violência, ameaça ou intimidação.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6043','Furto de Substância Ilícita','felony',25,6000,'#f9b115',
'Subtrair substância ilícita pertencente a terceiro sem emprego de violência ou grave ameaça.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6044','Roubo de Substância Ilícita','felony',45,12500,'#f9b115',
'Subtrair substância ilícita pertencente a terceiro mediante violência, ameaça ou intimidação.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6045','Receptação de Substância Ilícita Roubada ou Furtada','felony',30,7500,'#f9b115',
'Receber, guardar, transportar ou ocultar substância ilícita sabendo que foi obtida mediante roubo ou furto.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6046','Destruição ou Ocultação de Drogas para Evitar Apreensão','felony',25,7500,'#f9b115',
'Destruir, descartar ou ocultar deliberadamente substância ilícita com objetivo de impedir sua apreensão durante fiscalização ou investigação.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6047','Fornecimento de Informação Falsa sobre Origem de Substância','felony',20,5000,'#f9b115',
'Fornecer deliberadamente informação falsa sobre procedência, propriedade ou destino de substância ilícita para impedir responsabilização.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6048','Uso de Terceiro para Transporte de Drogas','felony',50,15000,'#f9b115',
'Utilizar conscientemente outra pessoa para transportar substância ilícita destinada à distribuição ou atividade criminosa.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6049','Participação em Organização de Tráfico','felony',85,30000,'#f9b115',
'Integrar conscientemente grupo estruturado destinado à produção, transporte, armazenamento, distribuição ou comercialização de substâncias ilícitas.',
'Drogas e Substâncias Ilícitas'),

('D.S.I. 6050','Comando de Organização de Tráfico','felony',120,50000,'#f9b115',
'Liderar, comandar ou exercer função de direção em organização destinada ao tráfico de substâncias ilícitas.',
'Drogas e Substâncias Ilícitas');

INSERT IGNORE INTO `mdt_penal_code_tags`
(`charge_code`, `tag_id`)
VALUES

  ('D.S.I. 6001', 2),

  ('D.S.I. 6002', 3),

  ('D.S.I. 6003', 3),

  ('D.S.I. 6004', 2),

  ('D.S.I. 6005', 3),

  ('D.S.I. 6006', 3),

  ('D.S.I. 6007', 2),

  ('D.S.I. 6008', 3),

  ('D.S.I. 6009', 3),

  ('D.S.I. 6010', 3),

  ('D.S.I. 6011', 3),

  ('D.S.I. 6012', 3),

  ('D.S.I. 6013', 3),

  ('D.S.I. 6014', 3),

  ('D.S.I. 6015', 3),

  ('D.S.I. 6016', 3),

  ('D.S.I. 6017', 3),

  ('D.S.I. 6018', 3),

  ('D.S.I. 6019', 3),

  ('D.S.I. 6020', 3),

  ('D.S.I. 6021', 3),

  ('D.S.I. 6022', 3),

  ('D.S.I. 6023', 3),

  ('D.S.I. 6024', 3),

  ('D.S.I. 6025', 3),

  ('D.S.I. 6026', 2),

  ('D.S.I. 6027', 3),

  ('D.S.I. 6028', 3),

  ('D.S.I. 6029', 3),

  ('D.S.I. 6030', 3),
('D.S.I. 6030', 4),

  ('D.S.I. 6031', 3),
('D.S.I. 6031', 4),

  ('D.S.I. 6032', 3),
('D.S.I. 6032', 7),

  ('D.S.I. 6033', 3),
('D.S.I. 6033', 7),

  ('D.S.I. 6034', 3),
('D.S.I. 6034', 7),

  ('D.S.I. 6035', 3),
('D.S.I. 6035', 7),

  ('D.S.I. 6036', 3),
('D.S.I. 6036', 7),

  ('D.S.I. 6037', 3),
('D.S.I. 6037', 7),

  ('D.S.I. 6038', 2),

  ('D.S.I. 6039', 3),

  ('D.S.I. 6040', 3),

  ('D.S.I. 6041', 3),
('D.S.I. 6041', 6),

  ('D.S.I. 6042', 3),
('D.S.I. 6042', 5),

  ('D.S.I. 6043', 3),
('D.S.I. 6043', 6),

  ('D.S.I. 6044', 3),
('D.S.I. 6044', 5),

  ('D.S.I. 6045', 3),
('D.S.I. 6045', 5),
('D.S.I. 6045', 6),

  ('D.S.I. 6046', 3),

  ('D.S.I. 6047', 3),
('D.S.I. 6047', 7),

  ('D.S.I. 6048', 3),

  ('D.S.I. 6049', 3),

  ('D.S.I. 6050', 3);

INSERT IGNORE INTO `mdt_penal_codes`
(`code`, `label`, `charge_class`, `months`, `fine`, `color`, `description`, `category`)
VALUES

('C.E.J. 7001','Desobediência a Ordem Judicial','misdemeanor',10,2500,'#f91521',
'Descumprir deliberadamente ordem válida emitida por autoridade judicial quando legalmente obrigado a cumpri-la.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7002','Descumprimento de Medida Judicial','felony',20,5000,'#f9b115',
'Descumprir conscientemente medida, restrição ou determinação judicial regularmente imposta.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7003','Violação de Restrição Judicial','felony',20,5000,'#f9b115',
'Violar deliberadamente condição ou restrição estabelecida por decisão judicial.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7004','Obstrução da Justiça','felony',30,7500,'#f9b115',
'Praticar ato deliberado destinado a impedir, atrasar, dificultar ou comprometer investigação, processo ou cumprimento da Justiça.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7005','Obstrução de Investigação','felony',25,6000,'#f9b115',
'Interferir deliberadamente em investigação criminal com objetivo de impedir descoberta de fatos, provas ou responsáveis.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7006','Interferência em Processo Judicial','felony',25,6000,'#f9b115',
'Interferir indevidamente em procedimento judicial, audiência, julgamento ou ato processual.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7007','Fraude Processual','felony',30,7500,'#f9b115',
'Alterar artificialmente estado de pessoa, local, objeto ou circunstância com objetivo de induzir autoridade judicial ou investigativa em erro.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7008','Falso Testemunho','felony',25,6000,'#f9b115',
'Prestar deliberadamente informação falsa relevante durante depoimento, audiência ou procedimento oficial.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7009','Omissão Deliberada em Testemunho','misdemeanor',12,3000,'#f91521',
'Ocultar conscientemente informação relevante quando legalmente obrigado a prestar depoimento verdadeiro.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7010','Indução a Falso Testemunho','felony',30,7500,'#f9b115',
'Induzir, pressionar, orientar ou solicitar que terceiro forneça informação falsa em procedimento oficial.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7011','Coação de Testemunha','felony',40,10000,'#f9b115',
'Ameaçar, intimidar ou constranger testemunha com objetivo de alterar, impedir ou influenciar seu depoimento.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7012','Suborno de Testemunha','felony',35,10000,'#f9b115',
'Oferecer dinheiro, bem ou vantagem a testemunha para influenciar depoimento, silêncio ou comportamento processual.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7013','Destruição de Provas','felony',35,10000,'#f9b115',
'Destruir, inutilizar ou eliminar deliberadamente elemento de prova relacionado a investigação ou processo.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7014','Ocultação de Provas','felony',30,7500,'#f9b115',
'Ocultar deliberadamente objeto, documento ou informação relevante para investigação ou processo.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7015','Alteração de Provas','felony',35,10000,'#f9b115',
'Modificar, adulterar ou manipular deliberadamente prova para alterar sua interpretação ou valor investigativo.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7016','Plantação de Provas Falsas','felony',45,12500,'#f9b115',
'Inserir deliberadamente prova falsa em local, propriedade ou contexto com objetivo de incriminar ou enganar autoridade.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7017','Fabricação de Prova Falsa','felony',45,12500,'#f9b115',
'Criar documento, objeto, registro ou informação falsa para utilização como prova em investigação ou processo.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7018','Supressão de Documento Oficial','felony',25,6000,'#f9b115',
'Destruir, ocultar ou retirar deliberadamente documento público ou oficial para impedir sua utilização.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7019','Falsificação de Documento Público','felony',40,10000,'#f9b115',
'Criar, alterar ou falsificar documento emitido ou reconhecido por órgão público.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7020','Uso de Documento Público Falso','felony',35,10000,'#f9b115',
'Utilizar conscientemente documento público falso ou adulterado com objetivo de enganar autoridade ou obter vantagem.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7021','Falsificação de Registro Oficial','felony',40,10000,'#f9b115',
'Alterar, criar ou manipular indevidamente registro pertencente a órgão público.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7022','Inserção de Informação Falsa em Registro Público','felony',35,10000,'#f9b115',
'Inserir ou provocar inserção deliberada de informação falsa em registro ou sistema oficial.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7023','Uso Fraudulento de Documento Oficial','felony',30,7500,'#f9b115',
'Utilizar documento oficial legítimo de terceiro ou obtido irregularmente para enganar autoridade ou obter vantagem indevida.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7024','Corrupção Ativa','felony',50,15000,'#f9b115',
'Oferecer ou prometer vantagem indevida a agente público para influenciar ato relacionado ao exercício de sua função.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7025','Corrupção Passiva','felony',60,20000,'#f9b115',
'Solicitar, receber ou aceitar promessa de vantagem indevida em razão do exercício de função pública.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7026','Suborno de Agente Público','felony',50,15000,'#f9b115',
'Oferecer dinheiro, bem ou benefício a agente público com objetivo de obter favorecimento ou omissão indevida.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7027','Solicitação de Vantagem Indevida por Agente Público','felony',55,17500,'#f9b115',
'Solicitar vantagem econômica ou benefício indevido utilizando a função pública como meio de pressão ou favorecimento.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7028','Venda de Influência','felony',40,12500,'#f9b115',
'Solicitar ou receber vantagem alegando possuir influência sobre agente público ou decisão estatal.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7029','Fraude contra Órgão Público','felony',40,12500,'#f9b115',
'Utilizar fraude ou informação falsa para obter dinheiro, serviço, benefício ou vantagem pertencente ao poder público.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7030','Obtenção Fraudulenta de Benefício Público','felony',35,10000,'#f9b115',
'Obter benefício, licença, autorização ou pagamento público mediante documento ou declaração falsa.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7031','Apropriação Indevida de Bem Público','felony',35,10000,'#f9b115',
'Apropriar-se deliberadamente de bem, equipamento ou valor pertencente à administração pública.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7032','Desvio de Bem Público','felony',45,15000,'#f9b115',
'Desviar bem, dinheiro ou recurso público para finalidade particular ou não autorizada.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7033','Furto de Documento Oficial','felony',25,6000,'#f9b115',
'Subtrair documento, registro ou material oficial pertencente a órgão público.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7034','Furto de Prova Oficial','felony',30,7500,'#f9b115',
'Subtrair elemento de prova legalmente apreendido, armazenado ou custodiado por autoridade pública.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7035','Acesso Não Autorizado a Arquivo Oficial','felony',25,6000,'#f9b115',
'Acessar sem autorização arquivo, registro ou sistema restrito pertencente a órgão público.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7036','Divulgação Indevida de Informação Sigilosa','felony',35,10000,'#f9b115',
'Divulgar conscientemente informação oficial protegida por sigilo sem autorização.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7037','Uso Indevido de Informação Sigilosa','felony',35,10000,'#f9b115',
'Utilizar informação oficial sigilosa para benefício próprio, de terceiro ou de atividade criminosa.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7038','Usurpação de Função Pública','felony',35,10000,'#f9b115',
'Exercer, simular ou assumir função pública sem possuir autoridade legítima para fazê-lo.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7039','Exercício Ilegal de Autoridade Pública','felony',35,10000,'#f9b115',
'Praticar atos próprios de autoridade estatal sem possuir competência ou autorização válida.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7040','Fuga de Custódia','felony',30,7500,'#f9b115',
'Evitar ou abandonar deliberadamente custódia legal após prisão, detenção ou condução válida.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7041','Fuga de Estabelecimento Prisional','felony',40,10000,'#f9b115',
'Escapar deliberadamente de estabelecimento prisional ou local destinado ao cumprimento de custódia.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7042','Facilitação de Fuga de Preso','felony',45,12500,'#f9b115',
'Auxiliar conscientemente pessoa legalmente presa ou custodiada a fugir ou evitar recaptura.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7043','Ocultação de Foragido','felony',35,10000,'#f9b115',
'Ocultar deliberadamente pessoa procurada ou foragida com objetivo de impedir sua localização ou prisão.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7044','Favorecimento Pessoal','felony',30,7500,'#f9b115',
'Auxiliar autor de crime a evitar investigação, prisão ou responsabilização após a prática criminosa.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7045','Favorecimento Material','felony',30,7500,'#f9b115',
'Fornecer conscientemente dinheiro, veículo, abrigo, equipamento ou outro recurso para facilitar fuga ou ocultação de criminoso.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7046','Impedimento de Cumprimento de Mandado','felony',30,7500,'#f9b115',
'Impedir ou dificultar deliberadamente o cumprimento legítimo de mandado judicial.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7047','Violação de Lacre Oficial','misdemeanor',10,2500,'#f91521',
'Romper, remover ou violar deliberadamente lacre, selo ou marca de interdição colocada por autoridade competente.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7048','Desrespeito a Interdição Oficial','misdemeanor',12,3000,'#f91521',
'Utilizar, acessar ou reabrir local oficialmente interditado sem autorização.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7049','Fraude para Evitar Responsabilização Judicial','felony',35,10000,'#f9b115',
'Utilizar identidade, documento, declaração ou outro meio fraudulento com objetivo de evitar responsabilização judicial.',
'Crimes contra o Estado e Justiça'),

('C.E.J. 7050','Conspiração para Obstruir a Justiça','felony',50,15000,'#f9b115',
'Associar-se conscientemente a outras pessoas para destruir provas, ocultar criminosos, fraudar processo ou impedir atuação legítima da Justiça.',
'Crimes contra o Estado e Justiça');

INSERT IGNORE INTO `mdt_penal_code_tags`
(`charge_code`, `tag_id`)
VALUES

 ('C.E.J. 7001', 2),

 ('C.E.J. 7002', 3),

 ('C.E.J. 7003', 3),

 ('C.E.J. 7004', 3),

 ('C.E.J. 7005', 3),

 ('C.E.J. 7006', 3),

  ('C.E.J. 7007', 3),
('C.E.J. 7007', 7),

 ('C.E.J. 7008', 3),

 ('C.E.J. 7009', 2),

 ('C.E.J. 7010', 3),

 ('C.E.J. 7011', 3),

 ('C.E.J. 7012', 3),

 ('C.E.J. 7013', 3),

 ('C.E.J. 7014', 3),

 ('C.E.J. 7015', 3),

  ('C.E.J. 7016', 3),
('C.E.J. 7016', 7),

  ('C.E.J. 7017', 3),
('C.E.J. 7017', 7),

 ('C.E.J. 7018', 3),

  ('C.E.J. 7019', 3),
('C.E.J. 7019', 7),

  ('C.E.J. 7020', 3),
('C.E.J. 7020', 7),

  ('C.E.J. 7021', 3),
('C.E.J. 7021', 7),

  ('C.E.J. 7022', 3),
('C.E.J. 7022', 7),

  ('C.E.J. 7023', 3),
('C.E.J. 7023', 7),

 ('C.E.J. 7024', 3),

 ('C.E.J. 7025', 3),

 ('C.E.J. 7026', 3),

 ('C.E.J. 7027', 3),

  ('C.E.J. 7028', 3),
('C.E.J. 7028', 7),

  ('C.E.J. 7029', 3),
('C.E.J. 7029', 7),

  ('C.E.J. 7030', 3),
('C.E.J. 7030', 7),

 ('C.E.J. 7031', 3),

 ('C.E.J. 7032', 3),

  ('C.E.J. 7033', 3),
('C.E.J. 7033', 6),

  ('C.E.J. 7034', 3),
('C.E.J. 7034', 6),

 ('C.E.J. 7035', 3),

 ('C.E.J. 7036', 3),

 ('C.E.J. 7037', 3),

 ('C.E.J. 7038', 3),

 ('C.E.J. 7039', 3),

 ('C.E.J. 7040', 3),

 ('C.E.J. 7041', 3),

 ('C.E.J. 7042', 3),

 ('C.E.J. 7043', 3),

 ('C.E.J. 7044', 3),

 ('C.E.J. 7045', 3),

 ('C.E.J. 7046', 3),

 ('C.E.J. 7047', 2),

 ('C.E.J. 7048', 2),

  ('C.E.J. 7049', 3),
('C.E.J. 7049', 7),

 ('C.E.J. 7050', 3);

INSERT IGNORE INTO `mdt_penal_codes`
(`code`, `label`, `charge_class`, `months`, `fine`, `color`, `description`, `category`)
VALUES

('C.A.P. 8001','Desobediência a Agente Público','misdemeanor',7,1500,'#f91521',
'Recusar-se deliberadamente a cumprir ordem legítima e claramente comunicada por agente público no exercício regular de sua função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8002','Desacato a Agente Público','misdemeanor',5,1250,'#f91521',
'Ofender, humilhar ou desrespeitar gravemente agente público em razão do exercício de sua função, causando perturbação relevante da atuação oficial.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8003','Perturbação de Atividade Oficial','misdemeanor',7,1500,'#f91521',
'Interferir de forma deliberada e persistente em atividade oficial realizada por agente público, sem emprego de violência.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8004','Obstrução de Abordagem','misdemeanor',10,2000,'#f91521',
'Dificultar deliberadamente abordagem, revista, identificação ou fiscalização realizada legitimamente por agente público.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8005','Recusa de Identificação em Procedimento Legal','misdemeanor',5,1000,'#f91521',
'Recusar-se injustificadamente a fornecer identificação quando legalmente exigida durante procedimento oficial.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8006','Resistência Passiva à Detenção','misdemeanor',10,2000,'#f91521',
'Resistir de maneira não violenta ao cumprimento legítimo de detenção, condução ou prisão.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8007','Resistência Ativa à Prisão','felony',20,5000,'#f9b115',
'Utilizar força física ou oposição ativa para impedir ou dificultar prisão ou detenção legítima.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8008','Fuga Durante Abordagem','felony',15,3500,'#f9b115',
'Empreender fuga deliberada durante abordagem ou procedimento oficial após ordem legítima para permanecer no local.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8009','Fuga após Ordem de Prisão','felony',25,6000,'#f9b115',
'Tentar fugir ou evadir-se após comunicação clara de prisão ou detenção legítima.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8010','Ameaça contra Agente Público','felony',20,5000,'#f9b115',
'Ameaçar agente público de causar mal injusto e relevante em razão de sua função ou durante exercício oficial.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8011','Ameaça Armada contra Agente Público','felony',35,9000,'#f9b115',
'Ameaçar agente público utilizando arma de fogo, arma branca ou instrumento potencialmente letal.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8012','Intimidação de Agente Público','felony',20,5000,'#f9b115',
'Utilizar intimidação, perseguição ou demonstração de força para constranger agente público em razão de sua função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8013','Coação de Agente Público','felony',30,7500,'#f9b115',
'Constranger agente público mediante violência ou grave ameaça a praticar, omitir ou alterar ato relacionado à função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8014','Agressão contra Agente Público','felony',30,7500,'#f9b115',
'Agredir fisicamente agente público durante ou em razão do exercício de sua função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8015','Lesão Corporal contra Agente Público','felony',40,10000,'#f9b115',
'Causar deliberadamente lesão corporal relevante a agente público durante ou em razão de sua função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8016','Lesão Corporal Grave contra Agente Público','felony',55,15000,'#f9b115',
'Causar deliberadamente lesão grave, incapacitante ou com risco significativo à vida de agente público.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8017','Agressão Armada contra Agente Público','felony',50,15000,'#f9b115',
'Agredir agente público utilizando arma de fogo, arma branca ou outro instrumento potencialmente letal.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8018','Tentativa de Desarmar Agente Público','felony',35,10000,'#f9b115',
'Tentar retirar, tomar ou assumir controle da arma utilizada ou portada por agente público durante procedimento oficial.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8019','Subtração de Arma de Agente Público','felony',50,15000,'#f9b115',
'Subtrair arma pertencente ou confiada a agente público sem emprego de violência ou grave ameaça.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8020','Roubo de Arma de Agente Público','felony',65,20000,'#f9b115',
'Subtrair arma de agente público mediante violência, grave ameaça ou domínio sobre a vítima.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8021','Furto de Equipamento Oficial','felony',30,7500,'#f9b115',
'Subtrair rádio, colete, algema, distintivo, equipamento tático ou outro material oficial pertencente a agente ou órgão público.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8022','Roubo de Equipamento Oficial','felony',45,12500,'#f9b115',
'Subtrair equipamento oficial de agente público mediante violência ou grave ameaça.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8023','Furto de Viatura Oficial','felony',45,12500,'#f9b115',
'Subtrair veículo oficial sem emprego de violência ou grave ameaça.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8024','Roubo de Viatura Oficial','felony',65,20000,'#f9b115',
'Subtrair veículo oficial mediante violência, grave ameaça ou domínio sobre agente público.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8025','Dano a Viatura Oficial','felony',25,7500,'#f9b115',
'Danificar, destruir ou inutilizar deliberadamente veículo oficial pertencente a órgão público.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8026','Dano a Equipamento de Agente Público','felony',20,5000,'#f9b115',
'Danificar ou inutilizar deliberadamente equipamento utilizado por agente público no exercício de sua função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8027','Retenção Indevida de Equipamento Oficial','felony',20,5000,'#f9b115',
'Manter, esconder ou recusar devolução de equipamento oficial sabendo não possuir autorização para sua posse.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8028','Uso Indevido de Equipamento Oficial','felony',25,7500,'#f9b115',
'Utilizar sem autorização equipamento pertencente a agente ou órgão público de modo capaz de induzir terceiros em erro ou interferir em serviço oficial.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8029','Falsa Identificação como Agente Público','felony',30,7500,'#f9b115',
'Apresentar-se falsamente como agente público com objetivo de exercer autoridade, obter acesso ou conseguir vantagem indevida.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8030','Uso Fraudulento de Distintivo ou Credencial Oficial','felony',30,7500,'#f9b115',
'Utilizar distintivo, identificação ou credencial oficial falsa, furtada ou pertencente a terceiro para obter vantagem ou acesso indevido.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8031','Obstrução de Operação Policial','felony',30,7500,'#f9b115',
'Interferir deliberadamente em operação policial de forma capaz de atrasar, impedir ou comprometer sua execução.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8032','Interferência em Prisão de Terceiro','felony',25,6000,'#f9b115',
'Interferir deliberadamente para impedir ou dificultar prisão legítima de outra pessoa.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8033','Auxílio à Fuga de Pessoa Detida','felony',35,10000,'#f9b115',
'Auxiliar conscientemente pessoa detida ou presa a escapar da custódia de agente público.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8034','Resgate de Preso','felony',55,17500,'#f9b115',
'Utilizar força, ameaça ou ação coordenada para retirar pessoa da custódia legítima de agentes públicos.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8035','Invasão de Área de Operação Policial','felony',20,5000,'#f9b115',
'Ingressar deliberadamente em área oficialmente isolada para operação policial sem autorização, comprometendo a segurança ou atuação dos agentes.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8036','Rompimento de Cerco Policial','felony',35,10000,'#f9b115',
'Romper deliberadamente bloqueio, cerco ou perímetro policial estabelecido para captura, segurança ou controle operacional.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8037','Uso de Veículo contra Agente Público','felony',55,17500,'#f9b115',
'Utilizar deliberadamente veículo para atingir, prensar, derrubar, ameaçar ou colocar agente público em grave risco físico.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8038','Disparo de Arma contra Agente Público','felony',80,25000,'#f9b115',
'Efetuar deliberadamente disparo de arma de fogo na direção de agente público durante ou em razão de sua função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8039','Tentativa de Homicídio de Agente Público','felony',110,40000,'#f9b115',
'Praticar ato diretamente destinado a causar a morte de agente público, não ocorrendo o resultado por circunstância alheia à vontade do autor.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8040','Homicídio de Agente Público','felony',120,60000,'#f9b115',
'Causar deliberadamente a morte de agente público durante ou em razão do exercício de sua função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8041','Tentativa de Homicídio de Agente Público mediante Emboscada','felony',120,50000,'#f9b115',
'Tentar matar agente público utilizando emboscada, surpresa ou recurso destinado a dificultar sua defesa.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8042','Homicídio de Agente Público mediante Emboscada','felony',120,75000,'#f9b115',
'Causar deliberadamente a morte de agente público mediante emboscada, tocaia ou recurso destinado a dificultar sua defesa.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8043','Contratação para Homicídio de Agente Público','felony',120,75000,'#f9b115',
'Contratar, pagar, oferecer recompensa ou solicitar a terceiro a morte de agente público em razão de sua função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8044','Participação em Homicídio de Agente Público','felony',110,50000,'#f9b115',
'Auxiliar, facilitar, incentivar ou participar conscientemente da execução de homicídio contra agente público.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8045','Sequestro de Agente Público','felony',80,25000,'#f9b115',
'Privar deliberadamente agente público de sua liberdade mediante força, ameaça, fraude ou retenção contra sua vontade.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8046','Sequestro de Agente Público para Obter Vantagem','felony',100,40000,'#f9b115',
'Privar agente público de sua liberdade com objetivo de obter dinheiro, informação, libertação de preso, benefício ou outra vantagem.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8047','Cárcere Privado de Agente Público','felony',60,20000,'#f9b115',
'Manter agente público confinado ou impedido de deixar determinado local contra sua vontade.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8048','Tortura de Agente Público','felony',110,40000,'#f9b115',
'Submeter agente público intencionalmente a sofrimento físico ou mental grave para punição, intimidação, obtenção de informação ou coerção.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8049','Coação Armada para Obter Informação Oficial','felony',60,20000,'#f9b115',
'Utilizar arma ou grave ameaça contra agente público para obrigá-lo a fornecer informação, acesso, senha ou dado relacionado à função.',
'Crimes contra Agentes Públicos'),

('C.A.P. 8050','Conspiração para Atacar Agentes Públicos','felony',70,25000,'#f9b115',
'Associar-se conscientemente a outras pessoas para planejar agressão, emboscada, sequestro ou ataque coordenado contra agentes públicos.',
'Crimes contra Agentes Públicos');

INSERT IGNORE INTO `mdt_penal_code_tags`
(`charge_code`, `tag_id`)
VALUES

 ('C.A.P. 8001', 2),

 ('C.A.P. 8002', 2),

 ('C.A.P. 8003', 2),

 ('C.A.P. 8004', 2),

 ('C.A.P. 8005', 2),

 ('C.A.P. 8006', 2),

 ('C.A.P. 8007', 3),

 ('C.A.P. 8008', 3),

 ('C.A.P. 8009', 3),

 ('C.A.P. 8010', 3),

 ('C.A.P. 8011', 3),

 ('C.A.P. 8012', 3),

 ('C.A.P. 8013', 3),

 ('C.A.P. 8014', 3),

 ('C.A.P. 8015', 3),

 ('C.A.P. 8016', 3),

 ('C.A.P. 8017', 3),

 ('C.A.P. 8018', 3),

  ('C.A.P. 8019', 3),
('C.A.P. 8019', 6),

  ('C.A.P. 8020', 3),
('C.A.P. 8020', 5),

  ('C.A.P. 8021', 3),
('C.A.P. 8021', 6),

  ('C.A.P. 8022', 3),
('C.A.P. 8022', 5),

  ('C.A.P. 8023', 3),
('C.A.P. 8023', 6),

  ('C.A.P. 8024', 3),
('C.A.P. 8024', 5),

 ('C.A.P. 8025', 3),

 ('C.A.P. 8026', 3),

 ('C.A.P. 8027', 3),

 ('C.A.P. 8028', 3),

  ('C.A.P. 8029', 3),

  ('C.A.P. 8030', 3),
('C.A.P. 8030', 7),

 ('C.A.P. 8031', 3),

 ('C.A.P. 8032', 3),

 ('C.A.P. 8033', 3),

 ('C.A.P. 8034', 3),

 ('C.A.P. 8035', 3),

 ('C.A.P. 8036', 3),

 ('C.A.P. 8037', 3),

  ('C.A.P. 8038', 3),

  ('C.A.P. 8039', 3),
('C.A.P. 8039', 4),

  ('C.A.P. 8040', 3),
('C.A.P. 8040', 4),

  ('C.A.P. 8041', 3),
('C.A.P. 8041', 4),

  ('C.A.P. 8042', 3),
('C.A.P. 8042', 4),

  ('C.A.P. 8043', 3),
('C.A.P. 8043', 4),

  ('C.A.P. 8044', 3),
('C.A.P. 8044', 4),

 ('C.A.P. 8045', 3),

 ('C.A.P. 8046', 3),

 ('C.A.P. 8047', 3),

 ('C.A.P. 8048', 3),

 ('C.A.P. 8049', 3),

 ('C.A.P. 8050', 3);

INSERT IGNORE INTO `mdt_penal_codes`
(`code`, `label`, `charge_class`, `months`, `fine`, `color`, `description`, `category`)
VALUES

('D.C. 9001','Desrespeito à Comunidade','infraction',0,0,'#15f943',
'Adotar comportamento desrespeitoso, hostil ou provocativo contra membros da comunidade sem configurar infração de maior gravidade.',
'Discord e Comunidade'),

('D.C. 9002','Ofensas Pessoais','misdemeanor',0,0,'#f91521',
'Dirigir insultos, humilhações ou ataques pessoais contra outro membro da comunidade.',
'Discord e Comunidade'),

('D.C. 9003','Assédio Persistente','felony',0,0,'#f9b115',
'Perseguir, importunar ou assediar reiteradamente outro membro por Discord, FiveM ou qualquer meio relacionado à comunidade.',
'Discord e Comunidade'),

('D.C. 9004','Discriminação','felony',0,0,'#f9b115',
'Praticar tratamento ofensivo ou discriminatório contra pessoa ou grupo com base em característica pessoal protegida ou identidade.',
'Discord e Comunidade'),

('D.C. 9005','Discurso de Ódio','felony',0,0,'#f9b115',
'Promover, incentivar ou divulgar discurso de ódio, hostilidade ou desumanização contra pessoa ou grupo.',
'Discord e Comunidade'),

('D.C. 9006','Ameaça Real contra Membro da Comunidade','felony',0,0,'#f9b115',
'Ameaçar causar dano real, físico, patrimonial ou pessoal a integrante da comunidade fora do contexto legítimo de roleplay.',
'Discord e Comunidade'),

('D.C. 9007','Incitação à Violência Real','felony',0,0,'#f9b115',
'Incentivar terceiros a praticar violência real contra jogador, membro da equipe ou integrante da comunidade.',
'Discord e Comunidade'),

('D.C. 9008','Humilhação Pública Organizada','felony',0,0,'#f9b115',
'Organizar ou incentivar campanha destinada a humilhar, ridicularizar ou constranger publicamente outro membro.',
'Discord e Comunidade'),

('D.C. 9009','Perseguição entre Plataformas','felony',0,0,'#f9b115',
'Perseguir deliberadamente membro da comunidade por Discord, redes sociais, FiveM ou outros meios após bloqueio ou pedido para cessar contato.',
'Discord e Comunidade'),

('D.C. 9010','Provocação Excessiva ou Flame','misdemeanor',0,0,'#f91521',
'Provocar conflitos, discussões ou hostilidade de maneira deliberada e repetitiva nos canais da comunidade.',
'Discord e Comunidade'),

('D.C. 9011','Spam','infraction',0,0,'#15f943',
'Enviar mensagens, imagens, comandos, marcações ou conteúdo repetitivo de maneira excessiva.',
'Discord e Comunidade'),

('D.C. 9012','Flood','infraction',0,0,'#15f943',
'Enviar grande quantidade de mensagens em curto período prejudicando a utilização normal dos canais.',
'Discord e Comunidade'),

('D.C. 9013','Uso Indevido de Menções','infraction',0,0,'#15f943',
'Utilizar menções de usuários, cargos ou grupos de forma abusiva ou sem necessidade.',
'Discord e Comunidade'),

('D.C. 9014','Divulgação em Canal Indevido','infraction',0,0,'#15f943',
'Publicar conteúdo promocional, convite ou anúncio em local não autorizado.',
'Discord e Comunidade'),

('D.C. 9015','Publicidade Não Autorizada','misdemeanor',0,0,'#f91521',
'Divulgar servidor, comunidade, produto, serviço ou conteúdo externo sem autorização da administração.',
'Discord e Comunidade'),

('D.C. 9016','Divulgação de Servidor Concorrente','felony',0,0,'#f9b115',
'Promover deliberadamente servidor ou comunidade concorrente utilizando os canais, jogadores ou estrutura da comunidade.',
'Discord e Comunidade'),

('D.C. 9017','Recrutamento Indevido de Membros','felony',0,0,'#f9b115',
'Tentar retirar membros da comunidade para grupo, servidor ou projeto externo mediante abordagem deliberada e não autorizada.',
'Discord e Comunidade'),

('D.C. 9018','Conteúdo Inadequado','misdemeanor',0,0,'#f91521',
'Publicar conteúdo inadequado, ofensivo ou incompatível com as regras e finalidade dos canais.',
'Discord e Comunidade'),

('D.C. 9019','Conteúdo Sexual Explícito','felony',0,0,'#f9b115',
'Publicar ou distribuir conteúdo sexual explícito em qualquer ambiente oficial da comunidade.',
'Discord e Comunidade'),

('D.C. 9020','Conteúdo Extremamente Gráfico','felony',0,0,'#f9b115',
'Publicar conteúdo real de violência extrema, mutilação ou material gráfico perturbador sem autorização e contexto adequado.',
'Discord e Comunidade'),

('D.C. 9021','Divulgação de Informação Pessoal','felony',0,0,'#f9b115',
'Divulgar sem consentimento informações pessoais ou privadas de outro membro da comunidade.',
'Discord e Comunidade'),

('D.C. 9022','Doxxing','felony',0,0,'#f9b115',
'Coletar, expor ou divulgar informações destinadas a identificar ou localizar pessoa no mundo real sem autorização.',
'Discord e Comunidade'),

('D.C. 9023','Ameaça de Doxxing','felony',0,0,'#f9b115',
'Ameaçar divulgar dados pessoais, localização ou informações privadas de membro da comunidade.',
'Discord e Comunidade'),

('D.C. 9024','Divulgação de Conversa Privada','misdemeanor',0,0,'#f91521',
'Publicar conversa privada sem autorização quando isso violar expectativa razoável de privacidade ou normas da comunidade.',
'Discord e Comunidade'),

('D.C. 9025','Vazamento de Conteúdo Interno','felony',0,0,'#f9b115',
'Divulgar sem autorização documentos, canais, informações ou conteúdo interno restrito da comunidade.',
'Discord e Comunidade'),

('D.C. 9026','Vazamento de Informação da Staff','felony',0,0,'#f9b115',
'Divulgar deliberadamente informações internas, investigações, decisões ou procedimentos reservados da equipe administrativa.',
'Discord e Comunidade'),

('D.C. 9027','Compartilhamento Indevido de Logs','felony',0,0,'#f9b115',
'Divulgar logs administrativos, registros internos ou informações de auditoria sem autorização.',
'Discord e Comunidade'),

('D.C. 9028','Gravação Indevida de Atendimento Privado','misdemeanor',0,0,'#f91521',
'Gravar ou divulgar atendimento privado da equipe em desacordo com as regras da comunidade.',
'Discord e Comunidade'),

('D.C. 9029','Falsa Identidade no Discord','misdemeanor',0,0,'#f91521',
'Utilizar identidade falsa com objetivo de enganar membros da comunidade sem configurar golpe patrimonial.',
'Discord e Comunidade'),

('D.C. 9030','Falsificação de Identidade de Staff','felony',0,0,'#f9b115',
'Fingir ser administrador, moderador ou integrante da equipe para exercer autoridade ou enganar outros membros.',
'Discord e Comunidade'),

('D.C. 9031','Uso Indevido do Nome da Administração','felony',0,0,'#f9b115',
'Alegar falsamente autorização, apoio ou decisão da administração para obter benefício ou influenciar terceiros.',
'Discord e Comunidade'),

('D.C. 9032','Falsificação de Prova contra Jogador','felony',0,0,'#f9b115',
'Criar, editar ou manipular imagem, vídeo, áudio, mensagem ou registro com objetivo de incriminar falsamente outro jogador.',
'Discord e Comunidade'),

('D.C. 9033','Manipulação de Evidência Administrativa','felony',0,0,'#f9b115',
'Alterar ou omitir deliberadamente evidência apresentada em denúncia, recurso ou investigação administrativa.',
'Discord e Comunidade'),

('D.C. 9034','Falsa Denúncia','felony',0,0,'#f9b115',
'Realizar denúncia sabendo que os fatos relatados são falsos com intenção de prejudicar outro membro.',
'Discord e Comunidade'),

('D.C. 9035','Abuso do Sistema de Tickets','misdemeanor',0,0,'#f91521',
'Abrir tickets repetitivos, falsos, ofensivos ou sem finalidade legítima para prejudicar o atendimento da equipe.',
'Discord e Comunidade'),

('D.C. 9036','Fraude em Ticket Administrativo','felony',0,0,'#f9b115',
'Utilizar informações ou provas falsas em ticket com objetivo de obter vantagem, benefício ou punição indevida de terceiro.',
'Discord e Comunidade'),

('D.C. 9037','Tentativa de Enganar a Staff','felony',0,0,'#f9b115',
'Fornecer deliberadamente versão falsa, informação manipulada ou omissão relevante para enganar decisão administrativa.',
'Discord e Comunidade'),

('D.C. 9038','Fraude em Benefício ou Recompensa','felony',0,0,'#f9b115',
'Utilizar fraude, conta alternativa ou informação falsa para obter recompensa, benefício, item ou vantagem da comunidade.',
'Discord e Comunidade'),

('D.C. 9039','Golpe contra Jogador','felony',0,0,'#f9b115',
'Utilizar engano, fraude ou falsa promessa para obter dinheiro, item, conta, benefício ou vantagem de outro membro.',
'Discord e Comunidade'),

('D.C. 9040','Golpe envolvendo Dinheiro Real','felony',0,0,'#f9b115',
'Utilizar a comunidade para aplicar golpe envolvendo dinheiro real, pagamento, produto ou serviço.',
'Discord e Comunidade'),

('D.C. 9041','Fraude em Venda de Produto ou Serviço','felony',0,0,'#f9b115',
'Oferecer produto ou serviço utilizando informações falsas com objetivo de obter vantagem de integrante da comunidade.',
'Discord e Comunidade'),

('D.C. 9042','Phishing contra Membros','felony',0,0,'#f9b115',
'Tentar obter senha, token, credencial ou informação de acesso de membro mediante página, mensagem ou identidade fraudulenta.',
'Discord e Comunidade'),

('D.C. 9043','Roubo ou Apropriação de Conta','felony',0,0,'#f9b115',
'Obter, assumir ou manter acesso não autorizado à conta de outro membro da comunidade.',
'Discord e Comunidade'),

('D.C. 9044','Subtração de Bens Digitais','felony',0,0,'#f9b115',
'Subtrair ou transferir sem autorização itens, valores ou ativos digitais pertencentes a outro jogador.',
'Discord e Comunidade'),

('D.C. 9045','Comércio Externo Não Autorizado','felony',0,0,'#f9b115',
'Comprar, vender ou negociar por dinheiro real itens, veículos, personagens, moeda ou vantagens do servidor sem autorização.',
'Discord e Comunidade'),

('D.C. 9046','Venda de Conta','felony',0,0,'#f9b115',
'Vender, comprar ou negociar conta vinculada ao servidor ou comunidade em desacordo com as regras estabelecidas.',
'Discord e Comunidade'),

('D.C. 9047','Compartilhamento Indevido de Conta','felony',0,0,'#f9b115',
'Compartilhar acesso à conta com terceiros quando tal conduta comprometer segurança, punições ou integridade do servidor.',
'Discord e Comunidade'),

('D.C. 9048','Evasão de Punição','felony',0,0,'#f9b115',
'Utilizar outra conta, identidade ou meio técnico para evitar mute, suspensão, banimento ou outra punição administrativa.',
'Discord e Comunidade'),

('D.C. 9049','Ban Evasion','felony',0,0,'#f9b115',
'Retornar deliberadamente à comunidade utilizando conta alternativa ou outro meio após banimento ativo.',
'Discord e Comunidade'),

('D.C. 9050','Auxílio à Evasão de Banimento','felony',0,0,'#f9b115',
'Auxiliar conscientemente pessoa banida a retornar ou ocultar sua identidade dentro da comunidade.',
'Discord e Comunidade'),

('D.C. 9051','Metagaming por Discord','felony',0,0,'#f9b115',
'Utilizar informações obtidas fora do personagem, inclusive por Discord, transmissão ou mensagem privada, para obter vantagem dentro do roleplay.',
'Discord e Comunidade'),

('D.C. 9052','Compartilhamento de Informação IC por Meio OOC','felony',0,0,'#f9b115',
'Transmitir por meio externo informação de personagem que não poderia legitimamente ser conhecida pelo destinatário dentro do roleplay.',
'Discord e Comunidade'),

('D.C. 9053','Ghosting por Stream','felony',0,0,'#f9b115',
'Assistir transmissão de outro jogador com objetivo de obter posição, estratégia ou informação para utilização dentro do servidor.',
'Discord e Comunidade'),

('D.C. 9054','Stream Sniping','felony',0,0,'#f9b115',
'Utilizar transmissão ao vivo para localizar, perseguir, abordar ou interferir deliberadamente com outro jogador dentro do servidor.',
'Discord e Comunidade'),

('D.C. 9055','Coordenação OOC para Obter Vantagem IC','felony',0,0,'#f9b115',
'Coordenar ações fora do personagem para produzir vantagem indevida dentro do roleplay.',
'Discord e Comunidade'),

('D.C. 9056','Divulgação de Informação Sigilosa do RP','felony',0,0,'#f9b115',
'Compartilhar externamente informação sigilosa obtida em contexto de roleplay quando isso comprometer investigação, operação ou narrativa em andamento.',
'Discord e Comunidade'),

('D.C. 9057','Exploração de Bug para Obter Vantagem','felony',0,0,'#f9b115',
'Explorar deliberadamente falha do servidor, sistema ou interface para obter vantagem, item, dinheiro ou benefício indevido.',
'Discord e Comunidade'),

('D.C. 9058','Omissão Deliberada de Bug Explorado','felony',0,0,'#f9b115',
'Continuar explorando vulnerabilidade conhecida sem comunicar a equipe quando dela resultar vantagem relevante ou prejuízo à comunidade.',
'Discord e Comunidade'),

('D.C. 9059','Divulgação Maliciosa de Exploit','felony',0,0,'#f9b115',
'Divulgar vulnerabilidade, exploit ou método de abuso com objetivo de permitir sua exploração por outros membros.',
'Discord e Comunidade'),

('D.C. 9060','Ataque Coordenado contra a Comunidade','felony',0,0,'#f9b115',
'Organizar ou participar de ação coordenada destinada a prejudicar gravemente o servidor, Discord, equipe ou comunidade, incluindo sabotagem, raids ou abuso massivo de sistemas.',
'Discord e Comunidade');

INSERT IGNORE INTO `mdt_penal_code_tags`
(`charge_code`, `tag_id`)
VALUES

 ('D.C. 9001', 8),

 ('D.C. 9002', 2),

 ('D.C. 9003', 3),

 ('D.C. 9004', 3),

 ('D.C. 9005', 3),

 ('D.C. 9006', 3),

 ('D.C. 9007', 3),

 ('D.C. 9008', 3),

 ('D.C. 9009', 3),

 ('D.C. 9010', 2),

 ('D.C. 9011', 8),

 ('D.C. 9012', 8),

 ('D.C. 9013', 8),

 ('D.C. 9014', 8),

 ('D.C. 9015', 2),

 ('D.C. 9016', 3),

 ('D.C. 9017', 3),

 ('D.C. 9018', 2),

 ('D.C. 9019', 3),

 ('D.C. 9020', 3),

 ('D.C. 9021', 3),

 ('D.C. 9022', 3),

 ('D.C. 9023', 3),

 ('D.C. 9024', 2),

 ('D.C. 9025', 3),

 ('D.C. 9026', 3),

 ('D.C. 9027', 3),

 ('D.C. 9028', 2),

 ('D.C. 9029', 2),

 ('D.C. 9030', 3),

 ('D.C. 9031', 3),

 ('D.C. 9032', 3),

 ('D.C. 9033', 3),

 ('D.C. 9034', 3),

 ('D.C. 9035', 2),

  ('D.C. 9036', 3),
('D.C. 9036', 7),

 ('D.C. 9037', 3),

  ('D.C. 9038', 3),
('D.C. 9038', 7),

  ('D.C. 9039', 3),
('D.C. 9039', 7),

  ('D.C. 9040', 3),
('D.C. 9040', 7),

  ('D.C. 9041', 3),
('D.C. 9041', 7),

  ('D.C. 9042', 3),
('D.C. 9042', 7),

 ('D.C. 9043', 3),

  ('D.C. 9044', 3),
('D.C. 9044', 6),

 ('D.C. 9045', 3),

 ('D.C. 9046', 3),

 ('D.C. 9047', 3),

 ('D.C. 9048', 3),

 ('D.C. 9049', 3),

 ('D.C. 9050', 3),

 ('D.C. 9051', 3),

 ('D.C. 9052', 3),

 ('D.C. 9053', 3),

 ('D.C. 9054', 3),

 ('D.C. 9055', 3),

 ('D.C. 9056', 3),

 ('D.C. 9057', 3),

 ('D.C. 9058', 3),

 ('D.C. 9059', 3),

 ('D.C. 9060', 3);

INSERT IGNORE INTO `mdt_cameras` (`cam_id`, `cam_label`, `cam_type`, `coords`, `rotation`, `image`, `can_rotate`, `is_online`, `spawns_model`, `created_by`) VALUES
('PCB01', 'Banco do Pacífico: saguão', 'bank', '{"x":257.45,"y":210.07,"z":109.08}', '{"x":-25.0,"y":0.0,"z":28.05}', 'https://files.fivemerr.com/images/45bab512-5836-4449-8831-fbe67d7c886f.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('PCB02', 'Banco do Pacífico: entrada', 'bank', '{"x":232.86,"y":221.46,"z":107.83}', '{"x":-25.0,"y":0.0,"z":-140.91}', 'https://files.fivemerr.com/images/4a50b347-aa12-4df2-9efc-cf3f38cc1d41.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('PCB03', 'Banco do Pacífico: Cofre', 'bank', '{"x":252.27,"y":225.52,"z":103.99}', '{"x":-35.0,"y":0.0,"z":-74.87}', 'https://files.fivemerr.com/images/7c1604e9-480b-41d2-9c6b-1899c763fb51.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('LTD01', 'LTD - Grove St', 'store', '{"x":-53.14,"y":-1746.71,"z":31.54}', '{"x":-35.0,"y":0.0,"z":-168.9182}', 'https://files.fivemerr.com/images/1ff40a9c-ee6e-4c6f-9273-15bae452375e.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('RLQ01', 'Loja de bebidas Rob\'s - Prosperity St', 'store', '{"x":-1482.9,"y":-380.463,"z":42.363}', '{"x":-35.0,"y":0.0,"z":79.53281}', 'https://files.fivemerr.com/images/b5bcfe95-3c3f-4dde-a0b9-2024ea5bfa08.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('RLQ02', 'Loja de bebidas Rob\'s - San Andreas Ave', 'store', '{"x":-1224.874,"y":-911.094,"z":14.401}', '{"x":-35.0,"y":0.0,"z":-6.778894}', 'https://files.fivemerr.com/images/f4aba38b-faa0-4050-ab00-ec55d8a1068d.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('LTD02', 'LTD - Ginger St', 'store', '{"x":-718.153,"y":-909.211,"z":21.49}', '{"x":-35.0,"y":0.0,"z":-137.1431}', 'https://files.fivemerr.com/images/ca78a638-f17a-4456-9061-1648b593e394.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('24701', '24/7 Inocência Blvd', 'store', '{"x":23.885,"y":-1342.441,"z":31.672}', '{"x":-35.0,"y":0.0,"z":-142.9191}', 'https://files.fivemerr.com/images/ca78a638-f17a-4456-9061-1648b593e394.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('RLQ03', 'Loja de bebidas Rob\'s - El Rancho Blvd', 'store', '{"x":1133.024,"y":-978.712,"z":48.515}', '{"x":-35.0,"y":0.0,"z":-137.302}', 'https://files.fivemerr.com/images/63f7c1dd-c537-44a4-9076-2dd9227dfa97.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('LTD03', 'LTD - West Mirror Drive', 'store', '{"x":1151.93,"y":-320.389,"z":71.33}', '{"x":-35.0,"y":0.0,"z":-119.4468}', 'https://files.fivemerr.com/images/686831ef-ed81-4882-bd23-72c2754e38ab.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('24702', '24/7 Clinton Ave', 'store', '{"x":383.402,"y":328.915,"z":105.541}', '{"x":-35.0,"y":0.0,"z":118.585}', 'https://files.fivemerr.com/images/2b19a04e-0f1d-4725-8262-1da93b30391e.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('LTD04', 'LTD - Banham Canyon Dr', 'store', '{"x":-1832.057,"y":789.389,"z":140.436}', '{"x":-35.0,"y":0.0,"z":-91.481}', 'https://files.fivemerr.com/images/c6f53e50-75da-4e4c-806c-08be6822e884.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('RLQ04', 'Loja de bebidas Rob\'s - Great Ocean Hwy', 'store', '{"x":-2966.15,"y":387.067,"z":17.393}', '{"x":-35.0,"y":0.0,"z":32.92229}', 'https://files.fivemerr.com/images/f25096f5-5724-4f4b-8a75-b7f968dd67ef.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('24703', 'Estrada Ineseno 24/7', 'store', '{"x":-3046.749,"y":592.491,"z":9.808}', '{"x":-35.0,"y":0.0,"z":-116.673}', 'https://files.fivemerr.com/images/055956f5-6f62-48a7-80d0-c6d94540b6e4.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('24704', '24/7 Barbareno Rd', 'store', '{"x":-3246.489,"y":1010.408,"z":14.705}', '{"x":-35.0,"y":0.0,"z":-135.2151}', 'https://files.fivemerr.com/images/14b9a9ff-4cf0-4373-a784-0723bec9c3b2.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('24705', '24/7 Rota 68', 'store', '{"x":539.773,"y":2664.904,"z":44.056}', '{"x":-35.0,"y":0.0,"z":-42.947}', 'https://files.fivemerr.com/images/4535c506-42dc-4ca9-9f6e-ece7215e1b7f.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('RLQ05', 'Loja de bebidas Rob\'s - Rota 68', 'store', '{"x":1169.855,"y":2711.493,"z":40.432}', '{"x":-35.0,"y":0.0,"z":127.17}', 'https://files.fivemerr.com/images/b8b8e6ff-234a-461f-8636-02c1c9247aeb.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('24706', '24/7 Senora Fwy', 'store', '{"x":2673.579,"y":3281.265,"z":57.541}', '{"x":-35.0,"y":0.0,"z":-80.242}', 'https://files.fivemerr.com/images/cf0b6dc6-3310-441a-ad00-2666fe89c700.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('24707', '24/7 Alhambra Dr', 'store', '{"x":1966.24,"y":3749.545,"z":34.143}', '{"x":-35.0,"y":0.0,"z":163.065}', 'https://files.fivemerr.com/images/6c3eb8b8-c8a5-4a25-895c-44724ac24a6f.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('24708', '24/7 Senora Fwy', 'store', '{"x":1729.522,"y":6419.87,"z":37.262}', '{"x":-35.0,"y":0.0,"z":-160.089}', 'https://files.fivemerr.com/images/64918129-eb25-4bd6-abe7-cc6263e36f1d.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('FLB01', 'Banco Fleeca - Legion Square', 'bank', '{"x":144.871,"y":-1043.044,"z":31.017}', '{"x":-35.0,"y":0.0,"z":-143.9796}', 'https://files.fivemerr.com/images/92659204-5c5d-44ab-a14f-68a7f83e01f3.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('FLB02', 'Banco Fleeca - Hawick/Power', 'bank', '{"x":309.341,"y":-281.439,"z":55.88}', '{"x":-35.0,"y":0.0,"z":-146.1595}', 'https://files.fivemerr.com/images/17a41043-bc9d-4a0c-945d-63d03ff4660d.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('FLB03', 'Banco Fleeca - Hawick/San Vitas', 'bank', '{"x":-355.7643,"y":-52.506,"z":50.746}', '{"x":-35.0,"y":0.0,"z":-143.8711}', 'https://files.fivemerr.com/images/ead3415f-bdc5-447f-9d6f-287c77211388.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('FLB04', 'Banco Fleeca - Del Perro Blvd', 'bank', '{"x":-1214.226,"y":-335.86,"z":39.515}', '{"x":-35.0,"y":0.0,"z":-97.862}', 'https://files.fivemerr.com/images/6d00ce1d-6078-4a69-8cfb-ebed60cbf833.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('FLB05', 'Banco Fleeca - Great Ocean Hwy', 'bank', '{"x":-2958.885,"y":478.983,"z":17.406}', '{"x":-35.0,"y":0.0,"z":-34.69595}', 'https://files.fivemerr.com/images/dbb2ec99-8212-47f2-9f79-e0b787608ce2.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('PLB01', 'Banco de Paleto', 'bank', '{"x":-102.939,"y":6467.668,"z":33.424}', '{"x":-35.0,"y":0.0,"z":24.66}', 'https://files.fivemerr.com/images/ff06da26-2cd6-4337-a1ca-c738d4267ae5.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('VGY01', 'Joalheria Vangelico: frente à direita', 'jewelry', '{"x":-627.54,"y":-239.74,"z":40.33}', '{"x":-35.0,"y":0.0,"z":5.78}', 'https://files.fivemerr.com/images/348eca1b-17ad-48fc-8f03-1c21bd87dadc.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('VGY02', 'Joalheria Vangelico: frente à esquerda', 'jewelry', '{"x":-627.51,"y":-229.51,"z":40.24}', '{"x":-35.0,"y":0.0,"z":-95.78}', 'https://files.fivemerr.com/images/707df30b-440e-4e55-ac93-c1878c381cee.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('VGY03', 'Joalheria Vangelico: fundos à esquerda', 'jewelry', '{"x":-620.3,"y":-224.31,"z":40.23}', '{"x":-35.0,"y":0.0,"z":165.78}', 'https://files.fivemerr.com/images/371e5386-c901-451d-a3c4-ce7a371bee86.png', TRUE, TRUE, FALSE, 'SYSTEM'),
('VGY04', 'Joalheria Vangelico: lateral', 'jewelry', '{"x":-622.57,"y":-236.3,"z":40.31}', '{"x":-35.0,"y":0.0,"z":5.78}', 'https://files.fivemerr.com/images/4c90514e-7a31-4654-a7a9-40864d106028.png', TRUE, TRUE, FALSE, 'SYSTEM');

INSERT IGNORE INTO `mdt_tags` (`name`, `type`, `color`, `job_type`) VALUES
('SWAT', 'officer', '#3b82f6', 'leo'),
('Instrutor de campo', 'officer', '#10b981', 'leo'),
('Detetive', 'officer', '#8b5cf6', 'leo'),
('Em estágio probatório', 'officer', '#f59e0b', 'leo'),
('Comando', 'officer', '#ef4444', 'leo'),
('Certificação K9', 'officer', '#06b6d4', 'leo'),
('Certificação aérea', 'officer', '#ec4899', 'leo');

INSERT IGNORE INTO mdt_tags (name, type, color, job_type) VALUES
('Paramédico', 'officer', '#10b981', 'ems'),
('Cirurgião', 'officer', '#3b82f6', 'ems'),
('Estagiário', 'officer', '#f59e0b', 'ems'),
('Em Chamada', 'officer', '#06b6d4', 'ems');

INSERT IGNORE INTO mdt_tags (name, type, color, job_type) VALUES
('Armado e Perigoso', 'citizen', '#dc2626', 'leo'),
('Violento', 'citizen', '#ef4444', 'leo'),
('Risco de fuga', 'citizen', '#f97316', 'leo'),
('Resistência', 'citizen', '#f97316', 'leo'),
('Condenado', 'citizen', '#b91c1c', 'leo'),
('Reincidente', 'citizen', '#ea580c', 'leo'),
('Membro de gangue', 'citizen', '#ec4899', 'leo'),
('Usuário de drogas', 'citizen', '#06b6d4', 'leo'),
('Liberdade provisória', 'citizen', '#f59e0b', 'leo'),
('Liberdade condicional', 'citizen', '#f59e0b', 'leo'),
('Informante', 'citizen', '#06b6d4', 'leo'),
('Saúde Mental', 'citizen', '#8b5cf6', 'leo'),
('Licença suspensa', 'citizen', '#6b7280', 'leo'),
('Veterano', 'citizen', '#10b981', 'leo');

INSERT IGNORE INTO mdt_tags (name, type, color, job_type) VALUES
('Alergia', 'citizen', '#ef4444', 'ems'),
('DNR', 'citizen', '#8b5cf6', 'ems'),
('Diabético', 'citizen', '#06b6d4', 'ems'),
('Epiléptico', 'citizen', '#a855f7', 'ems'),
('Condição Cardíaca', 'citizen', '#dc2626', 'ems'),
('Doador de Órgãos', 'citizen', '#10b981', 'ems'),
('Alerta Médico', 'citizen', '#f59e0b', 'all');

INSERT IGNORE INTO mdt_tags (name, type, color, job_type) VALUES
('Roubo', 'report', '#ef4444', 'leo'),
('Armado', 'report', '#f97316', 'leo'),
('Prioridade', 'report', '#f59e0b', 'leo'),
('Ativo', 'report', '#10b981', 'leo'),
('Balística', 'report', '#8b5cf6', 'leo'),
('Relacionado a gangue', 'report', '#ec4899', 'leo'),
('Relacionado com drogas', 'report', '#06b6d4', 'leo'),
('Tráfego', 'report', '#3b82f6', 'leo'),
('Ocorrência nacional', 'report', '#6b7280', 'leo'),
('Agressão', 'report', '#ef4444', 'leo'),
('Prioridade Alta', 'report', '#f59e0b', 'leo'),
('Confidencial', 'report', '#8b5cf6', 'leo'),
('Investigação ativa', 'report', '#10b981', 'leo');

INSERT IGNORE INTO mdt_tags (name, type, color, job_type) VALUES
('Overdose', 'report', '#ef4444', 'ems'),
('Trauma', 'report', '#f97316', 'ems'),
('DOA', 'report', '#6b7280', 'ems'),
('Transportes', 'report', '#3b82f6', 'ems'),
('Emergência Médica', 'report', '#f59e0b', 'ems'),
('Psiquiátrico', 'report', '#8b5cf6', 'ems');

INSERT IGNORE INTO `mdt_report_templates` (`id`, `name`, `type`, `content`) VALUES
(1, 'Incidente padrão', 'Incident Report', '<h2>Resumo do incidente</h2>\n<p>Em [DATA], aproximadamente às [HORÁRIO], [NOME/MATRÍCULA DO AGENTE] atendeu uma ocorrência em [LOCAL] relacionada a [TIPO DE INCIDENTE].</p>\n\n<h2>Detalhes do incidente</h2>\n<p>[DESCREVA A CENA E OS FATOS EM ORDEM CRONOLÓGICA.]</p>\n\n<h2>Partes envolvidas</h2>\n<p><strong>Comunicante:</strong> [NOME E CONTATO]</p>\n<p><strong>Suspeito(s):</strong> [NOME/DESCRIÇÃO]</p>\n<p><strong>Vítima(s):</strong> [NOME]</p>\n<p><strong>Testemunha(s):</strong> [NOME E RESUMO DO DEPOIMENTO]</p>\n\n<h2>Evidências coletadas</h2>\n<ul><li>[ITEM 1 - DESCRIÇÃO E LOCAL ONDE FOI ENCONTRADO]</li><li>[ITEM 2 - DESCRIÇÃO E LOCAL ONDE FOI ENCONTRADO]</li></ul>\n\n<h2>Providências adotadas</h2>\n<p>[DESCREVA PRISÕES, AUTUAÇÕES, ATENDIMENTO MÉDICO E DEMAIS PROVIDÊNCIAS.]</p>\n\n<h2>Conclusão</h2>\n<p>[SITUAÇÃO DO CASO E PROVIDÊNCIAS PENDENTES.]</p>'),
(2, 'Ocorrência de trânsito', 'Traffic Report', '<h2>Resumo da ocorrência de trânsito</h2>\n<p>Em [DATA], aproximadamente às [HORÁRIO], [NOME/MATRÍCULA DO AGENTE] atendeu uma ocorrência de trânsito em [LOCAL/CRUZAMENTO].</p>\n\n<h2>Veículos envolvidos</h2>\n<p><strong>Veículo 1:</strong> [MODELO] - Placa: [PLACA] - Condutor: [NOME]</p>\n<p><strong>Veículo 2:</strong> [MODELO] - Placa: [PLACA] - Condutor: [NOME]</p>\n\n<h2>Descrição da ocorrência</h2>\n<p>[DESCREVA COMO OCORREU, SENTIDO DOS VEÍCULOS, VELOCIDADE E CONDIÇÕES DA VIA E DO TEMPO.]</p>\n\n<h2>Feridos</h2>\n<p>[DESCREVA OS FERIMENTOS, O ATENDIMENTO REALIZADO E O DESTINO DO TRANSPORTE.]</p>\n\n<h2>Autuações emitidas</h2>\n<ul><li>[CONDUTOR] - [CÓDIGO DA INFRAÇÃO] - [DESCRIÇÃO]</li></ul>\n\n<h2>Testemunhas</h2>\n<p>[NOME]: [RESUMO DO DEPOIMENTO]</p>\n\n<h2>Observações adicionais</h2>\n<p>[DESCREVA A DISPOSIÇÃO DA CENA OU INDIQUE O DIAGRAMA ANEXADO.]</p>'),
(3, 'Relatório de investigação', 'Investigation Report', '<h2>Visão geral do caso</h2>\n<p><strong>Número do caso:</strong> [NÚMERO]</p>\n<p><strong>Investigador responsável:</strong> [NOME/MATRÍCULA]</p>\n<p><strong>Data de abertura:</strong> [DATA]</p>\n<p><strong>Classificação:</strong> [CRIME/CONTRAVENÇÃO/OUTRO]</p>\n\n<h2>Contexto</h2>\n<p>[DESCREVA O MOTIVO DA INVESTIGAÇÃO E CITE RELATÓRIOS ANTERIORES RELACIONADOS.]</p>\n\n<h2>Pessoas de interesse</h2>\n<p><strong>Suspeito 1:</strong> [NOME, DESCRIÇÃO, ASSOCIADOS E ÚLTIMO LOCAL CONHECIDO]</p>\n<p><strong>Suspeito 2:</strong> [NOME E DESCRIÇÃO]</p>\n\n<h2>Resumo das evidências</h2>\n<ul><li>[DESCRIÇÃO DA EVIDÊNCIA]</li><li>[DESCRIÇÃO DA EVIDÊNCIA]</li></ul>\n\n<h2>Linha do tempo</h2>\n<ul><li><strong>[DATA/HORÁRIO]:</strong> [EVENTO]</li><li><strong>[DATA/HORÁRIO]:</strong> [EVENTO]</li></ul>\n\n<h2>Entrevistas realizadas</h2>\n<p><strong>[NOME]:</strong> [RESUMO DA ENTREVISTA]</p>\n\n<h2>Conclusões e recomendações</h2>\n<p>[RESUMA AS CONCLUSÕES E RECOMENDE AS PRÓXIMAS PROVIDÊNCIAS.]</p>'),
(4, 'Relatório de prisão', 'Arrest Report', '<h2>Resumo da prisão</h2>\n<p>Em [DATA], aproximadamente às [HORÁRIO], [NOME/MATRÍCULA DO AGENTE] prendeu [NOME DO SUSPEITO] em [LOCAL].</p>\n\n<h2>Dados do suspeito</h2>\n<p><strong>Nome:</strong> [NOME COMPLETO]</p>\n<p><strong>ID do cidadão:</strong> [ID]</p>\n<p><strong>Descrição:</strong> [DESCRIÇÃO]</p>\n\n<h2>Fundada suspeita</h2>\n<p>[DESCREVA AS CIRCUNSTÂNCIAS E EVIDÊNCIAS QUE JUSTIFICARAM A PRISÃO.]</p>\n\n<h2>Acusações</h2>\n<ul><li>[CÓDIGO E DESCRIÇÃO]</li><li>[CÓDIGO E DESCRIÇÃO]</li></ul>\n\n<h2>Narrativa</h2>\n<p>[RELATO CRONOLÓGICO DOS FATOS QUE LEVARAM À PRISÃO.]</p>\n\n<h2>Evidências apreendidas</h2>\n<ul><li>[ITEM E DESCRIÇÃO]</li></ul>\n\n<h2>Direitos de Miranda</h2>\n<p>Os direitos foram lidos ao suspeito às [HORÁRIO]. O suspeito [SOLICITOU/NÃO SOLICITOU] advogado e [FORNECEU/NÃO FORNECEU] declaração.</p>\n\n<h2>Processamento</h2>\n<p>O suspeito foi registrado em [UNIDADE] às [HORÁRIO]. [INFORMAÇÕES SOBRE FIANÇA OU RETENÇÃO.]</p>'),
(5, 'Relatório de evidências', 'Evidence Report', '<h2>Resumo das evidências</h2>\n<p><strong>Caso relacionado:</strong> [NÚMERO DO CASO]</p>\n<p><strong>Agente responsável pela coleta:</strong> [NOME/MATRÍCULA]</p>\n<p><strong>Data da coleta:</strong> [DATA]</p>\n<p><strong>Local:</strong> [LOCAL DA COLETA]</p>\n\n<h2>Itens coletados</h2>\n<h3>Item 1</h3>\n<p><strong>Descrição:</strong> [DESCRIÇÃO DETALHADA]</p>\n<p><strong>Número de série/ID:</strong> [SE APLICÁVEL]</p>\n<p><strong>Local onde foi encontrado:</strong> [POSIÇÃO EXATA NA CENA]</p>\n<p><strong>Condição:</strong> [CONDIÇÃO AO SER ENCONTRADO]</p>\n<p><strong>Armazenamento:</strong> [ARMÁRIO/ID DO DEPÓSITO]</p>\n\n<h3>Item 2</h3>\n<p><strong>Descrição:</strong> [DESCRIÇÃO DETALHADA]</p>\n<p><strong>Local onde foi encontrado:</strong> [POSIÇÃO EXATA NA CENA]</p>\n<p><strong>Armazenamento:</strong> [ARMÁRIO/ID DO DEPÓSITO]</p>\n\n<h2>Cadeia de custódia</h2>\n<ul><li><strong>[DATA/HORÁRIO]:</strong> Coletado por [NOME] em [LOCAL]</li><li><strong>[DATA/HORÁRIO]:</strong> Transferido para [NOME/UNIDADE]</li></ul>\n\n<h2>Análise solicitada</h2>\n<p>[DESCREVA A ANÁLISE LABORATORIAL OU O EXAME FORENSE SOLICITADO.]</p>\n\n<h2>Observações</h2>\n<p>[INFORMAÇÕES ADICIONAIS RELEVANTES.]</p>');

INSERT IGNORE INTO `mdt_awards` (`id`, `name`, `description`, `icon`, `category`, `goal_type`, `goal_amount`) VALUES
(1, 'Primeiro relatório', 'Registre seu primeiro relatório no sistema MDT', 'description', 'relatórios', 'reports', 1),
(2, '50 relatórios registrados', 'Registre 50 relatórios e demonstre consistência na documentação', 'description', 'relatórios', 'reports', 50),
(3, '100 relatórios registrados', 'Registre 100 relatórios e demonstre dedicação à manutenção de registros completos', 'description', 'relatórios', 'reports', 100),
(4, 'Primeira prisão', 'Efetue sua primeira prisão e registre o relatório correspondente', 'local_police', 'prisões', 'arrests', 1),
(5, '50 prisões', 'Efetue 50 prisões como agente experiente', 'local_police', 'prisões', 'arrests', 50),
(6, 'Investigador de casos', 'Trabalhe em 25 casos como investigador', 'work', 'casos', 'cases', 25),
(7, 'Cem mil dólares', 'Aplique um total de $100.000 em multas', 'payments', 'financeiro', 'totalFined', 100000),
(8, '10 mandados emitidos', 'Emita 10 mandados contra suspeitos', 'gavel', 'mandados', 'warrants', 10);

INSERT IGNORE INTO `mdt_custom_licenses` (`name`, `description`) VALUES
('Licença de Caça', 'Permite a caça de animais selvagens em zonas designadas'),
('Licença náutica', 'Necessária para conduzir embarcações'),
('Licença de piloto', 'Necessária para operar aeronaves');

INSERT IGNORE INTO `mdt_fto_phases` (`id`, `job`, `name`, `description`, `duration_days`, `sort_order`) VALUES
(1, 'police', 'Fase 1 - Observação', 'O estagiário observa o instrutor durante atendimentos e patrulhas. O instrutor demonstra procedimentos adequados, elaboração de relatórios e comunicação por rádio.', 14, 1),
(2, 'police', 'Fase 2 - Patrulha supervisionada', 'O estagiário lidera os atendimentos sob supervisão. O instrutor avalia a tomada de decisões, a segurança do agente e a aplicação da lei.', 21, 2),
(3, 'police', 'Fase 3 - Supervisão reduzida', 'O estagiário atua com intervenção mínima do instrutor, que interfere somente quando necessário e avalia sua aptidão para patrulhar sozinho.', 14, 3),
(4, 'police', 'Fase 4 - Avaliação individual', 'O estagiário patrulha de forma independente enquanto o instrutor observa à distância ou acompanha pelo rádio. Esta é a avaliação final antes da aprovação.', 7, 4);

INSERT IGNORE INTO `mdt_fto_competencies` (`id`, `job`, `name`, `category`, `sort_order`) VALUES
(1, 'police', 'Operações de condução e veículos', 'Patrulha', 1),
(2, 'police', 'Radiocomunicação', 'Comunicação', 2),
(3, 'police', 'Comunicação verbal', 'Comunicação', 3),
(4, 'police', 'Escrita de Relatórios', 'Documentação', 4),
(5, 'police', 'Conhecimento do Código Penal', 'Jurídico', 5),
(6, 'police', 'Conhecimento das Leis de Tráfego', 'Jurídico', 6),
(7, 'police', 'Tomada de decisão sobre o uso da força', 'Tático', 7),
(8, 'police', 'Segurança e percepção situacional do agente', 'Tático', 8),
(9, 'police', 'Abordagem de suspeitos e redução de conflitos', 'Comunicação', 9),
(10, 'police', 'Gerenciamento de ocorrências', 'Tático', 10),
(11, 'police', 'Tratamento de Provas', 'Documentação', 11),
(12, 'police', 'Profissionalismo e conduta', 'Geral', 12);

INSERT IGNORE INTO `mdt_sop_settings` (`job`, `mission_statement`, `introduction`, `version`) VALUES
('police',
 '<p><strong>Missão</strong></p><p>A missão da aplicação da lei é fornecer serviços de segurança pública eficientes e eficazes aos moradores e visitantes da cidade. Oferecemos esses serviços com caráter, competência e comunicação aberta.</p><p><strong>Valores</strong></p><p>Julgamento, Unidade, Habilidade, Confiança, Ingenuidade, Coragem, Empoderamento =<strong>JUSTIÇA</strong></p><p><strong>M.O.S. Requerimento</strong></p><p>Espera-se que todos os Membros do Serviço (M.O.S.) cumpram em todos os momentos os valores acima mencionados e procedam código de conduta.</p><p>Um briefing deve ser conduzido se houver 4 ou mais policiais no referido departamento pelo seu departamento CS. A legislatura do Departamento ditará os termos dessas instruções.</p>',
 '<p>Ao acessar este Terminal de Dados Móveis, você reconhece que leu, compreendeu e concorda em seguir todos os Procedimentos Operacionais Padrão estabelecidos pelo Departamento.</p><p>Espera-se que todos os Membros do Serviço mantenham o profissionalismo, mantenham a lei e ajam com integridade em todos os momentos durante o serviço.</p><p>O não cumprimento desses procedimentos pode resultar em ação disciplinar, incluindo, mas não se limitando à suspensão, rebaixamento ou rescisão.</p><p>Se você tiver alguma dúvida sobre esses procedimentos, entre em contato com seu supervisor ou cadeia de comando.</p>',
 0);

INSERT IGNORE INTO `mdt_sop_categories` (`id`, `job`, `title`, `icon`, `sort_order`) VALUES
(1, 'police', 'Código de Ética', 'gavel', 1),
(2, 'police', 'Juramento de serviço', 'military_tech', 2),
(3, 'police', 'Padrões de patrulha', 'local_police', 3),
(4, 'police', 'Conduta dos membros', 'groups', 4),
(5, 'police', 'Disciplinas de Comando', 'report', 5),
(6, 'police', 'Incidentes', 'emergency', 6),
(7, 'police', 'Condução e Chamadas de Emergência', 'directions_car', 7),
(8, 'police', 'Políticas', 'policy', 8),
(9, 'police', 'Utilização da Força', 'security', 9),
(10, 'police', 'Formação e procedimentos', 'school', 10),
(11, 'police', 'Veículos', 'directions_car', 11);

INSERT IGNORE INTO `mdt_sop_sections` (`id`, `category_id`, `title`, `content`, `sort_order`) VALUES
(1, 1, 'Código de Ética',
 '<p>O Código de Ética estabelece um conjunto de valores e princípios em que todo o trabalho do departamento deve ser feito dentro. A violação de qualquer uma das éticas pode levar a queixas, ação disciplinar que pode incluir demissão.</p><p>Ao se tornar um oficial da lei, você ganha muitas responsabilidades, incluindo o poder e a capacidade de cumprir a lei. Dentro da lei você tem muito poder para prender, acusar e procurar civis. Todos estes devem estar dentro das leis do Estado. Qualquer falha em seguir oficiais superiores pode levar à Disciplina de Comando. A capacidade que é dada aos LEOs não pode ser abusada ou ser utilizada de forma diversa, caso contrário, podem ser tomadas medidas disciplinares.</p><ul><li>Profissionalismo</li><li>Responsabilidade</li><li>Respeito</li><li>Liderança</li></ul><p>Nunca agirei oficiamente ou permitirei que sentimentos pessoais, preconceitos, animosidades ou amizades influenciem minhas decisões. Sem compromisso para o crime e com a acusação implacável de criminosos, vou aplicar a lei com cortesia e apropriadamente sem medo ou favor, malícia ou má vontade, nunca empregando força desnecessária ou violência e nunca aceitar gratificações.</p><p>Reconheço o distintivo do meu gabinete como símbolo da fé pública, e aceito-o como uma confiança pública a ser mantida desde que seja fiel à ética do serviço policial. Sempre me esforçarei para alcançar esses objetivos e ideais, dedicando-me diante de Deus à minha profissão escolhida... Polícia.</p>',
 1),
(2, 2, 'Juramento de Estado',
 '<p><em>"Juro solenemente: Apoiarei, protegerei e defenderei a Constituição e o Governo dos Estados Unidos e do Estado; prestarei estrita obediência aos meus superiores na Agência de Execução da Lei, e observarei e cumprirei todas as ordens e regulamentos por eles prescritos para o governo e administração da referida Patrulha; sempre me comportarei sobriedade, honra e honestamente; manterei estrita, pontual e constante atenção aos meus deveres; abster-me-ei de toda personalidade ofensiva ou conduta imprópria para um Oficial de Execução da Lei; cumprirei minhas funções destemidamente, imparcialmente e com toda a devida cortesia e cumprirei com toda a fidelidade os deveres de um Oficial de Execução da Lei sobre o qual estou agora prestes a entrar. Que Deus me ajude."</em></p>',
 1),
(3, 3, 'Equipamento e preparação',
 '<ul><li><strong>Os agentes responsáveis pela aplicação da lei devem dispor de todo o equipamento adequado para desempenhar funções policiais.</strong></li><li><strong>Os agentes de aplicação da lei devem ter todos os equipamentos disponíveis e prontos para utilização.</strong></li><li><strong>Os agentes responsáveis pela aplicação da lei devem assegurar que o veículo dispõe de equipamento adequado e é passível de manutenção.</strong></li><li><strong>Os agentes da lei devem garantir que todas as armas sejam carregadas e servidas.</strong></li><li><strong>Os agentes da lei devem atender a todas as chamadas.</strong></li><li><strong>Os agentes da lei seguirão a cadeia de comando adequada.</strong></li><li><strong>Os agentes responsáveis pela aplicação da lei devem assegurar-se de que agem de forma segura.</strong></li></ul>',
 1),
(4, 4, 'Normas de Conduta do Oficial',
 '<ul><li>Os agentes policiais devem manter os rolamentos profissionais o tempo todo.</li><li>Os agentes da lei nunca devem assediar, intimidar ou violar os direitos de qualquer civil.</li><li>Os agentes policiais nunca devem abusar de seu poder para beneficiar-se ou ferir outros de qualquer forma. (Fisicamente, fisicamente, verbalmente ou de qualquer forma que esteja abaixo do juramento de um Oficial para proteger e servir.)</li><li>Os agentes de aplicação da lei devem ajudar todos os civis que necessitem do melhor possível.</li><li>Os agentes de aplicação da lei devem obedecer a qualquer ordem legal emitida por um supervisor de posto superior ao deles.</li><li>Os agentes de aplicação da lei são responsáveis por qualquer dano que cause a uma pessoa fora do Estado de direito e de acordo com o guia de patrulha de cada departamento.</li><li>Os agentes da lei devem e vão seguir todas as leis rodoviárias e não abusar das sirenes para ignorar essas leis.</li><li>Os agentes responsáveis pela aplicação da lei devem poder justificar qualquer uso da força ou da causa para uma detenção/parada de qualquer pessoa.</li><li>Os agentes responsáveis pela aplicação da lei não discriminarão qualquer pessoa por qualquer razão, incluindo, mas não se limitando a: Raça, religião, orientação sexual e gênero.</li></ul>',
 1),
(5, 5, 'Disciplinas de Comando',
 '<p>Disciplinas de Comando são recomendadas para má conduta que é mais problemática do que treinamento ruim, mas não sobe para o nível de encargos. Disciplinas de comando serão emitidas a todos os oficiais de aplicação da lei que violarem regulamentos ou não obedecerem a uma ordem legal de um supervisor, também conhecido como insubordinação.</p><p>Policiais podem acumular-se até<strong>(3)</strong>Disciplinas de Comando antes de terminar o departamento. Os agentes de aplicação da lei podem ser rescindidos também dependendo do nível do crime ou ofensas cometidas; isso depende do pessoal de comando e aprovado pelo Comissário.</p><p><strong>Nota:</strong>Um Verbal e Escrito devido à repetição da mesma má conduta será igual a uma Final.</p><p>(Verbal, Escrito, Final) são os CDs a que se referem.</p>',
 1),
(6, 5, 'Suspensão e encerramento',
 '<p>Os agentes policiais estão sujeitos à suspensão de qualquer CD escrito com base na discrição do supervisor.</p><p>A rescisão é a resposta final aos problemas de comportamento de um agente da lei. Os oficiais serão formalmente soltos pelo departamento e isso é decidido pelo supervisor. Agentes de condicional, ainda em andamento, podem ser encerrados por um SGT/LT.</p>',
 2),
(7, 5, 'Regras e assistência',
 '<p><strong>Regras:</strong>Todas as regras, políticas e procedimentos se aplicam aos LEO em todos os momentos.</p><p><strong>Política de participação:</strong>Policiais que estão ativos são muito apreciados, mas como todos sabemos nossas vidas e família são mais importantes. Os agentes que estarão ocupados devem avisar o pessoal de comando.</p><p><strong>Conduta Proibida:</strong></p><ul><li>Consumo de estupefacientes e álcool em serviço = ENCERRAMENTO</li><li>Envolvendo-se em discussão com outros membros enquanto intoxicado IRL em um canal de patrulha.</li></ul>',
 3),
(8, 6, 'Direito a uma Autoridade',
 '<p>Os cidadãos têm o direito de falar com um supervisor. Quando um supervisor é solicitado por um civil, espera-se que ele responda à chamada quando estiver disponível.</p><p>Os detidos têm também o direito de falar com um supervisor, caso o solicitem. Se um supervisor for solicitado por um suspeito a ser preso, pode ser levado para o Departamento de Polícia ou para o local atual para esperar por um. <strong>Mas, eles não devem receber nenhuma acusação criminal até que o supervisor tenha falado com eles.</strong></p><p><strong>O direito a um supervisor só pode ser recusado nas seguintes situações:</strong></p><ul><li>O Supervisor esteve anteriormente envolvido no caso do suspeito e confirmou que o suspeito será acusado.</li><li>Se o agente de detenção já for um Supervisor. Por exemplo, o sargento não tem que pedir a um tenente ou outro supervisor para falar com seu suspeito se o suspeito pedir.</li><li>Não há supervisores disponíveis.</li><li>Se não houver supervisores em Duty, qualquer ACL pode assumir o papel do supervisor e falar com o suspeito como um assistente de treinamento de campo.</li></ul>',
 1),
(9, 6, 'Receber e responder às chamadas',
 '<p><strong>Recebendo uma chamada de emergência:</strong>Sempre reconheça a chamada, se enviada por despacho, notificá-los e esclarecer que você está respondendo. Se notificado pelo sistema 911, então avise a todos sobre o canal de tráfego de rádio que você estará respondendo.</p><p><strong>Chegando à cena:</strong>Quando você chegar ao local, avise o despacho e seus colegas de que você chegou ao local. Geralmente, a menos que designado, o primeiro oficial no local será sempre o Oficial responsável (OIC). O primeiro supervisor no local tomará o comando da cena. É sua responsabilidade manter o despacho e/ou outros oficiais informados da situação que se desenrola e levar os suspeitos de volta para a Delegacia.</p>',
 2),
(10, 6, 'Cadeia e punição',
 '<p><strong>Tratamento dos suspeitos:</strong>Se um supervisor é solicitado por um suspeito a ser preso, então eles podem ser levados ao Departamento de Polícia para esperar por um, mas eles não devem receber quaisquer acusações criminais até que o supervisor tenha falado com eles. Por favor, consulte Direito a um Supervisor para quando o direito a um supervisor pode ser negado.</p><p><strong>Castigos:</strong>Os oficiais são esperados para não somar leis e não maximizar as sentenças, a menos que o assunto é o crime. Pequena quebra de leis (por exemplo, infrações de trânsito) deve<strong>NUNCA</strong>ser adicionado para criar uma sentença de prisão maior. Em geral, a extensão ou a cooperação oferecida pelo suspeito devem ser consideradas aquando da fixação de uma pena de prisão ou da emissão de uma multa.</p><ul><li><strong>Oficial de detenção DEVE ler os Direitos de Miranda</strong>Antes de prender ou transportar o sujeito para a Estação. * Em diferentes circunstâncias os direitos de Miranda podem ser lidos na estação.</li><li>Os agentes de detenção têm de explicar as acusações do suspeito antes de prendê-los.</li><li>Os agentes devem soltar o suspeito antes de enviá-los para a prisão.</li><li>Ao transportar um suspeito, o veículo deve incluir uma gaiola de transporte prisional.</li><li>Os suspeitos devem ser revistados antes de serem transportados.</li><li>Os agentes de detenção têm de fazer um relatório sobre o sistema MDT.</li><li><strong>Ao prender um suspeito, o Oficial de Detenção deve usar sempre os Código Penal para as Sentenças e para as Acusações.</strong></li></ul><p>Toda sentença está sujeita à discrição do oficial depois de ter em consideração outros crimes pendentes, status de liberdade condicional, crimes repetidos, ou outras informações obtidas durante a investigação. Os oficiais são encorajados a dar clemência a criminosos cooperativos e não violentos. Todas as cargas são empilháveis e sujeitas a alterações sem aviso prévio.</p><p><strong>Classificação dos crimes:</strong></p><ul><li><strong>Infração</strong>- A menos grave violação do código penal. Resulta em uma multa e/ou perda de um privilégio.</li><li><strong>Contravenção</strong>- Uma pequena violação do código penal. Resultados em prisão, multa e/ou prisão.</li><li><strong>Delito</strong>- Violação grave do código penal. Resultados em prisão, multa e prisão.</li></ul>',
 3),
(11, 7, 'Definições de condução de emergência',
 '<p><strong>Condução de Emergência (Não-Pesquisa):</strong>O funcionamento de um veículo de emergência (luzes vermelhas e azuis de emergência e sirene em funcionamento) por um agente da aplicação da lei em resposta a uma situação de risco de vida ou a um crime violento em curso, tendo devidamente em conta a segurança de outros.</p><p><strong>Condução de perseguição:</strong>Uma tentativa de um oficial da lei operando um veículo de emergência e utilizando simultaneamente luzes vermelhas e azuis e sirene para prender um ocupante de outro veículo em movimento, quando o motorista do veículo em fuga está ciente da tentativa e está resistindo à apreensão, mantendo ou aumentando a velocidade, desobedecendo as Leis de Tráfego, ignorando ou tentando iludir os oficiais da aplicação da lei.</p><p>O(s) agente(s) deve(m) deixar sempre o(s) espaço(s) entre o(s) suspeito(s) e o(s) seu(s) veículo(s) durante a perseguição, em caso de travagem de emergência ou de acidente. A Manobra do Pit só pode ser realizada por Supervisores ou Oficiais Certificados do Pit. A manobra de pit só deve ser realizada se não houver tráfego. A Manobra do Pit nunca deve ser realizada em Áreas Residenciais.</p><p><strong>A seguir:</strong>Condução em proximidade com um veículo sujeito sem utilizar qualquer esforço de apreensão, como luzes vermelhas e azuis ou sirenes, ou qualquer outro método de direção para parar.</p>',
 1),
(12, 7, 'Códigos de resposta',
 '<p><strong>Códigos de resposta às chamadas de emergência:</strong></p><p><strong>Código 1 - Não-Urgente / Sem Luzes, Sem Sereias:</strong>Supervisor chamadas, danos à propriedade, invasão, roubo de propriedade (não em andamento), Jaywalking.</p><p><strong>Código 2 - Alta prioridade / luzes acesas, sem sirenes:</strong>Chamadas de parada de trânsito, luta em progresso, acidentes de carro, tiros disparados na área, roubo de propriedade em andamento.</p><p><strong>Código 3 - Luzes de emergência e sirenes acesas:</strong>Perseguição de Veículos, Oficial para baixo ou em perigo, Roubo Armado, Procurado, Atualização de Homicídios, Tiro Ativo.</p>',
 2),
(13, 8, 'Identificação dos agentes',
 '<p>Os oficiais devem sempre se identificar como policiais durante uma situação e, especialmente, quando entram em um prédio ou durante as Paradas de Tráfego. Caso contrário, os oficiais poderiam estar enganados como pessoas hostis. Os agentes devem também comunicar o seu nome e os seus números de identificação a outros, se solicitado, se a pessoa que os solicita desejar apresentar uma queixa.</p><p><em>* Oficiais disfarçados não são obrigados a identificar-se aos civis se eles estão executando uma investigação.</em></p>',
 1),
(14, 8, 'Desempenho dos deveres',
 '<p><strong>Desempenho negligente dos deveres:</strong>Um oficial que exerce funções, mesmo dentro dos limites da lei, pode ser considerado negligente no desempenho de suas funções, se obviamente não agirem o melhor de sua capacidade ou se seu comportamento colocar em perigo de forma irracional a vida dos cidadãos, outros oficiais, ou de si mesmos, e os riscos, obviamente e pesadamente superam os benefícios.</p><p><strong>Respostas Supervisor às Chamadas:</strong>Espera-se que os supervisores respondam à chamada mais importante na altura e não possam ficar ociosos ou ignorar as funções regulares de policiamento e supervisão, em vez de tarefas mais brandas. <strong>Os supervisores devem responder e julgar todos os incidentes de tiroteio envolvidos em oficiais.</strong></p><ul><li>Os supervisores devem tomar Relatórios de Incidentes (em MDT) de cenas envolvidas de tiro, acidentes oficiais, perseguição de veículos.</li></ul>',
 2),
(15, 8, 'Estrutura do mandado',
 '<p>Para que um mandado seja motivo suficiente para prender alguém e ser classificado como "válido", você precisa fornecer uma visão geral da situação, incluindo evidências e armas usadas (se houver). Mandados apenas dizendo "Tentado para executar o motorista uber sobre" não será classificado como "válido" ou ser suficiente para prender alguém para, como ele não dá uma visão geral da situação, nem nos diz que tipo de evidência estava presente na época. Também é importante especificar se é um mandado de busca ou se é um mandado de prisão.</p><p>Um bom exemplo de mandado de detenção é: <em>"Mandado de prisão: Matou o civil durante o assalto à mão armada a 24 horas por dia com uma Beretta M9. Várias testemunhas, incluindo policiais, testemunharam a situação. Provas encontradas no local."</em></p><p>Um bom exemplo de um mandado de busca é: <em>"Mandado de busca: As plantas de drogas parecem ser visíveis da janela do apartamento, indicando que a produção de drogas está em andamento. O dono do apartamento recusou-se a abrir a porta para os oficiais."</em></p>',
 3),
(16, 8, 'Botão de pânico e comando de cena',
 '<p><strong>Botão de pânico:</strong>O Botão do Pânico só deve ser pressionado quando houver uma preocupação urgente com a segurança pessoal de você ou de um colega, o que requer assistência imediata.</p><ul><li><strong>Todas as unidades devem responder às cenas 10-99. Os supervisores podem cancelar se não forem necessárias mais unidades no local.</strong></li></ul><p><strong>Comando de Cena:</strong>O primeiro sargento ou superior no local será considerado como Comando de Cena. Somente o Comando de Cena pode remover Unidades da Cena Ativa, independentemente do Rank. O Comando Ativo da Cena irá aconselhar os oficiais sobre o que fazer. <strong>Os assistentes de treinamento de campo podem tomar o Scene Command se não houver um supervisor ativo no dever.</strong></p>',
 4),
(17, 8, 'Paragem de Tráfego',
 '<p>No momento de qualquer paragem de trânsito, é e deve ser conhecido como uma cena e será tratado como tal. Embora um policial tenha qualquer pessoa sob investigação por excesso de velocidade, equipamentos inoperáveis e veículos considerados impróprios para as estradas, todos os suspeitos serão atualmente detidos (<strong>eles não têm que estar algemados, eles podem estar em seu veículo</strong>) durante a paragem de trânsito. Talvez não saiam do local, mas talvez chamem um advogado antes do tempo, caso sintam necessidade de fazê - lo. Em nenhum momento durante uma parada de trânsito deve ser usado o uso de força mortal, a menos que um oficial teme por sua vida. Menos do que letal é sempre permitido se a situação surgir.</p><p>Durante uma parada de trânsito, se os comandos dos agentes da lei são dados ao suspeito ou ao acusado e após várias tentativas o suspeito se recusa a cumprir, então vários passos de menos do que a força letal são permitidos. O uso desta força é determinado pelo chefe de departamento. O uso de força mortal não é permitido e resultará na remoção do oficial ou ação disciplinar.</p>',
 5),
(18, 8, 'Limites de Velocidade e Roubos',
 '<p><strong>Limites de velocidade:</strong></p><ul><li>Limites da cidade - 40 MPH</li><li>Rodovias / Fora da Cidade - 80 MPH</li></ul><p><strong>Oficiais Máximos permitidos por roubo:</strong></p><ul><li>Casino Heist: 4</li><li>Roubo ao Pacífico: 5</li><li>Roubo de Jóias: 3</li><li>Roubo à Fleeca: 4</li><li>Roubo à casa: 2</li><li>Roubo à loja: 3</li><li>Roubo de comboio: 4</li><li>Roubo de camiões: 3</li><li>Ativo 10-80s: 3 (carros)</li></ul>',
 6),
(19, 8, 'Air One',
 '<p>Para que um oficial seja certificado como Air One, deve ser treinado e liberado por um Instrutor de Treinamento de Campo. Apenas um Departamento FTI certificado pela Air One pode autorizar outros a serem certificados. Para ser liberado para certificação Air One, seu instrutor de treinamento irá levá-lo através do curso de treinamento Air One, onde você terá que mostrar ao seu instrutor sua capacidade de voar e usar Air One. Só passará se tiver mostrado ao seu instrutor que está pronto. Você também será ensinado a maneira correta de usar Air One.</p><p><strong>Regras:</strong></p><ul><li>O Air One só pode sair durante 30 minutos antes de ter de voltar à MRPD para reabastecer.</li><li>Deve haver um tempo de reabastecimento de 3-5 minutos antes do Air One voltar ao ar ou voltar a uma situação ativa.</li><li>Só é possível soltar pessoas se a área estiver segura (o que significa que ninguém está atirando no Air One).</li></ul>',
 7),
(20, 9, 'Utilização da Política de Força',
 '<p>Os agentes responsáveis pela aplicação da lei podem utilizar qualquer força na execução das suas funções, desde que tal seja razoável e justificável.</p><ul><li><strong>Uma arma de fogo só pode ser utilizada quando existe um perigo claro e presente para a vida e outros métodos não letais são inadequados ou falharam.</strong></li><li><strong>As armas de fogo nunca devem ser utilizadas para prender um suspeito em fuga, a menos que se justifique no ponto acima.</strong></li><li><strong>Os tiros de aviso nunca devem ser disparados.</strong></li><li><strong>Só deverá descarregar a sua arma se tiver uma linha de visão clara e for seguro fazê-lo.</strong>Não efetue disparos cruzados na direção de outros agentes.</li><li><strong>Os agentes que utilizem uma força excessiva na execução das suas funções sem uma razão razoável e justificável podem conduzir a uma ação disciplinar.</strong></li></ul>',
 1),
(21, 9, 'Orientações Mortais para a Força',
 '<p><strong>a) Utilização da força mortal:</strong>Força mortal significa força que é usada contra outro indivíduo, que provavelmente causará sérios danos corporais ou morte ao indivíduo em questão. A utilização de força mortal pode ser utilizada se existir uma ou mais das seguintes circunstâncias:</p><p><strong>1 - Autodefesa:</strong>Quando a força mortal razoavelmente parece ser necessária para proteger um oficial que razoavelmente acredita em si mesmo está em perigo iminente de morte ou dano corporal grave.</p><p><strong>2 - Crimes graves:</strong>Quando a força mortal de forma razoável e objetiva parece ser necessária para proteger o público de uma ofensa grave. Exemplos: O assunto em questão está a conduzir imprudentemente ao ponto em que representa uma ameaça iminente para o público em geral ou para os agentes. Ou o sujeito está atualmente armado com uma arma de fogo e os oficiais acreditam que, sem qualquer dúvida, o sujeito irá usá-lo.</p><p><strong>3 - Pneus:</strong>Os agentes devem apontar para os pneus de um veículo quando for necessário atirar num veículo de condução imprudente em que os ocupantes sejam conhecidos por estarem armados ou sejam um perigo para o público. Uma vez que os pneus foram furados, os agentes devem parar de atirar no veículo.</p><p><strong>4 - Um Aviso:</strong>"POLÍCIA PARE" ou "POLÍCIA, PARE OU VOCÊ SERÁ BOLADO" geralmente deve ser dado se possível antes que o oficial dispare sua arma.</p><p><strong>5 - Veículos:</strong>Em geral, os veículos não devem ser utilizados como arma, a menos que este seja o último recurso do oficial.</p>',
 2),
(22, 10, 'Fases de treino',
 '<p>Quando você se tornar um oficial de aplicação da lei dentro do departamento, você deve passar por 3 estágios de treinamento de campo. Cada estagiário será designado com um oficial de formação em campo ou um assistente de formação em campo. Os estagiários que passarem as 3 etapas do treinamento de campo terão a capacidade de patrulhar sozinhos. Até lá, só podem patrulhar com agentes de patrulha ou FTO.</p>',
 1),
(23, 10, 'Direitos Miranda',
 '<p><em>"Você tem o direito de permanecer em silêncio, qualquer coisa que você diz ou faz pode ser usado contra você em um tribunal de direito, você tem o direito de um advogado. Se não puder pagar um, será nomeado pelo Estado. Compreende os direitos que lhe foram lidos? Com estes direitos em mente, deseja falar comigo?"</em></p>',
 2),
(24, 10, 'Advogado Ping',
 '<p>Quando se prende alguém, tem direito a um advogado presente. Marque os advogados no Discord, na categoria DOJ e no canal #lawyer-ping. Espere uma resposta ou um advogado chegar. Se ninguém chegar depois de 10 minutos, prossiga com a prisão.</p>',
 3),
(25, 11, 'Veículos PD',
 '<p>Os carros de polícia (os que encontrar na garagem) serão distribuídos como carros pessoais. Você pode estacioná-los em suas garagens e fazer upgrades para seus cruzadores pessoais.</p><ul><li>Você não pode mudar as cores ou os viveiros.</li><li>Você pode instalar upgrades para tornar o seu carro mais rápido com qualquer um dos mecânicos na cidade.</li></ul>',
 1),
(26, 11, 'Unidade K9',
 '<p><em>Trabalho em Progresso</em></p>',
 2);

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (1, 0, '0', 100000, 3, 0, 'Davis Avenue Ron');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (2, 0, '0', 100000, 3, 0, 'Grove Street LTD');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (3, 0, '0', 100000, 3, 0, 'Dutch London Xero');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (4, 0, '0', 100000, 3, 0, 'Little Seoul LTD');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (5, 0, '0', 100000, 3, 0, 'Strawberry Ave Xero');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (6, 0, '0', 100000, 3, 0, 'Popular Street Ron');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (7, 0, '0', 100000, 3, 0, 'Capital Blvd Ron');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (8, 0, '0', 100000, 3, 0, 'Mirror Park LTD');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (9, 0, '0', 100000, 3, 0, 'Clinton Ave Globe Oil');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (10, 0, '0', 100000, 3, 0, 'North Rockford Ron');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (11, 0, '0', 100000, 3, 0, 'Great Ocean Xero');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (12, 0, '0', 100000, 3, 0, 'Paleto Blvd Xero');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (13, 0, '0', 100000, 3, 0, 'Paleto Ron');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (14, 0, '0', 100000, 3, 0, 'Paleto Globe Oil');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (15, 0, '0', 100000, 3, 0, 'Grapeseed LTD');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (16, 0, '0', 100000, 3, 0, 'Sandy Shores Xero');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (17, 0, '0', 100000, 3, 0, 'Sandy Shores Globe Oil');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (18, 0, '0', 100000, 3, 0, 'Senora Freeway Xero');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (19, 0, '0', 100000, 3, 0, 'Harmony Globe Oil');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (20, 0, '0', 100000, 3, 0, 'Route 68 Globe Oil');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (21, 0, '0', 100000, 3, 0, 'Route 68 Workshop Globe O');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (22, 0, '0', 100000, 3, 0, 'Route 68 Xero');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (23, 0, '0', 100000, 3, 0, 'Route 68 Ron');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (24, 0, '0', 100000, 3, 0, "Rex\'s Diner Globe Oil");

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (25, 0, '0', 100000, 3, 0, 'Palmino Freeway Ron');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (26, 0, '0', 100000, 3, 0, 'North Rockford LTD');

INSERT IGNORE INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES (27, 0, '0', 100000, 3, 0, 'Alta Street Globe Oil');

-- Triggers originais do MDT, em instrucao unica para importadores SQL.

CREATE TRIGGER IF NOT EXISTS `mdt_reports_charges_after_delete` AFTER UPDATE ON `mdt_reports_charges` FOR EACH ROW
UPDATE mdt_reports_warrants
    SET
        felonies = (
            SELECT SUM(CASE WHEN mc.charge_class = 'felony' THEN 1 ELSE 0 END)
        FROM mdt_reports_charges AS mrc
                     INNER JOIN mdt_penal_codes AS mc
                                ON mrc.charge = mc.label
            WHERE mrc.reportid = OLD.reportid
        ),
        misdemeanors = (
            SELECT SUM(CASE WHEN mc.charge_class = 'misdemeanor' THEN 1 ELSE 0 END)
        FROM mdt_reports_charges AS mrc
                     INNER JOIN mdt_penal_codes AS mc
                                ON mrc.charge = mc.label
            WHERE mrc.reportid = OLD.reportid
        ),
        infractions = (
            SELECT SUM(CASE WHEN mc.charge_class = 'infraction' THEN 1 ELSE 0 END)
        FROM mdt_reports_charges AS mrc
                     INNER JOIN mdt_penal_codes AS mc
                                ON mrc.charge = mc.label
            WHERE mrc.reportid = OLD.reportid
        )
    WHERE reportid = OLD.reportid;

CREATE TRIGGER IF NOT EXISTS `mdt_reports_charges_after_insert` AFTER INSERT ON `mdt_reports_charges` FOR EACH ROW
UPDATE mdt_reports_warrants
    SET
        felonies = (
            SELECT SUM(CASE WHEN mc.charge_class = 'felony' THEN 1 ELSE 0 END)
        FROM mdt_reports_charges AS mrc
                     INNER JOIN mdt_penal_codes AS mc
                                ON mrc.charge = mc.label
            WHERE mrc.reportid = NEW.reportid
        ),
        misdemeanors = (
            SELECT SUM(CASE WHEN mc.charge_class = 'misdemeanor' THEN 1 ELSE 0 END)
        FROM mdt_reports_charges AS mrc
                     INNER JOIN mdt_penal_codes AS mc
                                ON mrc.charge = mc.label
            WHERE mrc.reportid = NEW.reportid
        ),
        infractions = (
            SELECT SUM(CASE WHEN mc.charge_class = 'infraction' THEN 1 ELSE 0 END)
        FROM mdt_reports_charges AS mrc
                     INNER JOIN mdt_penal_codes AS mc
                                ON mrc.charge = mc.label
            WHERE mrc.reportid = NEW.reportid
        )
    WHERE reportid = NEW.reportid;
