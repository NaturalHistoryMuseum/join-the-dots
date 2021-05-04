-- --------------------------------------------------------
-- Host:                         msq-info-1
-- Server version:               8.0.24 - MySQL Community Server - GPL
-- Server OS:                    Linux
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for jtd_live
CREATE DATABASE IF NOT EXISTS `jtd_live` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jtd_live`;

-- Dumping structure for table jtd_live.assessment_group
CREATE TABLE IF NOT EXISTS `assessment_group` (
  `assessment_group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`assessment_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.audit
CREATE TABLE IF NOT EXISTS `audit` (
  `audit_id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) NOT NULL,
  `record_id` int NOT NULL,
  `event_type` enum('insert','update','delete') NOT NULL,
  `event_datestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `audit_user` varchar(50) NOT NULL,
  `audit_data` json DEFAULT NULL,
  PRIMARY KEY (`audit_id`),
  KEY `table_name` (`table_name`),
  KEY `record_id` (`record_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (json_valid(`audit_data`))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.bibliographic_level
CREATE TABLE IF NOT EXISTS `bibliographic_level` (
  `bibliographic_level_id` int NOT NULL AUTO_INCREMENT,
  `bibliographic_level` varchar(255) NOT NULL,
  PRIMARY KEY (`bibliographic_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.building
CREATE TABLE IF NOT EXISTS `building` (
  `building_id` int NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `building_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`building_id`),
  KEY `FK_building_site` (`site_id`),
  CONSTRAINT `FK_building_site` FOREIGN KEY (`site_id`) REFERENCES `site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.category
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.collection_unit
CREATE TABLE IF NOT EXISTS `collection_unit` (
  `collection_unit_id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(255) NOT NULL,
  `section_id` int NOT NULL,
  `unit_active` enum('yes','no') NOT NULL DEFAULT 'yes',
  `responsible_curator_id` int DEFAULT NULL,
  `curatorial_unit_definition_id` int DEFAULT NULL,
  `taxon_life_science_id` int DEFAULT NULL,
  `taxon_palaeontology_id` int DEFAULT NULL,
  `storage_room_id` int DEFAULT NULL,
  `storage_container_id` int DEFAULT NULL,
  `geographic_origin_id` int DEFAULT NULL,
  `library_and_archives_function_id` int DEFAULT NULL,
  `geological_time_period_from_id` int DEFAULT NULL,
  `geological_time_period_to_id` int DEFAULT NULL,
  `type_collection_flag` enum('yes','no') DEFAULT NULL,
  `informal_taxon` text,
  `named_collection` varchar(255) DEFAULT NULL,
  `es_recent_specimen_flag` enum('yes','no') DEFAULT NULL,
  `archives_fond_ref` varchar(255) DEFAULT NULL,
  `count_curatorial_units_flag` enum('yes','no') DEFAULT NULL,
  PRIMARY KEY (`collection_unit_id`),
  KEY `FK_collection_unit_person` (`responsible_curator_id`),
  KEY `FK_collection_unit_curatorial_unit_definition` (`curatorial_unit_definition_id`),
  KEY `FK_collection_unit_taxon_life_science` (`taxon_life_science_id`),
  KEY `FK_collection_unit_taxon_palaeontology` (`taxon_palaeontology_id`),
  KEY `FK_collection_unit_storage_room` (`storage_room_id`),
  KEY `FK_collection_unit_storage_container` (`storage_container_id`),
  KEY `FK_collection_unit_geographic_origin` (`geographic_origin_id`),
  KEY `FK_collection_unit_library_and_archives_function` (`library_and_archives_function_id`),
  KEY `FK_collection_unit_geological_time_period` (`geological_time_period_from_id`),
  KEY `FK_collection_unit_geological_time_period_2` (`geological_time_period_to_id`),
  KEY `unit_active` (`unit_active`),
  CONSTRAINT `FK_collection_unit_curatorial_unit_definition` FOREIGN KEY (`curatorial_unit_definition_id`) REFERENCES `curatorial_unit_definition` (`curatorial_unit_definition_id`),
  CONSTRAINT `FK_collection_unit_geographic_origin` FOREIGN KEY (`geographic_origin_id`) REFERENCES `geographic_origin` (`geographic_origin_id`),
  CONSTRAINT `FK_collection_unit_geological_time_period` FOREIGN KEY (`geological_time_period_from_id`) REFERENCES `geological_time_period` (`geological_time_period_id`),
  CONSTRAINT `FK_collection_unit_geological_time_period_2` FOREIGN KEY (`geological_time_period_to_id`) REFERENCES `geological_time_period` (`geological_time_period_id`),
  CONSTRAINT `FK_collection_unit_library_and_archives_function` FOREIGN KEY (`library_and_archives_function_id`) REFERENCES `library_and_archives_function` (`library_and_archives_function_id`),
  CONSTRAINT `FK_collection_unit_person` FOREIGN KEY (`responsible_curator_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `FK_collection_unit_storage_container` FOREIGN KEY (`storage_container_id`) REFERENCES `storage_container` (`storage_container_id`),
  CONSTRAINT `FK_collection_unit_storage_room` FOREIGN KEY (`storage_room_id`) REFERENCES `storage_room` (`storage_room_id`),
  CONSTRAINT `FK_collection_unit_taxon_life_science` FOREIGN KEY (`taxon_life_science_id`) REFERENCES `taxon_life_science` (`taxon_life_science_id`),
  CONSTRAINT `FK_collection_unit_taxon_palaeontology` FOREIGN KEY (`taxon_palaeontology_id`) REFERENCES `taxon_palaeontology` (`taxon_palaeontology_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.collection_unit_metric
CREATE TABLE IF NOT EXISTS `collection_unit_metric` (
  `collection_unit_metric_id` int NOT NULL AUTO_INCREMENT,
  `collection_unit_id` int NOT NULL,
  `collection_unit_metric_definition_id` int NOT NULL,
  `metric_value` double NOT NULL,
  `confidence_level` varchar(255) DEFAULT NULL,
  `date_from` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_to` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `current` enum('yes','no') NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`collection_unit_metric_id`),
  KEY `FK_collection_unit_metric_collection_unit` (`collection_unit_id`),
  KEY `FK_collection_unit_metric_collection_unit_metric_definition` (`collection_unit_metric_definition_id`),
  CONSTRAINT `FK_collection_unit_metric_collection_unit_metric_definition` FOREIGN KEY (`collection_unit_metric_definition_id`) REFERENCES `collection_unit_metric_definition` (`collection_unit_metric_definition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.collection_unit_metric_definition
CREATE TABLE IF NOT EXISTS `collection_unit_metric_definition` (
  `collection_unit_metric_definition_id` int NOT NULL AUTO_INCREMENT,
  `metric_name` varchar(255) NOT NULL,
  `metric_definition` varchar(255) DEFAULT NULL,
  `metric_units` varchar(255) DEFAULT NULL,
  `metric_datatype` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`collection_unit_metric_definition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.criterion
CREATE TABLE IF NOT EXISTS `criterion` (
  `criterion_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `contact_person_id` int DEFAULT NULL,
  `criterion_code` varchar(255) NOT NULL,
  `criterion_name` varchar(255) NOT NULL,
  `definition` text,
  `referenced_standards` text,
  PRIMARY KEY (`criterion_id`),
  UNIQUE KEY `criterion_code` (`criterion_code`),
  KEY `FK_criterion_category` (`category_id`),
  KEY `FK_criterion_person` (`contact_person_id`),
  CONSTRAINT `FK_criterion_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `FK_criterion_person` FOREIGN KEY (`contact_person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.curatorial_unit_definition
CREATE TABLE IF NOT EXISTS `curatorial_unit_definition` (
  `curatorial_unit_definition_id` int NOT NULL AUTO_INCREMENT,
  `item_type_id` int NOT NULL,
  `preservation_method_id` int NOT NULL,
  `bibliographic_level_id` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `typical_item_count` varchar(255) DEFAULT NULL,
  `typical_item_count_range` varchar(255) DEFAULT NULL,
  `items_unestimatable_flag` enum('yes','no') DEFAULT NULL,
  PRIMARY KEY (`curatorial_unit_definition_id`),
  KEY `FK_curatorial_unit_definition_preservation_method` (`preservation_method_id`),
  KEY `FK_curatorial_unit_definition_item_type` (`item_type_id`),
  KEY `FK_curatorial_unit_definition_bibliographic_level` (`bibliographic_level_id`),
  CONSTRAINT `FK_curatorial_unit_definition_bibliographic_level` FOREIGN KEY (`bibliographic_level_id`) REFERENCES `bibliographic_level` (`bibliographic_level_id`),
  CONSTRAINT `FK_curatorial_unit_definition_item_type` FOREIGN KEY (`item_type_id`) REFERENCES `item_type` (`item_type_id`),
  CONSTRAINT `FK_curatorial_unit_definition_preservation_method` FOREIGN KEY (`preservation_method_id`) REFERENCES `preservation_method` (`preservation_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.department
CREATE TABLE IF NOT EXISTS `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) NOT NULL,
  `head_of_collections_id` int DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `FK_department_person` (`head_of_collections_id`),
  CONSTRAINT `FK_department_person` FOREIGN KEY (`head_of_collections_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.division
CREATE TABLE IF NOT EXISTS `division` (
  `division_id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL,
  `division_name` varchar(255) NOT NULL,
  `principal_curator_id` int DEFAULT NULL,
  `head_of_division_id` int DEFAULT NULL,
  PRIMARY KEY (`division_id`),
  KEY `FK_division_department` (`department_id`),
  KEY `FK_division_person` (`principal_curator_id`),
  KEY `FK_division_person_2` (`head_of_division_id`),
  CONSTRAINT `FK_division_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `FK_division_person` FOREIGN KEY (`principal_curator_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `FK_division_person_2` FOREIGN KEY (`head_of_division_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.floor
CREATE TABLE IF NOT EXISTS `floor` (
  `floor_id` int NOT NULL AUTO_INCREMENT,
  `building_id` int NOT NULL,
  `floor_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`floor_id`),
  KEY `FK_floor_building` (`building_id`),
  CONSTRAINT `FK_floor_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.geographic_origin
CREATE TABLE IF NOT EXISTS `geographic_origin` (
  `geographic_origin_id` int NOT NULL AUTO_INCREMENT,
  `geographic_origin_name` varchar(255) NOT NULL,
  `region_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`geographic_origin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.geological_time_period
CREATE TABLE IF NOT EXISTS `geological_time_period` (
  `geological_time_period_id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `period_name` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL,
  `rank_sort_order` int DEFAULT NULL,
  PRIMARY KEY (`geological_time_period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.item_type
CREATE TABLE IF NOT EXISTS `item_type` (
  `item_type_id` int NOT NULL AUTO_INCREMENT,
  `item_type` varchar(255) NOT NULL,
  PRIMARY KEY (`item_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.library_and_archives_function
CREATE TABLE IF NOT EXISTS `library_and_archives_function` (
  `library_and_archives_function_id` int NOT NULL AUTO_INCREMENT,
  `function_name` varchar(255) NOT NULL,
  PRIMARY KEY (`library_and_archives_function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.person
CREATE TABLE IF NOT EXISTS `person` (
  `person_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.preservation_method
CREATE TABLE IF NOT EXISTS `preservation_method` (
  `preservation_method_id` int NOT NULL AUTO_INCREMENT,
  `preservation_method` varchar(255) NOT NULL,
  PRIMARY KEY (`preservation_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.rank
CREATE TABLE IF NOT EXISTS `rank` (
  `rank_id` int NOT NULL AUTO_INCREMENT,
  `criterion_id` int NOT NULL,
  `rank_value` int NOT NULL,
  `definition` text,
  `assessment` varchar(255) DEFAULT NULL,
  `examples` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rank_id`),
  KEY `FK_rank_criterion` (`criterion_id`),
  CONSTRAINT `FK_rank_criterion` FOREIGN KEY (`criterion_id`) REFERENCES `criterion` (`criterion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.ref_col_taxon
CREATE TABLE IF NOT EXISTS `ref_col_taxon` (
  `taxonID` int NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `datasetID` varchar(255) DEFAULT NULL,
  `datasetName` varchar(255) DEFAULT NULL,
  `acceptedNameUsageID` int DEFAULT NULL,
  `parentNameUsageID` int DEFAULT NULL,
  `taxonomicStatus` varchar(255) DEFAULT NULL,
  `taxonRank` varchar(255) DEFAULT NULL,
  `verbatimTaxonRank` varchar(255) DEFAULT NULL,
  `scientificName` varchar(255) DEFAULT NULL,
  `kingdom` varchar(255) DEFAULT NULL,
  `phylum` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `order` varchar(255) DEFAULT NULL,
  `superfamily` varchar(255) DEFAULT NULL,
  `family` varchar(255) DEFAULT NULL,
  `genericName` varchar(255) DEFAULT NULL,
  `genus` varchar(255) DEFAULT NULL,
  `subgenus` varchar(255) DEFAULT NULL,
  `specificEpithet` varchar(255) DEFAULT NULL,
  `infraspecificEpithet` varchar(255) DEFAULT NULL,
  `scientificNameAuthorship` varchar(255) DEFAULT NULL,
  `source` text,
  `namePublishedIn` text,
  `nameAccordingTo` varchar(255) DEFAULT NULL,
  `modified` varchar(255) DEFAULT NULL,
  `description` text,
  `taxonConceptID` varchar(255) DEFAULT NULL,
  `scientificNameID` varchar(255) DEFAULT NULL,
  `references` varchar(255) DEFAULT NULL,
  `isExtinct` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`taxonID`),
  KEY `identifier` (`identifier`),
  KEY `taxonRank` (`taxonRank`),
  KEY `scientificName` (`scientificName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.ref_pbdb_taxa
CREATE TABLE IF NOT EXISTS `ref_pbdb_taxa` (
  `orig_no` int NOT NULL,
  `taxon_no` int DEFAULT NULL,
  `record_type` varchar(20) DEFAULT NULL,
  `flags` varchar(20) DEFAULT NULL,
  `taxon_rank` varchar(20) DEFAULT NULL,
  `taxon_name` varchar(100) DEFAULT NULL,
  `difference` varchar(20) DEFAULT NULL,
  `accepted_no` int DEFAULT NULL,
  `accepted_rank` varchar(50) DEFAULT NULL,
  `accepted_name` varchar(100) DEFAULT NULL,
  `parent_no` int DEFAULT NULL,
  `container_no` varchar(50) DEFAULT NULL,
  `reference_no` int DEFAULT NULL,
  `is_extant` varchar(50) DEFAULT NULL,
  `n_occs` int DEFAULT NULL,
  KEY `orig_no` (`orig_no`),
  KEY `taxon_no` (`taxon_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.section
CREATE TABLE IF NOT EXISTS `section` (
  `section_id` int NOT NULL AUTO_INCREMENT,
  `division_id` int NOT NULL,
  `section_name` varchar(255) NOT NULL,
  `senior_curator_id` int DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `FK_section_division` (`division_id`),
  KEY `FK_section_person` (`senior_curator_id`),
  CONSTRAINT `FK_section_division` FOREIGN KEY (`division_id`) REFERENCES `division` (`division_id`),
  CONSTRAINT `FK_section_person` FOREIGN KEY (`senior_curator_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.site
CREATE TABLE IF NOT EXISTS `site` (
  `site_id` int NOT NULL AUTO_INCREMENT,
  `site_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.storage_container
CREATE TABLE IF NOT EXISTS `storage_container` (
  `storage_container_id` int NOT NULL AUTO_INCREMENT,
  `container_name` varchar(255) DEFAULT NULL,
  `temperature` int DEFAULT NULL,
  `relative_humidity` int DEFAULT NULL,
  PRIMARY KEY (`storage_container_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.storage_room
CREATE TABLE IF NOT EXISTS `storage_room` (
  `storage_room_id` int NOT NULL AUTO_INCREMENT,
  `floor_id` int NOT NULL,
  `room_name` varchar(255) DEFAULT NULL,
  `room_code` varchar(255) DEFAULT NULL,
  `estates_room_type` varchar(50) DEFAULT NULL,
  `estates_division_code` varchar(50) DEFAULT NULL,
  `estates_room_area` decimal(10,2) DEFAULT NULL,
  `floorplan_area` decimal(10,2) DEFAULT NULL,
  `storage_footprint` decimal(10,2) DEFAULT NULL,
  `typical_height` decimal(10,2) DEFAULT NULL,
  `volume` decimal(10,2) DEFAULT NULL,
  `circulation` decimal(10,2) DEFAULT NULL,
  `multi_room_split` enum('yes','no') DEFAULT NULL,
  `threshold_temp_min` int DEFAULT NULL,
  `threshold_temp_max` int DEFAULT NULL,
  `threshold_rh_min` int DEFAULT NULL,
  `threshold_rh_max` int DEFAULT NULL,
  PRIMARY KEY (`storage_room_id`),
  KEY `FK_storage_room_floor` (`floor_id`),
  CONSTRAINT `FK_storage_room_floor` FOREIGN KEY (`floor_id`) REFERENCES `floor` (`floor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.structural_changes_basic
CREATE TABLE IF NOT EXISTS `structural_changes_basic` (
  `structural_changes_basic_id` int NOT NULL AUTO_INCREMENT,
  `structural_changes_higher_id` int DEFAULT NULL,
  `collection_unit_id` int NOT NULL DEFAULT '0',
  `operation` enum('create','delete') DEFAULT NULL,
  PRIMARY KEY (`structural_changes_basic_id`),
  KEY `FK__collection_unit` (`collection_unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.structural_changes_higher
CREATE TABLE IF NOT EXISTS `structural_changes_higher` (
  `structural_changes_higher_id` int NOT NULL AUTO_INCREMENT,
  `higher_operation` enum('create','delete','split','merge','update') DEFAULT NULL,
  `effective_date` datetime DEFAULT NULL,
  `change_agent_id` int DEFAULT NULL,
  `cause` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`structural_changes_higher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.taxon_life_science
CREATE TABLE IF NOT EXISTS `taxon_life_science` (
  `taxon_life_science_id` int NOT NULL AUTO_INCREMENT,
  `taxon_name` varchar(255) NOT NULL,
  `taxon_rank` varchar(255) NOT NULL,
  `external_ref_name` varchar(255) DEFAULT NULL,
  `external_ref_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`taxon_life_science_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.taxon_palaeontology
CREATE TABLE IF NOT EXISTS `taxon_palaeontology` (
  `taxon_palaeontology_id` int NOT NULL AUTO_INCREMENT,
  `taxon_name` varchar(255) NOT NULL,
  `taxon_rank` varchar(255) NOT NULL,
  `external_ref_name` varchar(255) DEFAULT NULL,
  `external_ref_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`taxon_palaeontology_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.unit_assessment_criterion
CREATE TABLE IF NOT EXISTS `unit_assessment_criterion` (
  `unit_assessment_criterion_id` int NOT NULL AUTO_INCREMENT,
  `collection_unit_id` int NOT NULL,
  `criterion_id` int NOT NULL,
  `assessor_id` int DEFAULT NULL,
  `criteria_assessment` enum('known','unknown','na') NOT NULL DEFAULT 'known',
  `date_assessed` date DEFAULT NULL,
  `date_from` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_to` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `current` enum('yes','no') NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`unit_assessment_criterion_id`),
  KEY `FK_unit_assessment_criterion_collection_unit` (`collection_unit_id`),
  KEY `FK_unit_assessment_criterion_criterion` (`criterion_id`),
  KEY `FK_unit_assessment_criterion_person` (`assessor_id`),
  KEY `current` (`current`),
  CONSTRAINT `FK_unit_assessment_criterion_collection_unit` FOREIGN KEY (`collection_unit_id`) REFERENCES `collection_unit` (`collection_unit_id`),
  CONSTRAINT `FK_unit_assessment_criterion_criterion` FOREIGN KEY (`criterion_id`) REFERENCES `criterion` (`criterion_id`),
  CONSTRAINT `FK_unit_assessment_criterion_person` FOREIGN KEY (`assessor_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.unit_assessment_rank
CREATE TABLE IF NOT EXISTS `unit_assessment_rank` (
  `unit_assessment_rank_id` int NOT NULL AUTO_INCREMENT,
  `unit_assessment_criterion_id` int NOT NULL,
  `rank_id` int NOT NULL,
  `percentage` decimal(8,7) NOT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`unit_assessment_rank_id`),
  UNIQUE KEY `unit_assessment_criterion_id_rank_id` (`unit_assessment_criterion_id`,`rank_id`),
  KEY `FK_unit_assessment_rank_rank` (`rank_id`),
  CONSTRAINT `FK_unit_assessment_rank_rank` FOREIGN KEY (`rank_id`) REFERENCES `rank` (`rank_id`),
  CONSTRAINT `FK_unit_assessment_rank_unit_assessment_criterion` FOREIGN KEY (`unit_assessment_criterion_id`) REFERENCES `unit_assessment_criterion` (`unit_assessment_criterion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table jtd_live.unit_comment
CREATE TABLE IF NOT EXISTS `unit_comment` (
  `unit_comment_id` int NOT NULL AUTO_INCREMENT,
  `collection_unit_id` int NOT NULL,
  `unit_comment` longtext,
  `date_added` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`unit_comment_id`),
  KEY `FK_unit_comment_collection_unit` (`collection_unit_id`),
  CONSTRAINT `FK_unit_comment_collection_unit` FOREIGN KEY (`collection_unit_id`) REFERENCES `collection_unit` (`collection_unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for view jtd_live.vw_all_current_scores
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_all_current_scores` (
	`collection_unit_id` INT(11) NOT NULL,
	`division_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`section_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`responsible_curator` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`preservation_method` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`unit_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`assessor` TEXT NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_count` DOUBLE NULL,
	`curatorial_unit_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_count` DOUBLE NULL,
	`item_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`barcoded_percentage` DOUBLE NULL,
	`barcoded_percentage_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`unit_comment` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`c1_rank_1` DECIMAL(8,7) NULL,
	`c1_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c1_rank_2` DECIMAL(8,7) NULL,
	`c1_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c1_rank_3` DECIMAL(8,7) NULL,
	`c1_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c1_rank_4` DECIMAL(8,7) NULL,
	`c1_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c1_rank_5` DECIMAL(8,7) NULL,
	`c1_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c2_rank_1` DECIMAL(8,7) NULL,
	`c2_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c2_rank_2` DECIMAL(8,7) NULL,
	`c2_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c2_rank_3` DECIMAL(8,7) NULL,
	`c2_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c2_rank_4` DECIMAL(8,7) NULL,
	`c2_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c2_rank_5` DECIMAL(8,7) NULL,
	`c2_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c4_rank_1` DECIMAL(8,7) NULL,
	`c4_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c4_rank_2` DECIMAL(8,7) NULL,
	`c4_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c4_rank_3` DECIMAL(8,7) NULL,
	`c4_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c4_rank_4` DECIMAL(8,7) NULL,
	`c4_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c4_rank_5` DECIMAL(8,7) NULL,
	`c4_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c5_rank_1` DECIMAL(8,7) NULL,
	`c5_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c5_rank_2` DECIMAL(8,7) NULL,
	`c5_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c5_rank_3` DECIMAL(8,7) NULL,
	`c5_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c5_rank_4` DECIMAL(8,7) NULL,
	`c5_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`c5_rank_5` DECIMAL(8,7) NULL,
	`c5_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S1_rank_1` DECIMAL(8,7) NULL,
	`S1_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S1_rank_2` DECIMAL(8,7) NULL,
	`S1_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S1_rank_3` DECIMAL(8,7) NULL,
	`S1_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S1_rank_4` DECIMAL(8,7) NULL,
	`S1_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S1_rank_5` DECIMAL(8,7) NULL,
	`S1_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S2_rank_1` DECIMAL(8,7) NULL,
	`S2_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S2_rank_2` DECIMAL(8,7) NULL,
	`S2_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S2_rank_3` DECIMAL(8,7) NULL,
	`S2_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S2_rank_4` DECIMAL(8,7) NULL,
	`S2_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S2_rank_5` DECIMAL(8,7) NULL,
	`S2_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S3_rank_1` DECIMAL(8,7) NULL,
	`S3_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S3_rank_2` DECIMAL(8,7) NULL,
	`S3_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S3_rank_3` DECIMAL(8,7) NULL,
	`S3_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S3_rank_4` DECIMAL(8,7) NULL,
	`S3_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S3_rank_5` DECIMAL(8,7) NULL,
	`S3_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S4_rank_1` DECIMAL(8,7) NULL,
	`S4_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S4_rank_2` DECIMAL(8,7) NULL,
	`S4_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S4_rank_3` DECIMAL(8,7) NULL,
	`S4_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S4_rank_4` DECIMAL(8,7) NULL,
	`S4_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`S4_rank_5` DECIMAL(8,7) NULL,
	`S4_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I1_rank_1` DECIMAL(8,7) NULL,
	`I1_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I1_rank_2` DECIMAL(8,7) NULL,
	`I1_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I1_rank_3` DECIMAL(8,7) NULL,
	`I1_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I1_rank_4` DECIMAL(8,7) NULL,
	`I1_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I1_rank_5` DECIMAL(8,7) NULL,
	`I1_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I2_rank_1` DECIMAL(8,7) NULL,
	`I2_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I2_rank_2` DECIMAL(8,7) NULL,
	`I2_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I2_rank_3` DECIMAL(8,7) NULL,
	`I2_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I2_rank_4` DECIMAL(8,7) NULL,
	`I2_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I2_rank_5` DECIMAL(8,7) NULL,
	`I2_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I3_rank_1` DECIMAL(8,7) NULL,
	`I3_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I3_rank_2` DECIMAL(8,7) NULL,
	`I3_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I3_rank_3` DECIMAL(8,7) NULL,
	`I3_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I3_rank_4` DECIMAL(8,7) NULL,
	`I3_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I3_rank_5` DECIMAL(8,7) NULL,
	`I3_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I4_rank_1` DECIMAL(8,7) NULL,
	`I4_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I4_rank_2` DECIMAL(8,7) NULL,
	`I4_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I4_rank_3` DECIMAL(8,7) NULL,
	`I4_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I4_rank_4` DECIMAL(8,7) NULL,
	`I4_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`I4_rank_5` DECIMAL(8,7) NULL,
	`I4_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O1_rank_1` DECIMAL(8,7) NULL,
	`O1_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O1_rank_2` DECIMAL(8,7) NULL,
	`O1_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O1_rank_3` DECIMAL(8,7) NULL,
	`O1_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O1_rank_4` DECIMAL(8,7) NULL,
	`O1_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O1_rank_5` DECIMAL(8,7) NULL,
	`O1_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O2_rank_1` DECIMAL(8,7) NULL,
	`O2_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O2_rank_2` DECIMAL(8,7) NULL,
	`O2_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O2_rank_3` DECIMAL(8,7) NULL,
	`O2_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O2_rank_4` DECIMAL(8,7) NULL,
	`O2_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O2_rank_5` DECIMAL(8,7) NULL,
	`O2_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O3_rank_1` DECIMAL(8,7) NULL,
	`O3_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O3_rank_2` DECIMAL(8,7) NULL,
	`O3_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O3_rank_3` DECIMAL(8,7) NULL,
	`O3_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O3_rank_4` DECIMAL(8,7) NULL,
	`O3_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O3_rank_5` DECIMAL(8,7) NULL,
	`O3_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O4_rank_1` DECIMAL(8,7) NULL,
	`O4_rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O4_rank_2` DECIMAL(8,7) NULL,
	`O4_rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O4_rank_3` DECIMAL(8,7) NULL,
	`O4_rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O4_rank_4` DECIMAL(8,7) NULL,
	`O4_rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`O4_rank_5` DECIMAL(8,7) NULL,
	`O4_rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_all_current_scores_no_comments
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_all_current_scores_no_comments` (
	`collection_unit_id` INT(10) NOT NULL,
	`department_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`division_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`section_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`responsible_curator` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`items_unestimatable_flag` ENUM('yes','no') NULL COLLATE 'utf8_general_ci',
	`item_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`preservation_method` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`unit_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`assessor` TEXT NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_count` DOUBLE NULL,
	`curatorial_unit_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_count` DOUBLE NULL,
	`item_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`barcoded_percentage` DOUBLE NULL,
	`barcoded_percentage_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`reporting_count` DOUBLE NULL,
	`reporting_metric_used` VARCHAR(15) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`unit_comment` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`c1_rank_1` DECIMAL(8,7) NULL,
	`c1_rank_2` DECIMAL(8,7) NULL,
	`c1_rank_3` DECIMAL(8,7) NULL,
	`c1_rank_4` DECIMAL(8,7) NULL,
	`c1_rank_5` DECIMAL(8,7) NULL,
	`c2_rank_1` DECIMAL(8,7) NULL,
	`c2_rank_2` DECIMAL(8,7) NULL,
	`c2_rank_3` DECIMAL(8,7) NULL,
	`c2_rank_4` DECIMAL(8,7) NULL,
	`c2_rank_5` DECIMAL(8,7) NULL,
	`c4_rank_1` DECIMAL(8,7) NULL,
	`c4_rank_2` DECIMAL(8,7) NULL,
	`c4_rank_3` DECIMAL(8,7) NULL,
	`c4_rank_4` DECIMAL(8,7) NULL,
	`c4_rank_5` DECIMAL(8,7) NULL,
	`c5_rank_1` DECIMAL(8,7) NULL,
	`c5_rank_2` DECIMAL(8,7) NULL,
	`c5_rank_3` DECIMAL(8,7) NULL,
	`c5_rank_4` DECIMAL(8,7) NULL,
	`c5_rank_5` DECIMAL(8,7) NULL,
	`S1_rank_1` DECIMAL(8,7) NULL,
	`S1_rank_2` DECIMAL(8,7) NULL,
	`S1_rank_3` DECIMAL(8,7) NULL,
	`S1_rank_4` DECIMAL(8,7) NULL,
	`S1_rank_5` DECIMAL(8,7) NULL,
	`S2_rank_1` DECIMAL(8,7) NULL,
	`S2_rank_2` DECIMAL(8,7) NULL,
	`S2_rank_3` DECIMAL(8,7) NULL,
	`S2_rank_4` DECIMAL(8,7) NULL,
	`S2_rank_5` DECIMAL(8,7) NULL,
	`S3_rank_1` DECIMAL(8,7) NULL,
	`S3_rank_2` DECIMAL(8,7) NULL,
	`S3_rank_3` DECIMAL(8,7) NULL,
	`S3_rank_4` DECIMAL(8,7) NULL,
	`S3_rank_5` DECIMAL(8,7) NULL,
	`S4_rank_1` DECIMAL(8,7) NULL,
	`S4_rank_2` DECIMAL(8,7) NULL,
	`S4_rank_3` DECIMAL(8,7) NULL,
	`S4_rank_4` DECIMAL(8,7) NULL,
	`S4_rank_5` DECIMAL(8,7) NULL,
	`I1_rank_1` DECIMAL(8,7) NULL,
	`I1_rank_2` DECIMAL(8,7) NULL,
	`I1_rank_3` DECIMAL(8,7) NULL,
	`I1_rank_4` DECIMAL(8,7) NULL,
	`I1_rank_5` DECIMAL(8,7) NULL,
	`I2_rank_1` DECIMAL(8,7) NULL,
	`I2_rank_2` DECIMAL(8,7) NULL,
	`I2_rank_3` DECIMAL(8,7) NULL,
	`I2_rank_4` DECIMAL(8,7) NULL,
	`I2_rank_5` DECIMAL(8,7) NULL,
	`I3_rank_1` DECIMAL(8,7) NULL,
	`I3_rank_2` DECIMAL(8,7) NULL,
	`I3_rank_3` DECIMAL(8,7) NULL,
	`I3_rank_4` DECIMAL(8,7) NULL,
	`I3_rank_5` DECIMAL(8,7) NULL,
	`I4_rank_1` DECIMAL(8,7) NULL,
	`I4_rank_2` DECIMAL(8,7) NULL,
	`I4_rank_3` DECIMAL(8,7) NULL,
	`I4_rank_4` DECIMAL(8,7) NULL,
	`I4_rank_5` DECIMAL(8,7) NULL,
	`O1_rank_1` DECIMAL(8,7) NULL,
	`O1_rank_2` DECIMAL(8,7) NULL,
	`O1_rank_3` DECIMAL(8,7) NULL,
	`O1_rank_4` DECIMAL(8,7) NULL,
	`O1_rank_5` DECIMAL(8,7) NULL,
	`O2_rank_1` DECIMAL(8,7) NULL,
	`O2_rank_2` DECIMAL(8,7) NULL,
	`O2_rank_3` DECIMAL(8,7) NULL,
	`O2_rank_4` DECIMAL(8,7) NULL,
	`O2_rank_5` DECIMAL(8,7) NULL,
	`O3_rank_1` DECIMAL(8,7) NULL,
	`O3_rank_2` DECIMAL(8,7) NULL,
	`O3_rank_3` DECIMAL(8,7) NULL,
	`O3_rank_4` DECIMAL(8,7) NULL,
	`O3_rank_5` DECIMAL(8,7) NULL,
	`O4_rank_1` DECIMAL(8,7) NULL,
	`O4_rank_2` DECIMAL(8,7) NULL,
	`O4_rank_3` DECIMAL(8,7) NULL,
	`O4_rank_4` DECIMAL(8,7) NULL,
	`O4_rank_5` DECIMAL(8,7) NULL
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_collections_hierarchy
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_collections_hierarchy` (
	`Department` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`Head of Collections` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`Division Name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`Principal Curator in Charge` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`Head of Division` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`Section Name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`Senior Curator` VARCHAR(511) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_collection_units_denormalised
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_collection_units_denormalised` (
	`collection_unit_id` INT(11) NOT NULL,
	`unit_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`department_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`division_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`section_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`responsible_curator` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`items_unestimatable_flag` ENUM('yes','no') NULL COLLATE 'utf8_general_ci',
	`item_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`preservation_method` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`bibliographic_level` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`taxon_ls` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`taxon_palaeo` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`informal_taxon` TEXT NULL COLLATE 'utf8_general_ci',
	`archives_function` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`site_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`building_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`floor_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`room_code` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`container_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`geographic_origin_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`type_collection_flag` ENUM('yes','no') NULL COLLATE 'utf8_general_ci',
	`named_collection` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`geological_time_period_from` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`geological_time_period_to` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`es_recent_specimen_flag` ENUM('yes','no') NULL COLLATE 'utf8_general_ci',
	`archives_fond_ref` VARCHAR(255) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_criteria_rank_current
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_criteria_rank_current` (
	`unit_assessment_criterion_id` INT(11) NOT NULL,
	`collection_unit_id` INT(11) NOT NULL,
	`criterion_id` INT(11) NOT NULL,
	`assessor_id` INT(11) NULL,
	`criteria_assessment` ENUM('known','unknown','na') NOT NULL COLLATE 'utf8_general_ci',
	`date_assessed` DATE NULL,
	`date_from` DATETIME NOT NULL,
	`date_to` DATETIME NOT NULL,
	`current` ENUM('yes','no') NOT NULL COLLATE 'utf8_general_ci',
	`rank_1_id` BIGINT(11) NULL,
	`rank_1_percentage` DECIMAL(8,7) NULL,
	`rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`rank_2_id` BIGINT(11) NULL,
	`rank_2_percentage` DECIMAL(8,7) NULL,
	`rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`rank_3_id` BIGINT(11) NULL,
	`rank_3_percentage` DECIMAL(8,7) NULL,
	`rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`rank_4_id` BIGINT(11) NULL,
	`rank_4_percentage` DECIMAL(8,7) NULL,
	`rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`rank_5_id` BIGINT(11) NULL,
	`rank_5_percentage` DECIMAL(8,7) NULL,
	`rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_criteria_rank_history
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_criteria_rank_history` (
	`unit_assessment_criterion_id` INT(11) NOT NULL,
	`collection_unit_id` INT(11) NOT NULL,
	`criterion_id` INT(11) NOT NULL,
	`assessor_id` INT(11) NULL,
	`criteria_assessment` ENUM('known','unknown','na') NOT NULL COLLATE 'utf8_general_ci',
	`date_assessed` DATE NULL,
	`date_from` DATETIME NOT NULL,
	`date_to` DATETIME NOT NULL,
	`current` ENUM('yes','no') NOT NULL COLLATE 'utf8_general_ci',
	`rank_1_id` BIGINT(11) NULL,
	`rank_1_percentage` DECIMAL(8,7) NULL,
	`rank_1_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`rank_2_id` BIGINT(11) NULL,
	`rank_2_percentage` DECIMAL(8,7) NULL,
	`rank_2_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`rank_3_id` BIGINT(11) NULL,
	`rank_3_percentage` DECIMAL(8,7) NULL,
	`rank_3_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`rank_4_id` BIGINT(11) NULL,
	`rank_4_percentage` DECIMAL(8,7) NULL,
	`rank_4_comment` TEXT NULL COLLATE 'utf8_general_ci',
	`rank_5_id` BIGINT(11) NULL,
	`rank_5_percentage` DECIMAL(8,7) NULL,
	`rank_5_comment` TEXT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_current_counts
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_current_counts` (
	`collection_unit_id` INT(10) NOT NULL,
	`division_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`section_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`responsible_curator` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`preservation_method` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`unit_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`assessor` TEXT NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_count` DOUBLE NULL,
	`curatorial_unit_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_count` DOUBLE NULL,
	`item_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`barcoded_percentage` DOUBLE NULL,
	`barcoded_percentage_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`items_unestimatable_flag` ENUM('yes','no') NULL COLLATE 'utf8_general_ci',
	`count_curatorial_units_flag` ENUM('yes','no') NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_metrics_current
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_metrics_current` (
	`collection_unit_id` INT(11) NOT NULL,
	`item_count` DOUBLE NULL,
	`item_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_count_last_updated` DATETIME NULL,
	`curatorial_unit_count` DOUBLE NULL,
	`curatorial_unit_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_count_last_updated` DATETIME NULL,
	`barcoded_percentage` DOUBLE NULL,
	`barcoded_percentage_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`barcoded_percentage_last_updated` DATETIME NULL
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_metrics_current_including_inactive
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_metrics_current_including_inactive` (
	`collection_unit_id` INT(10) NOT NULL,
	`item_count` DOUBLE NULL,
	`item_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_count_last_updated` DATETIME NULL,
	`curatorial_unit_count` DOUBLE NULL,
	`curatorial_unit_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_count_last_updated` DATETIME NULL,
	`barcoded_percentage` DOUBLE NULL,
	`barcoded_percentage_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`barcoded_percentage_last_updated` DATETIME NULL
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_person_name_lookup
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_person_name_lookup` (
	`person_id` INT(10) NOT NULL,
	`full_name` VARCHAR(511) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_reporting_section_list
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_reporting_section_list` (
	`department_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`division_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`section_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`section_id` INT(10) NULL,
	`unit_count` BIGINT(19) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_reporting_unit_metrics
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_reporting_unit_metrics` (
	`collection_unit_id` INT(10) NOT NULL,
	`division_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`section_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`preservation_method` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`unit_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_count` DOUBLE NULL,
	`curatorial_unit_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_count` DOUBLE NULL,
	`item_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`barcoded_percentage` DOUBLE NULL,
	`barcoded_percentage_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`reporting_count` DOUBLE NULL,
	`reporting_metric_used` VARCHAR(15) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_unit_rescore_form
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_unit_rescore_form` (
	`collection_unit_id` INT(10) NOT NULL,
	`division_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`section_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`responsible_curator` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_type` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`unit_name` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`sort_order` CHAR NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`assessor` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`curatorial_unit_count` DOUBLE NULL,
	`curatorial_unit_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`item_count` DOUBLE NULL,
	`item_count_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`barcoded_percentage` DOUBLE NULL,
	`barcoded_percentage_confidence` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`unit_comment` LONGTEXT NULL COLLATE 'utf8_general_ci',
	`c1_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c1_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c1_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c1_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c1_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c2_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c2_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c2_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c2_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c2_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c4_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c4_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c4_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c4_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c4_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c5_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c5_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c5_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c5_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`c5_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S1_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S1_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S1_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S1_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S1_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S2_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S2_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S2_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S2_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S2_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S3_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S3_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S3_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S3_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S3_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S4_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S4_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S4_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S4_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`S4_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I1_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I1_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I1_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I1_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I1_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I2_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I2_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I2_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I2_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I2_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I3_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I3_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I3_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I3_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I3_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I4_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I4_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I4_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I4_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`I4_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O1_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O1_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O1_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O1_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O1_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O2_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O2_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O2_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O2_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O2_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O3_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O3_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O3_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O3_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O3_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O4_rank_1` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O4_rank_2` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O4_rank_3` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O4_rank_4` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`O4_rank_5` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_unit_restructure_form
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_unit_restructure_form` (
	`Old Unit ID` INT(10) NOT NULL,
	`Notes` BINARY NULL,
	`Action` BINARY NULL,
	`OldSection` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`NewSection` BINARY NULL,
	`OldResponsibleCurator` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`NewResponsibleCurator` BINARY NULL,
	`OldUnitName` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`NewUnitName` BINARY NULL,
	`OldCuratorialUnitType` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`NewCuratorialUnitType` BINARY NULL,
	`OldLSTaxonName` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`NewLSTaxonName` BINARY NULL,
	`OldESTaxonName` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`NewESTaxonName` BINARY NULL,
	`OldInformalTaxon` TEXT NULL COLLATE 'utf8_general_ci',
	`NewInformalTaxon` BINARY NULL,
	`OldStorageRoom` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`NewStorageRoom` BINARY NULL,
	`OldGeographicOrigin` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`NewGeographicOrigin` BINARY NULL,
	`OldTypeCollection` ENUM('yes','no') NULL COLLATE 'utf8_general_ci',
	`NewTypeCollection` BINARY NULL,
	`OldContainerName` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`NewContainerName` BINARY NULL,
	`OldGeologicalTimePeriodFrom` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`NewGeologicalTimePeriodFrom` BINARY NULL,
	`OldGeologicalTimePeriodTo` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`NewGeologicalTimePeriodTo` BINARY NULL
) ENGINE=MyISAM;

-- Dumping structure for view jtd_live.vw_weighted_average_review
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_weighted_average_review` (
	`collection_unit_id` INT(11) NOT NULL,
	`criterion_code` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`criterion_name` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`assessor` VARCHAR(511) NULL COLLATE 'utf8_general_ci',
	`weighted_average` DOUBLE NULL,
	`distribution` TEXT NULL COLLATE 'latin1_swedish_ci'
) ENGINE=MyISAM;

-- Dumping structure for procedure jtd_live.sp_create_unit
DELIMITER //
CREATE PROCEDURE `sp_create_unit`(
	IN `unit_name` VARCHAR(255),
	IN `section_id` INT,
	IN `unit_active` ENUM('yes','no'),
	IN `responsible_curator_id` INT,
	IN `curatorial_unit_definition_id` INT,
	IN `taxon_life_science_id` INT,
	IN `taxon_palaeontology_id` INT,
	IN `storage_room_id` INT,
	IN `storage_container_id` INT,
	IN `geographic_origin_id` INT,
	IN `library_and_archives_function_id` INT,
	IN `geological_time_period_from_id` INT,
	IN `geological_time_period_to_id` INT,
	IN `type_collection_flag` ENUM('yes','no'),
	IN `informal_taxon` TEXT,
	IN `named_collection` VARCHAR(255),
	IN `es_recent_specimen_flag` ENUM('yes','no'),
	IN `archives_fond_ref` VARCHAR(255),
	IN `count_curatorial_units_flag` ENUM('yes','no'),
	IN `operation_type` VARCHAR(50),
	IN `change_agent_id` INT,
	IN `cause` VARCHAR(50)
,
	IN `higher_changes_id` INT









)
    COMMENT 'High level unit-creation op: only used for material not previously assessed under the JtD framework'
BEGIN

-- declare + set variables: one per field in collection, even if it's NULL - more effort to input but more consistent to process
DECLARE unit_name_var JSON;
DECLARE section_id_var JSON;
DECLARE unit_active_var JSON;
DECLARE responsible_curator_id_var JSON;
DECLARE curatorial_unit_definition_id_var JSON;
DECLARE taxon_life_science_id_var JSON;
DECLARE taxon_palaeontology_id_var JSON;
DECLARE storage_room_id_var JSON;
DECLARE storage_container_id_var JSON;
DECLARE geographic_origin_id_var JSON;
DECLARE library_and_archives_function_id_var JSON;
DECLARE geological_time_period_from_id_var JSON;
DECLARE geological_time_period_to_id_var JSON;
DECLARE type_collection_flag_var JSON;
DECLARE informal_taxon_var JSON;
DECLARE named_collection_var JSON;
DECLARE es_recent_specimen_flag_var JSON;
DECLARE archives_fond_ref_var JSON;
DECLARE count_curatorial_units_flag_var JSON;
DECLARE operation_type_var JSON;
DECLARE effective_date_var JSON;
DECLARE change_agent_id_var JSON;
DECLARE cause_var JSON;
DECLARE collection_unit_id INT(11);
DECLARE unit_insert_var JSON;
DECLARE higher_changes_var JSON;
DECLARE structural_changes_higher_id INT(11);
DECLARE basic_changes_var JSON;
DECLARE structural_changes_higher_id_auto INT(11);

SET unit_name_var = JSON_ARRAY('unit_name', unit_name);
SET section_id_var = JSON_ARRAY('section_id', section_id);
SET unit_active_var = JSON_ARRAY('unit_active', unit_active);
SET responsible_curator_id_var = JSON_ARRAY('responsible_curator_id', responsible_curator_id);
SET curatorial_unit_definition_id_var = JSON_ARRAY('curatorial_unit_definition_id', curatorial_unit_definition_id);
SET taxon_life_science_id_var = JSON_ARRAY('taxon_life_science_id', taxon_life_science_id);
SET taxon_palaeontology_id_var = JSON_ARRAY('taxon_palaeontology_id', taxon_palaeontology_id);
SET storage_room_id_var = JSON_ARRAY('storage_room_id', storage_room_id);
SET storage_container_id_var = JSON_ARRAY('storage_container_id', storage_container_id);
SET geographic_origin_id_var = JSON_ARRAY('geographic_origin_id', geographic_origin_id);
SET library_and_archives_function_id_var = JSON_ARRAY('library_and_archives_function_id', library_and_archives_function_id);
SET geological_time_period_from_id_var = JSON_ARRAY('geological_time_period_from_id', geological_time_period_from_id);
SET geological_time_period_to_id_var = JSON_ARRAY('geological_time_period_to_id', geological_time_period_to_id);
SET type_collection_flag_var = JSON_ARRAY('type_collection_flag', type_collection_flag);
SET informal_taxon_var = JSON_ARRAY('informal_taxon', informal_taxon);
SET named_collection_var = JSON_ARRAY('named_collection', named_collection);
SET es_recent_specimen_flag_var = JSON_ARRAY('es_recent_specimen_flag', es_recent_specimen_flag);
SET archives_fond_ref_var = JSON_ARRAY('archives_fond_ref', archives_fond_ref);
SET count_curatorial_units_flag_var = JSON_ARRAY('count_curatorial_units_flag', count_curatorial_units_flag);
SET operation_type_var = JSON_ARRAY('higher_operation', operation_type);
SET effective_date_var = JSON_ARRAY('effective_date', NOW());
SET change_agent_id_var = JSON_ARRAY('change_agent_id', change_agent_id);
SET cause_var = JSON_ARRAY('cause', cause);

-- Wrap in another array
SET unit_insert_var = JSON_ARRAY(unit_name_var, section_id_var, unit_active_var, responsible_curator_id_var, curatorial_unit_definition_id_var, taxon_life_science_id_var, taxon_palaeontology_id_var, storage_room_id_var, storage_container_id_var, geographic_origin_id_var, library_and_archives_function_id_var, geological_time_period_from_id_var, geological_time_period_to_id_var, type_collection_flag_var, informal_taxon_var, named_collection_var, es_recent_specimen_flag_var, archives_fond_ref_var, count_curatorial_units_flag_var);

-- call sp_insert_unit on collection_unit
CALL sp_insert_record('collection_unit', unit_insert_var);

-- query collection_unit for id of last inserted row + assign to parameter
SELECT MAX(cu.collection_unit_id) from collection_unit cu into collection_unit_id; 

-- Pure create operations won't have a higher_changes_id (yet), but creates linked to merges will.
IF operation_type = 'create' THEN 
	-- convert into json to match parameters required by sp_insert_record
	SET higher_changes_var = JSON_ARRAY(operation_type_var, effective_date_var, change_agent_id_var, cause_var);

	-- call sp_insert_record on structural_changes_higher
	CALL sp_insert_record('structural_changes_higher', higher_changes_var);

	-- query structural_changes_higher for id of last inserted row + assign to parameter
	SELECT MAX(sch.structural_changes_higher_id) from structural_changes_higher sch into structural_changes_higher_id_auto; 

ELSEIF operation_type = 'merge' THEN 
	-- convert into json to match parameters required by sp_insert_record, including higher_id field provided in input
	SET higher_changes_var = JSON_ARRAY(JSON_ARRAY('structural_changes_higher_id', higher_changes_id), operation_type_var, effective_date_var, change_agent_id_var, cause_var);

	-- call sp_insert_record on structural_changes_higher
	CALL sp_insert_record('structural_changes_higher', higher_changes_var);
	
	SET structural_changes_higher_id_auto = NULL;

END IF;

-- convert into json to match parameters required by sp_insert_record, choosing whichever higher_ID value is populated
SET basic_changes_var = JSON_ARRAY(JSON_ARRAY('structural_changes_higher_id', IFNULL(higher_changes_id, structural_changes_higher_id_auto)), JSON_ARRAY('collection_unit_id', collection_unit_id), JSON_ARRAY('operation', 'create'));

-- call sp_insert_record on structural_changes_basic
CALL sp_insert_record('structural_changes_basic', basic_changes_var);

END//
DELIMITER ;

-- Dumping structure for procedure jtd_live.sp_deactivate_unit
DELIMITER //
CREATE PROCEDURE `sp_deactivate_unit`(
	IN `collection_unit_id` INT,
	IN `structural_changes_higher_id` INT









,
	IN `change_agent_id` INT,
	IN `cause` VARCHAR(50)


,
	IN `higher_operation` VARCHAR(50)

)
BEGIN

DECLARE collection_unit_id_var JSON;
DECLARE structural_changes_higher_id_var JSON;
DECLARE change_agent_id_var JSON;
DECLARE cause_var JSON;
DECLARE effective_date_var JSON;

DECLARE structural_changes_higher_id_auto INT(11);
DECLARE structural_changes_higher_var JSON;
DECLARE structural_changes_basic_var JSON;

SET collection_unit_id_var = JSON_ARRAY('collection_unit_id', collection_unit_id);
SET change_agent_id_var = JSON_ARRAY('change_agent_id', change_agent_id);
SET effective_date_var = JSON_ARRAY('effective_date', NOW());
SET cause_var = JSON_ARRAY('cause', cause);

-- if it's a straightforward delete/deactivate unrelated to merge or split, we need to retrieve the higher_changes_id
IF higher_operation = 'delete' THEN
	-- build higher_changes array 
	SET structural_changes_higher_var = JSON_ARRAY(JSON_ARRAY('higher_operation', higher_operation), effective_date_var, change_agent_id_var, cause_var);
	-- call sp_insert_record to add new higher change record
	CALL sp_insert_record('structural_changes_higher', structural_changes_higher_var);
	-- get the higher change id from a MAX query against structural_changes_higher after the new record has been written
	SELECT MAX(sch.structural_changes_higher_id) from structural_changes_higher sch INTO structural_changes_higher_id_auto;
	-- wrap in array so we can ref in basic_changes records
	SET structural_changes_higher_id_var = JSON_ARRAY('structural_changes_higher_id', structural_changes_higher_id_auto);

ELSEIF higher_operation = 'merge' THEN
	-- higher_change record was created during creation of new unit (result of merge) so no need to add another one
	-- wrap higher_change_id passed as parameter into JSON for use in basic_changes insert
	SET structural_changes_higher_id_var = JSON_ARRAY('structural_changes_higher_id', structural_changes_higher_id);
	
ELSE
	-- Must be a deactivation as the result of a split operation
	-- The unit being split is responsible for the creation of the higher_changes record + it's own basic changes record
	SET structural_changes_higher_id_var = JSON_ARRAY('structural_changes_higher_id', structural_changes_higher_id);
	
	SET structural_changes_higher_var = JSON_ARRAY(structural_changes_higher_id_var, JSON_ARRAY('higher_operation', higher_operation), effective_date_var, change_agent_id_var, cause_var);
	-- call sp_insert_record to add new higher change record
	CALL sp_insert_record('structural_changes_higher', structural_changes_higher_var);
	
END IF;

-- deactivate collection unit
CALL sp_update_record('collection_unit', collection_unit_id, JSON_ARRAY(JSON_ARRAY('unit_active', 'no')));

-- add to basic structural change record
CALL sp_insert_record('structural_changes_basic', JSON_ARRAY(structural_changes_higher_id_var, collection_unit_id_var, JSON_ARRAY('operation', 'delete')));

END//
DELIMITER ;

-- Dumping structure for procedure jtd_live.sp_delete_record
DELIMITER //
CREATE PROCEDURE `sp_delete_record`(
	IN `p_table` VARCHAR(50),
	IN `p_record_id` INT

)
BEGIN

	DECLARE current_datetime DATETIME;
	DECLARE table_delete_sql TEXT;
	DECLARE audit_sql TEXT;	
	
	START TRANSACTION;
	
	# Initialise variables
	SET current_datetime = NOW();

	# Update main table
	SET @sql_query = CONCAT('DELETE FROM ', p_table, ' WHERE ', p_table, '_id = ', p_record_id);
	PREPARE table_delete_sql FROM @sql_query;
	EXECUTE table_delete_sql;
	DEALLOCATE PREPARE table_delete_sql;

	# Insert record into audit table
	SET @sql_query = CONCAT('INSERT INTO audit VALUES (NULL, \'', p_table, '\', ', p_record_id, ', \'delete\', \'', current_datetime, '\', \'mattw2\', \'{}\')');
	PREPARE audit_sql FROM @sql_query;
	EXECUTE audit_sql;
	DEALLOCATE PREPARE audit_sql;
	
	COMMIT;
	
END//
DELIMITER ;

-- Dumping structure for procedure jtd_live.sp_insert_collection_unit_metric
DELIMITER //
CREATE PROCEDURE `sp_insert_collection_unit_metric`(
	IN `p_collection_unit_id` INT,
	IN `p_metric_definition_id` INT,
	IN `p_metric_value` DOUBLE,
	IN `p_confidence_level` VARCHAR(50)

)
BEGIN

	DECLARE current_datetime DATETIME;
	DECLARE pension_datetime DATETIME;
	DECLARE old_id INT;
	DECLARE old_collection_unit_metric_definition_id INT;
	
	START TRANSACTION;
	
		SET current_datetime = NOW();
		SET pension_datetime = DATE_SUB(current_datetime, INTERVAL 1 SECOND);
		
		# Get the auto_id for the existing record
		SELECT 
			collection_unit_metric_id, collection_unit_metric_definition_id
		INTO
			old_id, old_collection_unit_metric_definition_id
		FROM collection_unit_metric
		WHERE collection_unit_id = p_collection_unit_id
		AND collection_unit_metric_definition_id = p_metric_definition_id
		AND current = 'yes';
	
		IF old_id IS NOT NULL THEN 
	
			# Pension the existing record
			CALL sp_update_record('collection_unit_metric', old_id, CONCAT('[["date_to", "', pension_datetime, '"], ["current", "no"]]'));
		
			# Insert the new record including data from the old record		
			CALL sp_insert_record('collection_unit_metric', CONCAT('[["collection_unit_id", ', p_collection_unit_id, '], ["collection_unit_metric_definition_id", ', old_collection_unit_metric_definition_id, '], ["metric_value", ', p_metric_value, '], ["confidence_level", "', p_confidence_level, '"], ["date_from", "', current_datetime, '"], ["current", "yes"]]'));
		
		ELSE
		
			# Insert the new record
			CALL sp_insert_record('collection_unit_metric', CONCAT('[["collection_unit_id", ', p_collection_unit_id, '], ["collection_unit_metric_definition_id", ', p_metric_definition_id, '], ["metric_value", ', p_metric_value, '], ["confidence_level", "', p_confidence_level, '"], ["date_from", "', current_datetime, '"], ["current", "yes"]]'));
			
		END IF;
	
	COMMIT;
	
END//
DELIMITER ;

-- Dumping structure for procedure jtd_live.sp_insert_record
DELIMITER //
CREATE PROCEDURE `sp_insert_record`(
	IN `p_table` VARCHAR(50),
	IN `p_data` JSON


)
BEGIN

	# Inserts a record into the table specified by the p_table parameter, using a JSON-formatted list of fields and values, and adds a corresponding record to the audit table
	
	# Expects a table name, and a json array of field names and values
	# Example: CALL sp_insert_record('collection_unit', '[["responsible_curator_id", 13], ["taxon_life_science_id", 99], ["unit_name", "Bob"], ["section_id", 3]]')
	
	# Created: 
	# Last updated: 2019-12-10 by Matt Woodburm

	DECLARE current_datetime DATETIME;
	DECLARE new_id INT;
	DECLARE result_check TEXT;
	DECLARE table_insert_fields_sql TEXT;
	DECLARE table_insert_values_sql TEXT;
	DECLARE table_insert_sql TEXT;
	DECLARE audit_sql TEXT;
	DECLARE field_count INT;
	DECLARE current_field INT;
	DECLARE audit_data TEXT;
	
	START TRANSACTION;
	
	# Initiate variables
	SET current_datetime = NOW();
	SET field_count = JSON_LENGTH(p_data);
	SET current_field = 0;	
	SET table_insert_fields_sql = CONCAT('INSERT INTO ', p_table, ' (');
	SET table_insert_values_sql = '';
	SET audit_sql = 'INSERT INTO audit VALUES (';
	SET audit_data = '';

	SET p_data = REPLACE(p_data, '\'', '@@@');

	# Iterate through the list of fields
	WHILE current_field < field_count DO
	
		# Build up the column and values sections of the sql strings, and the json string to insert into the audit table
		IF current_field = 0 THEN
			SET table_insert_fields_sql = CONCAT(table_insert_fields_sql, JSON_UNQUOTE(JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][0]'))));
			SET table_insert_values_sql = CONCAT(table_insert_values_sql, REPLACE(JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][1]')),'"', '\''));
			SET audit_data = CONCAT('[{"field_name": ', JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][0]')), ', ', '"new_value": ', JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][1]')), '}');
		ELSE
			SET table_insert_fields_sql = CONCAT(table_insert_fields_sql, ', ', JSON_UNQUOTE(JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][0]'))));
			SET table_insert_values_sql = CONCAT(table_insert_values_sql, ', ', REPLACE(JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][1]')),'"', '\''));
			SET audit_data = CONCAT(audit_data, ', {"field_name": ', JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][0]')), ', ', '"new_value": ', JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][1]')), '}');
		END IF;
		
		SET current_field = current_field + 1;
	
	END WHILE;

	# Prepare the final insert statement from the column and value strings and execute
	SET @sql_statement = CONCAT(table_insert_fields_sql, ') VALUES (', REPLACE(table_insert_values_sql, '@@@', '\\\''), ')');
	PREPARE table_insert_sql FROM @sql_statement;	
	EXECUTE table_insert_sql;
	
	# Get the new auto_id from adding to the audit trail
	SELECT LAST_INSERT_ID() INTO new_id;

	# Prepare the insert into the audit table and execute
	SET @sql_statement = CONCAT(audit_sql, 'NULL, \'', p_table, '\', ', new_id, ', \'insert\', \'', current_datetime, '\', \'mattw2\', \'', REPLACE(audit_data, '@@@', '\\\''), ']\')');
	PREPARE audit_sql FROM @sql_statement;
	EXECUTE audit_sql;
	
	COMMIT;
	
END//
DELIMITER ;

-- Dumping structure for procedure jtd_live.sp_insert_unit_assessment_criterion
DELIMITER //
CREATE PROCEDURE `sp_insert_unit_assessment_criterion`(
	IN `p_collection_unit_id` INT,
	IN `p_criterion_id` INT,
	IN `p_assessor_id` INT,
	IN `p_criteria_assessment` VARCHAR(50)


,
	IN `p_date_assessed` DATE


,
	IN `p_rank_1_percentage` DECIMAL(8,7),
	IN `p_rank_2_percentage` DECIMAL(8,7),
	IN `p_rank_3_percentage` DECIMAL(8,7),
	IN `p_rank_4_percentage` DECIMAL(8,7),
	IN `p_rank_5_percentage` DECIMAL(8,7)
,
	IN `p_rank_1_comment` VARCHAR(1000),
	IN `p_rank_2_comment` VARCHAR(1000),
	IN `p_rank_3_comment` VARCHAR(1000),
	IN `p_rank_4_comment` VARCHAR(1000),
	IN `p_rank_5_comment` VARCHAR(1000)







)
    MODIFIES SQL DATA
    DETERMINISTIC
BEGIN

	DECLARE current_datetime DATETIME;
	DECLARE pension_datetime DATETIME;
	DECLARE old_id INT;
	DECLARE new_id INT;
	DECLARE old_unit_assessment_criterion_id INT;
		
	START TRANSACTION;
		
		SET current_datetime = NOW();
		SET pension_datetime = DATE_SUB(current_datetime, INTERVAL 1 SECOND);
		
		# Get the auto_id for the existing record
		SELECT 
			unit_assessment_criterion_id
		INTO
			old_id
		FROM unit_assessment_criterion
		WHERE collection_unit_id = p_collection_unit_id
		AND criterion_id = p_criterion_id
		AND current = 'yes';
	
		IF old_id IS NOT NULL THEN 
	
			# Pension the existing record
			CALL sp_update_record('unit_assessment_criterion', old_id, CONCAT('[["date_to", "', pension_datetime, '"], ["current", "no"]]'));
	
			# Insert the new record including data from the old record		
			CALL sp_insert_record('unit_assessment_criterion', CONCAT('[["collection_unit_id", ', p_collection_unit_id, '], ["criterion_id", ', p_criterion_id, '], ["assessor_id", ', p_assessor_id, '], ["date_assessed", "', p_date_assessed, '"], ["criteria_assessment", "', p_criteria_assessment, '"], ["date_from", "', current_datetime, '"], ["current", "yes"]]'));
		
		ELSE
		
			# Insert the new record
			CALL sp_insert_record('unit_assessment_criterion', CONCAT('[["collection_unit_id", ', p_collection_unit_id, '], ["criterion_id", ', p_criterion_id, '], ["assessor_id", ', p_assessor_id, '], ["date_assessed", "', p_date_assessed, '"], ["criteria_assessment", "', p_criteria_assessment, '"], ["date_from", "', current_datetime, '"], ["current", "yes"]]'));
		
		END IF;
	
	#COMMIT;
	
	#START TRANSACTION;
	
		# Get the new unit_assessment_criterion_id
		SELECT 
			unit_assessment_criterion_id
		INTO
			new_id
		FROM unit_assessment_criterion
		WHERE collection_unit_id = p_collection_unit_id
		AND criterion_id = p_criterion_id
		AND current = 'yes';
	
		# Add the unit_assessment_rank records
		CALL sp_insert_unit_assessment_rank(new_id, 1, p_rank_1_percentage, p_rank_1_comment);
		CALL sp_insert_unit_assessment_rank(new_id, 2, p_rank_2_percentage, p_rank_2_comment);
		CALL sp_insert_unit_assessment_rank(new_id, 3, p_rank_3_percentage, p_rank_3_comment);
		CALL sp_insert_unit_assessment_rank(new_id, 4, p_rank_4_percentage, p_rank_4_comment);
		CALL sp_insert_unit_assessment_rank(new_id, 5, p_rank_5_percentage, p_rank_5_comment);
	
	COMMIT;
	
END//
DELIMITER ;

-- Dumping structure for procedure jtd_live.sp_insert_unit_assessment_rank
DELIMITER //
CREATE PROCEDURE `sp_insert_unit_assessment_rank`(
	IN `p_unit_assessment_criterion_id` INT,
	IN `p_rank` INT,
	IN `p_percentage` DECIMAL(8,7)


,
	IN `p_comment` VARCHAR(1000)









)
BEGIN

	# Example use:
	# CALL sp_insert_unit_assessment_rank(102451, 4, 0.85);

	DECLARE v_rank_id INT;
	DECLARE v_criterion_id INT;
	
	START TRANSACTION;

		# Get the criterion id for the rank query
		SELECT 
			criterion_id
		INTO
			v_criterion_id
		FROM unit_assessment_criterion
		WHERE unit_assessment_criterion_id = p_unit_assessment_criterion_id;
		
		# Get the rank_id for the rank
		SELECT 
			rank_id
		INTO
			v_rank_id
		FROM `rank`
		WHERE rank_value = p_rank
		AND criterion_id = v_criterion_id;
	
		IF p_comment IS NULL THEN
			SET p_comment = 'null';			
		ELSE
			SET p_comment = CONCAT('"', REPLACE(p_comment,'\'','\\\''), '"');
		END IF;
	
		# Insert the new record
		CALL sp_insert_record('unit_assessment_rank', 
			CONCAT('[["unit_assessment_criterion_id", ', p_unit_assessment_criterion_id, '], ["rank_id", ', v_rank_id, '], ["percentage", ', p_percentage, '], ["comment", ', REPLACE(p_comment,'\\\'','\''), ']]'));
		
		#CALL sp_insert_record('unit_assessment_rank', CONCAT('[["unit_assessment_criterion_id", 102477], ["rank_id", 22], ["percentage", 0.1], ["comment", ""]]'));
		
	COMMIT;
	
END//
DELIMITER ;

-- Dumping structure for procedure jtd_live.sp_update_record
DELIMITER //
CREATE PROCEDURE `sp_update_record`(
	IN `p_table` VARCHAR(50),
	IN `p_record_id` INT,
	IN `p_data` JSON



























)
BEGIN

	# Expects a table name, a record id, and a json array of field names and values
	# Example: CALL sp_update_record('collection_unit', 3745, '[["responsible_curator_id", 13], ["taxon_life_science_id", 99], ["unit_name", "Bob"], ["section_id", null]]');

	DECLARE current_datetime DATETIME;
	DECLARE table_update_sql TEXT;
	DECLARE audit_sql TEXT;
	DECLARE field_count INT;
	DECLARE current_field INT;
	DECLARE audit_data TEXT;
	DECLARE select_sql TEXT;
	DECLARE old_value TEXT;
	DECLARE data_type TEXT;
	DECLARE field_name TEXT;
	DECLARE field_value TEXT;
	DECLARE schema_sql TEXT;
	
	START TRANSACTION;
	
	# Initialise variables
	SET current_datetime = NOW();
	SET field_count = JSON_LENGTH(p_data);
	SET current_field = 0;	
	SET table_update_sql = CONCAT('UPDATE ', p_table, ' SET ');
	SET audit_sql = 'INSERT INTO audit VALUES (';
	SET audit_data = '';
	SET select_sql = '';
	SET schema_sql = '';

	WHILE current_field < field_count DO
		
		SET field_name = JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][0]'));
		SET field_value = JSON_EXTRACT(p_data, CONCAT('$[', current_field, '][1]'));
				
		# Get the existing value for the field
		SET @select_sql = CONCAT('SELECT ', JSON_UNQUOTE(field_name), ' INTO @old_value FROM ', p_table, ' WHERE ', CONCAT(p_table, '_id'), ' = ', p_record_id);
		PREPARE stmt FROM @select_sql;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
			
		# Get the field data type
		SET @schema_sql = CONCAT('SELECT DATA_TYPE INTO @data_type FROM information_schema.`COLUMNS` WHERE TABLE_NAME = \'', p_table, '\' AND TABLE_SCHEMA = \'jtd_live\' AND COLUMN_NAME = \'', JSON_UNQUOTE(field_name), '\'');
		PREPARE stmt FROM @schema_sql;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
		
		# Prepare value for audit according to data type
		IF @old_value IS NULL THEN
			SET @old_value = 'null';
		ELSEIF @data_type IN ('varchar', 'enum', 'datetime', 'longtext', 'text', 'date') THEN
			SET @old_value = CONCAT('"', @old_value, '"');
		END IF;
		
		IF current_field = 0 THEN
		
			# Add to the table sql update string
			SET table_update_sql = CONCAT(table_update_sql, JSON_UNQUOTE(field_name), ' = ', REPLACE(field_value,'"', '\''));			
			
			# Add to the audit sql insert string
			SET audit_data = CONCAT('[{"field_name": ', field_name, ', "new_value": ', field_value, ', "old_value": ', @old_value, '}');
			
		ELSE
		
			# Add to the table sql update string
			SET table_update_sql = CONCAT(table_update_sql, ', ', JSON_UNQUOTE(field_name), ' = ', REPLACE(field_value,'"', '\''));
			
			# Add to the audit sql insert string
			SET audit_data = CONCAT(audit_data, ', {"field_name": ', field_name, ', "new_value": ', field_value, ', "old_value": ', @old_value, '}');
			
		END IF;
		
		SET current_field = current_field + 1;
	
	END WHILE;	

	# Update main table
	SET @sql_statement = CONCAT(table_update_sql, ' WHERE ', p_table, '_id = ', p_record_id);
	PREPARE table_update_sql FROM @sql_statement;
	EXECUTE table_update_sql;

	# Insert record into audit table
	SET @sql_statement = CONCAT(audit_sql, 'NULL, \'', p_table, '\', ', p_record_id, ', \'update\', \'', current_datetime, '\', \'mattw2\', \'', audit_data, ']\')');
	PREPARE audit_sql FROM @sql_statement;
	EXECUTE audit_sql;
	
	COMMIT;
	
END//
DELIMITER ;

-- Dumping structure for function jtd_live.fn_criterion_distribution
DELIMITER //
CREATE FUNCTION `fn_criterion_distribution`(
	`p_rank_1_percentage` DECIMAL(8,7),
	`p_rank_2_percentage` DECIMAL(8,7),
	`p_rank_3_percentage` DECIMAL(8,7),
	`p_rank_4_percentage` DECIMAL(8,7),
	`p_rank_5_percentage` DECIMAL(8,7)

) RETURNS text CHARSET latin1
    DETERMINISTIC
BEGIN

	DECLARE output_string TEXT;
	DECLARE rank_1_multiplied DOUBLE;
	DECLARE rank_2_multiplied DOUBLE;
	DECLARE rank_3_multiplied DOUBLE;
	DECLARE rank_4_multiplied DOUBLE;
	DECLARE rank_5_multiplied DOUBLE;
	
	SET output_string = '';
	
	IF p_rank_1_percentage > 0 THEN
		SET rank_1_multiplied = p_rank_1_percentage * 100;
		SET output_string = CONCAT('1 (', rank_1_multiplied, '%)');
	END IF;
	
	IF p_rank_2_percentage > 0 THEN
		SET rank_2_multiplied = p_rank_2_percentage * 100;
		IF output_string <> '' THEN
			SET output_string = CONCAT(output_string, ', ', '2 (', rank_2_multiplied, '%)');
		ELSE
			SET output_string = CONCAT('2 (', rank_2_multiplied, '%)');
		END IF;
	END IF;
	
	IF p_rank_3_percentage > 0 THEN
		SET rank_3_multiplied = p_rank_3_percentage * 100;
		IF output_string <> '' THEN
			SET output_string = CONCAT(output_string, ', ', '3 (', rank_3_multiplied, '%)');
		ELSE
			SET output_string = CONCAT('3 (', rank_3_multiplied, '%)');
		END IF;
	END IF;
	
	IF p_rank_4_percentage > 0 THEN
		SET rank_4_multiplied = p_rank_4_percentage * 100;
		IF output_string <> '' THEN
			SET output_string = CONCAT(output_string, ', ', '4 (', rank_4_multiplied, '%)');
		ELSE
			SET output_string = CONCAT('4 (', rank_4_multiplied, '%)');
		END IF;
	END IF;
	
	IF p_rank_5_percentage > 0 THEN
		SET rank_5_multiplied = p_rank_5_percentage * 100;
		IF output_string <> '' THEN
			SET output_string = CONCAT(output_string, ', ', '5 (', rank_5_multiplied, '%)');
		ELSE
			SET output_string = CONCAT('5 (', rank_5_multiplied, '%)');
		END IF;
	END IF;

	RETURN output_string;

END//
DELIMITER ;

-- Dumping structure for function jtd_live.fn_get_criterion_average
DELIMITER //
CREATE FUNCTION `fn_get_criterion_average`(
	`p_collection_unit_id` INT,
	`p_criterion_id` INT

) RETURNS decimal(8,5)
    DETERMINISTIC
BEGIN

	DECLARE weighted_average DECIMAL(8,5);	
	DECLARE rank_percentage_1 DECIMAL(8,7);
	DECLARE rank_percentage_2 DECIMAL(8,7);
	DECLARE rank_percentage_3 DECIMAL(8,7);
	DECLARE rank_percentage_4 DECIMAL(8,7);
	DECLARE rank_percentage_5 DECIMAL(8,7);

	SELECT 
		percentage
	INTO
		rank_percentage_1
	FROM unit_assessment_rank a 
	INNER JOIN `rank` b ON b.rank_id = a.rank_id
	WHERE b.rank_value = 1
	AND a.unit_assessment_criterion_id = (
		SELECT unit_assessment_criterion_id
		FROM unit_assessment_criterion c
		WHERE c.collection_unit_id = p_collection_unit_id
		AND c.criterion_id = p_criterion_id
		AND current = 'yes'
	);

	SELECT 
		percentage
	INTO
		rank_percentage_2
	FROM unit_assessment_rank a 
	INNER JOIN `rank` b ON b.rank_id = a.rank_id
	WHERE b.rank_value = 2
	AND a.unit_assessment_criterion_id = (
		SELECT unit_assessment_criterion_id
		FROM unit_assessment_criterion c
		WHERE c.collection_unit_id = p_collection_unit_id
		AND c.criterion_id = p_criterion_id
		AND current = 'yes'
	);

	SELECT 
		percentage
	INTO
		rank_percentage_3
	FROM unit_assessment_rank a 
	INNER JOIN `rank` b ON b.rank_id = a.rank_id
	WHERE b.rank_value = 3
	AND a.unit_assessment_criterion_id = (
		SELECT unit_assessment_criterion_id
		FROM unit_assessment_criterion c
		WHERE c.collection_unit_id = p_collection_unit_id
		AND c.criterion_id = p_criterion_id
		AND current = 'yes'
	);

	SELECT 
		percentage
	INTO
		rank_percentage_4
	FROM unit_assessment_rank a 
	INNER JOIN `rank` b ON b.rank_id = a.rank_id
	WHERE b.rank_value = 4
	AND a.unit_assessment_criterion_id = (
		SELECT unit_assessment_criterion_id
		FROM unit_assessment_criterion c
		WHERE c.collection_unit_id = p_collection_unit_id
		AND c.criterion_id = p_criterion_id
		AND current = 'yes'
	);

	SELECT 
		percentage
	INTO
		rank_percentage_5
	FROM unit_assessment_rank a 
	INNER JOIN `rank` b ON b.rank_id = a.rank_id
	WHERE b.rank_value = 5
	AND a.unit_assessment_criterion_id = (
		SELECT unit_assessment_criterion_id
		FROM unit_assessment_criterion c
		WHERE c.collection_unit_id = p_collection_unit_id
		AND c.criterion_id = p_criterion_id
		AND current = 'yes'
	);

	SET weighted_average = rank_percentage_1 + (rank_percentage_2 * 2) + (rank_percentage_3 * 3) + (rank_percentage_4 * 4) + (rank_percentage_5 * 5);
	
	RETURN weighted_average;

END//
DELIMITER ;

-- Dumping structure for function jtd_live.fn_get_higher_change_id
DELIMITER //
CREATE FUNCTION `fn_get_higher_change_id`() RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN

	DECLARE result INT(11);
	
   SELECT MAX(structural_changes_higher_id) from structural_changes_higher INTO result;
	
	RETURN result;


END//
DELIMITER ;

-- Dumping structure for function jtd_live.fn_get_weighed_average
DELIMITER //
CREATE FUNCTION `fn_get_weighed_average`(
	`p_rank_1_percentage` DECIMAL(8,7),
	`p_rank_2_percentage` DECIMAL(8,7),
	`p_rank_3_percentage` DECIMAL(8,7),
	`p_rank_4_percentage` DECIMAL(8,7),
	`p_rank_5_percentage` DECIMAL(8,7)

) RETURNS decimal(8,5)
    DETERMINISTIC
BEGIN

	DECLARE weighted_average DECIMAL(8,5);

	SET weighted_average = p_rank_1_percentage + (p_rank_2_percentage * 2) + (p_rank_3_percentage * 3) + (p_rank_4_percentage * 4) + (p_rank_5_percentage * 5);
	
	RETURN weighted_average;

END//
DELIMITER ;

-- Dumping structure for function jtd_live.fn_portal_link
DELIMITER //
CREATE FUNCTION `fn_portal_link`(
	`taxon` TEXT,
	`taxon_rank` TEXT
) RETURNS text CHARSET utf8mb4
    DETERMINISTIC
    COMMENT 'Returns a Portal URL filtered by taxon rank and value. If there are no non-null values passed, function returns null'
BEGIN

DECLARE portal_url TEXT;

IF (ISNULL(taxon) AND ISNULL(taxon_rank)) THEN
	set portal_url = NULL;
ELSE
	set portal_url = CONCAT('https://data.nhm.ac.uk/dataset/56e711e6-c847-4f99-915a-6894bb5c5dea/resource/05ff2255-c38a-40c9-b657-4ccb55ab2feb?q=&filters=' , 
	taxon_rank, '%3A', taxon);
END IF;

RETURN (portal_url);

END//
DELIMITER ;

-- Dumping structure for function jtd_live.fn_split_unit_previous_id
DELIMITER //
CREATE FUNCTION `fn_split_unit_previous_id`(
	`curr_unit_id` INT
) RETURNS int
    DETERMINISTIC
BEGIN

DECLARE higher_operation_id INT;
DECLARE result_unit_id INT; 

-- query basic changes for collection_unit_id (op type is split/merge, sort by dec date and limit to 1 so we're sure it's the most recent) get higher_id
SELECT scb.structural_changes_higher_id from structural_changes_basic scb 
where scb.collection_unit_id = curr_unit_id 
order by scb.structural_changes_basic_id desc 
limit 1 into higher_operation_id;

-- use higher_id to find all matching rows in basic
-- if higher_op = 'split' we want the id of the result with the basic op type 'delete'
SELECT scb.collection_unit_id from structural_changes_basic scb
where scb.structural_changes_higher_id = higher_operation_id
and scb.operation = 'delete'
into result_unit_id;

-- pass unit id back
RETURN result_unit_id;

END//
DELIMITER ;

-- Dumping structure for view jtd_live.vw_all_current_scores
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_all_current_scores`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_all_current_scores` AS select `cu`.`collection_unit_id` AS `collection_unit_id`,`di`.`division_name` AS `division_name`,`se`.`section_name` AS `section_name`,concat(`pe`.`first_name`,' ',`pe`.`last_name`) AS `responsible_curator`,`cud`.`description` AS `curatorial_unit_type`,(select `item_type`.`item_type` from `item_type` where (`item_type`.`item_type_id` = `cud`.`item_type_id`)) AS `item_type`,(select `preservation_method`.`preservation_method` from `preservation_method` where (`preservation_method`.`preservation_method_id` = `cud`.`preservation_method_id`)) AS `preservation_method`,`cu`.`unit_name` AS `unit_name`,(select group_concat(concat(`person`.`first_name`,' ',`person`.`last_name`) separator '; ') from `person` where `person`.`person_id` in (select distinct `unit_assessment_criterion`.`assessor_id` from `unit_assessment_criterion` where ((`unit_assessment_criterion`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`unit_assessment_criterion`.`current` = 'yes')))) AS `assessor`,`vmc`.`curatorial_unit_count` AS `curatorial_unit_count`,`vmc`.`curatorial_unit_count_confidence` AS `curatorial_unit_count_confidence`,`vmc`.`item_count` AS `item_count`,`vmc`.`item_count_confidence` AS `item_count_confidence`,`vmc`.`barcoded_percentage` AS `barcoded_percentage`,`vmc`.`barcoded_percentage_confidence` AS `barcoded_percentage_confidence`,(select `uc`.`unit_comment` from `unit_comment` `uc` where (`uc`.`collection_unit_id` = `cu`.`collection_unit_id`) order by `uc`.`date_added` desc limit 1) AS `unit_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_5_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_1`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_1_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_2`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_2_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_3`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_3_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_4`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_4_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_5`,(select `uar`.`comment` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_5_comment` from (((((`collection_unit` `cu` left join `section` `se` on((`se`.`section_id` = `cu`.`section_id`))) left join `division` `di` on((`di`.`division_id` = `se`.`division_id`))) left join `person` `pe` on((`pe`.`person_id` = `cu`.`responsible_curator_id`))) left join `curatorial_unit_definition` `cud` on((`cud`.`curatorial_unit_definition_id` = `cu`.`curatorial_unit_definition_id`))) left join `vw_metrics_current` `vmc` on((`vmc`.`collection_unit_id` = `cu`.`collection_unit_id`))) where (`cu`.`unit_active` = 'yes') order by `cu`.`collection_unit_id`;

-- Dumping structure for view jtd_live.vw_all_current_scores_no_comments
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_all_current_scores_no_comments`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_all_current_scores_no_comments` AS select `cu`.`collection_unit_id` AS `collection_unit_id`,`de`.`department_name` AS `department_name`,`di`.`division_name` AS `division_name`,`se`.`section_name` AS `section_name`,concat(`pe`.`first_name`,' ',`pe`.`last_name`) AS `responsible_curator`,`cud`.`description` AS `curatorial_unit_type`,`cud`.`items_unestimatable_flag` AS `items_unestimatable_flag`,(select `item_type`.`item_type` from `item_type` where (`item_type`.`item_type_id` = `cud`.`item_type_id`)) AS `item_type`,(select `preservation_method`.`preservation_method` from `preservation_method` where (`preservation_method`.`preservation_method_id` = `cud`.`preservation_method_id`)) AS `preservation_method`,`cu`.`unit_name` AS `unit_name`,(select group_concat(concat(`person`.`first_name`,' ',`person`.`last_name`) separator '; ') from `person` where `person`.`person_id` in (select distinct `unit_assessment_criterion`.`assessor_id` from `unit_assessment_criterion` where ((`unit_assessment_criterion`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`unit_assessment_criterion`.`current` = 'yes')))) AS `assessor`,`vmc`.`curatorial_unit_count` AS `curatorial_unit_count`,`vmc`.`curatorial_unit_count_confidence` AS `curatorial_unit_count_confidence`,`vmc`.`item_count` AS `item_count`,`vmc`.`item_count_confidence` AS `item_count_confidence`,`vmc`.`barcoded_percentage` AS `barcoded_percentage`,`vmc`.`barcoded_percentage_confidence` AS `barcoded_percentage_confidence`,if((`cud`.`items_unestimatable_flag` = 'yes'),`vmc`.`curatorial_unit_count`,if((`cu`.`count_curatorial_units_flag` = 'yes'),`vmc`.`curatorial_unit_count`,`vmc`.`item_count`)) AS `reporting_count`,if((`cud`.`items_unestimatable_flag` = 'yes'),'Curatorial unit',if((`cu`.`count_curatorial_units_flag` = 'yes'),'Curatorial unit','Item')) AS `reporting_metric_used`,(select `uc`.`unit_comment` from `unit_comment` `uc` where (`uc`.`collection_unit_id` = `cu`.`collection_unit_id`) order by `uc`.`date_added` desc limit 1) AS `unit_comment`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_5`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_1`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_2`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_3`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_4`,(select `uar`.`percentage` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_5` from ((((((`collection_unit` `cu` left join `section` `se` on((`se`.`section_id` = `cu`.`section_id`))) left join `division` `di` on((`di`.`division_id` = `se`.`division_id`))) left join `department` `de` on((`de`.`department_id` = `di`.`department_id`))) left join `person` `pe` on((`pe`.`person_id` = `cu`.`responsible_curator_id`))) left join `curatorial_unit_definition` `cud` on((`cud`.`curatorial_unit_definition_id` = `cu`.`curatorial_unit_definition_id`))) left join `vw_metrics_current` `vmc` on((`vmc`.`collection_unit_id` = `cu`.`collection_unit_id`))) where (`cu`.`unit_active` = 'yes') order by `cu`.`collection_unit_id`;

-- Dumping structure for view jtd_live.vw_collections_hierarchy
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_collections_hierarchy`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_collections_hierarchy` AS select distinct `d`.`department_name` AS `Department`,concat_ws(' ',`p`.`first_name`,`p`.`last_name`) AS `Head of Collections`,`f`.`division_name` AS `Division Name`,concat_ws(' ',`p2`.`first_name`,`p2`.`last_name`) AS `Principal Curator in Charge`,concat_ws(' ',`p3`.`first_name`,`p3`.`last_name`) AS `Head of Division`,`s`.`section_name` AS `Section Name`,concat_ws(' ',`p4`.`first_name`,`p4`.`last_name`) AS `Senior Curator` from ((((((`department` `d` left join `division` `f` on((`d`.`department_id` = `f`.`department_id`))) left join `section` `s` on((`f`.`division_id` = `s`.`division_id`))) left join `person` `p` on((`d`.`head_of_collections_id` = `p`.`person_id`))) left join `person` `p2` on((`f`.`principal_curator_id` = `p2`.`person_id`))) left join `person` `p3` on((`f`.`head_of_division_id` = `p3`.`person_id`))) left join `person` `p4` on((`s`.`senior_curator_id` = `p4`.`person_id`)));

-- Dumping structure for view jtd_live.vw_collection_units_denormalised
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_collection_units_denormalised`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_collection_units_denormalised` AS select `cu`.`collection_unit_id` AS `collection_unit_id`,`cu`.`unit_name` AS `unit_name`,`de`.`department_name` AS `department_name`,`di`.`division_name` AS `division_name`,`se`.`section_name` AS `section_name`,concat(`pe`.`first_name`,' ',`pe`.`last_name`) AS `responsible_curator`,`cud`.`description` AS `curatorial_unit_type`,`cud`.`items_unestimatable_flag` AS `items_unestimatable_flag`,`it`.`item_type` AS `item_type`,`pm`.`preservation_method` AS `preservation_method`,`bl`.`bibliographic_level` AS `bibliographic_level`,`tls`.`taxon_name` AS `taxon_ls`,`tlp`.`taxon_name` AS `taxon_palaeo`,`cu`.`informal_taxon` AS `informal_taxon`,`laf`.`function_name` AS `archives_function`,`si`.`site_name` AS `site_name`,`bu`.`building_name` AS `building_name`,`fl`.`floor_name` AS `floor_name`,`sr`.`room_code` AS `room_code`,`sc`.`container_name` AS `container_name`,`go`.`geographic_origin_name` AS `geographic_origin_name`,`cu`.`type_collection_flag` AS `type_collection_flag`,`cu`.`named_collection` AS `named_collection`,`gtpt`.`period_name` AS `geological_time_period_from`,`gtpf`.`period_name` AS `geological_time_period_to`,`cu`.`es_recent_specimen_flag` AS `es_recent_specimen_flag`,`cu`.`archives_fond_ref` AS `archives_fond_ref` from (((((((((((((((((((`collection_unit` `cu` left join `section` `se` on((`se`.`section_id` = `cu`.`section_id`))) left join `division` `di` on((`di`.`division_id` = `se`.`division_id`))) left join `department` `de` on((`de`.`department_id` = `di`.`department_id`))) left join `person` `pe` on((`pe`.`person_id` = `cu`.`responsible_curator_id`))) left join `curatorial_unit_definition` `cud` on((`cud`.`curatorial_unit_definition_id` = `cu`.`curatorial_unit_definition_id`))) left join `item_type` `it` on((`it`.`item_type_id` = `cud`.`item_type_id`))) left join `preservation_method` `pm` on((`pm`.`preservation_method_id` = `cud`.`preservation_method_id`))) left join `bibliographic_level` `bl` on((`bl`.`bibliographic_level_id` = `cud`.`bibliographic_level_id`))) left join `taxon_life_science` `tls` on((`tls`.`taxon_life_science_id` = `cu`.`taxon_life_science_id`))) left join `taxon_palaeontology` `tlp` on((`tlp`.`taxon_palaeontology_id` = `cu`.`taxon_palaeontology_id`))) left join `library_and_archives_function` `laf` on((`laf`.`library_and_archives_function_id` = `cu`.`library_and_archives_function_id`))) left join `storage_room` `sr` on((`sr`.`storage_room_id` = `cu`.`storage_room_id`))) left join `floor` `fl` on((`fl`.`floor_id` = `sr`.`floor_id`))) left join `building` `bu` on((`bu`.`building_id` = `fl`.`building_id`))) left join `site` `si` on((`si`.`site_id` = `bu`.`site_id`))) left join `storage_container` `sc` on((`sc`.`storage_container_id` = `cu`.`storage_container_id`))) left join `geographic_origin` `go` on((`go`.`geographic_origin_id` = `cu`.`geographic_origin_id`))) left join `geological_time_period` `gtpt` on((`gtpt`.`geological_time_period_id` = `cu`.`geological_time_period_from_id`))) left join `geological_time_period` `gtpf` on((`gtpf`.`geological_time_period_id` = `cu`.`geological_time_period_to_id`))) where (`cu`.`unit_active` = 'yes') order by `cu`.`unit_name`;

-- Dumping structure for view jtd_live.vw_criteria_rank_current
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_criteria_rank_current`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_criteria_rank_current` AS select `vcrh`.`unit_assessment_criterion_id` AS `unit_assessment_criterion_id`,`vcrh`.`collection_unit_id` AS `collection_unit_id`,`vcrh`.`criterion_id` AS `criterion_id`,`vcrh`.`assessor_id` AS `assessor_id`,`vcrh`.`criteria_assessment` AS `criteria_assessment`,`vcrh`.`date_assessed` AS `date_assessed`,`vcrh`.`date_from` AS `date_from`,`vcrh`.`date_to` AS `date_to`,`vcrh`.`current` AS `current`,`vcrh`.`rank_1_id` AS `rank_1_id`,`vcrh`.`rank_1_percentage` AS `rank_1_percentage`,`vcrh`.`rank_1_comment` AS `rank_1_comment`,`vcrh`.`rank_2_id` AS `rank_2_id`,`vcrh`.`rank_2_percentage` AS `rank_2_percentage`,`vcrh`.`rank_2_comment` AS `rank_2_comment`,`vcrh`.`rank_3_id` AS `rank_3_id`,`vcrh`.`rank_3_percentage` AS `rank_3_percentage`,`vcrh`.`rank_3_comment` AS `rank_3_comment`,`vcrh`.`rank_4_id` AS `rank_4_id`,`vcrh`.`rank_4_percentage` AS `rank_4_percentage`,`vcrh`.`rank_4_comment` AS `rank_4_comment`,`vcrh`.`rank_5_id` AS `rank_5_id`,`vcrh`.`rank_5_percentage` AS `rank_5_percentage`,`vcrh`.`rank_5_comment` AS `rank_5_comment` from `vw_criteria_rank_history` `vcrh` where (`vcrh`.`current` = 'yes') order by `vcrh`.`collection_unit_id`,`vcrh`.`criterion_id`;

-- Dumping structure for view jtd_live.vw_criteria_rank_history
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_criteria_rank_history`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_criteria_rank_history` AS select `uac`.`unit_assessment_criterion_id` AS `unit_assessment_criterion_id`,`uac`.`collection_unit_id` AS `collection_unit_id`,`uac`.`criterion_id` AS `criterion_id`,`uac`.`assessor_id` AS `assessor_id`,`uac`.`criteria_assessment` AS `criteria_assessment`,`uac`.`date_assessed` AS `date_assessed`,`uac`.`date_from` AS `date_from`,`uac`.`date_to` AS `date_to`,`uac`.`current` AS `current`,(select `uar`.`rank_id` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 1))) AS `rank_1_id`,(select `uar`.`percentage` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 1))) AS `rank_1_percentage`,(select `uar`.`comment` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 1))) AS `rank_1_comment`,(select `uar`.`rank_id` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 2))) AS `rank_2_id`,(select `uar`.`percentage` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 2))) AS `rank_2_percentage`,(select `uar`.`comment` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 2))) AS `rank_2_comment`,(select `uar`.`rank_id` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 3))) AS `rank_3_id`,(select `uar`.`percentage` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 3))) AS `rank_3_percentage`,(select `uar`.`comment` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 3))) AS `rank_3_comment`,(select `uar`.`rank_id` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 4))) AS `rank_4_id`,(select `uar`.`percentage` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 4))) AS `rank_4_percentage`,(select `uar`.`comment` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 4))) AS `rank_4_comment`,(select `uar`.`rank_id` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 5))) AS `rank_5_id`,(select `uar`.`percentage` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 5))) AS `rank_5_percentage`,(select `uar`.`comment` from (`unit_assessment_rank` `uar` join `rank` `r` on((`r`.`rank_id` = `uar`.`rank_id`))) where ((`uar`.`unit_assessment_criterion_id` = `uac`.`unit_assessment_criterion_id`) and (`r`.`rank_value` = 5))) AS `rank_5_comment` from `unit_assessment_criterion` `uac` order by `uac`.`collection_unit_id`,`uac`.`criterion_id`,`uac`.`date_from` desc;

