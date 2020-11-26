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
 
