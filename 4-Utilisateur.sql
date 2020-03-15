------------------------------------------------------------
-- Droits utilisateurs
------------------------------------------------------------

CREATE USER 'util1'@'%' IDENTIFIED BY 'util1';
GRANT ALL PRIVILEGES ON papyrus.* TO 'util1'@'%';

CREATE USER 'util2'@'%' IDENTIFIED BY 'util2';
GRANT SELECT ON papyrus.* TO 'util2'@'%';

CREATE USER 'util3'@'%' IDENTIFIED BY 'util3';
GRANT SHOW VIEW ON papyrus.fournis TO 'util3';

