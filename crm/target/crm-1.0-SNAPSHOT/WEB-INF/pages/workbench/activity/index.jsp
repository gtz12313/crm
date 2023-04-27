<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort()
            + request.getContextPath() + "/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">

    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css"/>

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>
    <script type="text/javascript">

        $(function () {
            $(".myDate").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//可选择最小视图
                initialDate: new Date(),//初始显示时间
                autoclose: true,//选择完日期后 自动关闭
                todayBtn: true,//显示今天 按钮
                clearBtn: true//显示清空按钮
            });

            $("#exportActivityAllBtn").click(function () {
                window.location.href = "workbench/activity/fileDownload";
            });


            $("#exportActivityXzBtn").click(function () {
                var checkedIds = $("#tBody input[type='checkbox']:checked");

                if (checkedIds.size() == 0) {
                    alert("请选择要导出的活动");
                    return false;
                }
                var ids = "?";
                $.each(checkedIds, function () {
                    ids += "id=" + this.value + "&";
                });
                ids = ids.substring(0, ids.length - 1);

                window.location.href = "workbench/activity/fileDownloadByIds" + ids;
            });

            $("#saveUpdateBtn").click(function () {
                var owner = $("#edit-marketActivityOwner").val();
                var name = $.trim($("#edit-marketActivityName").val());
                var startDate = $("#edit-startTime").val();
                var endDate = $("#edit-endTime").val();
                var cost = $.trim($("#edit-cost").val());
                var description = $.trim($("#edit-describe").val());
                var id = $("#actId").val();
                var pageNo = $("#page").bs_pagination('getOption', 'currentPage');

                saveForm("workbench/activity/updateActivity", "#editActivityModal",
                    owner, name, startDate, endDate, cost, description, id, pageNo);
            });

            $("#saveBtn").click(function () {
                var owner = $("#create-marketActivityOwner").val();
                var name = $.trim($("#create-marketActivityName").val());
                var startDate = $("#create-startTime").val();
                var endDate = $("#create-endTime").val();
                var cost = $.trim($("#create-cost").val());
                var description = $.trim($("#create-description").val());
                saveForm("workbench/activity/saveActivity", "#createActivityModal",
                    owner, name, startDate, endDate, cost, description, "", 1);
            });

            $("#createActivityBtn").click(function () {
                //重置表单
                $("#createActivityForm").get(0).reset();

                $("#createActivityModal").modal("show");
            });

            $("#updateActivityBtn").click(function () {
                var checkedIds = $("#tBody input[type='checkbox']:checked");
                if (checkedIds.size() == 0) {
                    alert("请选择要修改的活动");
                    return false;
                }
                if (checkedIds.size() > 1) {
                    alert("只能修改一个活动");
                    return false;
                }
                var id = checkedIds.get(0).value;

                $.ajax({
                    url: "workbench/activity/queryActivityById",
                    data: {
                        id: id
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if (data.code == "1") {
                            $("#edit-marketActivityOwner").val(data.data.owner);
                            $("#edit-marketActivityName").val(data.data.name);
                            $("#edit-startTime").val(data.data.startDate);
                            $("#edit-endTime").val(data.data.endDate);
                            $("#edit-cost").val(data.data.cost);
                            $("#edit-describe").val(data.data.description);
                            $("#actId").val(data.data.id);

                            $("#editActivityModal").modal("show");
                        } else {
                            alert(data.msg);
                        }
                    },

                });

            });

            queryActivityByPage(1, 10);

            $("#quertActivityBtn").click(function () {
                queryActivityByPage(1, $("#page").bs_pagination('getOption', 'rowsPerPage'));
            });


            $("#checkAll").click(function () {
                $("#tBody input[type='checkbox']").prop("checked", this.checked);
            });


            $("#importActivityBtn").click(function () {
                var activityFileName = $("#activityFile").val();
                var suffix = activityFileName.substring(activityFileName.lastIndexOf(".") + 1).toLocaleLowerCase();

                if (suffix != "xls") {
                    alert("只支持xls文件");
                    return false;
                }
                /*if(!/^.+(\.xls)$/.test(activityFileName)){
                    alert("只支持xls文件");
                    return false;
                }*/
                var activityFile = $("#activityFile")[0].files[0];
                if (activityFile.size > 1024 * 1024 * 5) {
                    alert("文件大小不能超过5MB")
                    return false;
                }

                var formData = new FormData();
                formData.append("activityFile", activityFile);
                $.ajax({
                    url: "workbench/activity/importActivity",
                    data: formData,
                    processData: false,//设置ajax向后台提交参数之前,是否把参数转换为字符串;默认true -> 是
                    contentType: false,//设置ajax向后台提交参数前,是否把参数按urlencoded编码;默认true ->是
                    type: 'post',
                    dataType: 'json',

                    success: function (data) {
                        if (data.code == "1") {
                            alert("成功导入" + data.data + "条记录");
                            $("#importActivityModal").modal("hide");
                            queryActivityByPage(1, $("#page").bs_pagination('getOption', 'rowsPerPage'));
                        } else {
                            alert(data.msg);
                            $("#importActivityModal").modal("show");
                        }
                    }
                });

            });

            /*$("#tBody input[type='checkbox']").click(function () {
                if($("#tBody input[type='checkbox']").size ==
                $("#tBody input[type='checkbox']:checked")){
                    $("#checkAll").prop("checked",true);
                }else {
                    $("#checkAll").prop("checked",false);
                }
            })*/
            $("#tBody").on("click", "input[type='checkbox']", function () {
                if ($("#tBody input[type='checkbox']").size() == $("#tBody input[type='checkbox']:checked").size()) {
                    $("#checkAll").prop("checked", true);
                } else {
                    $("#checkAll").prop("checked", false);
                }
            });

            $("#tBody").on("click", "a", function () {
                var id = $(this).parent().parent().find("td:first").children("input[type='checkbox']").val();
                window.location.href = "workbench/activity/detail?activityId=" + id;
            });

            $("#deleteBtn").click(function () {
                var checkedIds = $("#tBody input[type='checkbox']:checked");
                if (checkedIds.size() == 0) {
                    alert("请选择要删除的活动");
                    return false;
                }
                if (window.confirm("确定要删除吗?")) {
                    var ids = "";
                    $.each(checkedIds, function () {
                        ids += "id=" + this.value + "&";
                    });
                    ids = ids.substring(0, ids.length - 1);
                    // alert(ids);
                    $.ajax({
                        url: "workbench/activity/deleteActivityByIds",
                        data: ids,
                        type: 'post',
                        dataType: 'json',
                        success: function (data) {
                            if (data.code == "1") {
                                queryActivityByPage(1, $("#page").bs_pagination('getOption', 'rowsPerPage'));
                            } else {
                                alert(data.msg);
                            }
                        }
                    });
                }
            });
        });

        function saveForm(url, elementId, owner, name, startDate, endDate, cost, description, id, pageNo) {

            if (owner == "") {
                alert("所有者不能为空");
                return false;
            }
            if (name == "") {
                alert("名称不能为空");
                return false;
            }
            if (endDate != "" && startDate != "") {
                if (startDate > endDate) {
                    alert("结束日期不能大于开始日期")
                    return false;
                }
            }
            var reg = /^[1-9][\d]*$/;
            if (!reg.test(cost)) {
                alert("成本只能是正整数");
                return false;
            }
            $.ajax({
                url: url,
                data: {
                    owner: owner,
                    name: name,
                    startDate: startDate,
                    endDate: endDate,
                    cost: cost,
                    description: description,
                    id: id
                },
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.code == "1") {
                        $(elementId).modal("hide");
                        queryActivityByPage(pageNo, $("#page").bs_pagination('getOption', 'rowsPerPage'));
                    } else {
                        alert(data.msg);
                        $(elementId).modal("show");
                    }
                }
            });
        }

        function queryActivityByPage(pageNo, pageSize) {
            var name = $("#quert-name").val();
            var owner = $("#query-owner").val();
            var startDate = $("#query-startDate").val();
            var endDate = $("#query-endDate").val();
            // var pageNo = 1;
            // var pageSize = 10;

            $.ajax({
                url: 'workbench/activity/queryActivityByPage',
                data: {
                    name: name,
                    owner: owner,
                    startDate: startDate,
                    endDate: endDate,
                    pageNo: pageNo,
                    pageSize: pageSize
                },
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    // $("#totalRows").text(data.totalRows);
                    var htmlStr = "";
                    $.each(data.activityList, function (index, obj) {
                        htmlStr += "<tr class='active'>";
                        htmlStr += "<td><input type='checkbox' value=\"" + obj.id + "\"/></td>";
                        htmlStr += "<td><a style=\"text-decoration: none; cursor: pointer;\">" + obj.name + "</a></td>";
                        htmlStr += "<td>" + obj.owner + "</td>";
                        htmlStr += "<td>" + obj.startDate + "</td>";
                        htmlStr += "<td>" + obj.endDate + "</td>";
                        htmlStr += "</tr>";
                    });
                    $("#tBody").html(htmlStr);

                    $("#checkAll").prop("checked", false);

                    var totalPages = 1;
                    totalPages = parseInt((data.totalRows + pageSize - 1) / pageSize);

                    $("#page").bs_pagination({
                        currentPage: pageNo,//当前页号
                        rowsPerPage: pageSize,//每页显示条数
                        totalRows: data.totalRows,//总记录数
                        totalPages: totalPages,//总页数

                        visiblePageLinks: 5,//最多显示卡片数

                        //每次切换页号后触发的函数
                        onChangePage: function (event, pageObj) {
                            queryActivityByPage(pageObj.currentPage, pageObj.rowsPerPage);
                        }
                    });
                }
            });
        }

    </script>
