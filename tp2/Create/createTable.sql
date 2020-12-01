SET ECHO ON;

CREATE TABLE Produit(
  numReference number(5) NOT NULL,
  typeProduit number(5) NOT NULL,
  description varchar2(20) NOT NULL,
  preFix varchar2(10) NOT NULL,
  prixVente number(10,2) NOT NULL,
  dateEntree date NOT NULL,
  seuilMinStock number(4) NOT NULL,
  stock number(4) NOT NULL,
  PRIMARY KEY(numReference)
);

CREATE TABLE Livraison(
  numLivraison number(20),
  dateJour date NOT NULL,
  dateLivraison date NOT NULL,
  PRIMARY KEY(numLivraison) 
);
CREATE TABLE Adresse (
  codePostal varchar2(7) NOT NULL,
  pays varchar2(5) NOT NULL,
  numCiv number(5) NOT NULL,
  ville varchar2(15) NOT NULL, 
  rue varchar2(20) NOT NULL,
  PRIMARY KEY(codePostal)
);

CREATE TABLE Individu(
  codeIndividu number(20) NOT NULL,
  numTel varchar2(14) NOT NULL,
  motDePasse varchar2(14) NOT NULL,
  codePostal varchar2(7) NOT NULL,
  PRIMARY KEY(codeIndividu),
  FOREIGN KEY(codePostal) REFERENCES Adresse ON DELETE CASCADE
);


CREATE TABLE Commande(
  numCommande number(20) NOT NULL,
  dateCommande date NOT NULL, 
  etatCommande varchar2(10) NOT NULL,
  codeIndividu number(20) NOT NULL,
  PRIMARY KEY(numCommande),
  FOREIGN KEY(codeIndividu) REFERENCES Individu ON DELETE CASCADE
);

CREATE TABLE Paiement(
  numPaiement number(20) NOT NULL,
  numLivraison number(20) NOT NULL,
  montant number(10,2) NOT NULL,
  datePaiement date NOT NULL,
  methodePaiement varchar2(10) NOT NULL,
  PRIMARY KEY(numPaiement, numLivraison),
  FOREIGN KEY(numLivraison) REFERENCES Livraison ON DELETE CASCADE
);
CREATE TABLE CarteCredit(
  numPaiement number(20),
  numLivraison number(20),
  dateExpiration date NOT NULL,
  numCarte number(16) NOT NULL,
  typeCarte varchar2(15) NOT NULL,
  PRIMARY KEY(numPaiement, numLivraison),
  FOREIGN KEY(numPaiement, numLivraison) REFERENCES Paiement ON DELETE CASCADE
);

CREATE TABLE Cheque(
  numPaiement number(20),
  numLivraison number(20),
  numCheque number(20) NOT NULL,
  idBanque number(10) NOT NULL,
  PRIMARY KEY(numPaiement, numLivraison),
  FOREIGN KEY(numPaiement, numLivraison) REFERENCES Paiement ON DELETE CASCADE
);

CREATE TABLE CommandeProduit(
  numReference number(20) NOT NULL,
  numCommande number(20) NOT NULL,
  nbrItems number(4) NOT NULL,
  PRIMARY KEY(numReference, numCommande),
  FOREIGN KEY(numReference) REFERENCES Produit ON DELETE CASCADE,
  FOREIGN KEY(numCommande) REFERENCES Commande ON DELETE CASCADE
);  
/*
CREATE TABLE ModificationPrix (
  numMod number(20) not null,
  dateMod date not null,
  nouvPrix number(10,2) not null,
  numReference number(20) not null,
  foreign key(numReference) references Produit ON DELETE CASCADE,
  primary key(numMod)
);
*/
CREATE TABLE Fournisseur(
  codeIndividu number(20) NOT NULL,
  typeFourn varchar2(50) NOT NULL,
  attribut varchar2(50) NOT NULL,
  PRIMARY KEY(codeIndividu),
  FOREIGN KEY(codeIndividu) REFERENCES Individu ON DELETE CASCADE
);

CREATE TABLE Client(
  codeIndividu number(20) NOT NULL,
  nom varchar2(50) NOT NULL,
  prenom varchar2(50) NOT NULL,
  qualite varchar2(50) NOT NULL,
  etatCompte varChar(10) NOT NULL,
  PRIMARY KEY(codeIndividu),
  FOREIGN KEY(codeIndividu) REFERENCES Individu ON DELETE CASCADE
);

CREATE TABLE CommandeLivraison(
  numCommande number(20),
  numLivraison number(20),
  nbrItems number(4) NOT NULL,
  PRIMARY KEY(numCommande, numLivraison),
  FOREIGN KEY(numCommande) REFERENCES Commande ON DELETE CASCADE,
  FOREIGN KEY(numLivraison) REFERENCES Livraison ON DELETE CASCADE
);
CREATE TABLE ProduitFournisseur(
  codeIndividu number(20) NOT NULL,
  numReference number(20) NOT NULL,
  ordrePrio number(1) NOT NULL,
  PRIMARY KEY(codeIndividu, numReference),
  FOREIGN KEY(codeIndividu) REFERENCES Fournisseur ON DELETE CASCADE,
  FOREIGN KEY(numReference) REFERENCES Produit ON DELETE CASCADE
);

CREATE TABLE Facture(
  numLivraison number(20) NOT NULL,
  prixSousTotal number(10,2) NOT NULL,
  taxes number(10,2) NOT NULL,
  prixTotal number(10,2) NOT NULL,
  etatFacture varchar2(10) NOT NULL,
  codeIndividu number(20) NOT NULL,
  PRIMARY KEY(numLivraison),
  FOREIGN KEY(codeIndividu) REFERENCES Client ON DELETE CASCADE,
  FOREIGN KEY(numLivraison) REFERENCES Livraison ON DELETE CASCADE
);

CREATE TABLE Exemplaire (
  codeZebre number(12) NOT NULL,
  numReference number(20) NOT NULL,
  numLivraison number(20) NOT NULL,
  PRIMARY KEY(codeZebre),
  FOREIGN KEY(numReference) REFERENCES Produit ON DELETE CASCADE,
  FOREIGN KEY(numLivraison) REFERENCES Livraison ON DELETE CASCADE
);


ALTER TABLE Produit
ADD CONSTRAINT stock_Positif CHECK (stock >= 0);

ALTER TABLE Produit
ADD CONSTRAINT seuilMinimum_Positif CHECK (seuilMinStock >= 0);

ALTER TABLE CarteCredit
ADD CONSTRAINT typeCarte_Valide CHECK 
(typeCarte IN ('VISA', 'Master Card', 'American Express'));

ALTER TABLE CommandeProduit
ADD CONSTRAINT nbrItems_Valide CHECK (nbrItems >=0);

ALTER TABLE Fournisseur
ADD CONSTRAINT typeFourn_Valide CHECK
(typeFourn IN ('Transformateur', 'Importateur', 'Livreur'));
