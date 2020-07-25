<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("Localhost", request.getContextPath());
%>
<script type="text/javascript" src="${Localhost}/static/js/jquery-3.4.1.js"></script>
<link href="${Localhost}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="${Localhost}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工修改</h4>
      </div>
      <div class="modal-body">
		<form class="form-horizontal">
	  	<div class="form-group">
	    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
	    <div class="col-sm-10">
	     <p class="form-control-static" id="empName_update_static"></p>
	       <span class="help-block"></span>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword3" class="col-sm-2 control-label">email</label>
	    <div class="col-sm-10">
	      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
	       <span class="help-block"></span>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword3" class="col-sm-2 control-label">gender</label>
	    <div class="col-sm-10">
		 <label class="radio-inline">
			  <input type="radio" name="gender" id="gender1_update_input" value="M" > 男
			</label>
			<label class="radio-inline">
			  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
		</label>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword3" class="col-sm-2 control-label">deptName</label>
	    <div class="col-sm-4">
		 <select class="form-control" name="dId" id="dept_update_input"></select>
	    </div>
	  </div>
	  
</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" id="emp_close_btn">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
      </div>
    </div>
  </div>
</div>




<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
		<form class="form-horizontal">
	  	<div class="form-group">
	    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
	    <div class="col-sm-10">
	      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
	       <span class="help-block"></span>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword3" class="col-sm-2 control-label">email</label>
	    <div class="col-sm-10">
	      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
	       <span class="help-block"></span>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword3" class="col-sm-2 control-label">gender</label>
	    <div class="col-sm-10">
		 <label class="radio-inline">
			  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
			</label>
			<label class="radio-inline">
			  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
		</label>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword3" class="col-sm-2 control-label">deptName</label>
	    <div class="col-sm-4">
		 <select class="form-control" name="dId" id="dept_add_input"></select>
	    </div>
	  </div>
	  
