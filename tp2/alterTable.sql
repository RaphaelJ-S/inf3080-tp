ALTER TABLE Produit
ADD CONSTRAINT stock_Positif CHECK (stock >= 0);

ALTER TABLE Produit
ADD CONSTRAINT seuilMinimum_Positif CHECK (seuilMinimum >=0);

ALTER TABLE CarteCredit
ADD CONSTRAINT typeCarte_Valide CHECK 
(typeCarte IN ('VISA', 'Master Card', 'American Express'));

ALTER TABLE CommandeProduit
ADD CONSTRAINT nbrItems_Valide CHECK (nbrItems >=0 AND nbrItems <=(SELECT Produit.stock FROM Produit WHERE Produit.numReference = commandeProduit.numReference));

ALTER TABLE Fournisseur
ADD CONSTRAINT typeFourn_Valide CHECK
(typeFourn IN ('Transformateur', 'Importateur', 'Livreur'));