-- Dumping structure for view jtd_live.vw_current_counts
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_current_counts`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_current_counts` AS select `cu`.`collection_unit_id` AS `collection_unit_id`,`di`.`division_name` AS `division_name`,`se`.`section_name` AS `section_name`,concat(`pe`.`first_name`,' ',`pe`.`last_name`) AS `responsible_curator`,`cud`.`description` AS `curatorial_unit_type`,(select `item_type`.`item_type` from `item_type` where (`item_type`.`item_type_id` = `cud`.`item_type_id`)) AS `item_type`,(select `preservation_method`.`preservation_method` from `preservation_method` where (`preservation_method`.`preservation_method_id` = `cud`.`preservation_method_id`)) AS `preservation_method`,`cu`.`unit_name` AS `unit_name`,(select group_concat(concat(`person`.`first_name`,' ',`person`.`last_name`) separator '; ') from `person` where `person`.`person_id` in (select distinct `unit_assessment_criterion`.`assessor_id` from `unit_assessment_criterion` where ((`unit_assessment_criterion`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`unit_assessment_criterion`.`current` = 'yes')))) AS `assessor`,`vmc`.`curatorial_unit_count` AS `curatorial_unit_count`,`vmc`.`curatorial_unit_count_confidence` AS `curatorial_unit_count_confidence`,`vmc`.`item_count` AS `item_count`,`vmc`.`item_count_confidence` AS `item_count_confidence`,`vmc`.`barcoded_percentage` AS `barcoded_percentage`,`vmc`.`barcoded_percentage_confidence` AS `barcoded_percentage_confidence`,`cud`.`items_unestimatable_flag` AS `items_unestimatable_flag`,`cu`.`count_curatorial_units_flag` AS `count_curatorial_units_flag` from (((((`collection_unit` `cu` left join `section` `se` on((`se`.`section_id` = `cu`.`section_id`))) left join `division` `di` on((`di`.`division_id` = `se`.`division_id`))) left join `person` `pe` on((`pe`.`person_id` = `cu`.`responsible_curator_id`))) left join `curatorial_unit_definition` `cud` on((`cud`.`curatorial_unit_definition_id` = `cu`.`curatorial_unit_definition_id`))) left join `vw_metrics_current` `vmc` on((`vmc`.`collection_unit_id` = `cu`.`collection_unit_id`))) where (`cu`.`unit_active` = 'yes') order by `cu`.`collection_unit_id`;

