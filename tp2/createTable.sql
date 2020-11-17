CREATE TABLE Produit(
  numReference number(5),
  description varchar2(20),
  preFix varchar2(10),
  prixVente number(10,2),
  dateEntree date,
  seuilMinStock number(4),
  stock number(4)
);
