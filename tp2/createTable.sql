CREATE TABLE Produit(
  numReference number(5) not null,
  description varchar2(20) not null,
  preFix varchar2(10) not null,
  prixVente number(10,2) not null,
  dateEntree date not null,
  seuilMinStock number(4) not null,
  stock number(4) not null,
  primary key (numReference)
);

CREATE TABLE Adresse (
  codePostal varchar2(7) not null,
  pays varchar2(5) not null,
  numCiv number(5) not null,
  ville varchar2(15) not null, 
  rue varchar2(20) not null,
  primary key(codePostal)
);

CREATE TABLE Commande(
  numCommande number(20) not null,
  dateCommande date not null, 
  etatCommande varchar2(10)not null,
  primary key(numCommande)
);

CREATE TABLE CarteCredit(
  numCarte number(16) not null,
  typeCarte varchar2(15) not null,
  primary key(numCarte)
);

CREATE TABLE Cheque(
  numCheque number(20) not null,
  idBanque number(10) not null,
  primary key(numCheque)
);

CREATE TABLE CommandeProduit(
  numReference number(20) not null,
  numCommande number(20) not null,
  nbrItems number(4) not null,
  primary key(numReference, numCommande),
  foreign key(numReference) references Produit,
  foreign key(numCommande) references Commande
);  

CREATE TABLE Individu(
  codeInd number(20) not null,
  numTel varchar2(14) not null,
  motDePasse varchar2(14) not null,
  codePostal varchar2(7) not null,
  primary key(codeInd),
  foreign key(codePostal) references Adresse
);

CREATE TABLE ModificationPrix (
  numMod number(20) not null,
  dateMod date not null,
  nouvPrix number(10,2) not null,
  numReference number(20) not null,
  foreign key(numReference) references Produit,
  primary key(numMod)
);

CREATE TABLE Fournisseur(
  codeFourn number(20) not null,
  typeFourn varchar2(50) not null,
  attribut varchar2(50) not null,
  primary key(codeFourn),
  foreign key(codeFourn) references Individu
);

CREATE TABLE Client(
  codeClient number(20) not null,
  nom varchar2(50) not null,
  prenom varchar2(50) not null,
  qualite varchar2(50) not null,
  etatCompte varChar(10) not null,
  primary key(codeClient),
  foreign key(codeClient) references Individu
);

CREATE TABLE ProduitFournisseur(
  codeFourn number(20) not null,
  numReference number(20) not null,
  ordrePrio number(1) not null,
  primary key(codeFourn, numReference),
  foreign key(codeFourn) references Fournisseur,
  foreign key(numReference) references Produit
);

CREATE TABLE Facture(
  numFacture number(20) not null,
  prixSousTotal number(10,2) not null,
  taxes number(10,2) not null,
  prixTotal number(10,2) not null,
  etatFacture varchar2(10) not null,
  dateLivraison date not null,
  codeClient number(20),
  primary key(numFacture),
  foreign key(codeClient) references Client
);

CREATE TABLE Exemplaire (
  codeZebre number(12) not null,
  numReference number(20) not null,
  numFacture number(20) not null,
  primary key(codeZebre),
  foreign key(numReference) references Produit,
  foreign key(numFacture) references Facture
);

CREATE TABLE CommandeFacture(
  numCommande number(20) not null,
  numFacture number(20) not null,
  nbrItems number(4) not null,
  numReference number(20) not null,
  primary key(numCommande, numFacture),
  foreign key(numCommande) references Commande,
  foreign key(numFacture) references Facture
);

CREATE TABLE Paiements(
  numPaiement number(20) not null,
  montant number(10,2) not null,
  datePaiement date not null,
  methodePaiement varchar2(10) not null,
  numFacture number(20) not null,
  numCheque number(20),
  numCarte number(16),
  primary key(numPaiement),
  foreign key(numFacture) references Facture,
  foreign key(numCheque) references Cheque,
  foreign key(numCarte) references CarteCredit
);
