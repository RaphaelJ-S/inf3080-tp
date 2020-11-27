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
