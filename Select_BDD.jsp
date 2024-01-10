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
    // Exemple de requête SQL
    String sql = "SELECT idFilm, titre, année FROM Film WHERE année >= 2000";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    // Afficher les résultats (à adapter selon vos besoins)
    while (rs.next()) {
        String colonne1 = rs.getString("idFilm");
        String colonne2 = rs.getString("titre");
        String colonne3 = rs.getString("année");
        // Faites ce que vous voulez avec les données...
        // Exemple d'affichage de 2 colonnes
        out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
    }

    // Fermer les ressources 
    rs.close();
    pstmt.close();
    conn.close();
    %>

    <h2>Exercice 1 : Les films entre 2000 et 2015</h2>
    <p>Extraire les films dont l'année est supérieur à l'année 2000 et inférieur à 2015.</p>

    <h1>Réponse Ex1</h1>
    <%
    // Re-utiliser la connexion existante
    String sql1 = "SELECT idFilm, titre, année FROM Film WHERE année >= 2000 AND année <= 2015";
    PreparedStatement pstmt1 = conn.prepareStatement(sql1);
    ResultSet rs1 = pstmt1.executeQuery();

    out.println("<h2>Exercice 1 : Les films entre 2000 et 2015</h2>");
    while (rs1.next()) {
        String colonne1 = rs1.getString("idFilm");
        String colonne2 = rs1.getString("titre");
        String colonne3 = rs1.getString("année");
        out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
    }

    // Fermer les ressources 
    rs1.close();
    pstmt1.close();
    %>

    <h2>Exercice 2 : Année de recherche</h2>
    <p>Créer un champ de saisie permettant à l'utilisateur de choisir l'année de sa recherche.</p>

    <form action="#" method="post">
        <label for="inputAnnee">Saisir une année :</label>
        <input type="text" id="inputAnnee" name="annee">
        <input type="submit" value="Rechercher">
    </form>

    <%
    String anneeRecherche = request.getParameter("annee");

    if (anneeRecherche != null && !anneeRecherche.isEmpty()) {
        String sql2 = "SELECT idFilm, titre, année FROM Film WHERE année = ?";
        PreparedStatement pstmt2 = conn.prepareStatement(sql2);
        pstmt2.setString(1, anneeRecherche);

        ResultSet rs2 = pstmt2.executeQuery();

        out.println("<h2>Résultats de la recherche pour l'année " + anneeRecherche + "</h2>");
        while (rs2.next()) {
            String colonne1 = rs2.getString("idFilm");
            String colonne2 = rs2.getString("titre");
            String colonne3 = rs2.getString("année");
            out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
        }

        rs2.close();
        pstmt2.close();
    }
    %>

    <h2>Exercice 3 : Modification du titre du film</h2>
    <p>Créer un formulaire permettant de modifier le titre d'un film sur la base de son ID (ID choisi par l'utilisateur)</p>

    <form action="#" method="post">
        <label for="inputIdFilm">ID du film :</label>
        <input type="text" id="inputIdFilm" name="idFilmAModifier">
        <label for="inputNouveauTitre">Nouveau titre :</label>
        <input type="text" id="inputNouveauTitre" name="nouveauTitre">
        <input type="submit" value="Modifier le titre">
    </form>

    <%
    String idFilmAModifier = request.getParameter("idFilmAModifier");
    String nouveauTitre = request.getParameter("nouveauTitre");

    if (idFilmAModifier != null && nouveauTitre != null && !idFilmAModifier.isEmpty() && !nouveauTitre.isEmpty()) {
        String sql3 = "UPDATE Film SET titre = ? WHERE idFilm = ?";
        PreparedStatement pstmt3 = conn.prepareStatement(sql3);
        pstmt3.setString(1, nouveauTitre);
        pstmt3.setString(2, idFilmAModifier);

        int rowsAffected = pstmt3.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<p>Modification du titre du film avec l'ID " + idFilmAModifier + " effectuée avec succès.</p>");
        } else {
            out.println("<p>Aucun film trouvé avec l'ID " + idFilmAModifier + ". Aucune modification effectuée.</p>");
        }

        pstmt3.close();
    }
    %>

    <h2>Exercice 4 : Ajout d'un nouveau film</h2>
    <p>Créer un formulaire permettant d'ajouter un nouveau film (titre et année saisis par l'utilisateur).</p>

    <form action="#" method="post">
        <label for="inputNouveauTitreFilm">Titre du nouveau film :</label>
        <input type="text" id="inputNouveauTitreFilm" name="nouveauTitreFilm">
        <label for="inputNouvelleAnneeFilm">Année du nouveau film :</label>
        <input type="text" id="inputNouvelleAnneeFilm" name="nouvelleAnneeFilm">
        <input type="submit" value="Ajouter le nouveau film">
    </form>

    <%
    String nouveauTitreFilm = request.getParameter("nouveauTitreFilm");
    String nouvelleAnneeFilm = request.getParameter("nouvelleAnneeFilm");

    if (nouveauTitreFilm != null && nouvelleAnneeFilm != null && !nouveauTitreFilm.isEmpty() && !nouvelleAnneeFilm.isEmpty()) {
        String sql4 = "INSERT INTO Film (titre, année) VALUES (?, ?)";
        PreparedStatement pstmt4 = conn.prepareStatement(sql4);
        pstmt4.setString(1, nouveauTitreFilm);
        pstmt4.setString(2, nouvelleAnneeFilm);

        int rowsAffected = pstmt4.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<p>Ajout du nouveau film \"" + nouveauTitreFilm + "\" effectué avec succès.</p>");
        } else {
            out.println("<p>Erreur lors de l'ajout du nouveau film. Aucune modification effectuée.</p>");
        }

        pstmt4.close();
    }
    %>


</body>
</html>

