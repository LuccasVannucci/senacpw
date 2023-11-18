<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Reserva - Resultado</title>
    <link rel="stylesheet" href="styl.css">
</head>
<body>
    <header>
        <h1>Editar Reserva - Resultado</h1>
    </header>
    
    
        <%
String cpf = request.getParameter("cpf");
String nome = request.getParameter("nome");
String email = request.getParameter("email");
String dataCheckin = request.getParameter("data_checkin");
String dataCheckout = request.getParameter("data_checkout");
String tipoQuarto = request.getParameter("tipo_quarto");

int quantidadePessoas = 0; // Inicialize com um valor padrão

String quantidadePessoasString = request.getParameter("Quantidade_pessoas");
if (quantidadePessoasString != null && !quantidadePessoasString.isEmpty()) {
    try {
        quantidadePessoas = Integer.parseInt(quantidadePessoasString);
    } catch (NumberFormatException e) {
        // Trate o erro de conversão aqui, se necessário
        e.printStackTrace();
    }
}

Connection connection = null;
PreparedStatement statement = null;

            try {
                // Fazer a conexão com o Banco de Dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel", "root", "1234");

                // Atualizar a reserva no banco de dados
                String query = "UPDATE reserva SET nome=?, email=?, data_checkin=?, data_checkout=?, tipo_quarto=?, Quantidade_de_pessoas=? WHERE cpf=?";
                statement = connection.prepareStatement(query);
                statement.setString(1, nome);
                statement.setString(2, email);
                statement.setString(3, dataCheckin);
                statement.setString(4, dataCheckout);
                statement.setString(5, tipoQuarto);
                statement.setInt(6, quantidadePessoas);
                statement.setString(7, cpf);

                int rowsUpdated = statement.executeUpdate();

                if (rowsUpdated > 0) {
        %>
                    <p>Reserva atualizada com sucesso!</p>
        <%
                } else {
        %>
                    <p style="color: red;">Não foi possível atualizar a reserva.</p>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
                <p style="color: red;">Ocorreu um erro ao atualizar a reserva: <%= e.getMessage() %></p>
        <%
            } finally {
                // Fechar recursos
                try {
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    
    <footer>
        <p>&copy; 2023 Hotel Água Branca</p>
    </footer>
</body>
</html>
