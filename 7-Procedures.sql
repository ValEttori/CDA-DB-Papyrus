USE `papyrus`;

-- 1. Fournisseurs ayant pass� une commande 
DROP PROCEDURE IF EXISTS Lst_fournis;
DELIMITER |

CREATE PROCEDURE Lst_fournis()
BEGIN
    SELECT DISTINCT numfou AS Fournisseurs
    FROM entcom;
END |

DELIMITER ;

CALL Lst_fournis;
SHOW CREATE PROCEDURE Lst_fournis;


-- 2. Liste des commandes avec observation 
DROP PROCEDURE IF EXISTS Lst_Commandes;
DELIMITER |
CREATE PROCEDURE Lst_Commandes(In Observations VARCHAR(50))
BEGIN
    SELECT `entcom`.`numcom` AS Commande,
    `fournis`.`nomfou` AS Fournisseur,
    `produit`.`libart` AS Article,
    `ligcom`.`priuni` * `ligcom`.`qtecde` AS Prix
    FROM entcom
    JOIN fournis ON entcom.`numfou` = `fournis`.`numfou`
    JOIN `ligcom` ON `ligcom`.`numcom`= entcom.`numcom`
    JOIN produit ON `produit`.`codart` = ligcom.`codart`
    WHERE entcom.`obscom` = Observations;
END |

DELIMITER ;

CALL Lst_Commandes('Commande urgente');


-- 3. Chiffre d'affaire par fournisseur et par ann�e 
DROP PROCEDURE IF EXISTS CA_Fournisseur;
DELIMITER |
CREATE PROCEDURE CA_Fournisseur(
		IN FournisNom VARCHAR(25),
          IN DateCommande VARCHAR(5))
BEGIN
    SELECT fournis.`nomfou` AS Fournisseurs,
    sum(ligcom.`qteliv` * ligcom.`priuni`) * 1.2 AS CA
    FROM fournis
    JOIN vente ON vente.`numfou` = fournis.`numfou`
    JOIN ligcom ON ligcom.`codart` = vente.`codart`
    JOIN entcom ON entcom.`numcom` = ligcom.`numcom`
    WHERE fournis.`nomfou` = FournisNom
    AND substring(cast(entcom.`datcom` AS DATE), 1, 4) = DateCommande
    GROUP BY nomfou;
END |

DELIMITER ;

CALL CA_Fournisseur('GROBRIGAN', '2018');