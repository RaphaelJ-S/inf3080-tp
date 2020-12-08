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

create procedure ProduireFacture(numLivr in number, dateLimite_f in date)
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
    dateLimite_c     date;
    e_rue            varchar(10) ;
    e_ville          varchar(10) ;
    e_numCiv         varchar(10) ;
    e_pays           varchar(10) ;
    e_cp             varchar(10) ;
begin

    SELECT codePostal, pays, numCiv, ville, rue
    INTO e_cp, e_pays, e_numCiv, e_ville, e_rue
    FROM Adresse
    where codepostal =
          (SELECT codePostal
           from INDIVIDU
           where CODEINDIVIDU =
                 (Select CODEINDIVIDU
                  From FACTURE
                  where NUMLIVRAISON = numLivr));

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

    select datepayerlim into dateLimite_c from FACTURE where datepayerLim = dateLimite_f;

    dbms_output.put_line('**********Facture Client**********');
    dbms_output.put_line('Numero du Client: ' || num_client_c);
    dbms_output.put_line('Nom du Client: ' || nom_client_c);
    dbms_output.put_line('Prenom du Client: ' || prenom_client_c);
    dbms_output.put_line('Adresse du Client : ');
    dbms_output.put_line('Numero Civique: ' || e_numCiv);
    dbms_output.put_line('Rue: ' || e_rue);
    dbms_output.put_line('Code Postal: ' || e_cp);
    dbms_output.put_line('Ville: ' || e_ville);
    dbms_output.put_line('Pays: ' || e_pays);
    dbms_output.put_line('Numero de Livraison: ' || num_livraison_c);
    dbms_output.put_line('Date de Livraison: ' || date_livraison_c);


    DECLARE
        c_num_livraison    int ;
        c_type_produit     varchar(20) ;
        c_prix_vente       varchar(20) ;
        c_code_zebre       varchar(20) ;
        c_num_commande     varchar(20);
        CURSOR cur_liste_commande IS
            SELECT LIVRAISONS.NUMLIVRAISON, LIVRAISONS.NUMCOMMANDE, CODEZEBRE, PRIXVENTE, TYPEPRODUIT
            into c_num_livraison, c_num_commande, c_code_zebre, c_prix_vente, c_type_produit
            FROM LIVRAISONS
                     INNER JOIN COMMANDEPRODUIT C2 on LIVRAISONS.NUMCOMMANDE = C2.NUMCOMMANDE
                     INNER JOIN PRODUIT P on P.NUMREFERENCE = C2.NUMREFERENCE
                     INNER JOIN EXEMPLAIRE E on LIVRAISONS.NUMLIVRAISON = E.NUMLIVRAISON
            WHERE LIVRAISONS.NUMLIVRAISON = 2;
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

    DBMS_OUTPUT.PUT_LINE('Date Limite de paiement : ' || dateLimite_c);
    dbms_output.put_line('Prix Sous-Total: ' || prix_soustotal_c);
    dbms_output.put_line('Montant des Taxes: ' || taxes_c);
    dbms_output.put_line('Prix Total: ' || prix_total_c);
end;
/





