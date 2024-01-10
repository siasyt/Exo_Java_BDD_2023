<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les tableaux</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les tableaux</h1>
<form action="#" method="post">
    <p>Saisir au minimu 3 chiffres à la suite, exemple : 6 78 15 <input type="text" id="inputValeur" name="chaine">
    <p><input type="submit" value="Afficher">
</form>
<%-- Récupération des valeurs --%>
    <% String chaine = request.getParameter("chaine"); %>
    
    <% if (chaine != null) { %>

    <%-- Division de la chaîne de chiffres séparés par des espaces --%>
    <% String[] tableauDeChiffres = chaine.split("\\s+"); %>
    <p>La tableau contient <%= tableauDeChiffres.length %> valeurs</br>
    Chiffre 1 : <%= Integer.parseInt(tableauDeChiffres[0]) %></br>
    Chiffre 2 : <%= Integer.parseInt(tableauDeChiffres[1]) %></br>
    Chiffre 3 : <%= Integer.parseInt(tableauDeChiffres[2]) %></p>
    
<h2>Exercice 1 : Le carré de la première valeur</h2>
<%
if (tableauDeChiffres.length > 0) {
    int premiereValeur = Integer.parseInt(tableauDeChiffres[0]);
    int carrePremiereValeur = premiereValeur * premiereValeur;
%>
    <p>Le carré de la première valeur est : <%= carrePremiereValeur %></p>
<%
} else {
%>
    <p>Aucune valeur n'a été saisie.</p>
<%
}
%>

<h2>Exercice 2 : La somme des 2 premières valeurs</h2>
<%
if (tableauDeChiffres.length >= 2) {
    int premiereValeur = Integer.parseInt(tableauDeChiffres[0]);
    int deuxiemeValeur = Integer.parseInt(tableauDeChiffres[1]);
    int sommeDeuxPremieresValeurs = premiereValeur + deuxiemeValeur;
%>
    <p>La somme des deux premières valeurs est : <%= sommeDeuxPremieresValeurs %></p>
<%
} else {
%>
    <p>Il n'y a pas suffisamment de valeurs saisies pour effectuer la somme.</p>
<%
}
%>

<h2>Exercice 3 : La somme de toutes les valeurs</h2>
<%
if (tableauDeChiffres.length >= 1) {
    int somme = 0;
    for (String valeur : tableauDeChiffres) {
        somme += Integer.parseInt(valeur);
    }
%>
    <p>La somme de toutes les valeurs est : <%= somme %></p>
<%
} else {
%>
    <p>Aucune valeur saisie pour effectuer la somme.</p>
<%
}
%>

<h2>Exercice 4 : La valeur maximum</h2>
<%
if (tableauDeChiffres.length >= 1) {
    int max = Integer.parseInt(tableauDeChiffres[0]);
    for (String valeur : tableauDeChiffres) {
        int nombre = Integer.parseInt(valeur);
        if (nombre > max) {
            max = nombre;
        }
    }
%>
    <p>La valeur maximale est : <%= max %></p>
<%
} else {
%>
    <p>Aucune valeur saisie pour trouver la valeur maximale.</p>
<%
}
%>

<h2>Exercice 5 : La valeur minimale</h2>
<%
if (tableauDeChiffres.length >= 1) {
    int min = Integer.parseInt(tableauDeChiffres[0]);
    for (String valeur : tableauDeChiffres) {
        int nombre = Integer.parseInt(valeur);
        if (nombre < min) {
            min = nombre;
        }
    }
%>
    <p>La valeur minimale est : <%= min %></p>
<%
} else {
%>
    <p>Aucune valeur saisie pour trouver la valeur minimale.</p>
<%
}
%>

<h2>Exercice 6 : La valeur la plus proche de 0</h2>
<%
if (tableauDeChiffres.length >= 1) {
    int plusProcheDeZero = Integer.parseInt(tableauDeChiffres[0]);
    for (String valeur : tableauDeChiffres) {
        int nombre = Integer.parseInt(valeur);
        if (Math.abs(nombre) < Math.abs(plusProcheDeZero)) {
            plusProcheDeZero = nombre;
        }
    }
%>
    <p>La valeur la plus proche de 0 est : <%= plusProcheDeZero %></p>
<%
} else {
%>
    <p>Aucune valeur saisie pour trouver la valeur la plus proche de 0.</p>
<%
}
%>

<h2>Exercice 7 : La valeur la plus proche de 0 (2° version)</h2>
<%
if (tableauDeChiffres.length >= 1) {
    int plusProcheDeZero = Integer.parseInt(tableauDeChiffres[0]);
    for (String valeur : tableauDeChiffres) {
        int nombre = Integer.parseInt(valeur);
        if (Math.abs(nombre) < Math.abs(plusProcheDeZero) || (Math.abs(nombre) == Math.abs(plusProcheDeZero) && nombre > 0)) {
            plusProcheDeZero = nombre;
        }
    }
%>
    <p>La valeur la plus proche de 0 (en cas d'égalité, la valeur positive est privilégiée) est : <%= plusProcheDeZero %></p>
<%
} else {
%>
    <p>Aucune valeur saisie pour trouver la valeur la plus proche de 0.</p>
<%
}
%>

<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
