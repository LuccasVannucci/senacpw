<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultado da Busca</title>
    <style>
        body{
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 0;
        }
        header {
    background-color: #1a2b2d;
    color: #fff;
    text-align: center;
    padding: 20px;
}
       h1 {
    font-size: 36px;
    margin: 0;
} 
.texto-com-borda {
    border: 1px solid black; 
    padding: 10px; 
    align-content: center;
    width: auto;
    height: auto;
}

resultSet {
      padding: 10px; 
    align-content: center;
    height: auto;
    width: auto;
    background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            margin: 20px;
            display: inline-block;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}
a{  text-decoration: none;
    display: inline-block;
    padding: 10px 20px;
    background-color: #13211d;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.2s;
}

    </style>
</head>

<body>
    <header>
         <h1>Resultado da Busca</h1>
    </header>
   
    <%
        String cpf = request.getParameter("cpf");
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Fazer a conexão com o Banco de Dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel", "root", "1234");

            // Consulta para encontrar a reserva com base no CPF
            String query = "SELECT * FROM reserva WHERE cpf = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, cpf);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Reserva encontrada
                String nome = resultSet.getString("nome");
                String email = resultSet.getString("email");
                String dataCheckin = resultSet.getString("data_checkin");
                String dataCheckout = resultSet.getString("data_checkout");
                String tipoQuarto = resultSet.getString("tipo_quarto");
                int quantidadePessoas = resultSet.getInt("Quantidade_de_pessoas");
               
                // Exiba os detalhes da reserva e opções de edição/exclusão
    %>
                <p class="texto-com-borda">Nome: <%= nome %></p>
                <p class="texto-com-borda">E-mail: <%= email %></p>
                <p class="texto-com-borda">Data de Check-In: <%= dataCheckin %></p>
                <p class="texto-com-borda">Data de Check-Out: <%= dataCheckout %></p>
                <p class="texto-com-borda">Tipo de Quarto: <%= tipoQuarto %></p>
                <p class="texto-com-borda">Quantidade de Pessoas: <%= quantidadePessoas %></p>
                

                <p><a href="atualizar.jsp?cpf=<%= cpf %>">Editar Reserva</a></p>
                <p><a href="excluir_reserva.jsp?cpf=<%= cpf %>">Excluir Reserva</a></p>
    <%
            } else {
                // Reserva não encontrada
    %>
                <p>Reserva não encontrada para o CPF fornecido.</p>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
            <p style='color: red;'>Ocorreu um erro ao buscar a reserva: <%= e.getMessage() %></p>
    <%
        } finally {
            // Fechar recursos
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
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
</body>
</html>