-- Dumping structure for view jtd_live.vw_metrics_current
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_metrics_current`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_metrics_current` AS select `cu`.`collection_unit_id` AS `collection_unit_id`,(select `cum`.`metric_value` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 1))) AS `item_count`,(select `cum`.`confidence_level` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 1))) AS `item_count_confidence`,(select `cum`.`date_from` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 1))) AS `item_count_last_updated`,(select `cum`.`metric_value` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 2))) AS `curatorial_unit_count`,(select `cum`.`confidence_level` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 2))) AS `curatorial_unit_count_confidence`,(select `cum`.`date_from` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 2))) AS `curatorial_unit_count_last_updated`,(select `cum`.`metric_value` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 3))) AS `barcoded_percentage`,(select `cum`.`confidence_level` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 3))) AS `barcoded_percentage_confidence`,(select `cum`.`date_from` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 3))) AS `barcoded_percentage_last_updated` from `collection_unit` `cu` where (`cu`.`unit_active` = 'yes') order by `cu`.`collection_unit_id`;

-- Dumping structure for view jtd_live.vw_metrics_current_including_inactive
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_metrics_current_including_inactive`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_metrics_current_including_inactive` AS select `cu`.`collection_unit_id` AS `collection_unit_id`,(select `cum`.`metric_value` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 1))) AS `item_count`,(select `cum`.`confidence_level` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 1))) AS `item_count_confidence`,(select `cum`.`date_from` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 1))) AS `item_count_last_updated`,(select `cum`.`metric_value` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 2))) AS `curatorial_unit_count`,(select `cum`.`confidence_level` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 2))) AS `curatorial_unit_count_confidence`,(select `cum`.`date_from` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 2))) AS `curatorial_unit_count_last_updated`,(select `cum`.`metric_value` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 3))) AS `barcoded_percentage`,(select `cum`.`confidence_level` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 3))) AS `barcoded_percentage_confidence`,(select `cum`.`date_from` from `collection_unit_metric` `cum` where ((`cum`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`cum`.`current` = 'yes') and (`cum`.`collection_unit_metric_definition_id` = 3))) AS `barcoded_percentage_last_updated` from `collection_unit` `cu` order by `cu`.`collection_unit_id`;

