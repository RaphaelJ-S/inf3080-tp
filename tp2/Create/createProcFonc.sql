
create or replace procedure QuantiteDejaLivree(numRef in number,numCom in number)
is
nbrItemsC number(4);
begin

select numLivraison into correspond from CommandeLivraison Where numCommande = numCom;
select count(codeZebre) from Exemplaire WHERE numLivraison = correspond AND numReference = numRef;
select nbrItems into nbrItemsC
from CommandeLivraison where numRef=numReference and numCom =numCommande;
dbms_output.put_line('Quantite deja livree: '|| nbrItemsC);
end;


create or replace procedure TotalFacture(numFac in number)
is
montantTotalC number(10,2);
begin

select prixTotal into montantTotalC
from Facture where numFac=numLivraison;
dbms_output.put_line('Montant total de la facture: '|| prixTotalC);
end;


reature or replace procedure ProduireFacture(numLivr in number, dateLimite in date)
is
numClientC number(20);
nomClientC varchar(50);
prenomClientC varchar(50);
\\ adresseClientC 
numLivraisonC number(20);
dateLivraisonC date;
\\listeproduit
prixSousTotalC number(10,2);
taxesC number(10,2);
prixTotalC number(10,2);
begin

select 