</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="createActivityForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner">
                                <c:forEach items="${requestScope.users}" var="user">
                                    <option name="owner">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="name" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input readonly type="text" name="startDate" class="form-control myDate"
                                   id="create-startTime">
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input readonly type="text" name="endDate" class="form-control myDate" id="create-endTime">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="cost" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-description" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" name="description" rows="3"
                                      id="create-description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="saveBtn" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                                <c:forEach items="${requestScope.users}" var="user">
                                    <option name="owner">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control myDate" readonly id="edit-startTime">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" readonly class="form-control myDate" id="edit-endTime">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe"></textarea>
                        </div>
                    </div>
                    <input type="hidden" id="actId"/>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveUpdateBtn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 导入市场活动的模态窗口 -->
<div class="modal fade" id="importActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：<small style="color: gray;">[仅支持.xls]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input type="file" id="activityFile">
                </div>
                <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;">
                    <h3>重要提示</h3>
                    <ul>
                        <li>操作仅针对Excel，仅支持后缀名为XLS的文件。</li>
                        <li>给定文件的第一行将视为字段名。</li>
                        <li>请确认您的文件大小不超过5MB。</li>
                        <li>日期值以文本形式保存，必须符合yyyy-MM-dd格式。</li>
                        <li>日期时间以文本形式保存，必须符合yyyy-MM-dd HH:mm:ss的格式。</li>
                        <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                        <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="importActivityBtn" type="button" class="btn btn-primary">导入</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style=" height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" id="quert-name" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" id="query-owner" type="text">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control" type="text" id="query-startDate"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control" type="text" id="query-endDate">
                    </div>
                </div>

                <button type="button" id="quertActivityBtn" class="btn btn-default">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" id="createActivityBtn" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" id="updateActivityBtn" class="btn btn-default"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" class="btn btn-danger" id="deleteBtn"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal">
                    <span class="glyphicon glyphicon-import"></span> 上传列表数据（导入）
                </button>
                <button id="exportActivityAllBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（批量导出）
                </button>
                <button id="exportActivityXzBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（选择导出）
                </button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="checkAll"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="tBody">
                </tbody>
            </table>
            <div id="page"></div>
        </div>

        <%--<div style="height: 50px; position: relative;top: 30px;">
            <div>
                <button type="button" class="btn btn-default" style="cursor: default;">共<b id="totalRows"></b>条记录</button>
            </div>
            <div class="btn-group" style="position: relative;top: -34px; left: 110px;">
                <button type="button" class="btn btn-default" style="cursor: default;">显示</button>
                <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                        10
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">20</a></li>
                        <li><a href="#">30</a></li>
                    </ul>
                </div>
                <button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
            </div>
            <div style="position: relative;top: -88px; left: 285px;">
                <nav>
                    <ul class="pagination">
                        <li class="disabled"><a href="#">首页</a></li>
                        <li class="disabled"><a href="#">上一页</a></li>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">下一页</a></li>
                        <li class="disabled"><a href="#">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>--%>

    </div>

</div>
</body>
</html>