-- Dumping structure for view jtd_live.vw_person_name_lookup
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_person_name_lookup`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_person_name_lookup` AS select `jtd_test`.`person`.`person_id` AS `person_id`,concat_ws(' ',`jtd_test`.`person`.`first_name`,`jtd_test`.`person`.`last_name`) AS `full_name` from `jtd_test`.`person`;

-- Dumping structure for view jtd_live.vw_reporting_section_list
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_reporting_section_list`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_reporting_section_list` AS select `dep`.`department_name` AS `department_name`,`di`.`division_name` AS `division_name`,`se`.`section_name` AS `section_name`,`se`.`section_id` AS `section_id`,count(`cu`.`collection_unit_id`) AS `unit_count` from (((`collection_unit` `cu` left join `section` `se` on((`se`.`section_id` = `cu`.`section_id`))) left join `division` `di` on((`di`.`division_id` = `se`.`division_id`))) left join `department` `dep` on((`di`.`department_id` = `dep`.`department_id`))) where (`cu`.`unit_active` = 'yes') group by `dep`.`department_name`,`di`.`division_name`,`se`.`section_name`,`se`.`section_id` order by `dep`.`department_name`;

-- Dumping structure for view jtd_live.vw_reporting_unit_metrics
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_reporting_unit_metrics`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_reporting_unit_metrics` AS select `cu`.`collection_unit_id` AS `collection_unit_id`,`di`.`division_name` AS `division_name`,`se`.`section_name` AS `section_name`,`cud`.`description` AS `curatorial_unit_type`,(select `item_type`.`item_type` from `item_type` where (`item_type`.`item_type_id` = `cud`.`item_type_id`)) AS `item_type`,(select `preservation_method`.`preservation_method` from `preservation_method` where (`preservation_method`.`preservation_method_id` = `cud`.`preservation_method_id`)) AS `preservation_method`,`cu`.`unit_name` AS `unit_name`,`vmc`.`curatorial_unit_count` AS `curatorial_unit_count`,`vmc`.`curatorial_unit_count_confidence` AS `curatorial_unit_count_confidence`,`vmc`.`item_count` AS `item_count`,`vmc`.`item_count_confidence` AS `item_count_confidence`,`vmc`.`barcoded_percentage` AS `barcoded_percentage`,`vmc`.`barcoded_percentage_confidence` AS `barcoded_percentage_confidence`,if(((`cu`.`count_curatorial_units_flag` = 'yes') or (`cud`.`items_unestimatable_flag` = 'yes')),`vmc`.`curatorial_unit_count`,`vmc`.`item_count`) AS `reporting_count`,if(((`cu`.`count_curatorial_units_flag` = 'yes') or (`cud`.`items_unestimatable_flag` = 'yes')),'Curatorial unit','Item') AS `reporting_metric_used` from (((((`collection_unit` `cu` left join `section` `se` on((`se`.`section_id` = `cu`.`section_id`))) left join `division` `di` on((`di`.`division_id` = `se`.`division_id`))) left join `person` `pe` on((`pe`.`person_id` = `cu`.`responsible_curator_id`))) left join `curatorial_unit_definition` `cud` on((`cud`.`curatorial_unit_definition_id` = `cu`.`curatorial_unit_definition_id`))) left join `vw_metrics_current` `vmc` on((`vmc`.`collection_unit_id` = `cu`.`collection_unit_id`))) where (`cu`.`unit_active` = 'yes') order by `cu`.`collection_unit_id`;

