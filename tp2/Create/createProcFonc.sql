create or replace procedure QuantiteDejaLivree(numRef in number, numCom in number)
    is
    nbr_items_c number(4);
begin

    select numLivraison into correspond from CommandeLivraison Where numCommande = numCom;
    select count(codeZebre) from Exemplaire WHERE numLivraison = correspond AND numReference = numRef;
    select nbrItems
    into nbr_items_c
    from CommandeLivraison
    where numRef = numReference
      and numCom = numCommande;
    dbms_output.put_line('Quantite deja livree: ' || nbr_items_c);
end;


create or replace procedure TotalFacture(numFac in number)
    is
    montant_total_c number(10, 2);
begin

    select prixTotal
    into montant_total_c
    from Facture
    where numFac = numLivraison;
    dbms_output.put_line('Montant total de la facture: ' || montant_total_c);
end;


create or replace procedure ProduireFacture(numLivr in number, dateLimite in date)
    is
    num_client_c     number(20);
    nom_client_c     varchar(50);
    prenom_client_c  varchar(50);
    num_livraison_c  number(20);
    date_livraison_c date;
    prix_soustotal_c number(10, 2);
    taxes_c          number(10, 2);
    prix_total_c     number(10, 2);


DECLARE
    CURSOR cur_adresse_client IS
        SELECT *
        FROM Adresse
                 INNER JOIN CLIENT On ADRESSE.codeIndividu = Client.CODEINDIVIDU;
    adresse_complete ADRESSE%ROWTYPE;

BEGIN
    OPEN cur_adresse_client;
    LOOP
        FETCH cur_adresse_client INTO adresse_complete;
        EXIT WHEN cur_adresse_client%NOTFOUND;
    END LOOP;
        CLOSE cur_adresse_client;

/*
DECLARE
CURSOR liste_produit_facture IS
SELECT X
FROM X
WHERE X = X; 
liste_complete X.X%TYPE;
BEGIN
  OPEN liste_produit_facture;
LOOP
  FETCH liste_produit_facture INTO liste_complete;
  EXIT WHEN liste_produit_facture%NOTFOUND;
END LOOP
CLOSE liste_produit_facture;
END;
*/

        select CODEINDIVIDU into num_client_c from Facture Where numLivraison = numLivr;
        select nom
        into nom_client_c
        from Client
                 INNER JOIN Facture ON Client.codeIndividu = Facture.CODEINDIVIDU;
        select prenom
        into prenom_client_c
        from Client
                 INNER JOIN Facture ON Client.codeIndividu = Facture.CODEINDIVIDU;
        select numLivraison into num_livraison_c from Facture Where numLivraison = numLivr;
        select DATELIVRAISON into date_livraison_c from Livraison Where numLivraison = numLivr;
        select prixSousTotal into prix_soustotal_c from Facture Where numLivraison = numLivr;
        select taxes into taxes_c from Facture Where numLivraison = numLivr;
        select prixTotal into prix_total_c from Facture Where numLivraison = numLivr;

        dbms_output.put_line('**********Facture Client**********');
        dbms_output.put_line('Numero du Client: ' || num_client_c);
        dbms_output.put_line('Nom du Client: ' || nom_client_c);
        dbms_output.put_line('Prenom du Client: ' || prenom_client_c);
        dbms_output.put_line('Adresse du Client: ' || adresse_complete);
        dbms_output.put_line('Numero de Livraison: ' || num_livraison_c);
        dbms_output.put_line('Date de Livraison: ' || date_livraison_c);
        dbms_output.put_line('Liste de Produits: ' || liste_complete);
        dbms_output.put_line('Prix Sous-Total: ' || prix_soustotal_c);
        dbms_output.put_line('Montant des Taxes: ' || taxes_c);
        dbms_output.put_line('Prix Total: ' || prix_total_c);
    end;
