DROP DATABASE IF EXISTS papyrus;
CREATE DATABASE papyrus;
USE papyrus;


------------------------------------------------------------
-- Table: Produit
------------------------------------------------------------
CREATE TABLE produit (
	CODART CHAR(4) NOT NULL,
	LIBART VARCHAR(30) NOT NULL,
	STKALE INT NOT NULL,
	STKPHY INT NOT NULL,
	QTEANN INT NOT NULL,
	UNIMES CHAR(5) NOT NULL,
	PRIMARY KEY (CODART)
)ENGINE=InnoDB;


------------------------------------------------------------
-- Table: Fournis
------------------------------------------------------------
CREATE TABLE fournis (
    NUMFOU INT,
    NOMFOU VARCHAR(25) NOT NULL,
    RUEFOU VARCHAR(50) NOT NULL,
    POSFOU CHAR(5) NOT NULL,
    VILFOU VARCHAR(30) NOT NULL,
    CONFOU VARCHAR(15) NOT NULL,
    SATISF TINYINT(3) CHECK (SATISF BETWEEN 1 AND 10),
    PRIMARY KEY (NUMFOU)
)ENGINE=InnoDB;


------------------------------------------------------------
-- Table: Entcom
------------------------------------------------------------
CREATE TABLE entcom (
	NUMCOM INT NOT NULL,
	OBSCOM VARCHAR(50),
	DATCOM TIMESTAMP DEFAULT NOW(),
	NUMFOU  INT,
        CONSTRAINT entcom_PK PRIMARY KEY(NUMCOM),
        CONSTRAINT entcom_fournis_SK FOREIGN KEY(NUMFOU) REFERENCES fournis(NUMFOU)
)ENGINE=InnoDB;


------------------------------------------------------------
-- Table: Ligcom
------------------------------------------------------------
CREATE TABLE ligcom (
	NUMLIG	TINYINT(3) NOT NULL, 
	QTECDE	INT(10) NOT NULL, 
	PRIUNI	DECIMAL(9,2) NOT NULL, 
	QTELIV	INT(10), 
	DERLIV	DATE NOT NULL, 
	NUMCOM	INT NOT NULL, 
	CODART	CHAR(4) NOT NULL, 
	PRIMARY KEY (NUMLIG, NUMCOM),
        CONSTRAINT ligcom_produit_SK FOREIGN KEY(CODART) REFERENCES produit(CODART),
        CONSTRAINT ligcom_entcom_SK FOREIGN KEY(NUMCOM) REFERENCES entcom(NUMCOM)
)ENGINE=InnoDB;


------------------------------------------------------------
-- Table: Vente
------------------------------------------------------------
CREATE TABLE vente (
	NUMFOU 	INT NOT NULL,
	CODART	CHAR(4)	NOT NULL,
	DELLIV	INT	NOT NULL, 
	QTE1 INT NOT NULL, 
	PRIX1 DECIMAL(9,2) NOT NULL, 
	QTE2 INT, 
	PRIX2 DECIMAL(9,2), 
	QTE3 INT, 
	PRIX3 DECIMAL(9,2),
	PRIMARY KEY (NUMFOU, CODART), 
	FOREIGN KEY (NUMFOU) REFERENCES fournis(NUMFOU), 
	FOREIGN KEY (CODART) REFERENCES produit(CODART)
)ENGINE=InnoDB;


------------------------------------------------------------
-- Index: Encom (NUMFOU)
------------------------------------------------------------
CREATE INDEX `index` ON `entcom` (`NUMFOU`);