-- Dumping structure for view jtd_live.vw_unit_rescore_form
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_unit_rescore_form`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_unit_rescore_form` AS select `cu`.`collection_unit_id` AS `collection_unit_id`,`di`.`division_name` AS `division_name`,`se`.`section_name` AS `section_name`,concat(`pe`.`first_name`,' ',`pe`.`last_name`) AS `responsible_curator`,`cud`.`description` AS `curatorial_unit_type`,`cu`.`unit_name` AS `unit_name`,'' AS `sort_order`,(select concat(`person`.`first_name`,' ',`person`.`last_name`) from `person` where (`person`.`person_id` in (select distinct `unit_assessment_criterion`.`assessor_id` from `unit_assessment_criterion` where ((`unit_assessment_criterion`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`unit_assessment_criterion`.`current` = 'yes'))) and (`person`.`person_id` <> 113)) limit 1) AS `assessor`,`vmc`.`curatorial_unit_count` AS `curatorial_unit_count`,`vmc`.`curatorial_unit_count_confidence` AS `curatorial_unit_count_confidence`,`vmc`.`item_count` AS `item_count`,`vmc`.`item_count_confidence` AS `item_count_confidence`,`vmc`.`barcoded_percentage` AS `barcoded_percentage`,`vmc`.`barcoded_percentage_confidence` AS `barcoded_percentage_confidence`,(select `uc`.`unit_comment` from `unit_comment` `uc` where (`uc`.`collection_unit_id` = `cu`.`collection_unit_id`) order by `uc`.`date_added` desc limit 1) AS `unit_comment`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 1)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 1)))))) AS `c1_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 2)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 2)))))) AS `c2_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 4)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 4)))))) AS `c4_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 5)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 5)))))) AS `c5_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 6)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 6)))))) AS `S1_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 7)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 7)))))) AS `S2_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 8)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 8)))))) AS `S3_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 9)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 9)))))) AS `S4_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 10)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 10)))))) AS `I1_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 11)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 11)))))) AS `I2_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 12)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 12)))))) AS `I3_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 13)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 13)))))) AS `I4_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 14)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 14)))))) AS `O1_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 15)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 15)))))) AS `O2_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 16)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 16)))))) AS `O3_rank_5`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 1) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_1`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 2) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_2`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 3) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_3`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 4) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_4`,(select if((`uar`.`percentage` = 0),'',`uar`.`percentage`) AS `perc_null` from `unit_assessment_rank` `uar` where ((`uar`.`unit_assessment_criterion_id` = (select `uac`.`unit_assessment_criterion_id` from `unit_assessment_criterion` `uac` where ((`uac`.`collection_unit_id` = `cu`.`collection_unit_id`) and (`uac`.`current` = 'yes') and (`uac`.`criterion_id` = 17)))) and (`uar`.`rank_id` = (select `r`.`rank_id` from `rank` `r` where ((`r`.`rank_value` = 5) and (`r`.`criterion_id` = 17)))))) AS `O4_rank_5` from (((((`collection_unit` `cu` left join `section` `se` on((`se`.`section_id` = `cu`.`section_id`))) left join `division` `di` on((`di`.`division_id` = `se`.`division_id`))) left join `person` `pe` on((`pe`.`person_id` = `cu`.`responsible_curator_id`))) left join `curatorial_unit_definition` `cud` on((`cud`.`curatorial_unit_definition_id` = `cu`.`curatorial_unit_definition_id`))) left join `vw_metrics_current` `vmc` on((`vmc`.`collection_unit_id` = `cu`.`collection_unit_id`))) where (`cu`.`unit_active` = 'yes') order by `cu`.`collection_unit_id`;

