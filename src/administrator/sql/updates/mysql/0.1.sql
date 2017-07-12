-- member
--
-- Table representing a user that has at least started becoming an SWA member
-- The user may not actually be a member yet as they may not have paid (see paid col)
CREATE TABLE IF NOT EXISTS `#__swa_member` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT(11)  NOT NULL ,
  `paid` TINYINT(1)  NOT NULL DEFAULT 0,
  `sex` VARCHAR(255)  NOT NULL DEFAULT 'None' ,
  `dob` DATE NOT NULL DEFAULT '0000-00-00',
  `university_id` INT(11)  NOT NULL ,
  `course` VARCHAR(100)  NOT NULL ,
  `graduation` INT(11)  NOT NULL ,
  `discipline` VARCHAR(50)  NOT NULL ,
  `level` VARCHAR(20)  NOT NULL DEFAULT 'Beginner',
  `shirt` VARCHAR(3)  NOT NULL ,
  `econtact` VARCHAR(255)  NOT NULL ,
  `enumber` VARCHAR(255)  NOT NULL ,
  `dietary` VARCHAR(10),
  `tel` VARCHAR(15) NOT NULL ,
  `swahelp` VARCHAR(50)  NOT NULL DEFAULT 'None',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  INDEX `fk_member_user_idx` (`user_id` ASC),
  INDEX `fk_member_university_idx` (`university_id` ASC)
)
DEFAULT COLLATE=utf8_general_ci;

-- committee
--
-- Table holding members that are on the SWA / org committee
CREATE  TABLE IF NOT EXISTS `#__swa_committee` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `member_id` INT(11)  NOT NULL ,
  `position` VARCHAR(50)  NOT NULL ,
  `blurb` VARCHAR(2000)  NOT NULL ,
  `image` VARCHAR(100)  NOT NULL ,
  PRIMARY KEY (`id`),
  INDEX `fk_committee_member_idx` (`member_id` ASC)
)
DEFAULT COLLATE=utf8_general_ci;

-- qualification
--
-- Table holding qualifications that members hold
CREATE  TABLE IF NOT EXISTS `#__swa_qualification` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `member_id` INT(11)  NOT NULL ,
  `type` VARCHAR(50)  NOT NULL ,
  `expiry_date` DATE NOT NULL ,
  `file` MEDIUMBLOB NOT NULL ,
  `file_type` VARCHAR(50) NOT NULL ,
  `approved` TINYINT(1) ,
  PRIMARY KEY (`id`),
  INDEX `fk_qualification_member_idx` (`member_id` ASC)
)
DEFAULT COLLATE=utf8_general_ci;

-- university
--
-- Table holding universities that members can be a part of
CREATE  TABLE IF NOT EXISTS `#__swa_university` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(200) NOT NULL ,
  `url` VARCHAR(200) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
DEFAULT COLLATE=utf8_general_ci;

-- university member
--
-- Table holding confirmed univiersity members
-- Note the committee files for makring members are university committee members
CREATE  TABLE IF NOT EXISTS `#__swa_university_member` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `member_id` INT(11)  NOT NULL ,
  `university_id` INT(11)  NOT NULL ,
  `committee` VARCHAR(15) DEFAULT NULL,
  `graduated` TINYINT(1)  NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_university_member_member_idx` (`member_id` ASC),
  INDEX `fk_university_member_university_idx` (`member_id` ASC),
  CONSTRAINT unique_member_id_university_id UNIQUE(member_id, university_id)
)
DEFAULT COLLATE=utf8_general_ci;

-- season
--
-- Table holding seasons
CREATE  TABLE IF NOT EXISTS `#__swa_season` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `year` VARCHAR(4) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `year_UNIQUE` (`year` ASC)
)
DEFAULT COLLATE=utf8_general_ci;

-- deposit
--
-- Table holding deposits info
-- This is basically a copy from the old site
CREATE  TABLE IF NOT EXISTS `#__swa_deposit` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `event_id` INT NOT NULL ,
  `university_id` INT NOT NULL ,
  `date` DATE NOT NULL ,
  `amount` DECIMAL(6,2) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_deposit_university_idx` (`university_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- event
--
-- Table holding event information
CREATE  TABLE IF NOT EXISTS `#__swa_event` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(100) NOT NULL ,
  `season_id` INT NOT NULL ,
  `capacity` INT NOT NULL ,
  `date_open` DATE NOT NULL ,
  `date_close` DATE NOT NULL ,
  `date` DATE NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_event_season1_idx` (`season_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- event host
