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
    %>

    <form action="" method="post">
        <label for="annee">Année de recherche :</label>
        <input type="text" id="annee" name="annee" required>
        <button type="submit">Rechercher</button>
    </form>

    <% 
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

    <!-- Exercice 3 : Modification du titre du film -->
    <h2>Exercice 3 : Modification du titre du film</h2>
    <form action="" method="post">
        <label for="filmId">ID du film à modifier :</label>
        <input type="text" id="filmId" name="filmId" required>
        <label for="nouveauTitre">Nouveau titre :</label>
        <input type="text" id="nouveauTitre" name="nouveauTitre" required>
        <button type="submit" name="action" value="modifierTitre">Modifier le titre</button>
    </form>

    <%
        // Check if the form is submitted for modifying the title
        if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null) {
            String action = request.getParameter("action");

            if (action.equals("modifierTitre")) {
                try {
                    String filmId = request.getParameter("filmId");
                    String nouveauTitre = request.getParameter("nouveauTitre");

                    // Exécutez la mise à jour du titre du film
                    String sql = "UPDATE Film SET titre = ? WHERE idFilm = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, nouveauTitre);
                    pstmt.setString(2, filmId);
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p>Le titre du film a été modifié avec succès.</p>");
                    } else {
                        out.println("<p>Erreur : Aucun film trouvé avec l'ID spécifié.</p>");
                    }

                    pstmt.close();
                } catch (Exception e) {
                    out.println("<p>Erreur : " + e.getMessage() + "</p>");
                }
            }
        }
    %>

    <!-- Exercice 4 : La valeur maximum -->
    <form action="ajout.jsp" method="post">
        <label for="nouveauTitreExercice4">Titre du nouveau film :</label>
        <input type="text" id="nouveauTitreExercice4" name="nouveauTitreExercice4" required>
        <label for="nouvelleAnneeExercice4">Année du nouveau film :</label>
        <input type="text" id="nouvelleAnneeEx






