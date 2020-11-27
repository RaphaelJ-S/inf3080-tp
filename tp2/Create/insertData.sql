SET ECHO ON;

--Insertion des données de la table Produit
INSERT
INTO Produit
VALUES(numReference.nextval,1002,'Brosse a dents','Bros', 1.25,TO_DATE('2020-02-03'),4, 15);

INSERT
INTO Produit
VALUES(numreference.nextval, 1002, 'Brosse a cheveux','Bros', 2.82,TO_DATE('1920-11-23'), 15, 5);

INSERT
INTO Produit
VALUES(numReference.nextval, 15, 'Pillules pour bobo', 'Pill', 12.02,TO_DATE('2004-08-11'), 23, 54);

INSERT
INTO Produit
VALUES(numReference.nextval, 1534, 'Coupe ongle', 'Coup', 0.95, TO_DATE('1987-12-25'), 2,12);

INSERT
INTO Produit
VALUES(numReference.nextval, 425, 'Couche pour adulte', 'Couc', 25.34, TO_DATE('2011-01-12'), 43, 123);

--Insertion des données de la table Adresse
INSERT
INTO Adresse
VALUES('H2S-3T1', 'CAN', 12345, 'Quebec', 'Random');

INSERT
INTO Adresse
VALUES('A5B-3T1', 'USA', 23456, 'Boston', 'Bay'); 

INSERT
INTO Adresse
VALUES('B1C-3T1', 'FR', 34567, 'Paris', 'Rochelle'); 

INSERT
INTO Adresse
VALUES('L8I-3T1', 'MEX', 45678, 'Aguella', 'Payo'); 

INSERT
INTO Adresse
VALUES('G6Z-3T1', 'CHN', 56789, 'Zhouqing', 'Wang'); 

--Insertion des données de la table Commande
INSERT
INTO Commande
VALUES(numCommande.nextval, TO_DATE('1912-04-01'), 'livrer');

INSERT
INTO Commande
VALUES(numCommande.nextval, TO_DATE('2001-09-30'), 'livrer');

INSERT
INTO Commande
VALUES(numCommande.nextval, TO_DATE('2020-10-12'), 'preparer');

INSERT
INTO Commande
VALUES(numCommande.nextval, TO_DATE('2020-01-01'), 'livrer');

INSERT
INTO Commande
VALUES(numCommande.nextval, TO_DATE('2019-12-25'), 'preparer');

--Insertion des données de la table CommandeProduit
INSERT
INTO CommandeProduit
VALUES(2,6,4);

INSERT
INTO CommandeProduit
VALUES(3,5,1);

INSERT
INTO CommandeProduit
VALUES(4,4,9);

INSERT
INTO CommandeProduit
VALUES(5,3,12);

INSERT
INTO CommandeProduit
VALUES(6,2,122);

--Insertion des données de la table Individu

INSERT
INTO Individu
VALUES(codeIndividu.nextval, '(514)-123-1234','Secret','H2S-3T1');

INSERT
INTO Individu
VALUES(codeIndividu.nextval, '(438)-098-8765','secret1', 'A5B-3T1');

INSERT
INTO Individu
VALUES(codeIndividu.nextval, '(450)-534-8745','secret2', 'B1C-3T1');

INSERT
INTO Individu
VALUES(codeIndividu.nextval, '(800)-164-8934','Secret3', 'H2S-3T1');

INSERT
INTO Individu
VALUES(codeIndividu.nextval, '(514)-435-1458','Secret4', 'G6Z-3T1');  