--
-- Table holding event hosts
-- Note: An event can exist with no hosts
CREATE  TABLE IF NOT EXISTS `#__swa_event_host` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `event_id` INT NOT NULL ,
  `university_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_event_host_event1_idx` (`event_id` ASC) ,
  INDEX `fk_event_host_university1_idx` (`university_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- event ticket
--
-- Table holding event ticket information.
-- These are types of ticket that can be purchased for an event rather than individual tickets.
-- The need_* fields are ugly and we may want to think og a nicer solution here
CREATE  TABLE IF NOT EXISTS `#__swa_event_ticket` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `event_id` INT NOT NULL ,
  `name` VARCHAR(100) NOT NULL ,
  `quantity` INT NOT NULL ,
  `price` DECIMAL(6,2) NOT NULL ,
  `notes` TEXT DEFAULT NULL ,
  `need_level` VARCHAR(20) DEFAULT NULL ,
  `need_swa` TINYINT(1)  NOT NULL DEFAULT 0 ,
  `need_xswa` TINYINT(1)  NOT NULL DEFAULT 0 ,
  `need_host` TINYINT(1)  NOT NULL DEFAULT 0 ,
  `need_qualification` TINYINT(1)  NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_event_ticket_event1_idx` (`event_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- grant
--
-- Table holding grant info
-- This is basically a copy from the old site
CREATE  TABLE IF NOT EXISTS `#__swa_grant` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `event_id` VARCHAR(45) NOT NULL ,
  `application_date` DATE NOT NULL ,
  `amount` DECIMAL(6,2) NOT NULL ,
  `fund_use` VARCHAR(255) NOT NULL ,
  `instructions` VARCHAR(255) NOT NULL ,
  `ac_sortcode` VARCHAR(8) NULL ,
  `ac_number` VARCHAR(8) NULL ,
  `ac_name` VARCHAR(200) NULL ,
  `finances_date` DATE NULL ,
  `finances_id` INT NULL ,
  `auth_date` DATE NULL ,
  `auth_id` INT NULL ,
  `payment_date` DATE NULL ,
  `payment_id` INT NULL ,
  `created_by` INT(11)  NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_grants_createdby1_idx` (`created_by` ASC) ,
  INDEX `fk_grants_event1_idx` (`event_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- ticket
--
-- Table holding event ticket information.
-- Each record here represents an individual ticket
CREATE  TABLE IF NOT EXISTS `#__swa_ticket` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `member_id` INT NOT NULL ,
  `event_ticket_id` INT NOT NULL ,
  `paid` DECIMAL(6,2) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_ticket_event_ticket1_idx` (`event_ticket_id` ASC) ,
  INDEX `fk_ticket_member1_idx` (`member_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- event registration
--
-- Table holding event registration information
-- This table exists to maintain the concept of event registration from the old site
-- University members should be registered for an event in order to buy a ticket...
CREATE  TABLE IF NOT EXISTS `#__swa_event_registration` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `event_id` INT NOT NULL ,
  `member_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_event_registration_event1_idx` (`event_id` ASC) ,
  INDEX `fk_event_registration_member1_idx` (`member_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- competition type
--
-- Table holding types of competitions that can be held at events
CREATE  TABLE IF NOT EXISTS `#__swa_competition_type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `series` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`id`) )
DEFAULT COLLATE=utf8_general_ci;

-- competition
--
-- Table holding competitions that have been / are going to be held at events
CREATE  TABLE IF NOT EXISTS `#__swa_competition` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `event_id` INT NOT NULL ,
  `competition_type_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_competition_event1_idx` (`event_id` ASC) ,
  INDEX `fk_competition_competition_type1_idx` (`competition_type_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- indi result
--
-- Individual member results in competitions
CREATE  TABLE IF NOT EXISTS `#__swa_indi_result` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `member_id` INT NOT NULL ,
  `competition_id` INT NOT NULL ,
  `result` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_indi_result_competition1_idx` (`competition_id` ASC) ,
  INDEX `fk_indi_result_member1_idx` (`member_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- team result
--
-- University team results in competitions
CREATE  TABLE IF NOT EXISTS `#__swa_team_result` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `competition_id` INT NOT NULL ,
  `university_id` INT NOT NULL ,
  `team_number` INT NOT NULL DEFAULT 1 ,
  `result` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_team_result_competition1_idx` (`competition_id` ASC) ,
  INDEX `fk_team_result_university1_idx` (`university_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- damages
--
-- Table holding damages info
-- This is basically a copy from the old site
CREATE  TABLE IF NOT EXISTS `#__swa_damages` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `event_id` INT NOT NULL ,
  `university_id` INT ,
  `date` DATE NOT NULL ,
  `cost` DECIMAL(6,2) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_damages_event1_idx` (`event_id` ASC) ,
  INDEX `fk_damages_university1_idx` (`university_id` ASC) )
DEFAULT COLLATE=utf8_general_ci;

-- viewlevels
--
-- Add 2 view level if they do not already exist
-- These are used to control the availability of menus for Org / Club committee members
INSERT INTO `#__viewlevels` (title, ordering, rules)
SELECT 'Club Committee', 0, '[]'
FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM `#__viewlevels`
                    WHERE title = 'Club Committee');

INSERT INTO `#__viewlevels` (title, ordering, rules)
SELECT 'Org Committee', 0, '[]'
FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM `#__viewlevels`
                    WHERE title = 'Org Committee');
