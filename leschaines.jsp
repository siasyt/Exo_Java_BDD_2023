<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les chaines</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les chaines de charactères</h1>
<form action="#" method="post">
    <p>Saisir une chaine (Du texte avec 6 caractères minimum) : <input type="text" id="inputValeur" name="chaine">
    <p><input type="submit" value="Afficher">
</form>
<%-- Récupération des valeurs --%>
    <% String chaine = request.getParameter("chaine"); %>
    
    <% if (chaine != null) { %>

    <%-- Obtention de la longueur de la chaîne --%>
    <% int longueurChaine = chaine.length(); %>
    <p>La longueur de votre chaîne est de <%= longueurChaine %> caractères</p>

    <%-- Extraction du 3° caractère dans votre chaine --%>
    <% char caractereExtrait = chaine.charAt(2); %>
    <p>Le 3° caractère de votre chaine est la lettre <%= caractereExtrait %></p>

    <%-- Obtention d'une sous-chaîne --%>
    <% String sousChaine = chaine.substring(2, 6); %>
    <p>Une sous chaine de votre texte : <%= sousChaine %></p>

    <%-- Recharche de la lettre "e" --%>
    <% char recherche = 'e'; 
       int position = chaine.indexOf(recherche); %>
    <p>Votre premier "e" est en : <%= position %></p>

    
<h2>Exercice 1 : Combien de 'e' dans notre chaîne de caractères ?</h2>
<p>Ecrire un programme pour compter le nombre de lettres 'e' (minuscules ou majuscules) dans votre chaîne de caractères</p>

<h2>Exercice 1 : Réponse </h2>
<% int countE = 0;
   for (int i = 0; i < chaine.length(); i++) {
       char currentChar = Character.toLowerCase(chaine.charAt(i));
       if (currentChar == 'e') {
           countE++;
       }
   }
%>

<p>Le nombre de lettres 'e' dans votre chaîne est : <%= countE %></p>

<h2>Exercice 2 : Affichage vertical</h2>
<p>Ecrire le programme pour afficher le texte en vertical</br>
Exemple : Bonjour</br>
B</br>
o</br>
n</br>
j</br>
o</br>
u</br>
r</p>

<h2>Exercice 2 : Réponse </h2>

<% for (int i = 0; i < chaine.length(); i++) { %>
    <p><%= chaine.charAt(i) %></p>
<% } %>

<h2>Exercice 3 : Retour à la ligne</h2>
<p>La présence d'un espace provoque un retour à la ligne </br>
Exemple : L'hiver sera pluvieux</br>
L'hiver</br>
sera</br>
pluvieux</p>

<h2>Exercice 3 : Réponse </h2>

<% for (int i = 0; i < chaine.length(); i++) {
     char currentChar = chaine.charAt(i);
     if (currentChar == ' ') { %>
        <br>
     <% } else { %>
        <%= currentChar %>
     <% }
} %>

<h2>Exercice 4 : Afficher une lettre sur deux</h2>
<p>Ecrire le programme pour afficher seulement une lettre sur deux de votre texte </br>
Exemple : L'hiver sera pluvieux</br>
Lhvrsr lvex</p>

<h2>Exercice 4 : Réponse </h2>


<% for (int i = 0; i < chaine.length(); i += 2) { %>
    <%= chaine.charAt(i) %>
<% } %>

<h2>Exercice 5 : La phrase en verlan</h2>
<p>Ecrire le programme afin d'afficher le texte en verlan </br>
Exemple : L'hiver sera pluvieux</br>
xueivulp ares revih'l</p>

<h2>Exercice 5 : Réponse </h2>

<% for (int i = chaine.length() - 1; i >= 0; i--) { %>
    <%= chaine.charAt(i) %>
<% } %>

<h2>Exercice 6 : Consonnes et voyelles</h2>
<p>Ecrire le programme afin de compter les consonnes et les voyelles dans votre texte</p>

<%-- Initialisation des compteurs --%>
<% int nbVoyelles = 0; %>
<% int nbConsonnes = 0; %>

<h2>Exercice 6 : Réponse </h2>

<% for (int i = 0; i < chaine.length(); i++) {
     char currentChar = Character.toLowerCase(chaine.charAt(i));
     if (Character.isLetter(currentChar)) {
        if (currentChar == 'a' || currentChar == 'e' || currentChar == 'i' || currentChar == 'o' || currentChar == 'u' || currentChar == 'y') {
            nbVoyelles++;
        } else {
            nbConsonnes++;
        }
     }
} %>

<p>Nombre de voyelles : <%= nbVoyelles %></p>
<p>Nombre de consonnes : <%= nbConsonnes %></p>

<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
