set echo on;

CREATE OR REPLACE TRIGGER Valider_Stock_Produit
BEFORE INSERT ON Livraisons 
FOR EACH ROW

DECLARE
	qqt INTEGER := 0;

BEGIN
	
	SELECT stock
	INTO qqt
	FROM Produit
 	WHERE numReference = :NEW.numreference;

	IF :NEW.nbritems > qqt THEN 
		raise_application_error(-20101, 'Nombre commande superieur au stock existant.');
	END IF;
END;
/

CREATE OR REPLACE TRIGGER Actualiser_Stock_Produit
AFTER INSERT ON Livraisons 
FOR EACH ROW

BEGIN
	UPDATE CommandeProduit SET nbrItems = (nbrItems - :New.nbrItems) WHERE numReference = :NEW.numReference AND numCommande = :NEW.numCommande;	
	UPDATE Produit SET stock = (stock - :NEW.nbritems) WHERE numReference = :NEW.numreference;
END;
/

CREATE OR REPLACE TRIGGER Valider_Stock_Commande 
BEFORE INSERT ON Livraisons 
FOR EACH ROW

DECLARE
	qqt INTEGER := 0;

BEGIN
	
	SELECT nbritems 
	INTO qqt
	FROM CommandeProduit
	WHERE numReference = :NEW.numreference AND numCommande = :NEW.numCommande;

	IF :NEW.nbritems > qqt THEN 
		raise_application_error(-20102, 'Nombre commande est superieur au stock de la commande.');
	END IF;
END;
/


CREATE OR REPLACE TRIGGER Valider_Paiement
BEFORE INSERT ON Paiement 
FOR EACH ROW

DECLARE
	montantFacture number(10,2) := 0;

BEGIN
  
	SELECT prixTotal 
  INTO montantFacture 
  FROM Facture 
  WHERE Facture.numLivraison = :NEW.numLivraison;
	
	IF :NEW.montant > montantFacture THEN 
    raise_application_error(-20103, 'Montant du paiement est superieur au montant de la facture');
	END IF;
END;
/

