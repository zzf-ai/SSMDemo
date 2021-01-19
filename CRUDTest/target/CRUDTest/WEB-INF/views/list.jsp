<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <script type="text/javascript" src="${APP_PATH}/static/jquery-3.4.1/jquery-3.4.1.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        var totalRecord,currentPage;//全局总页数，当前页面

        //点击全选当前页面的记录
        function checkAllBox() {
            //alert(111)
            //全选
            $(".check_item").prop("checked",$("#checkAll").prop("checked"));
        }

        //点击选中
        $(document).on("click",".check_item",function () {
            //判断当前选中的元素是否为当前页面记录数
            var flag=$(".check_item:checked").length==$(".check_item").length;
            $("#checkAll").prop("checked",flag);
        });

        //批量删除
        function deleteBatch() {
            var empNames="";
            var del_idstr="";
            $.each($(".check_item:checked"),function () {
                empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
                del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            empNames=empNames.substring(0,empNames.length-1);
            del_idstr=del_idstr.substring(0,del_idstr.length-1);
            if(confirm("确认删除【"+empNames+"】吗?")){
                $.ajax({
                    url:"${APP_PATH}/empDelete/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                })
            }
        }

        //清空表单样式和数据
        function resetForm(element){
            if(element.indexOf("Add")!=-1){
                $(element)[0].reset();
            }
            $(element).find("*").removeClass("has-success has-error");
            $(element).find(".help-block").text("");
        }

        //打开添加模态框
        function empAdd(){
            //清除之前的数据
            resetForm("#empAddModal form");
            getDepts("#empAddModal select");
            $("#empAddModal").modal({
                backdrop:"static"
            });
        }
        //添加校验
        function validateAddForm() {
            var empName=$("#inputempName").val();
            if(empName==null||empName==''){
                showValidateMsg("#inputempName","error","请输入员工姓名");
                return false;
            }else{
                showValidateMsg("#inputempName","success","");
            }
            //邮箱校验
            var email=$("#inputEmail").val();
            var reg = /^[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*\.[a-z]{2,}$/;
            if(email==null||email==''){
                showValidateMsg("#inputEmail","error","请输入邮箱");
                return false;
            }
            else if(!reg.test(email)){
                showValidateMsg("#inputEmail","error","邮箱格式不正确");
                return false;
            }else{
                if($("#empSubmit").attr("ajax-val")=="error"){
                    showValidateMsg("#inputEmail","error","邮箱已被使用");
                }
                else {
                    showValidateMsg("#inputEmail","success","");
                }
            }
            return true;

        }

        //显示校验结果
        function showValidateMsg(element,status,msg) {
            //先清除元素的校验状态，防止叠加
            $(element).parent().removeClass("has-success has-error");
            $(element).next("span").text("");
            if("success"==status){
                $(element).parent().addClass("has-success");
                $(element).next("span").text(msg);
            }else if("error"==status){
                $(element).parent().addClass("has-error");
                $(element).next("span").text(msg);
            }
        }

        //检验邮箱（后端校验）
        function CheckEmail() {
            var email=$("#inputEmail").val();
            $.ajax({
                url:"${APP_PATH}/checkEmail",
                type:"POST",
                data:"email="+email,
                success:function (result) {
                    if(result.code==200){
                        showValidateMsg("#inputEmail","success","");
                        $("#empSubmit").attr("ajax-val","success");
                    }else{
                        showValidateMsg("#inputEmail","error",result.data.error_msg);
                        $("#empSubmit").attr("ajax-val","error");
                    }

                }
            })
        }
        //编辑模态框时检验邮箱（后端校验）
        function CheckEmailByUpdate() {
            var email=$("#inputEmailByUpdate").val();
            $.ajax({
                url:"${APP_PATH}/checkEmail",
                type:"POST",
                data:"email="+email,
                success:function (result) {
                    if(result.code==200){
                        showValidateMsg("#inputEmailByUpdate","success","");
                        $("#empSubmitByUpdate").attr("ajax-val","success");
                    }else{
                        showValidateMsg("#inputEmailByUpdate","error",result.data.error_msg);
                        $("#empSubmitByUpdate").attr("ajax-val","error");
                    }

                }
            })
        }

        //添加的提交
        function empSubmit() {
            //先校验
            if(!validateAddForm()){
                return false;
            }
            if($("#empSubmit").attr("ajax-val")=="error"){
                return false;
            }
            $.ajax({
                url:"${APP_PATH}/empAdd",
                type:"POST",
                data: $("#empAddModal form").serialize(),
                success:function (result) {
                    if(result.code==200){
                        //关闭模态框
                        $("#empAddModal").modal('hide');
                        //跳到最后一页
                        to_page(totalRecord);
                    }else {
                        if(undefined!=result.data.errorFields.empName){
                            showValidateMsg("#inputempName","error",result.data.errorFields.empName)
                        }
                        if(undefined!=result.data.errorFields.email){
                            showValidateMsg("#inputEmail","error",result.data.errorFields.email);
                        }
                    }
                }
            })
        }

        //更新校验
        function validateUpdateForm() {
            var empName=$("#inputempNameByUpdate").val();
            if(empName==null||empName==''){
                showValidateMsg("#inputempNameByUpdate","error","请输入员工姓名");
                return false;
            }else{
                showValidateMsg("#inputempNameByUpdate","success","");
            }
            //邮箱校验
            var email=$("#inputEmailByUpdate").val();
            var reg = /^[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*\.[a-z]{2,}$/;
            if(email==null||email==''){
                showValidateMsg("#inputEmailByUpdate","error","请输入邮箱");
                return false;
            }
            else if(!reg.test(email)){
                showValidateMsg("#inputEmailByUpdate","error","邮箱格式不正确");
                return false;
            }else{
                if($("#empSubmitByUpdate").attr("ajax-val")=="error"){
                    showValidateMsg("#inputEmailByUpdate","error","邮箱已被使用");
                }
                else {
                    showValidateMsg("#inputEmailByUpdate","success","");
                }
                showValidateMsg("#inputEmailByUpdate","success","");
            }
            return true;
        }
        //更新提交
        function empUpdateSubmit() {
            if(!validateUpdateForm()){
                return false;
            }
            if($("#empSubmitByUpdate").attr("ajax-val")=="error"){
                return false;
            }

            //发送更新请求
            $.ajax({
                url:"${APP_PATH}/empUpdate/"+$("#empSubmitByUpdate").attr("editBtn-empId"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {

                    //关闭模态框
                    $("#empUpdateModal").modal("hide");
                    //回到本页面
                    to_page(currentPage);

                }
            })
        }

        //获取所有部门
        function getDepts(element){
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"POST",
                success:function (result) {
                    //构建前先清空
                    $(element).empty();
                    $.each(result.data.depts,function (index,item) {
                        var optionElement=$("<option></option>").append(item.deptName).attr("value",item.deptId);
                        optionElement.appendTo(element);
                    })
                }
            })
        }

        //打开更新模态框
        $(document).on("click",".edit_btn",function () {
            resetForm("#empUpdateModal form");
            getDepts("#empUpdateModal select");
            getEmp($(this).attr("editBtn-empId"));
            //传递员工的empId给模态框的更新按钮
            $("#empSubmitByUpdate").attr("editBtn-empId",$(this).attr("editBtn-empId"));
            //显示模态框
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        });

        //点击删除
        $(document).on("click",".delete_btn",function () {
            //弹出是否确认删除对话框
            var empName=$(this).parents("tr").find("td:eq(2)").text();
            var empId=$(this).attr("deleteBtn-empId");
            if(confirm("确认删除【"+empName+"】吗？")){
                $.ajax({
                    url:"${APP_PATH}/empDelete/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //回到本页
                        to_page(currentPage);
                    }
                })
            }
        })

        //获取emp信息
        function getEmp(empId){
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"GET",
                success:function (result) {
                    var empData=result.data.emp;
                    $("#inputempNameByUpdate").val(empData.empName);
                    $("#inputEmailByUpdate").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                }
            })

        }

        //跳转第一页
        $(function () {
            to_page(1);
        });

        //页面跳转
        function to_page(pn) {
            $("#checkAll").prop("checked",false);
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"POST",
                success:function (result) {
                    //console.log(result)
                    build_emps_table(result);
                    build_page_info(result);
                    build_page_nav(result);
                }
            })
        }

        //构建表格
        function build_emps_table(result) {
            //构建前先清空
            $("#emps_table tbody").empty();

            var emps=result.data.pageInfo.list;
            $.each(emps,function (index,item) {
                var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
                var empId=$("<td></td>").append(item.empId);
                var empName=$("<td></td>").append(item.empName);
                var gender=$("<td></td>").append(item.gender=="M"?"男":"女");
                var empEmail=$("<td></td>").append(item.email);
                var deptName=$("<td></td>").append(item.department.deptName);

                var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                    .append("编辑");
                editBtn.attr("editBtn-empId",item.empId);
                var deleteBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append("删除");
                deleteBtn.attr("deleteBtn-empId",item.empId);
                var btnTd=$("<td></td>").append(editBtn).append(" ").append(deleteBtn);
                $("<tr></tr>")
                    .append(checkBoxTd)
                    .append(empId)
                    .append(empName)
                    .append(gender)
                    .append(empEmail)
                    .append(deptName)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            })
        }

        //构建分页信息
        function build_page_info(result) {
            //构建前先清空
            $("#pageInfoArea").empty();

            $("#pageInfoArea").append(" 当前第"+result.data.pageInfo.pageNum+"页，总共"+result.data.pageInfo.pages+"页，总共"+result.data.pageInfo.total+"条记录");
            totalRecord=result.data.pageInfo.total;
            currentPage=result.data.pageInfo.pageNum;
        }

        //构建分页条
        /**参考
         * <nav aria-label="Page navigation">
         <ul class="pagination">
         <li><a href="#">首页</a></li>
         <li>
         <a href="#" aria-label="Previous">
         <span aria-hidden="true">&laquo;</span>
         </a>
         </li>
         <li><a href="#">1</a></li>
         <li><a href="#">2</a></li>
         <li><a href="#">3</a></li>
         <li><a href="#">4</a></li>
         <li><a href="#">5</a></li>
         <li>
         <a href="#" aria-label="Next">
         <span aria-hidden="true">&raquo;</span>
         </a>
         </li>
         <li><a href="#">尾页</a></li>
         </ul>
         </nav>
         *
         */
        function build_page_nav(result) {
            //构建前先清空
            $("#pageNavArea").empty();

            var ul=$("<ul></ul>").addClass("pagination");
            var firstPage=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var lastPage=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));

            var nextPage=$("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            var prePage=$("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));

            if(result.data.pageInfo.hasPreviousPage==false){
                firstPage.addClass("disabled");
                prePage.addClass("disabled");
            }else{
                firstPage.click(function () {
                    to_page(1);
                });
                prePage.click(function () {
                    to_page(result.data.pageInfo.pageNum - 1);
                });
            }
            if(result.data.pageInfo.hasNextPage==false){
                nextPage.addClass("disabled");
                lastPage.addClass("disabled");
            }else {
                nextPage.click(function () {
                    to_page(result.data.pageInfo.pageNum + 1);
                });

                lastPage.click(function () {
                    to_page(result.data.pageInfo.pages);
                });
            }

            ul.append(firstPage).append(prePage);
            $.each(result.data.pageInfo.navigatepageNums,function (index,item) {
                var num=$("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                if(result.data.pageInfo.pageNum==item){
                    num.addClass("active");
                }
                //点击某一页跳转
                num.click(function () {
                    to_page(item);
                });
                ul.append(num);
            });
            ul.append(nextPage).append(lastPage);
            var navEle=$("<nav></nav>").append(ul);
            navEle.appendTo($("#pageNavArea"));
        }
    </script>
