
--Suppression des données de toutes les tables

DELETE FROM Produit WHERE numReference IS NOT NULL;

DELETE FROM Adresse WHERE codePostal IS NOT NULL;

DELETE FROM Commande WHERE numCommande IS NOT NULL;

DELETE FROM CommandeProduit WHERE numCommande IS NOT NULL AND numReference IS NOT NULL;

DELETE FROM Livraisons WHERE numLivraison IS NOT NULL;

DELETE FROM CarteCredit WHERE numCarte IS NOT NULL;

DELETE FROM Cheque WHERE numCheque IS NOT NULL;

DELETE FROM Individu WHERE codeInd IS NOT NULL;

DELETE FROM Fournisseur WHERE codeFourn IS NOT NULL;

DELETE FROM Client WHERE codeClient IS NOT NULL;

DELETE FROM ProduitFournisseur WHERE codeFourn IS NOT NULL AND numReference IS NOT NULL;

DELETE FROM Facture WHERE numFacture IS NOT NULL;

DELETE FROM Exemplaire WHERE codeZebre IS NOT NULL;

DELETE FROM Paiement WHERE numPaiement IS NOT NULL;


