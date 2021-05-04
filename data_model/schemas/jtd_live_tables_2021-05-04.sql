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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
