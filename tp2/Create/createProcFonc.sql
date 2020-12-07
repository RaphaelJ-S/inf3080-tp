create or replace procedure QuantiteDejaLivree(numRef in number, numCom in number)
    is
    nbr_items_c number(4);
    correspond  number(20);

begin

    select numLivraison into correspond from LIVRAISON Where NUMCOMMANDE = numCom;
    select count(codeZebre) into nbr_items_c from Exemplaire WHERE numLivraison = correspond AND numReference = numRef;
    /*select nbrItems
    into nbr_items_c
    from CommandeLivraison
    where numRef = numReference
      and numCom = numCommande;*/
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
    adresse_complete Adresse%rowtype;
    num_livraison_c  number(20);
    date_livraison_c date;
    prix_soustotal_c number(10, 2);
    taxes_c          number(10, 2);
    prix_total_c     number(10, 2);
    c_num_commande   number(20);
    code_zebre_c     number(12);

Begin
    DECLARE
        CURSOR cur_liste_commande IS
            SELECT NUMCOMMANDE
            into c_num_commande
            FROM LIVRAISON
            WHERE NUMLIVRAISON = numLivr;
        produits_commandes NUMCOMMANDE%TYPE;
    BEGIN
        OPEN cur_liste_commande;
        LOOP
            FETCH cur_liste_commande INTO produits_commandes;
            EXIT WHEN cur_liste_commande%NOTFOUND;
        END LOOP;
        CLOSE cur_liste_commande;


        DECLARE
            CURSOR cur_liste_produit IS
                SELECT *
                FROM COMMANDEPRODUIT
                WHERE c_num_commande = NUMCOMMANDE;
            produits_commandes COMMANDEPRODUIT%ROWTYPE;
        BEGIN
            OPEN cur_liste_produit;
            LOOP
                FETCH cur_liste_produit INTO produits_commandes;
                EXIT WHEN cur_liste_produit%NOTFOUND;
            END LOOP;
            CLOSE cur_liste_produit;

            DECLARE
                CURSOR cur_info_produit IS
                    SELECT *
                    FROM PRODUIT
                    WHERE produits_commandes.NUMREFERENCE = PRODUIT.NUMREFERENCE;
                info_produits PRODUIT%ROWTYPE;
            BEGIN
                OPEN cur_info_produit;
                LOOP
                    FETCH cur_info_produit INTO info_produits;
                    EXIT WHEN cur_info_produit%NOTFOUND;
                END LOOP;
                CLOSE cur_info_produit;

                select CODEZEBRE
                into code_zebre_c
                FROM EXEMPLAIRE
                where NUMREFERENCE = info_produits.NUMREFERENCE;


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
                dbms_output.put_line('Adresse du Client ');
                dbms_output.put_line('Numero Civique: ' || adresse_complete.NUMCIV);
                dbms_output.put_line('Rue: ' || adresse_complete.RUE);
                dbms_output.put_line('Code Postal: ' || adresse_complete.CODEPOSTAL);
                dbms_output.put_line('Ville: ' || adresse_complete.Ville);
                dbms_output.put_line('Pays: ' || adresse_complete.Pays);
                dbms_output.put_line('Numero de Livraison: ' || num_livraison_c);
                dbms_output.put_line('Date de Livraison: ' || date_livraison_c);
                /*      dbms_output.put_line('#Produit : ' || info_produits.TYPEPRODUIT);
                      DBMS_OUTPUT.put_line('Code Zebre : ' || code_zebre_c);
                      dbms_output.put_line('#Commande : ' || produits_commandes.NUMCOMMANDE);
                      dbms_output.put_line('Prix : ' || info_produits.PRIXVENTE);
                 */ dbms_output.put_line('Prix Sous-Total: ' || prix_soustotal_c);
                dbms_output.put_line('Montant des Taxes: ' || taxes_c);
                dbms_output.put_line('Prix Total: ' || prix_total_c);
            end;
            end;
        end;
    end;