-- 테이블 정의, 물리 스키마 정제

-- ALTER TABLE
-- => 자동 생성해주는 CREATE TABLE 문 최종 버전을
--      여기에 업데이트

-- 트레이너
CREATE TABLE `trainer` (
  `trainer_id` int NOT NULL AUTO_INCREMENT,
  `trainer_name` varchar(20) NOT NULL,
  `trainer_gender` varchar(5) NOT NULL,
  `trainer_age` int DEFAULT NULL,
  `activity_area` varchar(10) NOT NULL,
  `starting_at` datetime DEFAULT '2022-01-01 00:00:00',
  `number_of_pokemon` int DEFAULT NULL,
  PRIMARY KEY (`trainer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 도감
CREATE TABLE `pokemon_index` (
  `pokemon_index_id` int NOT NULL AUTO_INCREMENT,
  `pokemon_index_name` varchar(20) NOT NULL,
  `pokemon_type` varchar(10) DEFAULT 'normal',
  `pokemon_evolved_check` tinyint(1) DEFAULT '0',
  `pokemon_activity_area` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`pokemon_index_id`),
  UNIQUE KEY `pokemon_index_name` (`pokemon_index_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 포켓몬
CREATE TABLE `pokemon` (
  `pokemon_captured_id` int NOT NULL AUTO_INCREMENT,
  `pokemon_index_id` int NOT NULL,
  `pokemon_rename` varchar(10) NOT NULL,
  `pokemon_age` int DEFAULT '0',
  `pokemon_height` int NOT NULL,
  `pokemon_weight` varchar(5) DEFAULT '1kg',
  `pokemon_captured_at` datetime DEFAULT '2022-01-01 00:00:00',
  `pokemon_captured_area` varchar(10) DEFAULT NULL,
  `master_id` int NOT NULL,
  PRIMARY KEY (`pokemon_captured_id`),
  KEY `master_id` (`master_id`),
  KEY `pokemon_index_id` (`pokemon_index_id`),
  CONSTRAINT `pokemon_ibfk_1` FOREIGN KEY (`master_id`) REFERENCES `trainer` (`trainer_id`),
  CONSTRAINT `pokemon_ibfk_2` FOREIGN KEY (`pokemon_index_id`) REFERENCES `pokemon_index` (`pokemon_index_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 전투결과
CREATE TABLE `battle_result` (
  `battle_result_id` INT NOT NULL AUTO_INCREMENT,
  `winner_id` INT NOT NULL,
  `loser_id` INT NOT NULL,
  `result_description` TEXT,
  PRIMARY KEY (`battle_result_id`),
  KEY `winner_id` (`winner_id`),
  KEY `loser_id` (`loser_id`),
  CONSTRAINT `battle_result_ibfk_1` FOREIGN KEY (`winner_id`) REFERENCES `trainer` (`trainer_id`),
  CONSTRAINT `battle_result_ibfk_2` FOREIGN KEY (`loser_id`) REFERENCES `trainer` (`trainer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 포켓몬 도감과 포켓몬 테이블 연결을 위한 컬럼 추가
ALTER TABLE `pokemon_index`
ADD COLUMN `pokemon_evolved_index_id` INT DEFAULT NULL,
ADD COLUMN `pokemon_evolved_index_name` VARCHAR(20) DEFAULT NULL,
ADD COLUMN `pokemon_evolved_index_type` VARCHAR(10) DEFAULT NULL,
ADD CONSTRAINT `fk_evolved_index_id` FOREIGN KEY (`pokemon_evolved_index_id`) REFERENCES `pokemon_index` (`pokemon_index_id`);
