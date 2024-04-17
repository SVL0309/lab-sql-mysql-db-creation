-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`salespersons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`salespersons` (
  `salesperson` INT NOT NULL AUTO_INCREMENT,
  `staff ID` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `store` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `staff ID_UNIQUE` (`staff ID` ASC) VISIBLE,
  PRIMARY KEY (`salesperson`),
  UNIQUE INDEX `salesperson_UNIQUE` (`salesperson` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `customer ID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NULL,
  `state/province` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zip/postal code` INT NULL,
  `salespersons_salesperson` INT NOT NULL,
  PRIMARY KEY (`customer ID`, `salespersons_salesperson`),
  UNIQUE INDEX `customer ID_UNIQUE` (`customer ID` ASC) VISIBLE,
  UNIQUE INDEX `phone number_UNIQUE` (`phone number` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_customers_salespersons1_idx` (`salespersons_salesperson` ASC) VISIBLE,
  CONSTRAINT `fk_customers_salespersons1`
    FOREIGN KEY (`salespersons_salesperson`)
    REFERENCES `mydb`.`salespersons` (`salesperson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cars` (
  `car` INT NOT NULL AUTO_INCREMENT,
  `VIN` INT NOT NULL,
  `manufacturer` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `year` DATE NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `customers_customer ID` INT NOT NULL,
  `salespersons_salesperson` INT NOT NULL,
  UNIQUE INDEX `VIN_UNIQUE` (`VIN` ASC) VISIBLE,
  PRIMARY KEY (`car`),
  UNIQUE INDEX `car_UNIQUE` (`car` ASC) VISIBLE,
  INDEX `fk_cars_customers_idx` (`customers_customer ID` ASC) VISIBLE,
  INDEX `fk_cars_salespersons1_idx` (`salespersons_salesperson` ASC) VISIBLE,
  CONSTRAINT `fk_cars_customers`
    FOREIGN KEY (`customers_customer ID`)
    REFERENCES `mydb`.`customers` (`customer ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cars_salespersons1`
    FOREIGN KEY (`salespersons_salesperson`)
    REFERENCES `mydb`.`salespersons` (`salesperson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.` invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.` invoices` (
  `invoice number` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `car` VARCHAR(45) NOT NULL,
  `customer` VARCHAR(45) NOT NULL,
  `salesperson` VARCHAR(45) NOT NULL,
  `salespersons_salesperson` INT NOT NULL,
  `customers_customer ID` INT NOT NULL,
  `customers_salespersons_salesperson` INT NOT NULL,
  PRIMARY KEY (`invoice number`, `salespersons_salesperson`),
  UNIQUE INDEX `invoice number_UNIQUE` (`invoice number` ASC) VISIBLE,
  INDEX `fk_ invoices_salespersons1_idx` (`salespersons_salesperson` ASC) VISIBLE,
  INDEX `fk_ invoices_customers1_idx` (`customers_customer ID` ASC, `customers_salespersons_salesperson` ASC) VISIBLE,
  CONSTRAINT `fk_ invoices_salespersons1`
    FOREIGN KEY (`salespersons_salesperson`)
    REFERENCES `mydb`.`salespersons` (`salesperson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ invoices_customers1`
    FOREIGN KEY (`customers_customer ID` , `customers_salespersons_salesperson`)
    REFERENCES `mydb`.`customers` (`customer ID` , `salespersons_salesperson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;