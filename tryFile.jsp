<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%

boolean DEBUG=true;

String db="interapp";
String usuario="interapp";
String passwd="oH3C7!Jo5PZw5Zfc";

Connection conn=null;
Statement stmt=null;
Statement stmt2=null;    //Catch:)
Statement stmt3=null;
ResultSet rs=null; //Equipo 1
ResultSet rs2=null; //Equipo 2

String sql=null; //equipo 1
String sql2=null; //equipo 2
String sql3=null; //insert into
String disciplina=null;
String rama=null;
String local=null;
String visitante=null;
String cancha=null;
String hora=null;
String seccion=null;

int a=0;
int b=0;

disciplina = request.getParameter("disciplina") == null ? "": request.getParameter("disciplina");
rama = request.getParameter("rama") == null ? "": request.getParameter("rama");
local = request.getParameter("local") == null ? "": request.getParameter("local");
visitante = request.getParameter("visitante") == null ? "": request.getParameter("visitante");
cancha = request.getParameter("cancha") == null ? "": request.getParameter("cancha");
hora = request.getParameter("hora") == null ? "": request.getParameter("hora");
seccion = request.getParameter("seccion") == null ? "": request.getParameter("seccion");

if (DEBUG)
{
	out.println("<br/>disciplina [" + disciplina + "]");
	out.println("<br/>rama [" + rama + "]");
	out.println("<br/>local [" + local + "]");
	out.println("<br/>visitante [" + visitante + "]");
	out.println("<br/>cancha [" + cancha + "]");
	out.println("<br/>hora [" + hora + "]");
	out.println("<br/>seccion [" + seccion + "]");
}

try{
	Class.forName("org.gjt.mm.mysql.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://arkesol.ddnsfree.com/"+db,usuario,passwd);
	
	stmt=conn.createStatement();
	stmt2=conn.createStatement();
	stmt3=conn.createStatement();
	
	sql="SELECT e.equipo_id FROM equipo e, rama r, delegaciones del, deporte dep, seccion s WHERE del.delegaciones_id=e.ID_D AND del.delegaciones_id ='"+local+"' AND r.rama_id = e.ID_R AND r.rama_id ='"+rama+"' AND dep.deporte_id=e.ID_De AND dep.deporte_id ='"+disciplina+"' AND s.seccion_id=e.ID_S AND s.seccion_id='" +seccion+"'";
	sql2="SELECT e.equipo_id FROM equipo e, rama r, delegaciones del, deporte dep, seccion s WHERE del.delegaciones_id=e.ID_D AND del.delegaciones_id ='"+visitante+"' AND r.rama_id = e.ID_R AND r.rama_id ='"+rama+"' AND dep.deporte_id=e.ID_De AND dep.deporte_id ='"+disciplina+"' AND s.seccion_id=e.ID_S AND s.seccion_id='" +seccion+"'";

	if (DEBUG) out.println("<br/><br>sql [" + sql + "]<br><br>sql2["+ sql2 +"]");
	
	
	rs=stmt.executeQuery(sql);
	
	System.out.println(sql);
	
		if(rs.next()){
			a = rs.getInt("equipo_id");
			System.out.println("<br><br>"+a);
		}
		
	rs2=stmt2.executeQuery(sql2);
		
	System.out.println(sql2);
		if(rs2.next()){
			b = rs2.getInt("equipo_id");
			System.out.println("<br><br>"+b);
		}
		
		
		//sql3="INSERT INTO partido(Fecha, ID_C, ID_Eq, ID_Eq2) VALUES ("+ hora +","+ cancha +","+ a +","+ b +");";	
		//sql3="INSERT INTO partido(ID_C, ID_Eq, ID_Eq2) VALUES ('"+ cancha +"','"+ a +"','"+ b +"')";
		//sql3="INSERT INTO partido(ID_C) VALUES ('1')";
		sql3="INSERT INTO partido(ID_C, ID_Eq, ID_Eq2) VALUES (" + cancha + "," + a + "," + b + ")";
		out.println("<br><br> sql3["+sql3+"]");
		
		int c=0; 
		stmt3.executeUpdate(sql3);
		
		
}
 
catch(SQLException e)
{
	out.println("SQLException caught: " + e.getMessage());
}
finally
{
	try{rs.close();} catch(Exception e){}
	try{rs2.close();} catch(Exception e){}
	//try{rs3.close();} catch(Exception e){}
	try{stmt.close();} catch(Exception e){}
	try{stmt2.close();} catch(Exception e){}
	try{stmt3.close();} catch(Exception e){}
	try{conn.close();} catch(Exception e){}
}

%>