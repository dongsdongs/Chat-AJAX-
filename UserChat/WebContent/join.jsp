<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css" />
	<link rel="stylesheet" href="css/custom.css" />
	<title>Chat for Ajax/Jsp</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	<script type="text/javascript">
		function registerCheckFunction(){
			var userID = $('#userID').val();
			$.ajax({
				type:'POST',
				url: './UserRegisterCheckServlet',
				data: {userID: userID},
				success : function(result){
					if(result == 1){
						$('#checkMessage').html('사용할 수 있는 아이디 입니다.');
						$('#checkType').attr('class','modal-content panel-success');
					}else{
						$('#checkMessage').html('사용할 수 없는 아이디 입니다.');
						$('#checkType').attr('class','modal-content panel-warning');
					}
					$('#checkModal').modal("show");
				}
			});
		}
		
		function passwordCheckFunction(){
			var userPassword1 = $('#userPassword1').val();
			var userPassword2 = $('#userPassword2').val();
			if(userPassword1 != userPassword2){
				$('#passwordCheckMessage').html('비밀번호가 일치하지 않습니다.');
			}else{
				$('#passwordCheckMessage').html('');
			}
			
		}
		
	</script>
</head>
<body>
	<%
		String userID =  null;
		if(session.getAttribute("userID")!= null){
			userID = (String)session.getAttribute("userID");
		}
	
		if(userID != null){
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "현재 로그인이 되어 있는 상태입니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
	%>
	
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
			data-target="#bs-example-navbar-collapse-1" aria-expanded="false" >
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">Ajax Chatting</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" aria-expanded="false">
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">Main Page</a>
				<li><a href="find.jsp">친구 찾기</a>
			</ul> 
			<%
				if(userID == null){
			%>	
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"	data-toggle="dropdown" role="buton" aria-haspopup="true" aria-expanded="false">
						접속하기<span class="caret"></span>
					
					</a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">login</a></li>
						<li class="active"><a href="join.jsp">join</a></li>
					</ul>
				</li>
			</ul>					
			<%
				}
			%>
		</div>
	</nav>
	
	
	<div class="container">
		<form method="post" action="./UserRegisterServlet">
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>회원등록양식</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="width: 110px;"><h5>ID*</h5></th>
						<td>
							<input class="form-control" type="text" id="userID" name="userID" maxlength="20" placeholder="input ID"/>
						</td>
						<td style="width: 110px;">
							<button class="btn btn-primary" onclick="registerCheckFunction();" type="button">중복체크</button>
						</td>
					</tr>
					<tr>
						<th style="width: 110px;"><h5>Password*</h5></th>
						<td colspan="2">
							<input onkeyup="passwordCheckFunction();" class="form-control" id="userPassword1" type="password" name="userPassword1" maxlength="20" placeholder="input PASSWORD"/>
						</td>
					</tr>
					<tr>
						<th style="width: 110px;"><h5>Password Check*</h5></th>
						<td colspan="2">
							<input onkeyup="passwordCheckFunction();" class="form-control" id="userPassword2" type="password" name="userPassword2" maxlength="20" placeholder="check PASSWORD"/>
						</td>
					</tr>
					
					<tr>
						<th style="width: 110px;"><h5>Name*</h5></th>
						<td colspan="2">
							<input class="form-control" id="userName" type="text" name="userName" maxlength="10" placeholder="input your Name"/>
						</td>
					</tr>
					
					<tr>
						<th style="width: 110px;"><h5>Age*</h5></th>
						<td colspan="2">
							<input class="form-control" id="userAge" type="number" name="userAge" maxlength="5" placeholder="input your Age"/>
						</td>
					</tr>
					
					<tr>
						<th style="width: 110px;"><h5>Gender*</h5></th>
						<td colspan="2">
							<div class="form-group" style="text-align:center; magin: 0 auto">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-primary active">
										<input type="radio" name="userGender" autoComplete="off" value="남자" checked/>남자
									</label>
									<label class="btn btn-primary">
										<input type="radio" name="userGender" autoComplete="off" value="여자" /> 여자
									</label>
									
								</div>
							</div>
						</td>
					</tr>
					
					<tr>
						<th style="width: 110px;"><h5>Email*</h5></th>
						<td colspan="2">
							<input class="form-control" id="userEmail" type="email" name="userEmail" maxlength="20" placeholder="input your Email"/>
						</td>
					</tr>
					
					<tr>
						<td style="text-align: left;" colspan="3"><h5 style="color:red;" id="passwordCheckMessage"></h5>
							<input type="submit" class="btn btn-primary pull-right" value="등록">
						</td>
					</tr>					
					
				</tbody>
				
			</table>
		</form>
	</div>
	<%
		String messageContent = null;
		if(session.getAttribute("messageContent")!=null){
			messageContent = (String)session.getAttribute("messageContent");
		}
		String messageType = null;
		if(session.getAttribute("messageContent")!=null){
			messageType = (String)session.getAttribute("messageType");
		}
		if(messageContent != null){
	%>
		<!--bootstrap에서 제공  -->
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div class="modal-content <%if(messageType.equals("오류 메시지")) out.println("panel-warning"); else out.println("panel-success"); %>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%=messageType %>
						</h4>
					</div>
					<div class="modal-body">
						<%=messageContent %>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$('#messageModal').modal("show");
		</script>
		
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
		
	%>
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							확인메시지
						</h4>
					</div>
					<div id="checkMessage" class="modal-body">
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
					</div>
				</div>
			</div>
	</div>
	
	
</body>
</html>