<html>
<head>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.InitialContext, javax.naming.Context" %>
</head>
<body>
	<%
	/*Testing  */
	/*initCtx를 중심으로 resource를 찾을 수 있도록  */
	/* 소스를 발견하면 실제로 적용할 수 있도록 */
	/* url 주소에 접근 */
	/* statement는 실제로 sql문장을  그 결과를 반환시켜주는 역할*/
		InitialContext initCtx = new InitialContext();
		Context envContext = (Context)initCtx.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/UserChat");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT VERSION();");
		while(rs.next()){
			out.println("mysql version ="+rs.getString("version()"));
		}
		rs.close();
		stmt.close();
		conn.close();
		initCtx.close();
	%>

</body>
</html>