create or replace function QuantiteDejaLivree(numRef in number, numCom in number)
return number 
is
    num_livr    number(20);
    date_livr   date;
    nbr_items_c number(20) := 0;

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
return number
is
    montant_total_c number(10, 2) := 0;
begin

    select prixTotal
    into montant_total_c
    from Facture
    where numFac = numLivraison;
    return montant_total_c;
end;
/


