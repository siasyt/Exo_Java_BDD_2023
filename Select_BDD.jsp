<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MariaDB via JSP</title>
</head>
<body>
    <h1>Exemple de connexion à MariaDB avec JSP</h1>
    
    <% 
        String url = "jdbc:mariadb://localhost:3306/films";
        String user = "mysql";
        String password = "mysql";

        // Charger le pilote JDBC (pilote disponible dans WEB-INF/lib)
        Class.forName("org.mariadb.jdbc.Driver");

        // Établir la connexion
        Connection conn = DriverManager.getConnection(url, user, password);
        
        // Exercice 1 : Les films entre 2000 et 2015
        String sqlExercice1 = "SELECT idFilm, titre, année FROM Film WHERE année > 2000 AND année < 2015";
        PreparedStatement pstmtExercice1 = conn.prepareStatement(sqlExercice1);
        ResultSet rsExercice1 = pstmtExercice1.executeQuery();

        out.println("<h2>Exercice 1 : Les films entre 2000 et 2015</h2>");
        out.println("<p>Extraire les films dont l'année est supérieure à 2000 et inférieure à 2015.</p>");

        while (rsExercice1.next()) {
            String colonne1 = rsExercice1.getString("idFilm");
            String colonne2 = rsExercice1.getString("titre");
            String colonne3 = rsExercice1.getString("année");
            out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
        }

        rsExercice1.close();
        pstmtExercice1.close();
        
        // Exercice 2 : Année de recherche
        if (request.getMethod().equalsIgnoreCase("post")) {
            String anneeRecherche = request.getParameter("annee");

            if (anneeRecherche != null && !anneeRecherche.isEmpty()) {
                int anneeInt = Integer.parseInt(anneeRecherche);

                // Execute the query
                String sqlExercice2 = "SELECT idFilm, titre, année FROM Film WHERE année = ?";
                PreparedStatement pstmtExercice2 = conn.prepareStatement(sqlExercice2);
                pstmtExercice2.setInt(1, anneeInt);
                ResultSet rsExercice2 = pstmtExercice2.executeQuery();

                out.println("<h2>Exercice 2 : Résultats de la recherche pour l'année " + anneeRecherche + "</h2>");

                while (rsExercice2.next()) {
                    String colonne1 = rsExercice2.getString("idFilm");
                    String colonne2 = rsExercice2.getString("titre");
                    String colonne3 = rsExercice2.getString("année");
                    out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
                }

                rsExercice2.close();
                pstmtExercice2.close();
            }
        }
    %>

    <form action="" method="post">
        <label for="annee">Année de recherche :</label>
        <input type="text" id="annee" name="annee" required>
        <button type="submit">Rechercher</button>
    </form>

    <!-- Exercice 3 : Modification du titre du film -->
    <form action="modification.jsp" method="post">
        <label for="filmId">ID du film à modifier :</label>
        <input type="text" id="filmId" name="filmId" required>
        <label for="nouveauTitre">Nouveau titre :</label>
        <input type="text" id="nouveauTitre" name="nouveauTitre" required>
        <button type="submit">Modifier</button>
    </form>

    <!-- Exercice 4 : La valeur maximum -->
    <form action="ajout.jsp" method="post">
        <label for="nouveauTitre">Titre du nouveau film :</label>
        <input type="text" id="nouveauTitre" name="nouveauTitre" required>
        <label for="nouvelleAnnee">Année du nouveau film :</label>
        <input type="text" id="nouvelle





