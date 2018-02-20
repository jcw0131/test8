<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");

	response.setHeader("Cache-control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>style test</title>
<script language="JavaScript" type="text/JavaScript">
	var xhrObject;

	function createXHR() 
	{
		if (window.ActiveXObject) 
		{
			xhrObject = new ActiveXObject("Microsoft.XMLHTTP");
		} 
		else if (window.XMLHttpRequest) 
		{
			xhrObject = new XMLHttpRequest();
		}
	}

	function getData() {
		var form_name = "form_main";
		var goods_name = document.forms[form_name].elements["txt_goods_name"].value;
		createXHR();
		var url="./testDB.jsp";
		//var url = "./testFile.jsp";
		var reqparam = "goods_name=" + goods_name;
		//alert(reqparam);
		xhrObject.onreadystatechange = resGetData;
		//alert(resGetData);
		xhrObject.open("Post", url, "true");
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		xhrObject.send(reqparam);
	}

	function resGetData() {
		if (xhrObject.readyState == 4) {
			if (xhrObject.status == 200) {
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
				var num = objRes.datas.length;
				var res = "<table align='center' cellpadding='3' cellspacing='1' border='1' width='980'>";
// 				res += "<form name='form_table' onSubmit='javascript:return false;'>";
				var resDiv = document.getElementById("div_res");//HTML 요소 찾아옴.
				
//				resDiv.invisible;

				if (num < 1) {
					res += "<tr><td width='980' height='100' align='center' style='font-size:50;'>검색결과가 없습니다.</td></tr>";
				} else 
					{
					res +="<tr>";
					res +="<td width='30' heigh='100' align='center' style='font-size:30' bgcolor='#D0E6FC'>NAME</td>";
					res +="<td width='30' heigh='100' align='center' style='font-size:30' bgcolor='#D0E6FC'>CODE</td>";
					res +="<td width='30' heigh='100' align='center' style='font-size:30' bgcolor='#D0E6FC'>NUM</td>";
					res +="<td width='30' heigh='100' align='center' style='font-size:30' bgcolor='#D0E6FC'>PDATE</td>";
					res +="<td width='30' heigh='100' align='center' style='font-size:30' bgcolor='#D0E6FC'>CONTENTS</td>";
					res +="<td width='30' heigh='100' align='center' style='font-size:30' bgcolor='#D0E6FC'>STATE</td>";
					res +="<td width='10' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>UPDATE</td>";
					res +="<td width='10' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>DELETE</td>";
					res +="</tr>";
					for (var i = 0; i < num; i++) {//받은 데이터를 html로 전송
						var goods_name = objRes.datas[i].NAME;
						var goods_code = objRes.datas[i].CODE;
						var goods_num = objRes.datas[i].NUM;
						var goods_pdate = objRes.datas[i].PDATE;
						var goods_contents = objRes.datas[i].CONTENTS;
						var goods_state = objRes.datas[i].STATE;
						
						
						
						
						res +="<tr>";
						res +="<td width='30' align='center' style='font-size:20' bgcolor='#FFFCC'>"+goods_name+"</td>";
						res +="<td width='30' align='center' style='font-size:30' bgcolor='#FFFCC'>"+goods_code+"</td>";
						res +="<td width='30' align='center' style='font-size:30' bgcolor='#FFFCC'>"+goods_num+"</td>";
 						res +="<td width='30' align='center' style='font-size:20' bgcolor='#FFFCC'>"+goods_pdate+"</td>";
 						res +="<td width='30' align='center' style='font-size:30' bgcolor='#FFFCC'>"+goods_contents+"</td>";
 						res +="<td width='30' align='center' style='font-size:30' bgcolor='#FFFCC'>"+goods_state+"</td>";
 						res +="<td width='30' align='center'><input type='button' value='수정' onClick='javascript:openUpDate(\""+goods_name+"\");'></td>";
 						res +="<td width='30' align='center'><input type='button' value='삭제' onClick='javascript:deleteData(\""+goods_name+"\");'></td>";
						res +="</tr>";
						
						
						
						
						/*원본
						res += "<tr>";
						res += "<td width='980' height='100' align='center' style='font-size:50' bgcolor='#D0E6FC'>"+ user_id + "</td>";
						res += "</tr>";

						res += "<tr>";
						res += "<td width='980' align='center' style='font-size:50' bgcolor='#FFFCC'><br>"+ user_name + "<br></td>";
						res += "</tr>";
						res += "<tr>";
						res += "<td width='980' align='center' style= 'font-size:50' bgcolor='#FFFFCC'><br>"+ user_phone + "<br></td>";
						res += "</tr>";
						*/
						
					}
				}
// 				res += "</form>";
				res += "</table>";
				resDiv.innerHTML = res;
			}
		}
	}

	function searchData() {
		var form_name = "form_main";
		var goods_name = document.forms[form_name].elements["txt_goods_name"].value;
		//alert(goods_name);
		if (goods_name == "") {
			//alert("user_id를 입력해주세요");
			document.forms[form_name].elements["txt_goods_name"].focus();
			return;
		} else {
			//user_id 검색
			getData();
		}
	}
	
	
	
	function insertData(){
		var form_name ="form_insert";
		var set_goods_name =document.forms[form_name].elements["set_goods_name"].value;
		var set_goods_code =document.forms[form_name].elements["set_goods_code"].value;
		var set_goods_num =document.forms[form_name].elements["set_goods_num"].value;
		var set_goods_contents =document.forms[form_name].elements["set_goods_contents"].value;
		var set_goods_state =document.forms[form_name].elements["set_goods_state"].value;
// 		alert(set_user_grade);
		
		
		createXHR();
		//alert("url");
		var url="./testDB3_insert.jsp";
		//var url = "./testFile.jsp";
		//alert(url);
		var reqparam = "";
		reqparam += "set_goods_name=" + set_goods_name;//여러개 추가시에 += , & 붙여준다
		reqparam += "&set_goods_code="+set_goods_code;
		reqparam += "&set_goods_num=" +set_goods_num;
		reqparam += "&set_goods_contents=" +set_goods_contents;
		reqparam += "&set_goods_state=" +set_goods_state ;
 		alert(reqparam);
// 		xhrObject.onreadystatechange = resGetData;
		xhrObject.open("Post", url, "true");
		//alert("open");
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		xhrObject.send(reqparam);
		
	}
	
	function deleteData(name){
		//alert();
		alert(name+" delStart");
		createXHR();
		var url="./testDB3_delete.jsp";
		//var url = "./testFile.jsp";
		var reqparam = "goods_name=" + name;
		alert(reqparam);
		xhrObject.onreadystatechange = resDelData;
		xhrObject.open("Post", url, "true");
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		xhrObject.send(reqparam);
	}
	
	function resDelData() {
		if (xhrObject.readyState == 4) {
			if (xhrObject.status == 200) {
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
// 				var num = objRes.datas.length;
				var ok = objRes[0].length;
				
//				alert(ok)
				
				var res = "<table align='center' cellpadding='3' cellspacing='1' border='1' width='980'>";
// 				res += "<form name='form_table' onSubmit='javascript:return false;'>";
				var resDiv = document.getElementById("div_res");//HTML 요소 찾아옴.
				
//				resDiv.invisible;

				if (ok < 1) {
					alert("삭제 null");
				} 
				else
				{
// 					alert("삭제 1 or 0");
					if(objRes[0].RESULT_OK == "1")
					{
						alert("삭제 성공")
						getData();
					}
					else
						alert("삭제 실패")
				}


				resDiv.innerHTML = res;
			}
		}
	}
	function openUpDate(){
		var resDiv = document.getElementById("div_update");//HTML 요소 찾아옴.
		
		resDiv.visible;
	}
	function getfileInfo(){
		var form_name ="form_res";
		var set_file_name =document.forms[form_name].elements["txt_file_name"].value;
		alert(set_file_name);
		createXHR();
		var url="./testDB3_fileout.jsp";
		var reqparam = "set_file_name=" + set_file_name;
		xhrObject.onreadystatechange = resGetData;
		//alert(resGetData);
		xhrObject.open("Post", url, "true");
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		xhrObject.send(reqparam);
	}
	
	
// 	function searchButton(e){
// 		alert("press'ENTER'")
// 		if(e.keyCode==13){
// 			searchData();
// 		}
// 	}

</script>


</head>

<body>
	<div id='div_main' width='980' height='300' style="visibility: visible; position: absolute; left: 0px; top: 100px; z-index: 1;">
		<table border='0' width='980' cellpadding='0' cellspacing='0'>
			<form name="form_main" onSubmit="javascript:return false;">
				
<!-- 				<table border='1' width='980' cellpadding='0' cellspacing='0'> -->
<!-- 					<tr> -->
<!-- 						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>NAME</td> -->
<!-- 						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>CODE</td> -->
<!-- 						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>NUM</td> -->
<!-- 						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>CONTENTS</td> -->
<!-- 						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>STATE</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td width='100'><input type='text' name='set_goods_name' size='10' value='' maxlength='10' style='width:200px; font-size:20; text-align:center'></td> -->
<!-- 						<td width='100'><input type='text' name='set_goods_code' size='10' value='' maxlength='10' style='width:200px; font-size:20; text-align:center'></td> -->
<!-- 						<td width='100'><input type='text' name='set_goods_num' size='10' value='' maxlength='10' style='width:200px; font-size:20; text-align:center'></td> -->
<!-- 						<td width='100'><input type='text' name='set_goods_contents' size='10' value='' maxlength='15' style='width:200px; font-size:20; text-align:center'></td> -->
<!-- 						<td width='100'><input type='text' name='set_goods_state' size='10' value='' maxlength='15' style='width:200px; font-size:20; text-align:center'></td> -->
<!-- 						<td width='100'><input type="button" name='upload_button' value='업로드' onClick='javascript:insertData();'></td> -->
<!-- 					</tr> -->
<!-- 				</table> -->
				<tr>
					<td width='800'></td>
				</tr>
				<tr>
					
					<td width='800' align="center"><input type='text' name='txt_goods_name' size='10' value='' maxlength='10' style='width: 450px; font-size: 50; text-align: left' onkeypress="javascript:if(event.keyCode == 13)searchData();"></td>
					<td width='100'><img src='./img/search.gif' name='searchButton' align="middle" width='100'	height='50' onClick='javascript:searchData();'></td>
					
				</tr>
			</form>
		</table>
	</div>

	
	<div id='div_update' width='980'style="visibility: invisible; position: absolute; left: 10px; top: 200px; z-index: 1;">
		<table border='1' width='980' cellpadding='0' cellspacing='0'>
			<form name="form_insert" onSubmit="javascript:return false;">	
					<tr>
						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>NAME</td>
						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>CODE</td>
						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>NUM</td>
						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>CONTENTS</td>
						<td width='20' heigh='100' align='center' style='font-size:20' bgcolor='#D0E6FC'>STATE</td>
					</tr>
					<tr>
						<td width='100'><input type='text' name='set_goods_name' size='10' value='' maxlength='10' style='width:200px; font-size:20; text-align:center'></td>
						<td width='100'><input type='text' name='set_goods_code' size='10' value='' maxlength='10' style='width:200px; font-size:20; text-align:center'></td>
						<td width='100'><input type='text' name='set_goods_num' size='10' value='' maxlength='10' style='width:200px; font-size:20; text-align:center'></td>
						<td width='100'><input type='text' name='set_goods_contents' size='10' value='' maxlength='15' style='width:200px; font-size:20; text-align:center'></td>
						<td width='100'><input type='text' name='set_goods_state' size='10' value='' maxlength='15' style='width:200px; font-size:20; text-align:center'></td>
						<td width='100'><input type="button" name='setload_button' value='업로드' onClick='javascript:insertData();'></td>
					</tr>
			</form>
		</table>
	</div>
	
	<div id='div_res' width='980'style="visibility: visible; position: absolute; left: 10px; top: 300px; z-index: 1;">
		<table border='1' width='980' cellpadding='10' cellspacing='0'>
			<form name="form_res" onSubmit="javascript:return false;">
			<tr>
				<td align='center' style='width: 950px; font-size: 50;'	bgcolor='#FFFFCC'>결과물</td>
				<td width='245' align='center'><input type="button" align='center' value='전체 목록' onClick='javascript:getData();'>
				<td width='245' align="center"><input type='text' name='txt_file_name' size='10' value='' maxlength='10' style='width: 150px; font-size: 10; text-align: left'></td>
				<td width='100' align='center'><input type="button" align='center' value='파일출력' onClick='javascript:getfileInfo();'>
			</tr>
			</form>
		</table>
	</div>
</body>
</html>