<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        p{
            align-content: center;
            font-size: 23px;  
        }
    </style>
</head>
<body>
<%
    // Receber os dados do formulário
    String nome = request.getParameter("nome");
    String cpf = request.getParameter("cpf");
    String email = request.getParameter("email");
    String dataCheckin = request.getParameter("data_checkin");
    String dataCheckout = request.getParameter("data_checkout");
    String tipoQuarto = request.getParameter("tipo_quarto");
    int quantidadePessoas = Integer.parseInt(request.getParameter("pessoas"));

    try {
        // Fazer a conexão com o Banco de Dados
        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel", "root", "1234");

        st = conecta.prepareStatement("INSERT INTO reserva (nome, cpf, email, data_checkin, data_checkout, tipo_quarto, Quantidade_de_pessoas) VALUES (?, ?, ?, ?, ?, ?, ?)");
        st.setString(1, nome);
        st.setString(2, cpf);
        st.setString(3, email);
        st.setString(4, dataCheckin);
        st.setString(5, dataCheckout);
        st.setString(6, tipoQuarto);
        st.setInt(7, quantidadePessoas);
        st.executeUpdate(); // Executa o comando INSERT
%>
        <p>Cadastro realizado com sucesso</p>
        <script>
            window.open('contato.html');
        </script>
<%
    } catch (Exception x) {
        String erro = x.getMessage();
        out.print("<p style='color: red; font-size: 15px'>Mensagem de erro:" + erro + "</p>");
    }
%>
</body>
</html>
