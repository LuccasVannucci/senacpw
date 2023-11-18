<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Excluir Informações</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        header {
            background-color: #1f2e2c;
            color: #fff;
            text-align: center;
            padding: 10px;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
            font-family: 'Rubik', sans-serif;
            margin: 0;
            width: 100%;
        }

        .container {
            width: 100%;
            max-width: 400px;
            padding: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            text-align: center;
            margin-top: 10px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        button {
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            margin-top: 15px;
        }

        button:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <h1>Excluir Informações</h1>
    <div class="container">
        <form id="deleteForm" method="post">
            <label for="cpf">CPF da linha a ser excluída: </label>
            <input type="text" id="cpf" name="cpf" required><br>
            <button type="button" onclick="deleteInfo()">Excluir</button>
        </form>
    </div>

    <%
        String cpf = request.getParameter("cpf");

        if (request.getMethod().equals("POST") && cpf != null && !cpf.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel", "root", "1234");

                String sql = "DELETE FROM reserva WHERE cpf=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, cpf);

                int rowsDeleted = stmt.executeUpdate();

                if (rowsDeleted > 0) {
                    out.println("Informações excluídas com sucesso.");
                } else {
                    out.println("Nenhum registro encontrado. Verifique se o CPF é válido.");
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>

    <script>
        function deleteInfo() {
            var cpf = document.getElementById("cpf").value;
            if (cpf) {
                document.getElementById("deleteForm").submit();
            }
        }
    </script>
</body>
</html>
