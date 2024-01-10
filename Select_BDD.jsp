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
    %>
    <form action="" method="post">
        <label for="annee">Année de recherche :</label>
        <input type="text" id="annee" name="annee" required>
        <button type="submit">Rechercher</button>
    </form>

    <% 
        // Exercice 3 : Modification du titre du film
    %>
    <form action="" method="post">
        <label for="filmId">ID du film à modifier :</label>
        <input type="text" id="filmId" name="filmId" required>
        <label for="nouveauTitre">Nouveau titre :</label>
        <input type="text" id="nouveauTitre" name="nouveauTitre" required>
        <button type="submit">Modifier</button>
    </form>

    <% 
        // Exercice 4 : La valeur maximum
    %>
    <form action="" method="post">
        <label for="nouveauTitre">Titre du nouveau film :</label>
        <input type="text" id="nouveauTitre" name="nouveauTitre" required>
        <label for="nouvelleAnnee">Année du nouveau film :</label>
        <input type="text" id="nouvelleAnnee" name="nouvelleAnnee" required>
        <button type="submit">Ajouter</button>
    </form>

    <% 
        // Fermer la connexion
        conn.close();
    %>
</body>
</html>



