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
-- Table `account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `account` ;

CREATE TABLE IF NOT EXISTS `account` (
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
  `link_image_url` VARCHAR(5000) NULL,
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
  `account_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trip_national_park1_idx` (`national_park_id` ASC),
  INDEX `fk_trip_user_idx` (`account_id` ASC),
  CONSTRAINT `fk_trip_national_park1`
    FOREIGN KEY (`national_park_id`)
    REFERENCES `national_park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_user`
    FOREIGN KEY (`account_id`)
    REFERENCES `account` (`id`)
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
  `link_wiki` VARCHAR(45) NULL,
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
-- Table `national_park_visitor_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `national_park_visitor_type` ;

CREATE TABLE IF NOT EXISTS `national_park_visitor_type` (
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

SET SQL_MODE = '';
DROP USER IF EXISTS notVisitor@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'notVisitor'@'localhost' IDENTIFIED BY 'notVisitor';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'notVisitor'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `account`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `account` (`id`, `username`, `password`, `active`, `first_name`, `last_name`, `email_address`) VALUES (1, 'admin', 'admin', true, 'Skill', 'Distillery', 'admin@skilldistillery.com');

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
-- Data for table `national_park`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (1, 'Acadia', 'Covering most of Mount Desert Island and other coastal islands, Acadia features the tallest mountain on the Atlantic coast of the United States, granite peaks, ocean shoreline, woodlands, and lakes. There are freshwater, estuary, forest, and intertidal habitats.', 1, 'https://www.nps.gov/acad/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (2, 'American Samoa', 'The southernmost National Park is on three Samoan islands and protects coral reefs, rainforests, volcanic mountains, and white beaches. The area is also home to flying foxes, brown boobies, sea turtles, and 900 species of fish.', 2, 'https://www.nps.gov/npsa/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (3, 'Arches', 'This site features more than 2,000 natural sandstone arches, with some of the most popular arches in the park being Delicate Arch, Landscape Arch and Double Arch. Millions of years of erosion have created these structures located in a desert climate where the arid ground has life-sustaining biological soil crusts and potholes that serve as natural water-collecting basins. Other geologic formations include stone pinnacles, fins, and balancing rocks.', 3, 'https://www.nps.gov/arch/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (4, 'Badlands', 'The Badlands are a collection of buttes, pinnacles, spires, and mixed-grass prairies. The White River Badlands contain the largest assemblage of known late Eocene and Oligocene mammal fossils. The wildlife includes bison, bighorn sheep, black-footed ferrets, and prairie dogs.', 4, 'https://www.nps.gov/badl/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (5, 'Big Bend', 'Named for the prominent bend in the Rio Grande along the U.S.ÐMexico border, this park encompasses a large and remote part of the Chihuahuan Desert. Its main attraction is backcountry recreation in the arid Chisos Mountains and in canyons along the river. A wide variety of Cretaceous and Tertiary fossils as well as cultural artifacts of Native Americans also exist within its borders.', 5, 'https://www.nps.gov/bibe/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (6, 'Biscayne', 'Located in Biscayne Bay, this park at the north end of the Florida Keys has four interrelated marine ecosystems: mangrove forest, the Bay, the Keys, and coral reefs. Threatened animals include the West Indian manatee, American crocodile, various sea turtles, and peregrine falcon.', 6, 'https://www.nps.gov/bisc/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (7, 'Black Canyon of the Gunnison', 'The park protects a quarter of the Gunnison River, which slices sheer canyon walls from dark Precambrian-era rock. The canyon features some of the steepest cliffs and oldest rock in North America, and is a popular site for river rafting and rock climbing. The deep, narrow canyon is composed of gneiss and schist which appears black when in shadow.', 7, 'https://www.nps.gov/blca/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (8, 'Bryce Canyon', 'Bryce Canyon is a geological amphitheater on the Paunsaugunt Plateau with hundreds of tall, multicolored sandstone hoodoos formed by erosion. The region was originally settled by Native Americans and later by Mormon pioneers.', 8, 'https://www.nps.gov/brca/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (9, 'Canyonlands', 'This landscape was eroded into a maze of canyons, buttes, and mesas by the combined efforts of the Colorado River, Green River, and their tributaries, which divide the park into three districts. The park also contains rock pinnacles and arches, as well as artifacts from Ancient Pueblo peoples.', 9, 'https://www.nps.gov/cany/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (10, 'Capitol Reef', 'The park\'s Waterpocket Fold is a 100-mile (160 km) monocline that exhibits the earth\'s diverse geologic layers. Other natural features include monoliths, cliffs, and sandstone domes shaped like the United States Capitol.', 10, 'https://www.nps.gov/care/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (11, 'Carlsbad Caverns', 'Carlsbad Caverns has 117 caves, the longest of which is over 120 miles (190 km) long. The Big Room is almost 4,000 feet (1,200 m) long, and the caves are home to over 400,000 Mexican free-tailed bats and sixteen other species. Above ground are the Chihuahuan Desert and Rattlesnake Springs.', 11, 'https://www.nps.gov/cave/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (12, 'Channel Islands', 'Five of the eight Channel Islands are protected, and half of the park\'s area is underwater. The islands have a unique Mediterranean ecosystem originally settled by the Chumash people. They are home to over 2,000 species of land plants and animals, and 145 are unique to them, including the island fox. Ferry services offer transportation to the islands from the mainland.', 12, 'https://www.nps.gov/chis/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (13, 'Congaree', 'On the Congaree River, this park is the largest portion of old-growth floodplain forest left in North America. Some of the trees are the tallest in the eastern United States. An elevated walkway called the Boardwalk Loop guides visitors through the swamp.', 13, 'https://www.nps.gov/cong/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (14, 'Crater Lake', 'Crater Lake lies in the caldera of an ancient volcano called Mount Mazama that collapsed 7,700 years ago. It is the deepest lake in the United States and is noted for its vivid blue color and water clarity. There are two more recent volcanic islands in the lake, and, with no inlets or outlets, all water comes through precipitation.', 14, 'https://www.nps.gov/crla/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (15, 'Cuyahoga Valley', 'This park along the Cuyahoga River has waterfalls, hills, trails, and exhibits on early rural living. The Ohio and Erie Canal Towpath Trail follows the Ohio and Erie Canal, where mules towed canal boats. The park has numerous historic homes, bridges, and structures, and also offers a scenic train ride.', 15, 'https://www.nps.gov/cuva/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (16, 'Death Valley', 'Death Valley is the hottest, lowest, and driest place in the United States. Daytime temperatures have topped 130 ¡F (54 ¡C) and it is home to Badwater Basin, the lowest elevation in North America. The park contains canyons, badlands, sand dunes, and mountain ranges, while more than 1000 species of plants grow in this geologic graben. Additional points of interest include salt flats, historic mines, and springs.', 16, 'https://www.nps.gov/deva/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (17, 'Denali', 'Centered on Denali, the tallest mountain in North America, Denali is serviced by a single road leading to Wonder Lake. Denali and other peaks of the Alaska Range are covered with long glaciers and boreal forest. Wildlife includes grizzly bears, Dall sheep, caribou, and gray wolves.', 17, 'https://www.nps.gov/dena/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (18, 'Dry Tortugas', 'The islands of the Dry Tortugas, at the westernmost end of the Florida Keys, are the site of Fort Jefferson, a Civil War-era fort that is the largest masonry structure in the Western Hemisphere. With most of the park being remote ocean, it is home to undisturbed coral reefs and shipwrecks and is only accessible by plane or boat.', 18, 'https://www.nps.gov/drto/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (19, 'Everglades', 'The Everglades are the largest tropical wilderness in the United States. This mangrove and tropical rainforest ecosystem and marine estuary is home to 36 protected species, including the Florida panther, American crocodile, and West Indian manatee. Some areas have been drained and developed; restoration projects aim to restore the ecology.', 19, 'https://www.nps.gov/ever/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (20, 'Gates of the Arctic', 'The country\'s northernmost park protects an expanse of pure wilderness in Alaska\'s Brooks Range and has no park facilities. The land is home to Alaska Natives who have relied on the land and caribou for 11,000 years.', 20, 'https://www.nps.gov/gaar/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (21, 'Glacier', 'The U.S. half of Waterton-Glacier International Peace Park, this park includes 26 glaciers and 130 named lakes surrounded by Rocky Mountain peaks. There are historic hotels and a landmark road called the Going-to-the-Sun Road in this region of rapidly receding glaciers. The local mountains, formed by an overthrust, expose Paleozoic fossils including trilobites, mollusks, giant ferns and dinosaurs.', 21, 'https://www.nps.gov/glac/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (22, 'Glacier Bay', 'Glacier Bay contains tidewater glaciers, mountains, fjords, and a temperate rainforest, and is home to large populations of grizzly bears, mountain goats, whales, seals, and eagles. When discovered in 1794 by George Vancouver, the entire bay was covered by ice, but the glaciers have since receded more than 65 miles (105 km).', 22, 'https://www.nps.gov/glba/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (23, 'Grand Canyon', 'The Grand Canyon, carved by the mighty Colorado River, is 277 miles (446 km) long, up to 1 mile (1.6 km) deep, and up to 15 miles (24 km) wide. Millions of years of erosion have exposed the multicolored layers of the Colorado Plateau in mesas and canyon walls, visible from both the north and south rims, or from a number of trails that descend into the canyon itself.', 23, 'https://www.nps.gov/grca/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (24, 'Grand Teton', 'Grand Teton is the tallest mountain in the Teton Range. The park\'s historic Jackson Hole and reflective piedmont lakes teem with endemic wildlife, with a backdrop of craggy mountains that rise abruptly from the sage-covered valley.', 24, 'https://www.nps.gov/grte/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (25, 'Great Basin', 'Based around Nevada\'s second tallest mountain, Wheeler Peak, Great Basin National Park contains 5,000-year-old bristlecone pines, a rock glacier, and the limestone Lehman Caves. Due to its remote location, the park has some of the country\'s darkest night skies. Wildlife includes the Townsend\'s big-eared bat, pronghorn, and Bonneville cutthroat trout.', 25, 'https://www.nps.gov/grba/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (26, 'Great Sand Dunes', 'The tallest sand dunes in North America, up to 750 feet (230 m) tall, were formed by deposits of the ancient Rio Grande in the San Luis Valley. Abutting a variety of grasslands, shrublands, and wetlands, the park also has alpine lakes, six 13,000-foot mountains, and old-growth forests.', 26, 'https://www.nps.gov/grsa/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (27, 'Great Smoky Mountains', 'The Great Smoky Mountains, part of the Appalachian Mountains, span a wide range of elevations, making them home to over 400 vertebrate species, 100 tree species, and 5000 plant species. Hiking is the park\'s main attraction, with over 800 miles (1,300 km) of trails, including 70 miles (110 km) of the Appalachian Trail. Other activities include fishing, horseback riding, and touring nearly 80 historic structures.', 27, 'https://www.nps.gov/grsm/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (28, 'Guadalupe Mountains', 'This park contains Guadalupe Peak, the highest point in Texas, as well as the scenic McKittrick Canyon filled with bigtooth maples, a corner of the arid Chihuahuan Desert, and a fossilized coral reef from the Permian era.', 28, 'https://www.nps.gov/gumo/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (29, 'Haleakala', 'The Haleakala volcano on Maui features a very large crater with numerous cinder cones, Hosmer\'s Grove of alien trees, the Kipahulu section\'s scenic pools of freshwater fish, and the native Hawaiian goose. It is home to the greatest number of endangered species within a U.S. National Park.', 29, 'https://www.nps.gov/hale/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (30, 'Hawaii Volcanoes', 'This park on the Big Island protects the K_lauea and Mauna Loa volcanoes, two of the world\'s most active geological features. Diverse ecosystems range from tropical forests at sea level to barren lava beds at more than 13,000 feet (4,000 m).', 30, 'https://www.nps.gov/havo/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (31, 'Hot Springs', 'Hot Springs was established by act of Congress as a federal reserve on April 20, 1832. As such it is the oldest park managed by the National Park Service. Congress changed the reserve\'s designation to National Park on March 4, 1921 after the National Park Service was established in 1916. Hot Springs is the smallest and only National Park in an urban area and is based around natural hot springs that flow out of the low lying Ouachita Mountains. The springs provide opportunities for relaxation in an historic setting; Bathhouse Row preserves numerous examples of 19th-century architecture.', 31, 'https://www.nps.gov/hosp/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (32, 'Isle Royale', 'The largest island in Lake Superior is a place of isolation and wilderness. Along with its many shipwrecks, waterways, and hiking trails, the park also includes over 400 smaller islands within 4.5 miles (7.2 km) of its shores. There are only 20 mammal species on the entire island, though the relationship between its wolf and moose populations is especially unique.', 32, 'https://www.nps.gov/isro/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (33, 'Joshua Tree', 'Covering large areas of the Colorado and Mojave Deserts and the Little San Bernardino Mountains, this desert landscape is populated by vast stands of Joshua trees. Large changes in elevation reveal various contrasting environments including bleached sand dunes, dry lakes, rugged mountains, and maze-like clusters of monzogranite monoliths.', 33, 'https://www.nps.gov/jotr/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (34, 'Katmai', 'This park on the Alaska Peninsula protects the Valley of Ten Thousand Smokes, an ash flow formed by the 1912 eruption of Novarupta, as well as Mount Katmai. Over 2,000 grizzly bears come here each year to catch spawning salmon. Other wildlife includes caribou, wolves, moose, and wolverines.', 34, 'https://www.nps.gov/katm/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (35, 'Kenai Fjords', 'Near Seward on the Kenai Peninsula, this park protects the Harding Icefield and at least 38 glaciers and fjords stemming from it. The only area accessible to the public by road is Exit Glacier; the rest must be viewed or reached from boat tours.', 35, 'https://www.nps.gov/kefj/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (36, 'Kings Canyon', 'Home to several giant sequoia groves and the General Grant Tree, the world\'s second largest measured tree, this park also features part of the Kings River, sculptor of the dramatic granite canyon that is its namesake, and the San Joaquin River, as well as Boyden Cave.', 36, 'https://www.nps.gov/seki/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (37, 'Kobuk Valley', 'Kobuk Valley protects 61 miles (98 km) of the Kobuk River and three regions of sand dunes. Created by glaciers, the Great Kobuk, Little Kobuk, and Hunt River Sand Dunes can reach 100 feet (30 m) high and 100 ¡F (38 ¡C), and they are the largest dunes in the Arctic. Twice a year, half a million caribou migrate through the dunes and across river bluffs that expose well-preserved ice age fossils.', 37, 'https://www.nps.gov/kova/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (38, 'Lake Clark', 'The region around Lake Clark features four active volcanoes, including Mount Redoubt, as well as an abundance of rivers, glaciers, and waterfalls. Temperate rainforests, a tundra plateau, and three mountain ranges complete the landscape.', 38, 'https://www.nps.gov/lacl/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (39, 'Lassen Volcanic', 'Lassen Peak, the largest plug dome volcano in the world, is joined by all three other types of volcanoes in this park: shield, cinder dome, and composite. Though Lassen itself last erupted in 1915, most of the rest of the park is continuously active. Numerous hydrothermal features, including fumaroles, boiling pools, and bubbling mud pots, are heated by molten rock from beneath the peak.', 39, 'https://www.nps.gov/lavo/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (40, 'Mammoth Cave', 'With more than 400 miles (640 km) of passageways explored, Mammoth Cave is the world\'s longest known cave system. Subterranean wildlife includes eight bat species, Kentucky cave shrimp, Northern cavefish, and cave salamanders. Above ground, the park provides recreation on the Green River, 70 miles of hiking trails, and plenty of sinkholes and springs.', 40, 'https://www.nps.gov/maca/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (41, 'Mesa Verde', 'This area constitutes over 4,000 archaeological sites of the Ancestral Puebloan people, who lived here and elsewhere in the Four Corners region for at least 700 years. Cliff dwellings built in the 12th and 13th centuries include Cliff Palace, which has 150 rooms and 23 kivas, and the Balcony House, with its many passages and tunnels.', 41, 'https://www.nps.gov/meve/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (42, 'Mount Rainier', 'Mount Rainier, an active stratovolcano, is the most prominent peak in the Cascades and is covered by 26 named glaciers including Carbon Glacier and Emmons Glacier, the largest in the contiguous United States. The mountain is popular for climbing, and more than half of the park is covered by subalpine and alpine forests and meadows seasonally in bloom with wildflowers. Paradise on the south slope is the snowiest place on Earth where snowfall is measured regularly. The Longmire visitor center is the start of the Wonderland Trail, which encircles the mountain.', 42, 'https://www.nps.gov/mora/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (43, 'North Cascades', 'This complex encompasses two units of the National Park itself as well as the Ross Lake and Lake Chelan National Recreation Areas. The highly glaciated mountains are spectacular examples of Cascade geology. Popular hiking and climbing areas include Cascade Pass, Mount Shuksan, Mount Triumph, and Eldorado Peak.', 43, 'https://www.nps.gov/olym/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (44, 'Olympic', 'Situated on the Olympic Peninsula, this park includes a wide range of ecosystems from Pacific shoreline to temperate rainforests to the alpine slopes of the Olympic Mountains, the tallest of which is Mount Olympus. The Hoh Rainforest and Quinault Rainforest are the wettest area in the contiguous United States, with the Hoh receiving an average of almost 12 ft (3.7 m) of rain every year.', 44, 'https://www.nps.gov/pefo/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (45, 'Petrified Forest', 'This portion of the Chinle Formation has a large concentration of 225-million-year-old petrified wood. The surrounding Painted Desert features eroded cliffs of red-hued volcanic rock called bentonite. Dinosaur fossils and over 350 Native American sites are also protected in this park.', 45, 'https://www.nps.gov/pinn/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (46, 'Pinnacles', 'Named for the eroded leftovers of a portion of an extinct volcano, the park\'s massive black and gold monoliths of andesite and rhyolite are a popular destination for rock climbers. Hikers have access to trails crossing the Coast Range wilderness. The park is home to the endangered California condor (Gymnogyps californianus) and one of the few locations in the world where these extremely rare birds can be seen in the wild. Pinnacles also supports a dense population of prairie falcons, and more than 13 species of bat which populate its talus caves.', 46, 'https://www.nps.gov/redw/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (47, 'Redwood', 'This park and the co-managed state parks protect almost half of all remaining coastal redwoods, the tallest trees on earth. There are three large river systems in this very seismically active area, and 37 miles (60 km) of protected coastline reveal tide pools and seastacks. The prairie, estuary, coast, river, and forest ecosystems contain a wide variety of animal and plant species.', 47, 'https://www.nps.gov/romo/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (48, 'Rocky Mountain', 'Bisected north to south by the Continental Divide, this portion of the Rockies has ecosystems varying from over 150 riparian lakes to montane and subalpine forests to treeless alpine tundra. Wildlife including mule deer, bighorn sheep, black bears, and cougars inhabit its igneous mountains and glacial valleys. Longs Peak, a classic Colorado fourteener, and the scenic Bear Lake are popular destinations, as well as the historic Trail Ridge Road, which reaches an elevation of more than 12,000 feet (3,700 m).', 48, 'https://www.nps.gov/sagu/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (49, 'Saguaro', 'Split into the separate Rincon Mountain and Tucson Mountain districts, this park is evidence that the dry Sonoran Desert is still home to a great variety of life spanning six biotic communities. Beyond the namesake giant saguaro cacti, there are barrel cacti, chollas, and prickly pears, as well as lesser long-nosed bats, spotted owls, and javelinas.', 49, 'https://www.nps.gov/seki/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (50, 'Sequoia', 'This park protects the Giant Forest, which boasts some of the world\'s largest trees, the General Sherman being the largest measured tree in the park. Other features include over 240 caves, a long segment of the Sierra Nevada including the tallest mountain in the contiguous United States, and Moro Rock, a large granite dome.', 50, 'https://www.nps.gov/shen/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (51, 'Shenandoah', 'Shenandoah\'s Blue Ridge Mountains are covered by hardwood forests that teem with a wide variety of wildlife. The Skyline Drive and Appalachian Trail run the entire length of this narrow park, along with more than 500 miles (800 km) of hiking trails passing scenic overlooks and cataracts of the Shenandoah River.', 51, 'https://www.nps.gov/thro/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (52, 'Theodore Roosevelt', 'This region that enticed and influenced President Theodore Roosevelt consists of a park of three units in the northern badlands. Besides Roosevelt\'s historic cabin, there are numerous scenic drives and backcountry hiking opportunities. Wildlife includes American bison, pronghorn, bighorn sheep, and wild horses.', 52, 'https://www.nps.gov/viis/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (53, 'Virgin Islands', 'This island park on Saint John preserves Ta’no archaeological sites and the ruins of sugar plantations from Columbus\'s time, as well as all the natural environs. Surrounding the pristine beaches are mangrove forests, seagrass beds, and coral reefs.', 53, 'https://www.nps.gov/voya/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (54, 'Voyageurs', 'This park protecting four lakes near the CanadaÐUS border is a site for canoeing, kayaking, and fishing. The park also preserves a history populated by Ojibwe Native Americans, French fur traders called voyageurs, and gold miners. Formed by glaciers, the region features tall bluffs, rock gardens, islands, bays, and several historic buildings.', 54, 'https://www.nps.gov/wica/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (55, 'Wind Cave', 'Wind Cave is distinctive for its calcite fin formations called boxwork, a unique formation rarely found elsewhere, and needle-like growths called frostwork. The cave is one of the longest and most complex caves in the world. Above ground is a mixed-grass prairie with animals such as bison, black-footed ferrets, and prairie dogs, and ponderosa pine forests that are home to cougars and elk. The cave is culturally significant to the Lakota people as the site \'from which Wakan Tanka, the Great Mystery, sent the buffalo out into their hunting grounds.\'', 55, 'https://www.nps.gov/wrst/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (56, 'WrangellÐSt. Elias', 'An over 8 million acres (32,375 km2) plot of mountainous countryÑthe largest National Park in the systemÑprotects the convergence of the Alaska, Chugach, and Wrangell-Saint Elias Ranges, which include many of the continent\'s tallest mountains and volcanoes, including the 18,008-foot Mount Saint Elias. More than a quarter of the park is covered with glaciers, including the tidewater Hubbard Glacier, piedmont Malaspina Glacier, and valley Nabesna Glacier.', 56, 'https://www.nps.gov/yell/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (57, 'Yellowstone', 'Situated on the Yellowstone Caldera, the park has an expansive network of geothermal areas including boiling mud pots, vividly colored hot springs such as Grand Prismatic Spring, and regularly erupting geysers, the best-known being Old Faithful. The yellow-hued Grand Canyon of the Yellowstone River contains several high waterfalls, while four mountain ranges traverse the park. More than 60 mammal species including gray wolves, grizzly bears, black bears, lynxes, bison, and elk, make this park one of the best wildlife viewing spots in the country.', 57, 'https://www.nps.gov/yell/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (58, 'Yosemite', 'Yosemite features sheer granite cliffs, exceptionally tall waterfalls, and old-growth forests at a unique intersection of geology and hydrology. Half Dome and El Capitan rise from the park\'s centerpiece, the glacier-carved Yosemite Valley, and from its vertical walls drop Yosemite Falls, one of North America\'s tallest waterfalls at 2,425 feet (739 m) high. Three giant sequoia groves, along with a pristine wilderness in the heart of the Sierra Nevada, are home to a wide variety of rare plant and animal species.', 58, 'https://www.nps.gov/yose/index.htm', NULL);
INSERT INTO `national_park` (`id`, `name`, `description`, `location_id`, `link_nps`, `link_image_url`) VALUES (59, 'Zion', 'Located at the junction of the Colorado Plateau, Great Basin, and Mojave Desert, this park contains sandstone features such as mesas, rock towers, and canyons, including the Virgin River Narrows. The various sandstone formations and the forks of the Virgin River create a wilderness divided into four ecosystems: desert, riparian, woodland, and coniferous forest.', 59, 'https://www.nps.gov/zion/index.htm', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trip`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `trip` (`id`, `name`, `national_park_id`, `account_id`) VALUES (1, 'Yosemite', 58, 1);
INSERT INTO `trip` (`id`, `name`, `national_park_id`, `account_id`) VALUES (2, 'Wind Cave', 55, 1);

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
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (1, 'Rock Climbing', 'https://en.wikipedia.org/wiki/Rock_climbing');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (2, 'Hiking', 'https://en.wikipedia.org/wiki/Hiking');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (3, 'Camping', 'https://en.wikipedia.org/wiki/Camping');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (4, 'Backpacking', 'https://en.wikipedia.org/wiki/Backpacking_(wilderness)');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (5, 'Stargazing', 'https://en.wikipedia.org/wiki/Amateur_astronomy');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (6, 'Rapelling', 'https://en.wikipedia.org/wiki/Abseiling');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (7, 'Fishing', 'https://en.wikipedia.org/wiki/Fishing');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (8, 'Snorkling', 'https://en.wikipedia.org/wiki/Snorkeling');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (9, 'Boating', 'https://en.wikipedia.org/wiki/Boating');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (10, 'Swimming', 'https://en.wikipedia.org/wiki/Swimming');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (11, 'Caving', 'https://en.wikipedia.org/wiki/Caving');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (12, 'Mountain Biking', 'https://en.wikipedia.org/wiki/Mountain_biking');
INSERT INTO `activity` (`id`, `name`, `link_wiki`) VALUES (13, 'Bicycling ', 'https://en.wikipedia.org/wiki/Cycling');

COMMIT;


-- -----------------------------------------------------
-- Data for table `geo_feature`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `geo_feature` (`id`, `name`) VALUES (1, 'Volcanic');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (2, 'Mountains');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (3, 'Rivers');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (4, 'Ocean');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (5, 'Old Growth');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (6, 'Forests');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (7, 'Geysers');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (8, 'Redwoods');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (9, 'Glaciers');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (10, 'Lava Tubes');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (11, 'Waterfalls');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (12, 'Cactus');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (13, 'Canyons');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (14, 'Sandstone Formations');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (15, 'Lakes');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (16, 'Rain Forest');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (17, 'Swamp');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (18, 'Caves');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (19, 'Desert');
INSERT INTO `geo_feature` (`id`, `name`) VALUES (20, 'Sand Dunes');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trip_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `trip_comment` (`id`, `trip_id`, `create_date`, `description`, `title`) VALUES (1, 2, '2019-09-14', 'omg totes yes', 'Wind Cave Extravaganza');

COMMIT;


-- -----------------------------------------------------
-- Data for table `national_park_geo_feature`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (1, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (2, 4);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (3, 14);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (4, 14);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (4, 18);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (4, 1);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (5, 18);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (5, 19);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (5, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (5, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (5, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (6, 4);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (7, 18);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (7, 11);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (7, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (7, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (7, 13);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (8, 13);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (8, 14);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (9, 18);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (9, 14);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (9, 13);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (10, 13);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (10, 14);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (11, 18);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (12, 4);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (13, 5);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (13, 17);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (13, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (14, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (14, 15);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (14, 1);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (15, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (16, 19);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (17, 5);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (17, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (17, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (18, 4);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (19, 5);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (19, 17);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (20, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (20, 9);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (20, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (21, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (21, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (21, 9);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (21, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (22, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (22, 9);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (22, 5);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (22, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (23, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (23, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (23, 14);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (23, 13);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (24, 11);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (24, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (24, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (24, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (24, 7);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (25, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (25, 19);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (26, 20);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (27, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (27, 11);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (27, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (28, 18);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (28, 19);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (28, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (29, 4);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (29, 11);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (29, 1);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (29, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (30, 11);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (30, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (30, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (30, 1);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (31, 7);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (31, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (31, 15);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (32, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (32, 15);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (33, 19);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (33, 12);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (34, 9);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (35, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (35, 4);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (35, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (35, 9);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (36, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (36, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (36, 5);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (37, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (37, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (37, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (38, 15);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (38, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (38, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (38, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (39, 19);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (39, 10);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (40, 18);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (41, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (42, 1);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (42, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (42, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (42, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (43, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (43, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (44, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (44, 5);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (44, 16);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (45, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (45, 19);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (46, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (47, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (48, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (48, 11);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (48, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (49, 19);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (49, 12);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (50, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (50, 5);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (51, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (51, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (51, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (52, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (52, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (53, 4);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (54, 15);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (54, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (55, 18);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (56, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (56, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (57, 11);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (57, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (57, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (57, 7);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (58, 2);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (58, 3);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (58, 5);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (58, 6);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (58, 13);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (59, 19);
INSERT INTO `national_park_geo_feature` (`national_park_id`, `geo_feature_id`) VALUES (59, 14);

COMMIT;


-- -----------------------------------------------------
-- Data for table `national_park_activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (1, 55, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (2, 1, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (3, 1, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (4, 1, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (5, 2, 10);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (6, 2, 8);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (7, 2, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (8, 3, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (9, 3, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (10, 3, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (11, 3, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (12, 3, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (13, 4, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (14, 4, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (15, 4, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (16, 4, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (17, 4, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (18, 4, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (19, 4, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (20, 5, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (21, 5, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (22, 5, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (23, 5, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (24, 5, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (25, 5, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (26, 5, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (27, 5, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (28, 5, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (29, 6, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (30, 6, 10);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (31, 6, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (32, 6, 8);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (33, 7, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (34, 7, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (35, 7, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (36, 7, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (37, 7, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (38, 7, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (39, 7, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (40, 8, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (41, 8, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (42, 8, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (43, 8, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (44, 8, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (45, 8, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (46, 8, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (47, 8, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (48, 8, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (49, 9, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (50, 9, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (51, 9, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (52, 9, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (53, 9, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (54, 9, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (55, 9, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (56, 9, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (57, 9, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (58, 10, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (59, 10, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (60, 10, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (61, 10, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (62, 10, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (63, 10, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (64, 11, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (65, 12, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (66, 12, 10);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (67, 12, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (68, 12, 8);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (69, 12, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (70, 12, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (71, 12, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (72, 13, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (73, 13, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (74, 13, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (75, 13, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (76, 13, 10);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (77, 14, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (78, 14, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (79, 14, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (80, 14, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (81, 14, 10);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (82, 14, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (83, 14, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (84, 15, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (85, 15, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (86, 15, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (87, 15, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (88, 15, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (89, 16, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (90, 16, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (91, 16, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (92, 16, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (93, 16, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (94, 16, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (95, 16, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (96, 17, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (97, 17, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (98, 17, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (99, 17, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (100, 17, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (101, 17, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (102, 17, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (103, 17, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (104, 17, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (105, 18, 10);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (106, 18, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (107, 18, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (108, 18, 8);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (109, 18, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (110, 18, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (111, 19, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (112, 19, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (113, 19, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (114, 19, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (115, 20, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (116, 20, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (117, 20, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (118, 20, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (119, 20, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (120, 20, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (121, 20, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (122, 21, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (123, 21, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (124, 21, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (125, 21, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (126, 21, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (127, 21, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (128, 21, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (129, 22, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (130, 22, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (131, 22, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (132, 22, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (133, 22, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (134, 23, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (135, 23, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (136, 23, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (137, 23, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (138, 23, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (139, 23, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (140, 23, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (141, 23, 10);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (142, 23, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (143, 23, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (144, 23, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (145, 24, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (146, 24, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (147, 24, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (148, 24, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (149, 24, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (150, 24, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (151, 24, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (152, 24, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (153, 25, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (154, 25, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (155, 25, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (156, 25, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (157, 25, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (158, 25, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (159, 25, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (160, 26, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (161, 26, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (162, 26, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (163, 27, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (164, 27, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (165, 27, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (166, 27, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (167, 27, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (168, 27, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (169, 27, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (170, 28, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (171, 28, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (172, 28, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (173, 28, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (174, 28, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (175, 29, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (176, 29, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (177, 29, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (178, 29, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (179, 29, 8);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (180, 30, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (181, 30, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (182, 30, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (183, 30, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (184, 30, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (185, 30, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (186, 31, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (187, 31, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (188, 31, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (189, 31, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (190, 31, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (191, 32, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (192, 32, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (193, 32, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (194, 32, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (195, 33, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (196, 33, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (197, 33, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (198, 33, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (199, 33, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (200, 33, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (201, 33, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (202, 34, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (203, 34, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (204, 34, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (205, 34, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (206, 34, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (207, 34, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (208, 34, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (209, 34, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (210, 34, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (211, 35, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (212, 35, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (213, 35, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (214, 35, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (215, 35, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (216, 35, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (217, 36, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (218, 36, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (219, 36, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (220, 36, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (221, 36, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (222, 36, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (223, 37, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (224, 37, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (225, 37, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (226, 37, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (227, 37, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (228, 37, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (229, 37, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (230, 38, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (231, 38, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (232, 38, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (233, 38, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (234, 38, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (235, 38, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (236, 39, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (237, 39, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (238, 39, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (239, 39, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (240, 39, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (241, 39, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (242, 40, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (243, 41, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (244, 41, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (245, 41, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (246, 42, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (247, 42, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (248, 42, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (249, 42, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (250, 42, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (251, 42, 7);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (252, 42, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (253, 43, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (254, 43, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (255, 43, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (256, 43, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (257, 44, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (258, 44, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (259, 44, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (260, 44, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (261, 44, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (262, 45, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (263, 45, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (264, 45, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (265, 46, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (266, 46, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (267, 46, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (268, 46, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (269, 46, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (270, 46, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (271, 47, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (272, 47, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (273, 47, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (274, 47, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (275, 47, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (276, 47, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (277, 48, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (278, 48, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (279, 48, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (280, 48, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (281, 48, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (282, 48, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (283, 48, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (284, 48, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (285, 49, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (286, 49, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (287, 49, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (288, 50, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (289, 50, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (290, 50, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (291, 50, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (292, 50, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (293, 50, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (294, 51, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (295, 51, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (296, 51, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (297, 51, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (298, 51, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (299, 52, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (300, 52, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (301, 52, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (302, 52, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (303, 52, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (304, 52, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (305, 53, 10);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (306, 53, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (307, 54, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (308, 54, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (309, 54, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (310, 54, 9);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (311, 55, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (312, 55, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (313, 55, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (314, 55, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (315, 56, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (316, 56, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (317, 56, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (318, 56, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (319, 56, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (320, 56, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (321, 57, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (322, 57, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (323, 57, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (324, 57, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (325, 57, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (326, 57, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (327, 57, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (328, 58, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (329, 58, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (330, 58, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (331, 58, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (332, 58, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (333, 58, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (334, 58, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (335, 59, 11);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (336, 59, 12);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (337, 59, 13);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (338, 59, 6);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (339, 59, 4);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (340, 59, 5);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (341, 59, 3);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (342, 59, 2);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (343, 59, 1);
INSERT INTO `national_park_activity` (`id`, `national_park_id`, `activity_id`) VALUES (344, 55, 13);

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


-- -----------------------------------------------------
-- Data for table `national_park_visitor_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `national_park_visitor_type` (`national_park_id`, `visitor_type_id`) VALUES (55, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trip_activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `trip_activity` (`id`, `trip_id`, `national_park_activity_id`) VALUES (1, 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `national_park_wildlife`
-- -----------------------------------------------------
START TRANSACTION;
USE `nationalparks`;
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (1, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (1, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (1, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (1, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (1, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (1, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (1, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (1, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (1, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (2, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (2, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (2, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (2, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (2, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (2, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (2, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (2, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (2, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (3, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (3, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (3, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (3, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (3, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (3, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (3, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (3, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (3, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (4, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (4, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (4, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (4, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (4, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (4, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (4, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (4, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (4, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (5, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (5, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (5, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (5, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (5, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (5, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (5, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (5, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (5, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (6, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (6, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (6, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (6, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (6, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (6, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (6, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (6, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (6, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (7, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (7, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (7, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (7, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (7, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (7, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (7, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (7, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (7, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (8, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (8, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (8, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (8, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (8, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (8, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (8, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (8, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (8, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (9, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (9, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (9, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (9, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (9, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (9, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (9, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (9, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (9, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (10, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (10, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (10, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (10, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (10, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (10, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (10, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (10, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (10, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (11, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (11, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (11, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (11, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (11, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (11, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (11, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (11, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (11, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (12, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (12, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (12, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (12, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (12, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (12, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (12, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (12, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (12, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (13, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (13, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (13, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (13, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (13, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (13, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (13, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (13, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (13, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (14, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (14, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (14, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (14, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (14, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (14, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (14, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (14, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (14, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (15, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (15, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (15, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (15, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (15, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (15, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (15, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (15, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (15, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (16, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (16, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (16, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (16, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (16, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (16, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (16, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (16, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (16, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (17, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (17, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (17, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (17, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (17, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (17, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (17, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (17, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (17, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (18, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (18, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (18, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (18, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (18, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (18, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (18, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (18, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (18, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (19, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (19, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (19, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (19, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (19, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (19, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (19, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (19, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (19, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (20, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (20, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (20, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (20, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (20, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (20, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (20, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (20, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (20, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (21, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (21, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (21, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (21, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (21, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (21, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (21, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (21, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (21, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (22, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (22, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (22, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (22, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (22, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (22, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (22, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (22, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (22, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (23, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (23, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (23, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (23, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (23, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (23, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (23, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (23, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (23, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (24, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (24, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (24, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (24, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (24, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (24, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (24, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (24, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (24, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (25, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (25, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (25, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (25, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (25, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (25, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (25, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (25, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (25, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (26, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (26, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (26, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (26, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (26, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (26, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (26, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (26, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (26, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (27, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (27, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (27, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (27, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (27, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (27, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (27, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (27, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (27, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (28, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (28, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (28, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (28, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (28, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (28, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (28, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (28, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (28, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (29, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (29, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (29, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (29, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (29, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (29, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (29, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (29, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (29, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (30, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (30, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (30, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (30, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (30, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (30, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (30, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (30, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (30, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (31, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (31, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (31, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (31, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (31, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (31, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (31, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (31, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (31, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (32, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (32, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (32, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (32, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (32, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (32, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (32, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (32, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (32, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (33, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (33, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (33, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (33, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (33, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (33, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (33, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (33, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (33, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (34, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (34, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (34, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (34, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (34, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (34, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (34, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (34, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (34, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (35, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (35, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (35, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (35, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (35, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (35, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (35, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (35, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (35, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (36, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (36, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (36, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (36, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (36, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (36, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (36, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (36, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (36, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (37, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (37, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (37, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (37, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (37, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (37, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (37, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (37, 11);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (37, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (38, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (38, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (38, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (38, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (38, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (38, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (38, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (38, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (38, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (39, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (39, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (39, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (39, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (39, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (39, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (39, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (39, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (39, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (40, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (40, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (40, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (40, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (40, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (40, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (40, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (40, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (40, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (41, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (41, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (41, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (41, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (41, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (41, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (41, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (41, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (41, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (42, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (42, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (42, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (42, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (42, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (42, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (42, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (42, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (42, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (43, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (43, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (43, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (43, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (43, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (43, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (43, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (43, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (43, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (44, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (44, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (44, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (44, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (44, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (44, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (44, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (44, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (44, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (45, 1);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (45, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (45, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (45, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (45, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (45, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (45, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (45, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (45, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (46, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (46, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (46, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (46, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (46, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (46, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (46, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (46, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (46, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (47, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (47, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (47, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (47, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (47, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (47, 8);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (47, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (47, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (47, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (48, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (48, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (48, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (48, 5);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (48, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (48, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (48, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (48, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (48, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (49, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (49, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (49, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (49, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (49, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (49, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (49, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (49, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (49, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (50, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (50, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (50, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (50, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (50, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (50, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (50, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (50, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (50, 13);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (51, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (51, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (51, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (51, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (51, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (51, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (51, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (51, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (52, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (52, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (52, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (52, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (52, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (52, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (52, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (52, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (53, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (53, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (53, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (53, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (53, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (53, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (53, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (53, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (54, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (54, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (54, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (54, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (54, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (54, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (54, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (54, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (55, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (55, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (55, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (55, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (55, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (55, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (55, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (55, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (56, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (56, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (56, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (56, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (56, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (56, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (56, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (56, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (57, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (57, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (57, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (57, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (57, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (57, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (57, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (57, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (58, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (58, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (58, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (58, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (58, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (58, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (58, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (58, 12);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (59, 2);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (59, 3);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (59, 4);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (59, 6);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (59, 7);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (59, 9);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (59, 10);
INSERT INTO `national_park_wildlife` (`national_park_id`, `wildlife_id`) VALUES (59, 12);

COMMIT;

