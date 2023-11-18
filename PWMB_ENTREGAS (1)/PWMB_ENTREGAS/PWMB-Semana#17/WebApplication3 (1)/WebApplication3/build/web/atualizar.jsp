<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Informações</title>
    <style>
 /* Estilos gerais para o corpo da página */
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    min-height: 100vh;
}

/* Estilos para o cabeçalho */
header {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 10px;
    text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5);
    font-family: 'Rubik', sans-serif;
    width: 100%;
}

/* Estilos para o formulário */
form {
    width: 100%;
    max-width: 400px; /* Define a largura máxima do formulário */
    padding: 20px;
    text-align: center;
}

/* Estilos para rótulos e campos de entrada */
label {
    font-weight: bold;
    display: block;
    margin-top: 10px;
}

input {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

select {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    height: 40px;
}

/* Estilos para o botão de envio */
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
    <h1>Editar Informações</h1>
    <form action="atualizar.jsp" method="post">
        <label>CPF usado no registro: </label>
        <input type="text" name="cpf"><br>
        <label>Email: </label>
        <input type="text" name="email" value=""><br>
        <label>Data de Check-in:</label>
        <input type="date" name="data_checkin" required><br>
        <label>Data de Check-out:</label>
        <input type="date" name="data_checkout" required><br>
        <label>Tipo de Quarto: </label>
        <select name="tipoQuarto">
            <option value="standard">Standard</option>
            <option value="luxo">Luxo</option>
            <option value="suíte">Suíte</option>
        </select>
        <label>Quantidade de Pessoas:</label>
        <input type="text" name="quantidadePessoas" value=""><br>
        <button type="submit">Salvar</button>
    </form>
        <script>
    const checkinInput = document.querySelector('input[name="data_checkin"]');
    const checkoutInput = document.querySelector('input[name="data_checkout"]');
    
    const hoje = new Date();
    const anoAtual = hoje.getFullYear();
    const mesAtual = hoje.getMonth() + 1; // Os meses em JavaScript são zero-indexed, então adicionamos 1.

    checkinInput.addEventListener('input', () => {
      const checkinDate = new Date(checkinInput.value);
      const checkoutDate = new Date(checkoutInput.value);
      
      if (checkinDate < hoje) {
        alert('Você não pode selecionar uma data de check-in anterior ao mês e ano atual.');
        checkinInput.value = '';
      }
      
      if (checkoutDate < checkinDate) {
        alert('A data de check-out não pode ser anterior à data de check-in.');
        checkoutInput.value = '';
      }
    });

    checkoutInput.addEventListener('input', () => {
      const checkinDate = new Date(checkinInput.value);
      const checkoutDate = new Date(checkoutInput.value);
      
      if (checkoutDate < checkinDate) {
        alert('A data de check-out não pode ser anterior à data de check-in.');
        checkoutInput.value = '';
      }
    });
</script>

    <%
        String cpf = request.getParameter("cpf");
        String email = request.getParameter("email");
        String dataCheckin = request.getParameter("data_checkin");
        String dataCheckout = request.getParameter("data_checkout");
        String tipoQuarto = request.getParameter("tipoQuarto");
        String quantidadePessoas = request.getParameter("quantidadePessoas");

        if (cpf != null && !cpf.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel", "root", "1234");

                String sql = "UPDATE reserva SET email=?, data_checkin=?, data_checkout=?, tipo_quarto=?, Quantidade_de_pessoas=? WHERE cpf=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, dataCheckin);
                stmt.setString(3, dataCheckout);
                stmt.setString(4, tipoQuarto);
                stmt.setString(5, quantidadePessoas);
                stmt.setString(6, cpf);

                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("Informações atualizadas com sucesso.");
                } else {
                    out.println("Nenhum registro atualizado.");
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
