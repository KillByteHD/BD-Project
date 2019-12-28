-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema umclinic
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema umclinic
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `umclinic` DEFAULT CHARACTER SET utf8 ;
USE `umclinic` ;

-- -----------------------------------------------------
-- Table `umclinic`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umclinic`.`category` (
  `idCategory` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `umclinic`.`club`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umclinic`.`club` (
  `idClub` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idClub`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `umclinic`.`modality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umclinic`.`modality` (
  `idModality` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idModality`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `umclinic`.`zipcode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umclinic`.`zipcode` (
  `zipcode` VARCHAR(10) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`zipcode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `umclinic`.`athlete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umclinic`.`athlete` (
  `idAthlete` INT(11) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `birthdate` DATE NOT NULL,
  `weight` DECIMAL(4,1) NULL DEFAULT NULL,
  `idModality` INT(11) NOT NULL,
  `idCategory` INT(11) NOT NULL,
  `idClub` INT(11) NOT NULL,
  `idZipcode` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idAthlete`),
  INDEX `idModality_idx` (`idModality` ASC) VISIBLE,
  INDEX `idCategory_idx` (`idCategory` ASC) VISIBLE,
  INDEX `idClub_idx` (`idClub` ASC) VISIBLE,
  INDEX `idZipcode_idx` (`idZipcode` ASC) VISIBLE,
  CONSTRAINT `idCategory`
    FOREIGN KEY (`idCategory`)
    REFERENCES `umclinic`.`category` (`idCategory`),
  CONSTRAINT `idClub`
    FOREIGN KEY (`idClub`)
    REFERENCES `umclinic`.`club` (`idClub`),
  CONSTRAINT `idModality`
    FOREIGN KEY (`idModality`)
    REFERENCES `umclinic`.`modality` (`idModality`),
  CONSTRAINT `idZipcode`
    FOREIGN KEY (`idZipcode`)
    REFERENCES `umclinic`.`zipcode` (`zipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `umclinic`.`expertise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umclinic`.`expertise` (
  `idExpertise` INT(11) NOT NULL AUTO_INCREMENT,
  `designation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idExpertise`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `umclinic`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umclinic`.`doctor` (
  `idDoctor` INT(11) NOT NULL,
  `birthdate` DATE NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `cellphone` VARCHAR(12) NOT NULL,
  `idExpertise` INT(11) NOT NULL,
  `idZipcode` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idDoctor`),
  INDEX `idExpertise_idx` (`idExpertise` ASC) VISIBLE,
  INDEX `idZipcode_idx` (`idZipcode` ASC) VISIBLE,
  CONSTRAINT `idExpertise`
    FOREIGN KEY (`idExpertise`)
    REFERENCES `umclinic`.`expertise` (`idExpertise`),
    FOREIGN KEY (`idZipcode`)
    REFERENCES `umclinic`.`zipcode` (`zipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `umclinic`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umclinic`.`appointment` (
  `idDoctor` INT(11) NOT NULL,
  `idAthlete` INT(11) NOT NULL,
  `observations` TEXT NULL DEFAULT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `date` DATETIME NOT NULL,
  `finished` TINYINT(4) NOT NULL,
  PRIMARY KEY (`idDoctor`, `idAthlete`, `date`),
  INDEX `idAthlete_idx` (`idAthlete` ASC) VISIBLE,
  CONSTRAINT `idAthlete`
    FOREIGN KEY (`idAthlete`)
    REFERENCES `umclinic`.`athlete` (`idAthlete`),
  CONSTRAINT `idDoctor`
    FOREIGN KEY (`idDoctor`)
    REFERENCES `umclinic`.`doctor` (`idDoctor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
