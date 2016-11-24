-- MySQL Script generated by MySQL Workbench
-- Wed Nov 16 00:07:58 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema cinema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cinema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cinema` DEFAULT CHARACTER SET utf8 ;
USE `cinema` ;

-- -----------------------------------------------------
-- Table `cinema`.`CINE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`CINE` (
  `id_cine` INT NOT NULL AUTO_INCREMENT,
  `comuna` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cine`),
  UNIQUE INDEX `id_cine_UNIQUE` (`id_cine` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`SALA`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `cinema`.`SALA` (
  `n_sala` INT NOT NULL,
  `n_asientos` INT NULL DEFAULT 100,
  `CINE_id_cine` INT NOT NULL,
  PRIMARY KEY (`n_sala`, `CINE_id_cine`),
  UNIQUE INDEX `n_sala_UNIQUE` (`n_sala` ASC),
  INDEX `fk_SALA_CINE_idx` (`CINE_id_cine` ASC),
  CONSTRAINT `fk_SALA_CINE`
    FOREIGN KEY (`CINE_id_cine`)
    REFERENCES `cinema`.`CINE` (`id_cine`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`FUNCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`FUNCION` (
  `SALA_n_sala` INT NOT NULL,
  `PELICULA_id_pelicula` INT NOT NULL,
  `fecha-hora` DATETIME NOT NULL,
  `PROYECTADOR_EMPLEADO_id_empleado` INT NULL,
  PRIMARY KEY (`SALA_n_sala`, `PELICULA_id_pelicula`, `fecha-hora`),
  INDEX `fk_FUNCION_PELICULA1_idx` (`PELICULA_id_pelicula` ASC),
  INDEX `fk_FUNCION_PROYECTADOR1_idx` (`PROYECTADOR_EMPLEADO_id_empleado` ASC),
  CONSTRAINT `fk_FUNCION_SALA1`
    FOREIGN KEY (`SALA_n_sala`)
    REFERENCES `cinema`.`SALA` (`n_sala`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FUNCION_PELICULA1`
    FOREIGN KEY (`PELICULA_id_pelicula`)
    REFERENCES `cinema`.`PELICULA` (`id_pelicula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_FUNCION_PROYECTADOR1`
    FOREIGN KEY (`PROYECTADOR_EMPLEADO_id_empleado`)
    REFERENCES `cinema`.`PROYECTADOR` (`EMPLEADO_id_empleado`)
    ON DELETE SET NULL
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`USUARIO` (
  `user` VARCHAR(15) NOT NULL,
  `rut` VARCHAR(12) NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`user`),
  UNIQUE INDEX `user_UNIQUE` (`user` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`EMPLEADO` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `sueldo` INT NULL DEFAULT 300000,
  `CINE_id_cine` INT NOT NULL,
  `USUARIO_user` VARCHAR(15) NULL,
  INDEX `fk_EMPLEADO_CINE1_idx` (`CINE_id_cine` ASC),
  PRIMARY KEY (`id_empleado`),
  UNIQUE INDEX `id_empleado_UNIQUE` (`id_empleado` ASC),
  INDEX `fk_EMPLEADO_USUARIO1_idx` (`USUARIO_user` ASC),
  CONSTRAINT `fk_EMPLEADO_CINE1`
    FOREIGN KEY (`CINE_id_cine`)
    REFERENCES `cinema`.`CINE` (`id_cine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADO_USUARIO1`
    FOREIGN KEY (`USUARIO_user`)
    REFERENCES `cinema`.`USUARIO` (`user`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`CLIENTE` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `USUARIO_user` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `id_cliente_UNIQUE` (`id_cliente` ASC),
  INDEX `fk_CLIENTE_USUARIO1_idx` (`USUARIO_user` ASC),
  CONSTRAINT `fk_CLIENTE_USUARIO1`
    FOREIGN KEY (`USUARIO_user`)
    REFERENCES `cinema`.`USUARIO` (`user`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`PROYECTADOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`PROYECTADOR` (
  `EMPLEADO_id_empleado` INT NOT NULL,
  PRIMARY KEY (`EMPLEADO_id_empleado`),
  CONSTRAINT `fk_PROYECTADOR_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_id_empleado`)
    REFERENCES `cinema`.`EMPLEADO` (`id_empleado`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`VENDEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`VENDEDOR` (
  `EMPLEADO_id_empleado` INT NOT NULL,
  PRIMARY KEY (`EMPLEADO_id_empleado`),
  UNIQUE INDEX `EMPLEADO_id_empleado_UNIQUE` (`EMPLEADO_id_empleado` ASC),
  CONSTRAINT `fk_VENDEDOR_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_id_empleado`)
    REFERENCES `cinema`.`EMPLEADO` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`TRANSACCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`TRANSACCION` (
  `id_transaccion` INT NOT NULL AUTO_INCREMENT,
  `CLIENTE_id_cliente` INT NOT NULL,
  `VENDEDOR_EMPLEADO_id_empleado` INT NULL,
  PRIMARY KEY (`id_transaccion`),
  UNIQUE INDEX `id_transaccion_UNIQUE` (`id_transaccion` ASC),
  INDEX `fk_TRANSACCION_CLIENTE1_idx` (`CLIENTE_id_cliente` ASC),
  INDEX `fk_TRANSACCION_VENDEDOR1_idx` (`VENDEDOR_EMPLEADO_id_empleado` ASC),
  CONSTRAINT `fk_TRANSACCION_CLIENTE1`
    FOREIGN KEY (`CLIENTE_id_cliente`)
    REFERENCES `cinema`.`CLIENTE` (`id_cliente`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TRANSACCION_VENDEDOR1`
    FOREIGN KEY (`VENDEDOR_EMPLEADO_id_empleado`)
    REFERENCES `cinema`.`VENDEDOR` (`EMPLEADO_id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`PELICULA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`PELICULA` (
  `id_pelicula` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(15) NULL,
  `clasificacion` VARCHAR(5) NULL DEFAULT 'TE',
  `precio` INT NULL DEFAULT 5000,
  PRIMARY KEY (`id_pelicula`),
  UNIQUE INDEX `id_pelicula_UNIQUE` (`id_pelicula` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`TICKET`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`TICKET` (
  `n_ticket` INT NOT NULL AUTO_INCREMENT,
  `asiento` VARCHAR(5) NULL,
  `FUNCION_SALA_n_sala` INT NOT NULL,
  `FUNCION_PELICULA_id_pelicula` INT NOT NULL,
  `FUNCION_fecha-hora` DATETIME NOT NULL,
  `TRANSACCION_id_transaccion` INT NOT NULL,
  PRIMARY KEY (`n_ticket`),
  UNIQUE INDEX `n_ticket_UNIQUE` (`n_ticket` ASC),
  INDEX `fk_TICKET_FUNCION1_idx` (`FUNCION_SALA_n_sala` ASC, `FUNCION_PELICULA_id_pelicula` ASC, `FUNCION_fecha-hora` ASC),
  INDEX `fk_TICKET_TRANSACCION1_idx` (`TRANSACCION_id_transaccion` ASC),
  CONSTRAINT `fk_TICKET_FUNCION1`
    FOREIGN KEY (`FUNCION_SALA_n_sala` , `FUNCION_PELICULA_id_pelicula` , `FUNCION_fecha-hora`)
    REFERENCES `cinema`.`FUNCION` (`SALA_n_sala` , `PELICULA_id_pelicula` , `fecha-hora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TICKET_TRANSACCION1`
    FOREIGN KEY (`TRANSACCION_id_transaccion`)
    REFERENCES `cinema`.`TRANSACCION` (`id_transaccion`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`COMENTARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`COMENTARIO` (
  `USUARIO_user` VARCHAR(15) NOT NULL,
  `PELICULA_id_pelicula` INT NOT NULL,
  `texto` VARCHAR(500) NULL,
  PRIMARY KEY (`USUARIO_user`, `PELICULA_id_pelicula`),
  INDEX `fk_COMENTARIO_PELICULA1_idx` (`PELICULA_id_pelicula` ASC),
  CONSTRAINT `fk_COMENTARIO_USUARIO1`
    FOREIGN KEY (`USUARIO_user`)
    REFERENCES `cinema`.`USUARIO` (`user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_COMENTARIO_PELICULA1`
    FOREIGN KEY (`PELICULA_id_pelicula`)
    REFERENCES `cinema`.`PELICULA` (`id_pelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`DIRECTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`DIRECTOR` (
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nombre`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`ACTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`ACTOR` (
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nombre`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`DIRIGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`DIRIGE` (
  `PELICULA_id_pelicula` INT NOT NULL,
  `DIRECTOR_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PELICULA_id_pelicula`, `DIRECTOR_nombre`),
  INDEX `fk_DIRIGE_PELICULA1_idx` (`PELICULA_id_pelicula` ASC),
  INDEX `fk_DIRIGE_DIRECTOR1_idx` (`DIRECTOR_nombre` ASC),
  CONSTRAINT `fk_DIRIGE_PELICULA1`
    FOREIGN KEY (`PELICULA_id_pelicula`)
    REFERENCES `cinema`.`PELICULA` (`id_pelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIRIGE_DIRECTOR1`
    FOREIGN KEY (`DIRECTOR_nombre`)
    REFERENCES `cinema`.`DIRECTOR` (`nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`ACTUA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`ACTUA` (
  `PELICULA_id_pelicula` INT NOT NULL,
  `ACTOR_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PELICULA_id_pelicula`, `ACTOR_nombre`),
  INDEX `fk_ACTUA_PELICULA1_idx` (`PELICULA_id_pelicula` ASC),
  INDEX `fk_ACTUA_ACTOR1_idx` (`ACTOR_nombre` ASC),
  CONSTRAINT `fk_ACTUA_PELICULA1`
    FOREIGN KEY (`PELICULA_id_pelicula`)
    REFERENCES `cinema`.`PELICULA` (`id_pelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACTUA_ACTOR1`
    FOREIGN KEY (`ACTOR_nombre`)
    REFERENCES `cinema`.`ACTOR` (`nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