</head>
<body>
<!-- 修改Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myUpdateModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myUpdateModalLabel">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="inputempNameByUpdate" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="inputempNameByUpdate" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmailByUpdate" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" onchange="CheckEmailByUpdate()" name="email" class="form-control" id="inputEmailByUpdate" placeholder="empEmail">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inputGender1ByUpdate" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inputGender2ByUpdate" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="empSubmitByUpdate" onclick="empUpdateSubmit()">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 新增Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="inputempName" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="inputempName" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" onchange="CheckEmail()" name="email" class="form-control" id="inputEmail" placeholder="empEmail">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inputGender1" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inputGender2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="empSubmit" onclick="empSubmit()">提交</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div>
            <div class="col-md-12">
                <h1>SSM_CRUD</h1>
            </div>
        </div>
    </div>
    <div class="row">
        <div>
            <div class="col-md-4 col-md-offset-8">
                <button type="button" class="btn btn-primary" onclick="empAdd()">添加</button>
                <button type="button" class="btn btn-danger" id="deleteAll" onclick="deleteBatch()">批量删除</button>
            </div>
        </div>
    </div>
    <!--表格-->
    <div class="row">
        <table class="table table-hover" id="emps_table">
            <thead>
            <th><input type="checkbox" id="checkAll" onclick="checkAllBox()"></th>
            <th>#</th>
            <th>empName</th>
            <th>gender</th>
            <th>email</th>
            <th>deptName</th>
            <th>操作</th>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <!--分页-->
    <div class="row">
        <div class="col-md-12 text-center" id="pageInfoArea">
        </div>
        <div class="col-md-12 text-center" id="pageNavArea">
        </div>
    </div>
</div>
</body>
</html>