-- Dumping structure for view jtd_live.vw_unit_restructure_form
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_unit_restructure_form`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_unit_restructure_form` AS select `cud`.`collection_unit_id` AS `Old Unit ID`,NULL AS `Notes`,NULL AS `Action`,`cud`.`section_name` AS `OldSection`,NULL AS `NewSection`,`cud`.`responsible_curator` AS `OldResponsibleCurator`,NULL AS `NewResponsibleCurator`,`cud`.`unit_name` AS `OldUnitName`,NULL AS `NewUnitName`,`cud`.`curatorial_unit_type` AS `OldCuratorialUnitType`,NULL AS `NewCuratorialUnitType`,`cud`.`taxon_ls` AS `OldLSTaxonName`,NULL AS `NewLSTaxonName`,`cud`.`taxon_palaeo` AS `OldESTaxonName`,NULL AS `NewESTaxonName`,`cud`.`informal_taxon` AS `OldInformalTaxon`,NULL AS `NewInformalTaxon`,`cud`.`room_code` AS `OldStorageRoom`,NULL AS `NewStorageRoom`,`cud`.`geographic_origin_name` AS `OldGeographicOrigin`,NULL AS `NewGeographicOrigin`,`cud`.`type_collection_flag` AS `OldTypeCollection`,NULL AS `NewTypeCollection`,`cud`.`container_name` AS `OldContainerName`,NULL AS `NewContainerName`,`cud`.`geological_time_period_from` AS `OldGeologicalTimePeriodFrom`,NULL AS `NewGeologicalTimePeriodFrom`,`cud`.`geological_time_period_to` AS `OldGeologicalTimePeriodTo`,NULL AS `NewGeologicalTimePeriodTo` from `vw_collection_units_denormalised` `cud` order by `cud`.`responsible_curator`,`cud`.`collection_unit_id`;