</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" id="emp_close_btn">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>
		<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		
		<div class="row">
			 <div class="col-md-4 col-md-offset-8">
			 	<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
			 	<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			 </div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody id="tbody">
						
					</tbody>
				</table>
			</div>
			
		</div>

		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav_area"></div>
				</div>
		</div>
		<script type="text/javascript">
		var totalRecord,currentPage;
			$(function() {
				to_page(1);
			});
			
			function to_page(pn){
				$.ajax({
					url:"${Localhost}/emps",
					data:"pn="+pn,
					type:"GET",
				success:function(result){
						build_emps_table(result);
						build_page_info(result);
						build_page_nav(result);
					}
				});			
			};
			//表格信息
			function build_emps_table(result) {
				$("#tbody").empty();//清楚之前的缓存
				var emps = result.extend.PageInfo.list;
				$.each(emps,function(index,item){
					var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>")
					var empIdTd=$("<td></td>").append(item.empId);
					var empNameTd=$("<td></td>").append(item.empName);
					var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
					var emailTd=$("<td></td>").append(item.email);
					var deptNameTd=$("<td></td>").append(item.department.deptName);
					var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
					editBtn.attr("edit-id",item.empId);
					var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
					delBtn.attr("del-id",item.empId);
					var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
					$("<tr></tr>").append(checkBoxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btnTd)
					.appendTo("#tbody");	
				});
			}
			//分页信息
			function build_page_info(result) {
				$("#page_info_area").empty();
				$("#page_info_area").append("当前第"+
						result.extend.PageInfo.pageNum+"页,总共"+
						result.extend.PageInfo.pages+"页,总共"+
						result.extend.PageInfo.total+"条记录");
				totalRecord=result.extend.PageInfo.total;
				currentPage=result.extend.PageInfo.pageNum;
			}
			//分页条数据
			function build_page_nav(result) {
				$("#page_nav_area").empty();
				var ul=$("<ul></ul>").addClass("pagination");
				var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
				var prePageLi =$("<li></li>").append($("<a></a>").append("&laquo;"));
				if(result.extend.PageInfo.hasPreviousPage==false){
					firstPageLi.addClass("disabled");
					prePageLi.addClass("disabled");
				}else{
					firstPageLi.click(function(){
						to_page(1);
					});
					prePageLi.click(function(){
						to_page(result.extend.PageInfo.pageNum-1);
					});
				}
				var nextPageLi =$("<li></li>").append($("<a></a>").append("&raquo;"));
				var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
				if(result.extend.PageInfo.hasNextPage==false){
					nextPageLi.addClass("disabled");
					lastPageLi.addClass("disabled");
				}else{
					nextPageLi.click(function(){
						to_page(result.extend.PageInfo.pageNum+1);
					});
					lastPageLi.click(function(){
						to_page(result.extend.PageInfo.pages);
					});
				}
				ul.append(firstPageLi).append(prePageLi);
				$.each(result.extend.PageInfo.navigatepageNums,function(index,item){
					var numLi=$("<li></li>").append($("<a></a>").append(item));
					if(result.extend.PageInfo.pageNum==item){
						numLi.addClass("active");
					}
					numLi.click(function(){
						to_page(item);
					});
					ul.append(numLi);
				});
				ul.append(nextPageLi).append(lastPageLi);
				var navEle =$("<nav></nav>").append(ul);
				navEle.appendTo("#page_nav_area");
			}
			//清除模块缓存
			function reset_form(ele){
				$(ele)[0].reset();//javascript的方法 用[0]将jQuery装换为dom,reset()重置
				$(ele).find("*").removeClass("has-error has-success");
				$(ele).find(".help-block").text("");
			}
			//新增模块界面
			$("#emp_add_modal_btn").click(function(){
				reset_form("#empAddModal form");//表单的初始化
				getDepts("#dept_add_input");//加载部门
				$("#empAddModal").modal({//设置点击模块界面外不会关闭
					backdrop:"static"
				});
			})
			//部门信息加载
			function getDepts(ele) {
				$(ele).empty();
				$.ajax({
					url:"${Localhost}/depts",
					type:"get",
					success:function(result){
						$.each(result.extend.depts,function(index,item){
							var optionEle =$("<option></option>").append(item.deptName).attr("value",item.deptId);
							optionEle.appendTo(ele);
						})
					}
				})
			}
			//信息校验
			function validate_add_form(){
				var empName=$("#empName_add_input").val();
				var email=$("#email_add_input").val();
				var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
				var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if(regName.test(empName)==false){
					//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合!");
					show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合!");
						$("#email_add_input").parent().removeClass("has-success has-error");
						$("#email_add_input").next("span").text("");
						return false;
				}else{
					show_validate_msg("#empName_add_input","success","");
				};
				if(regEmail.test(email)==false){
					//alert("邮箱格式不正确!");
						show_validate_msg("#email_add_input","error","邮箱格式不正确!");
						return false;
					}else{
					show_validate_msg("#email_add_input","success","");
				};
				return true;
			}
			//信息校验包装方法
			function show_validate_msg(ele,status,msg){
				$(ele).parent().removeClass("has-success has-error");
				$(ele).next("span").text("");
				if(status=="success"){
					$(ele).parent().addClass("has-success");
					$(ele).next("span").text(msg);
				}else if(status=="error"){
					$(ele).parent().addClass("has-error");
					$(ele).next("span").text(msg);
				}
			}
			//校验名字的可用
			$("#empName_add_input").change(function(){
				var empName=this.value;
				$.ajax({
					url:"${Localhost}/checkuser",
					type:"POST",
					data:"empName="+empName,
					success:function(result){
						if(result.code == 100){
							show_validate_msg("#empName_add_input","success","用户名可用");
							$("#emp_save_btn").attr("ajax","success");
						}else{
							show_validate_msg("#empName_add_input","error",result.extend.vamsg);
							$("#emp_save_btn").attr("ajax","error");
						}
					}
				})
			});
			//校验邮箱
			$("#email_add_input").change(function(){
				var email=$("#email_add_input").val();
				var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if(regEmail.test(email)==false){
					//alert("邮箱格式不正确!");
						show_validate_msg("#email_add_input","error","邮箱格式不正确!");
						return false;
					}else{
					show_validate_msg("#email_add_input","success","邮箱可用");
				};
			})
			//保存按钮
			$("#emp_save_btn").click(function(){
				if(validate_add_form()==false){
					return false;
				}
				if($(this).attr("ajax")=="error"){
					show_validate_msg("#empName_add_input","error","用户名已存在");
					return false;
				}
				$.ajax({
					url:"${Localhost}/emp",
					type:"post",
					data:$("#empAddModal form").serialize(),
					success:function(result){
						if(result.code==100){
							$("#empAddModal").modal('hide');//关闭模态框
							to_page(totalRecord);
							alert(result.msg);
						}else{
							if(undefined != result.extend.errorFields.email){
								show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
							}
							if(undefined != result.extend.errorFields.empName){
								show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
							}
						}
						
					}
					
				})
			});
			//1.我们是按钮创建之前就绑定了click,所以绑定不上
			//2.使用on来替代
			$(document).on("click",".edit_btn",function(){
					getEmp($(this).attr("edit-id"));
					getDepts("#dept_update_input");
					$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
					$("#empUpdateModal").modal({//设置点击模块界面外不会关闭
						backdrop:"static"
					});
			})
			//获取单个员工信息
			function getEmp(id){
				$.ajax({
					url:"${Localhost}/emp/"+id,
					type:"get",
					success:function(result){
						var empData=result.extend.emp;
						$("#empName_update_static").text(empData.empName);
						$("#email_update_input").val(empData.email);
						$("#empUpdateModal input[name=gender]").val([empData.gender]);//单选框的选择方式val()等于相同值
						$("#empUpdateModal select").val([empData.dId]);
					}
				})
			}
			//更新按钮
			$("#emp_update_btn").click(function(){
				//1.校验邮箱
				var email=$("#email_update_input").val();
				var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if(regEmail.test(email)==false){
						show_validate_msg("#email_update_input","error","邮箱格式不正确!");
						return false;
					}else{
					show_validate_msg("#email_update_input","success","");
				};
				//2.ajax
				$.ajax({
					url:"${Localhost}/emp/"+$(this).attr("edit-id"),
					type:"POST",
					data:$("#empUpdateModal form").serialize()+"&_method=PUT",//数据需要加这个才能被识别
					success:function(result){
						alert(result.msg);
						$("#empUpdateModal").modal("hide");
						to_page(currentPage);
					} 
					
				})
			})
			//删除按钮
			$(document).on("click",".delete_btn",function(){
				var empName=$(this).parents("tr").find("td:eq(2)").text();
				if(confirm("确认删除["+empName+"]吗?")==true){
					$.ajax({
						url:"${Localhost}/emp/"+$(this).attr("del-id"),
						type:"DELETE",
						success:function(result){
							alert(result.msg);
							to_page(currentPage);
						}
					});
				}
			})
			//完成全选和全部选功能
			$("#check_all").click(function(){
				$(".check_item").prop("checked",$(this).prop("checked"));
			})
			//check_item
			$(document).on("click",".check_item",function(){
				var flag=$(".check_item:checked").length==$(".check_item").length;
				$("#check_all").prop("checked",flag);
			});
			//点击全部删除,就批量删除
			$("#emp_delete_all_btn").click(function(){
				var empNames="";
				var del_idstr="";
				$.each($(".check_item:checked"),function(){
					empNames +=$(this).parents("tr").find("td:eq(2)").text()+",";
					del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
				})
				empNames=empNames.substring(0,empNames.length-1);
				del_idstr=del_idstr.substring(0,del_idstr.length-1);
				if(confirm("确认删除["+empNames+"]吗?")==true){
					$.ajax({
						url:"${Localhost}/emp/"+del_idstr,
						type:"DELETE",
						success:function(result){
							alert(result.msg);
							to_page(currentPage);
						}
					});
				}
			});
		</script>
</body>
</html>