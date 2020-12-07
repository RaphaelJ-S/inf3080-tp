create procedure QuantiteDejaLivree(numRef in number, numCom in number)
    is
    nbr_items_c number(4);
    correspond  number(20);
begin

    select numLivraison into correspond from LIVRAISON Where numCommande = numCom;
    select count(codeZebre) from Exemplaire WHERE numLivraison = correspond AND numReference = numRef;
    select nbrItems
    into nbr_items_c
    from COMMANDEPRODUIT
    where numRef = numReference
      and numCom = numCommande;
    dbms_output.put_line('Quantite deja livree: ' || nbr_items_c);
end;
/




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
    adresse_complete Adresse%rowtype;
    num_livraison_c  number(20);
    date_livraison_c date;
    prix_soustotal_c number(10, 2);
    taxes_c          number(10, 2);
    prix_total_c     number(10, 2);
    c_num_commande   number(20);

Begin
    SELECT *
    into adresse_complete
    FROM Adresse
    where ADRESSE.CODEINDIVIDU = (select CODEINDIVIDU
                                  from Facture
                                  Where numLivraison = numLivr
    );

    select CODEINDIVIDU into num_client_c from Facture Where numLivraison = numLivr;

    select nom
    into nom_client_c
    from Individu
             INNER JOIN Facture ON Individu.codeIndividu = Facture.CODEINDIVIDU;

    select prenom
    into prenom_client_c
    from Individu
             INNER JOIN Facture ON Individu.codeIndividu = Facture.CODEINDIVIDU;

    select numLivraison into num_livraison_c from Facture Where numLivraison = numLivr;

    select DATELIVRAISON into date_livraison_c from Livraison Where numLivraison = numLivr;

    select prixSousTotal into prix_soustotal_c from Facture Where numLivraison = numLivr;

    select taxes into taxes_c from Facture Where numLivraison = numLivr;

    select prixTotal into prix_total_c from Facture Where numLivraison = numLivr;

    dbms_output.put_line('**********Facture Client**********');
    dbms_output.put_line('Numero du Client: ' || num_client_c);
    dbms_output.put_line('Nom du Client: ' || nom_client_c);
    dbms_output.put_line('Prenom du Client: ' || prenom_client_c);
    dbms_output.put_line('Adresse du Client ');
    dbms_output.put_line('Numero Civique: ' || adresse_complete.NUMCIV);
    dbms_output.put_line('Rue: ' || adresse_complete.RUE);
    dbms_output.put_line('Code Postal: ' || adresse_complete.CODEPOSTAL);
    dbms_output.put_line('Ville: ' || adresse_complete.Ville);
    dbms_output.put_line('Pays: ' || adresse_complete.Pays);
    dbms_output.put_line('Numero de Livraison: ' || num_livraison_c);
    dbms_output.put_line('Date de Livraison: ' || date_livraison_c);


    DECLARE
            CURSOR cur_liste_commande IS
                SELECT LIVRAISON.NUMCOMMANDE, CODEZEBRE, PRIXVENTE, TYPEPRODUIT
                into c_num_commande
                FROM LIVRAISON inner join COMMANDEPRODUIT C2 on LIVRAISON.NUMCOMMANDE = C2.NUMCOMMANDE
                    INNER JOIN PRODUIT P on P.NUMREFERENCE = C2.NUMREFERENCE
                    INNER JOIN EXEMPLAIRE E on LIVRAISON.NUMLIVRAISON = E.NUMLIVRAISON
                WHERE LIVRAISON.NUMLIVRAISON = numLivr;
            produits_commandes cur_liste_commande%ROWTYPE;
        BEGIN
            OPEN cur_liste_commande;
            LOOP
                FETCH cur_liste_commande INTO produits_commandes;
              dbms_output.put_line('#Produit : ' || produits_commandes.TYPEPRODUIT);
              DBMS_OUTPUT.put_line('Code Zebre : ' || produits_commandes.CODEZEBRE);
              dbms_output.put_line('#Commande : ' || produits_commandes.NUMCOMMANDE);
              dbms_output.put_line('Prix : ' || produits_commandes.PRIXVENTE);
                EXIT WHEN cur_liste_commande%NOTFOUND;
            END LOOP;
            CLOSE cur_liste_commande;
        end;
/*
        DECLARE
            CURSOR cur_liste_produit IS
                SELECT *
                FROM COMMANDEPRODUIT
                WHERE c_num_commande = NUMCOMMANDE;
            liste_produits COMMANDEPRODUIT%ROWTYPE;
        BEGIN
            OPEN cur_liste_produit;
            LOOP
                FETCH cur_liste_produit INTO liste_produits;
                EXIT WHEN cur_liste_produit%NOTFOUND;
            END LOOP;
            CLOSE cur_liste_produit;
        end;

        DECLARE
            CURSOR cur_info_produit IS
                SELECT *
                FROM PRODUIT
                WHERE liste_produits.NUMREFERENCE = PRODUIT.NUMREFERENCE;
            info_produits PRODUIT%ROWTYPE;
        BEGIN
            OPEN cur_info_produit;
            LOOP
                FETCH cur_info_produit INTO info_produits;
                EXIT WHEN cur_info_produit%NOTFOUND;
            END LOOP;
            CLOSE cur_info_produit;
        end;

        select CODEZEBRE
        into code_zebre_c
        FROM EXEMPLAIRE
        where NUMREFERENCE = info_produits.NUMREFERENCE;
*/
        DBMS_OUTPUT.PUT_LINE('Date Limite de paiement : '|| dateLimite);
        dbms_output.put_line('Prix Sous-Total: ' || prix_soustotal_c);
        dbms_output.put_line('Montant des Taxes: ' || taxes_c);
        dbms_output.put_line('Prix Total: ' || prix_total_c);
    end;



