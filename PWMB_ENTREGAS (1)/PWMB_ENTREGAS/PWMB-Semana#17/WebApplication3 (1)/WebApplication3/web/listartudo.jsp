<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listagem de Reservas</title>
    <Style>  body{
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
   

.texto-com-borda {
    
    display: table-cell;
    padding: 8px; 
    border: 1px solid #000; 
    background-color: #f0f0f0; 
    font-weight: bold;
    align-content: center;
    
}

reserva{
    padding: 10px;
    height: 100px;
    width: 50px;
    background-color: #fff;
    border-radius: 10px;
    padding: 30px 20px;
    margin: 20px;
    display: inline-block;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}
</style>
</head>
<body>
    <header>
        <h1>Listagem de Reservas</h1>
    </header>
    
   

    <%
        if (request.getParameter("listReservas") != null) {
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                // Fazer a conexão com o Banco de Dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel", "root", "1234");

                // Consulta para obter todas as reservas
                String query = "SELECT * FROM reserva";
                statement = connection.prepareStatement(query);
                resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    // Recupere os detalhes da reserva
                    String cpf = resultSet.getString("cpf");
                    String nome = resultSet.getString("nome");
                    String email = resultSet.getString("email");
                    String dataCheckin = resultSet.getString("data_checkin");
                    String dataCheckout = resultSet.getString("data_checkout");
                    String tipoQuarto = resultSet.getString("tipo_quarto");
                    int quantidadePessoas = resultSet.getInt("Quantidade_de_pessoas");
    %>
    <div class = "reserva">
                        <p class="texto-com-borda">CPF: <%= cpf %></p>
                        <p class="texto-com-borda">Nome: <%= nome %></p>
                        <p class="texto-com-borda">E-mail: <%= email %></p>
                        <p class="texto-com-borda">Data de Check-In: <%= dataCheckin %></p>
                        <p class="texto-com-borda">Data de Check-Out: <%= dataCheckout %></p>
                        <p class="texto-com-borda">Tipo de Quarto: <%= tipoQuarto %></p>
                        <p class="texto-com-borda">Quantidade de Pessoas: <%= quantidadePessoas %></p>
                    
    </div>
                    
                       
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
    %>
                <p style='color: red;'>Ocorreu um erro ao listar as reservas: <%= e.getMessage() %></p>
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
        }
    %>
</body>
</html>
