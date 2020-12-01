set echo on;


CREATE OR REPLACE TRIGGER actualiserStock
BEFORE INSERT ON CommandeProduit 
FOR EACH ROW
DECLARE
  qqt INTEGER;
BEGIN
  SELECT stock
  INTO qqt
  FROM Produit
  WHERE numReference = :NEW.numreference;
IF :new.nbritems > qqt then
  raise_application_error(-20100, 'ERREUR DANS LE NBR');
else 
  UPDATE Produit SET stock = (stock - :new.nbritems) WHERE numReference = :new.numreference;
end if;
END;
/


CREATE OR REPLACE TRIGGER validerStock
BEFORE INSERT ON CommandeLivraison 
FOR EACH ROW
DECLARE
  qqt INTEGER;
BEGIN
  SELECT stock
  INTO qqt
  FROM Produit
  WHERE numReference = :NEW.numreference;
IF :new.nbritems > qqt then
    raise_application_error(-20101, 'ERREUR DANS LE NBR');
end if;
END;
/

CREATE OR REPLACE TRIGGER validerLivraison 
BEFORE INSERT ON CommandeLivraison 
FOR EACH ROW
DECLARE
  qqt INTEGER;
BEGIN
  SELECT nbritems 
  INTO qqt
  FROM CommandeProduit
  WHERE numReference = :NEW.numreference AND numCommande = :NEW.numCommande;
IF :new.nbritems > qqt then
    raise_application_error(-20102, 'ERREUR DANS LE NBR');
end if;
END;
/


CREATE OR REPLACE TRIGGER validerPaiement
BEFORE INSERT ON Paiement 
FOR EACH ROW
DECLARE
  qqt INTEGER;
BEGIN
  SELECT prixTotal 
  INTO montantFacture 
  FROM Facture 
  WHERE numLivraison = :NEW.numLivraison;
IF :NEW.montant > montantFacture then
    raise_application_error(-20103, 'ERREUR DANS LE NBR');
end if;
END;
/