-- Dumping structure for view jtd_live.vw_weighted_average_review
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_weighted_average_review`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_weighted_average_review` AS select `vcrc`.`collection_unit_id` AS `collection_unit_id`,(select `c`.`criterion_code` from `criterion` `c` where (`c`.`criterion_id` = `vcrc`.`criterion_id`)) AS `criterion_code`,(select `c`.`criterion_name` from `criterion` `c` where (`c`.`criterion_id` = `vcrc`.`criterion_id`)) AS `criterion_name`,(select concat(`p`.`first_name`,' ',`p`.`last_name`) from `person` `p` where (`p`.`person_id` = `vcrc`.`assessor_id`)) AS `assessor`,(cast(`fn_get_weighed_average`(`vcrc`.`rank_1_percentage`,`vcrc`.`rank_2_percentage`,`vcrc`.`rank_3_percentage`,`vcrc`.`rank_4_percentage`,`vcrc`.`rank_5_percentage`) as char charset utf8mb4) + 0) AS `weighted_average`,`fn_criterion_distribution`(`vcrc`.`rank_1_percentage`,`vcrc`.`rank_2_percentage`,`vcrc`.`rank_3_percentage`,`vcrc`.`rank_4_percentage`,`vcrc`.`rank_5_percentage`) AS `distribution` from `vw_criteria_rank_current` `vcrc`;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
