-- MySQL Script generated by MySQL Workbench
-- Wed 13 Apr 2016 03:39:39 AM EEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema bidit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bidit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bidit` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(150) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `Lastname` VARCHAR(45) NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(45) NOT NULL,
  `AFM` VARCHAR(45) NOT NULL,
  `HomeAddress` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `SignUpDate` DATE NOT NULL,
  `IsAdmin` TINYINT(1) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC),
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC),
  UNIQUE INDEX `AFM_UNIQUE` (`AFM` ASC),
  UNIQUE INDEX `e-mail_UNIQUE` (`e-mail` ASC))
ENGINE = InnoDB;

USE `bidit` ;

-- -----------------------------------------------------
-- Table `bidit`.`registered_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`registered_user` (
  `regId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(30) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  `phoneNumber` VARCHAR(20) NOT NULL,
  `afm` VARCHAR(20) NOT NULL,
  `signUpDate` DATETIME NOT NULL,
  `isAdmin` TINYINT(1) NOT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `latitude` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`regId`),
  UNIQUE INDEX `regId` (`regId` ASC),
  UNIQUE INDEX `username` (`username` ASC),
  UNIQUE INDEX `email` (`email` ASC),
  UNIQUE INDEX `username_2` (`username` ASC),
  UNIQUE INDEX `email_2` (`email` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 7622
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bidit`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`item` (
  `itemID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `buyPrice` DOUBLE NOT NULL,
  `firstBid` DOUBLE NOT NULL,
  `location` VARCHAR(200) NOT NULL,
  `country` VARCHAR(200) NOT NULL,
  `latitude` DOUBLE NULL DEFAULT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `started` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ends` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sellerId` BIGINT(20) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`itemID`),
  UNIQUE INDEX `itemID` (`itemID` ASC),
  UNIQUE INDEX `name` (`name` ASC),
  UNIQUE INDEX `itemID_2` (`itemID` ASC),
  INDEX `sellerId` (`sellerId` ASC),
  CONSTRAINT `item_ibfk_1`
    FOREIGN KEY (`sellerId`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 23164
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bidit`.`bid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`bid` (
  `bidderId` BIGINT(20) NOT NULL,
  `itemId` BIGINT(20) NOT NULL,
  `bidTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `amount` DOUBLE NOT NULL,
  PRIMARY KEY (`bidderId`, `itemId`, `bidTime`),
  INDEX `itemId` (`itemId` ASC),
  CONSTRAINT `bid_ibfk_1`
    FOREIGN KEY (`bidderId`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `bid_ibfk_2`
    FOREIGN KEY (`itemId`)
    REFERENCES `bidit`.`item` (`itemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bidit`.`bidder_rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`bidder_rating` (
  `bidderId` BIGINT(20) NOT NULL,
  `rater` BIGINT(20) NOT NULL,
  `rating` INT(11) NOT NULL,
  PRIMARY KEY (`bidderId`, `rater`),
  INDEX `rater` (`rater` ASC),
  CONSTRAINT `bidder_rating_ibfk_1`
    FOREIGN KEY (`bidderId`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `bidder_rating_ibfk_2`
    FOREIGN KEY (`rater`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bidit`.`final_transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`final_transaction` (
  `transactionId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `sellerId` BIGINT(20) NOT NULL,
  `buyerId` BIGINT(20) NOT NULL,
  `itemName` VARCHAR(200) NOT NULL,
  `finalPrice` DOUBLE NOT NULL,
  PRIMARY KEY (`transactionId`),
  UNIQUE INDEX `transactionId` (`transactionId` ASC),
  INDEX `sellerId` (`sellerId` ASC),
  INDEX `buyerId` (`buyerId` ASC),
  CONSTRAINT `final_transaction_ibfk_1`
    FOREIGN KEY (`sellerId`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `final_transaction_ibfk_2`
    FOREIGN KEY (`buyerId`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bidit`.`buyer_inbox`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`buyer_inbox` (
  `conversationId` BIGINT(20) NOT NULL,
  `messageId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(1000) NOT NULL,
  `sentTime` TIMESTAMP NOT NULL,
  `isRead` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`messageId`),
  INDEX `conversationId` (`conversationId` ASC),
  CONSTRAINT `buyer_inbox_ibfk_1`
    FOREIGN KEY (`conversationId`)
    REFERENCES `bidit`.`final_transaction` (`transactionId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bidit`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`category` (
  `CategoryId` INT(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`CategoryId`),
  UNIQUE INDEX `CategoryName` (`CategoryName` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 39
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bidit`.`item_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`item_category` (
  `itemId` BIGINT(20) NOT NULL,
  `categoryId` INT(11) NOT NULL,
  PRIMARY KEY (`itemId`, `categoryId`),
  INDEX `categoryId` (`categoryId` ASC),
  CONSTRAINT `item_category_ibfk_1`
    FOREIGN KEY (`itemId`)
    REFERENCES `bidit`.`item` (`itemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `item_category_ibfk_2`
    FOREIGN KEY (`categoryId`)
    REFERENCES `bidit`.`category` (`CategoryId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bidit`.`item_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`item_images` (
  `itemID` BIGINT(20) NOT NULL,
  `imgName` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`itemID`, `imgName`),
  CONSTRAINT `item_images_ibfk_1`
    FOREIGN KEY (`itemID`)
    REFERENCES `bidit`.`item` (`itemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bidit`.`notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`notification` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `regId` BIGINT(20) NOT NULL,
  `message` VARCHAR(500) NOT NULL,
  `transactionId` BIGINT(20) NULL DEFAULT NULL,
  `isRead` TINYINT(4) NULL DEFAULT '0',
  `sold` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `transactionId` (`transactionId` ASC),
  INDEX `regId` (`regId` ASC),
  CONSTRAINT `notification_ibfk_1`
    FOREIGN KEY (`transactionId`)
    REFERENCES `bidit`.`final_transaction` (`transactionId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `notification_ibfk_2`
    FOREIGN KEY (`regId`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bidit`.`recommendation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`recommendation` (
  `regId` BIGINT(20) NOT NULL,
  `itemId` BIGINT(20) NOT NULL,
  PRIMARY KEY (`regId`, `itemId`),
  INDEX `itemId` (`itemId` ASC),
  CONSTRAINT `recommendation_ibfk_1`
    FOREIGN KEY (`regId`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `recommendation_ibfk_2`
    FOREIGN KEY (`itemId`)
    REFERENCES `bidit`.`item` (`itemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bidit`.`seller_inbox`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`seller_inbox` (
  `conversationId` BIGINT(20) NOT NULL,
  `messageId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(1000) NOT NULL,
  `sentTime` TIMESTAMP NOT NULL,
  PRIMARY KEY (`messageId`),
  INDEX `conversationId` (`conversationId` ASC),
  CONSTRAINT `seller_inbox_ibfk_1`
    FOREIGN KEY (`conversationId`)
    REFERENCES `bidit`.`final_transaction` (`transactionId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bidit`.`seller_rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`seller_rating` (
  `sellerId` BIGINT(20) NOT NULL,
  `rater` BIGINT(20) NOT NULL,
  `rating` INT(11) NOT NULL,
  PRIMARY KEY (`sellerId`, `rater`),
  INDEX `rater` (`rater` ASC),
  CONSTRAINT `seller_rating_ibfk_1`
    FOREIGN KEY (`sellerId`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `seller_rating_ibfk_2`
    FOREIGN KEY (`rater`)
    REFERENCES `bidit`.`registered_user` (`regId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bidit`.`unverified_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bidit`.`unverified_user` (
  `regId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(30) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `country` VARCHAR(100) NOT NULL,
  `phoneNumber` VARCHAR(20) NOT NULL,
  `afm` VARCHAR(20) NOT NULL,
  `signUpDate` DATETIME NOT NULL,
  `isAdmin` TINYINT(1) NOT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `latitude` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`regId`),
  UNIQUE INDEX `regId` (`regId` ASC),
  UNIQUE INDEX `username` (`username` ASC),
  UNIQUE INDEX `email` (`email` ASC),
  UNIQUE INDEX `username_2` (`username` ASC),
  UNIQUE INDEX `email_2` (`email` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;