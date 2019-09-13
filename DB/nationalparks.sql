-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nationalparks
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `nationalparks` ;

-- -----------------------------------------------------
-- Schema nationalparks
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nationalparks` DEFAULT CHARACTER SET utf8 ;
USE `nationalparks` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `id` INT NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location` ;

CREATE TABLE IF NOT EXISTS `location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `state` VARCHAR(45) NOT NULL,
  `latitude` DOUBLE NOT NULL,
  `longitude` DOUBLE NOT NULL,
  `region_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_location_region1_idx` (`region_id` ASC),
  CONSTRAINT `fk_location_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `national_park`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `national_park` ;

CREATE TABLE IF NOT EXISTS `national_park` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `location_id` INT NOT NULL,
  `link_nps` VARCHAR(5000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_national_park_location_idx` (`location_id` ASC),
  CONSTRAINT `fk_national_park_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trip` ;

CREATE TABLE IF NOT EXISTS `trip` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `national_park_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trip_national_park1_idx` (`national_park_id` ASC),
  INDEX `fk_trip_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_trip_national_park1`
    FOREIGN KEY (`national_park_id`)
    REFERENCES `national_park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wildlife`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wildlife` ;

CREATE TABLE IF NOT EXISTS `wildlife` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `link_wiki` VARCHAR(5000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `activity` ;

CREATE TABLE IF NOT EXISTS `activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `link_wiki` VARCHAR(5000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `geo_feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `geo_feature` ;

CREATE TABLE IF NOT EXISTS `geo_feature` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trip_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trip_comment` ;

CREATE TABLE IF NOT EXISTS `trip_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `trip_id` INT NOT NULL,
  `create_date` DATE NULL,
  `description` TEXT NULL,
  `title` VARCHAR(250) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_trip1_idx` (`trip_id` ASC),
  CONSTRAINT `fk_comment_trip1`
    FOREIGN KEY (`trip_id`)
    REFERENCES `trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `national_park_wildlife`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `national_park_wildlife` ;

CREATE TABLE IF NOT EXISTS `national_park_wildlife` (
  `national_park_id` INT NOT NULL,
  `wildlife_id` INT NOT NULL,
  PRIMARY KEY (`national_park_id`, `wildlife_id`),
  INDEX `fk_national_park_has_wildlife_wildlife1_idx` (`wildlife_id` ASC),
  INDEX `fk_national_park_has_wildlife_national_park1_idx` (`national_park_id` ASC),
  CONSTRAINT `fk_national_park_has_wildlife_national_park1`
    FOREIGN KEY (`national_park_id`)
    REFERENCES `national_park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_national_park_has_wildlife_wildlife1`
    FOREIGN KEY (`wildlife_id`)
    REFERENCES `wildlife` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `national_park_geo_feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `national_park_geo_feature` ;

CREATE TABLE IF NOT EXISTS `national_park_geo_feature` (
  `national_park_id` INT NOT NULL,
  `geo_feature_id` INT NOT NULL,
  PRIMARY KEY (`national_park_id`, `geo_feature_id`),
  INDEX `fk_national_park_has_geo_feature_geo_feature1_idx` (`geo_feature_id` ASC),
  INDEX `fk_national_park_has_geo_feature_national_park1_idx` (`national_park_id` ASC),
  CONSTRAINT `fk_national_park_has_geo_feature_national_park1`
    FOREIGN KEY (`national_park_id`)
    REFERENCES `national_park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_national_park_has_geo_feature_geo_feature1`
    FOREIGN KEY (`geo_feature_id`)
    REFERENCES `geo_feature` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `national_park_activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `national_park_activity` ;

CREATE TABLE IF NOT EXISTS `national_park_activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `national_park_id` INT NOT NULL,
  `activity_id` INT NOT NULL,
  INDEX `fk_national_park_has_activity_activity1_idx` (`activity_id` ASC),
  INDEX `fk_national_park_has_activity_national_park1_idx` (`national_park_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_national_park_has_activity_national_park1`
    FOREIGN KEY (`national_park_id`)
    REFERENCES `national_park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_national_park_has_activity_activity1`
    FOREIGN KEY (`activity_id`)
    REFERENCES `activity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `visitor_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `visitor_type` ;

CREATE TABLE IF NOT EXISTS `visitor_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `national_park_has_visitor_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `national_park_has_visitor_type` ;

CREATE TABLE IF NOT EXISTS `national_park_has_visitor_type` (
  `national_park_id` INT NOT NULL,
  `visitor_type_id` INT NOT NULL,
  PRIMARY KEY (`national_park_id`, `visitor_type_id`),
  INDEX `fk_national_park_has_visitor_type_visitor_type1_idx` (`visitor_type_id` ASC),
  INDEX `fk_national_park_has_visitor_type_national_park1_idx` (`national_park_id` ASC),
  CONSTRAINT `fk_national_park_has_visitor_type_national_park1`
    FOREIGN KEY (`national_park_id`)
    REFERENCES `national_park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_national_park_has_visitor_type_visitor_type1`
    FOREIGN KEY (`visitor_type_id`)
    REFERENCES `visitor_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trip_activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trip_activity` ;

CREATE TABLE IF NOT EXISTS `trip_activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `trip_id` INT NOT NULL,
  `national_park_activity_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trip_activity_trip_idx` (`trip_id` ASC),
  INDEX `fk_trip_activity_np_activity_idx` (`national_park_activity_id` ASC),
  CONSTRAINT `fk_trip_activity_trip`
    FOREIGN KEY (`trip_id`)
    REFERENCES `trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_activity_np_activity`
    FOREIGN KEY (`national_park_activity_id`)
    REFERENCES `national_park_activity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS notVisitor@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'notVisitor'@'localhost' IDENTIFIED BY 'notVisitor';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'notVisitor'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `user` (`id`, `username`, `password`, `active`, `first_name`, `last_name`, `email_address`) VALUES (1, 'admin', 'admin', true, 'Skill', 'Distillery', 'admin@skilldistillery.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `region`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `region` (`id`, `name`) VALUES (1, 'Northeast');
INSERT INTO `region` (`id`, `name`) VALUES (2, 'Southeast');
INSERT INTO `region` (`id`, `name`) VALUES (3, 'Midwest');
INSERT INTO `region` (`id`, `name`) VALUES (4, 'Pacific West');
INSERT INTO `region` (`id`, `name`) VALUES (5, 'Inter Mountain');
INSERT INTO `region` (`id`, `name`) VALUES (6, 'Alaska');

COMMIT;


-- -----------------------------------------------------
-- Data for table `location`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (1, 'Maine', 44.35, -68.21, 1);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (2, 'American Samoa', -14.25, -170.68, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (3, 'Utah', 38.68, -109.57, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (4, 'South Dakota', 43.75, -102.5, 3);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (5, 'Texas', 29.25, -103.25, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (6, 'Florida', 25.65, -80.08, 2);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (7, 'Colorado', 38.57, -107.72, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (8, 'Utah', 37.57, -112.18, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (9, 'Utah', 38.2, -109.93, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (10, 'Utah', 38.2, -111.17, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (11, 'New Mexico', 32.17, -104.44, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (12, 'California', 34.01, -119.42, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (13, 'South Carolina', 33.78, -80.78, 2);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (14, 'Oregon', 42.94, -122.1, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (15, 'Ohio', 41.24, -81.55, 3);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (16, 'California', 36.24, -116.82, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (17, 'Alaska', 63.33, -150.5, 6);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (18, 'Florida', 24.63, -82.87, 2);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (19, 'Florida', 25.32, -80.93, 2);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (20, 'Alaska', 67.78, -153.3, 6);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (21, 'Montana', 48.8, -114, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (22, 'Alaska', 58.5, -137, 6);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (23, 'Arizona', 36.06, -112.14, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (24, 'Wyoming', 43.73, -110.8, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (25, 'Nevada', 38.98, -114.3, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (26, 'Colorado', 37.73, -105.51, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (27, 'Tennessee', 35.68, -83.53, 2);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (28, 'Texas', 31.92, -104.87, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (29, 'Hawaii', 20.72, -156.17, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (30, 'Hawaii', 19.38, -155.2, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (31, 'Arkansas', 34.51, -93.05, 3);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (32, 'Michigan', 48.1, -88.55, 3);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (33, 'California', 33.79, -115.9, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (34, 'Alaska', 58.5, -155, 6);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (35, 'Alaska', 59.92, -149.65, 6);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (36, 'California', 36.8, -118.55, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (37, 'Alaska', 67.55, -159.28, 6);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (38, 'Alaska', 60.97, -153.42, 6);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (39, 'California', 40.49, -121.51, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (40, 'Kentucky', 37.18, -86.1, 2);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (41, 'Colorado', 37.18, -108.49, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (42, 'Washington', 46.85, -121.75, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (43, 'Washington', 48.7, -121.2, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (44, 'Washington', 47.97, -123.5, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (45, 'Arizona', 35.07, -109.78, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (46, 'California', 36.48, -121.16, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (47, 'California', 41.3, -124, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (48, 'Colorado', 40.4, -105.58, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (49, 'Arizona', 32.25, -110.5, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (50, 'California', 36.43, -118.68, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (51, 'Virginia', 38.53, -78.35, 1);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (52, 'North Dakota', 46.97, -103.45, 3);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (53, 'US Virgin Islands', 18.33, -64.73, 2);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (54, 'Minnesota', 48.5, -92.88, 3);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (55, 'South Dakota', 43.57, -103.48, 3);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (56, 'Alaska', 61, -142, 6);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (57, 'Wyoming', 44.6, -110.5, 5);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (58, 'California', 37.83, -119.5, 4);
INSERT INTO `location` (`id`, `state`, `latitude`, `longitude`, `region_id`) VALUES (59, 'Utah', 37.3, -113.05, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `wildlife`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (1, 'Bald Eagle', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (2, 'Sea Turtle', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (3, 'Bison', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (4, 'Elk', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (5, 'Bear', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (6, 'Moose', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (7, 'Bats', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (8, 'Gators', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (9, 'Birds', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (10, 'Wolves', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (11, 'Whales', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (12, 'Marmots', NULL);
INSERT INTO `wildlife` (`id`, `name`, `link_wiki`) VALUES (13, 'Bighorn', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (1, 'Snorkeling', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (2, 'Hiking', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (3, 'Swimming', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (4, 'Biking', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (5, 'Horseback Riding', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (6, 'Bird Watching', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (7, 'Fishing', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (8, 'Rock Climbing ', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (9, 'Boating', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (10, 'Camping', NULL);
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (11, 'Back Packing', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `geo_feature`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `geo_feature` (`id`, `name`) VALUES (1, 'Forest');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (2, 'Mountains');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (3, 'Ocean');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (4, 'Lake');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (5, 'Desert');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (6, 'Glacier');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (7, 'Volcano');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (8, 'Waterfall');

COMMIT;


-- -----------------------------------------------------
-- Data for table `visitor_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `visitor_type` (`id`, `name`) VALUES (1, 'Handicapped');
INSERT INTO `visitor_type` (`id`, `name`) VALUES (2, 'Youth');
INSERT INTO `visitor_type` (`id`, `name`) VALUES (3, 'Senior');

COMMIT;

