create or replace function QuantiteDejaLivree(numRef in number, numCom in number)
    is
    num_livr    number(20);
    date_livr   date;
    nbr_items_c number(20);

begin
    select NUMLIVRAISON into num_livr from LIVRAISONS Where numCommande = numCom and NUMREFERENCE = numRef;
    select DATELIVRAISON into date_livr from LIVRAISONS where NUMLIVRAISON = num_livr;
    if date_livr < SYSDATE THEN
        select NBRITEMS into nbr_items_c from LIVRAISONS Where numCommande = numCom and NUMREFERENCE = numRef;
        return nbr_items_c;
    END IF;
end;
/


create or replace function TotalFacture(numFac in number)
    is
    montant_total_c number(10, 2);
begin

    select prixTotal
    into montant_total_c
    from Facture
    where numFac = numLivraison;
    return montant_total_c;
end;
/

create procedure ProduireFacture(numLivr in number, dateLimite in date)
    is
    num_client_c     number(20);
    nom_client_c     varchar(50);
    prenom_client_c  varchar(50);
    num_livraison_c  number(20);
    date_livraison_c date;
    prix_soustotal_c number(10, 2);
    taxes_c          number(10, 2);
    prix_total_c     number(10, 2);
    c_num_commande   number(20);
    rue_c    varchar(10) ;
    ville_c  varchar(10) ;
    numCiv_c varchar(10) ;
    pays_c   varchar(10) ;
    cp_c     varchar(10) ;
begin

    SELECT codePostal, pays, numCiv, ville, rue
    INTO cp_c, pays_c, numCiv_c, ville_c, rue_c
    FROM Adresse
    where codepostal = (SELECT codePostal from INDIVIDU where CODEINDIVIDU = (Select CODEINDIVIDU From FACTURE where NUMLIVRAISON = numLivr));


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

    select DATELIVRAISON into date_livraison_c from LIVRAISONS Where numLivraison = numLivr;

    select prixSousTotal into prix_soustotal_c from Facture Where numLivraison = numLivr;

    select taxes into taxes_c from Facture Where numLivraison = numLivr;

    select prixTotal into prix_total_c from Facture Where numLivraison = numLivr;

    dbms_output.put_line('**********Facture Client**********');
    dbms_output.put_line('Numero du Client: ' || num_client_c);
    dbms_output.put_line('Nom du Client: ' || nom_client_c);
    dbms_output.put_line('Prenom du Client: ' || prenom_client_c);
    dbms_output.put_line('Adresse du Client ');
    dbms_output.put_line('Numero Civique: ' || numCiv_c);
    dbms_output.put_line('Rue: ' || rue_c);
    dbms_output.put_line('Code Postal: ' || cp_c);
    dbms_output.put_line('Ville: ' || ville_c);
    dbms_output.put_line('Pays: ' || pays_c);
    dbms_output.put_line('Numero de Livraison: ' || num_livraison_c);
    dbms_output.put_line('Date de Livraison: ' || date_livraison_c);


    DECLARE
        CURSOR cur_liste_commande IS
            SELECT LIVRAISONS.NUMCOMMANDE, CODEZEBRE, PRIXVENTE, TYPEPRODUIT
            into c_num_commande
            FROM LIVRAISONS
                     inner join COMMANDEPRODUIT C2 on LIVRAISONS.NUMCOMMANDE = C2.NUMCOMMANDE
                     INNER JOIN PRODUIT P on P.NUMREFERENCE = C2.NUMREFERENCE
                     INNER JOIN EXEMPLAIRE E on LIVRAISONS.NUMLIVRAISON = E.NUMLIVRAISON
            WHERE LIVRAISONS.NUMLIVRAISON = numLivr;
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
    DBMS_OUTPUT.PUT_LINE('Date Limite de paiement : ' || dateLimite);
    dbms_output.put_line('Prix Sous-Total: ' || prix_soustotal_c);
    dbms_output.put_line('Montant des Taxes: ' || taxes_c);
    dbms_output.put_line('Prix Total: ' || prix_total_c);
end;
/



