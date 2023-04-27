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
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">

        //默认情况下取消和保存按钮是隐藏的
        var cancelAndSaveBtnDefault = true;

        function activityName() {
            return $("#activityName").val();
        }

        $(function () {

            // queryActivityRemarkById();

            $("#remarkDivList").on("click", ".myHref[name='removeRemark']", function () {
                var remarkId = $(this).attr("remarkId");
                var text = $("#h5_" + remarkId).text();
                if (window.confirm("您确定要删除备注 " + text + " 吗?")) {
                    $.ajax({
                        url: 'workbench/activity/deleteActivityRemarkById',
                        data: {id: remarkId},
                        type: 'post',
                        dataType: 'json',
                        success: function (data) {
                            if (data.code == "1") {
                                $("#div_" + remarkId).remove();
                                alert("删除成功");
                            } else {
                                alert(data.msg);
                            }
                        }
                    });
                }
            });


            $("#remarkDivList").on("click", ".myHref[name='editRemark']", function () {

                var remarkId = $(this).attr("remarkId");

                $("#remarkId").val(remarkId);
                $("#noteContent").val($("#h5_" + remarkId).text());
                $("#editRemarkModal").modal("show");
                /*$.ajax({
                    url:"workbench/activity/queryRemarkById",
                    data:{id:remarkId},
                    type:'post',
                    dataType:'json',
                    success:function (data) {
                        if(data.code == "1"){
                            $("#remarkId").val(remarkId);
                            $("#noteContent").text(data.data.noteContent);
                            $("#editRemarkModal").modal("show");
                        }else {
                            alert(data.msg);
                        }
                    }
                });*/

            });

            $("#saveEditRemarkBtn").click(function () {
                var noteContent = $.trim($("#noteContent").val());
                var id = $("#remarkId").val();
                if (noteContent == ""){
                    alert("内容不能为空");
                    return false;
                }
                $.ajax({
                    url: 'workbench/activity/saveEditActivityRemark',
                    data: {id: id, noteContent: noteContent},
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        if (data.code == "1") {

                            /*var htmlStr = "";
                            htmlStr += "<img title=\"  \" src=\"image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">";
                            htmlStr += "<div style=\"position: relative; top: -40px; left: 40px;\" >"
                            htmlStr += "<h5 id='h5_" + data.data.id + "'>" + data.data.noteContent + "</h5>";
                            htmlStr += "<font color=\"gray\">市场活动</font> <font color=\"gray\">-</font> <b>" + activityName() + "</b>";
                            htmlStr += "<small style=\"color: gray;\">" + data.data.editTime + " 由 修改</small>";
                            htmlStr += "<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">";
                            htmlStr += "<a name=\"editRemark\" id='a_" + data.data.id + "' remarkId='" + data.data.id + "' class=\"myHref\" href=\"javascript:void(0);\">";
                            htmlStr += "<span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span>";
                            htmlStr += "</a>&nbsp;&nbsp;&nbsp;&nbsp;";
                            htmlStr += "<a name=\"removeRemark\" remarkId='" + data.data.id + "' class=\"myHref\" href=\"javascript:void(0);\">"
                            htmlStr += "<span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>";
                            htmlStr += "</div></div>";*/

                            $("#div_" + data.data.id + " h5").text(data.data.noteContent);
                            $("#div_" + data.data.id + " small").text(" " + data.data.editTime + " 由 ${sessionScope.sessionUser.name} 修改");

                            // $("#div_" + data.data.id).html(htmlStr);
                            $("#editRemarkModal").modal("hide");
                        } else {
                            alert(data.msg);
                            $("#editRemarkModal").modal("show");
                        }
                    }
                });
            });

            $("#saveActivityRemarkBtn").click(function () {
                var activityId = $("#activityId").val();
                var noteContent = $.trim($("#remark").val());
                if (noteContent == "") {
                    alert("内容不能为空");
                    return false;
                }
                $.ajax({
                    url: "workbench/activity/saveCreateActivityRemark",
                    data: {
                        activityId: activityId,
                        noteContent: noteContent
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        if (data.code == "1") {
                            $("#remark").val("");
                            var htmlStr = "";
                            htmlStr += "<div class=\"remarkDiv\" id=\"div_" + data.data.id + "\" style=\"height: 60px;\">";
                            htmlStr += "<img title=\" ${sessionScope.sessionUser.name} \" src=\"image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">";
                            htmlStr += "<div style=\"position: relative; top: -40px; left: 40px;\" >"
                            htmlStr += "<h5 id='h5_" + data.data.id + "'>" + data.data.noteContent + "</h5>";
                            htmlStr += "<font color=\"gray\">市场活动</font> <font color=\"gray\">-</font> <b>" + activityName() + "</b>";
                            htmlStr += "<small style=\"color: gray;\"> " + data.data.createTime + " 由 ${sessionScope.sessionUser.name} 创建</small>";
                            htmlStr += "<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">";
                            htmlStr += "<a name=\"editRemark\" id='a_" + data.data.id + "' remarkId='" + data.data.id + "' class=\"myHref\" href=\"javascript:void(0);\">";
                            htmlStr += "<span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span>";
                            htmlStr += "</a>&nbsp;&nbsp;&nbsp;&nbsp;";
                            htmlStr += "<a name=\"removeRemark\" remarkId='" + data.data.id + "' class=\"myHref\" href=\"javascript:void(0);\">"
                            htmlStr += "<span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>";
                            htmlStr += "</div></div></div>";

                            $("#saveRemarkDiv").before(htmlStr);
                        } else {
                            alert(data.msg);
                        }
                    }
                });

            });

            $("#remark").focus(function () {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    $("#remarkDiv").css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });

            $("#cancelBtn").click(function () {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                $("#remarkDiv").css("height", "90px");
                cancelAndSaveBtnDefault = true;
            });

            /*$(".remarkDiv").mouseover(function () {
                $(this).children("div").children("div").show();
            });*/

            $("#remarkDivList").on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            });

            /*$(".remarkDiv").mouseout(function () {
                $(this).children("div").children("div").hide();
            });*/

            $("#remarkDivList").on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            });

            /*$(".myHref").mouseover(function () {
                $(this).children("span").css("color", "red");
            });*/
            $("#remarkDivList").on("mouseover", ".myHref", function () {
                $(this).children("span").css("color", "red");
            });


            /*$(".myHref").mouseout(function () {
                $(this).children("span").css("color", "#E6E6E6");
            });*/

            $("#remarkDivList").on("mouseout", ".myHref", function () {
                $(this).children("span").css("color", "#E6E6E6");
            });
        });

        function queryActivityRemarkById() {
            var activityId = $("#activityId").val();
            // $("#remark").get(0).reset();
            window.location.href = "workbench/activity/detail?activityId=" + activityId;

            /*$.ajax({
                url: "workbench/activity/queryRemark",
                data: {activityId: activityId},
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    /!*var htmlStr = "";
                    var createBy = "";
                    var createTime = "";*!/


                    $.each(data.data, function (index, obj) {
                        alert(data.remarkList);
                        $("h5#remarkNoteContent").get(index).text(obj.noteContent);
                        $("img#remarkCreateBy").get(index).title = obj.createBy;
                        var str = "";
                        if (obj.editFlag == "1"){
                            str = obj.createTime + " 由 " + obj.createBy + " 创建";
                        }else {
                            str = obj.editTime + " 由 " + obj.editBy + " 修改";
                        }
                        $("small#createTimeAndName").get(index).text(str);
                        index = index + 1;
                        /!*if (obj.editFlag == "0") {
                            createBy = obj.editBy;
                            createTime = obj.editTime;
                        } else {
                            createBy = obj.createBy;
                            createTime = obj.createTime;
                        }


                        htmlStr += "<img title=\"" + obj.createBy + "\" src=\"image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">";
                        htmlStr += "<div style=\"position: relative; top: -40px; left: 40px;\" >"
                        htmlStr += "<h5>" + obj.noteContent + "</h5>";
                        htmlStr += "<font color=\"gray\">市场活动</font> <font color=\"gray\">-</font> <b>" + activityName + "</b>";
                        htmlStr += "<small style=\"color: gray;\">" + createTime + " 由 " + createBy + "</small>";
                        htmlStr += "<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">";
                        htmlStr += "<a class=\"myHref\" href=\"javascript:void(0);\">";
                        htmlStr += "<span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span>";
                        htmlStr += "</a>&nbsp;&nbsp;&nbsp;&nbsp;";
                        htmlStr += "<a class=\"myHref\" href=\"javascript:void(0);\">"
                        htmlStr += "<span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>";
                        htmlStr += "</div></div>";*!/
                    });

                    // $("#remarkDiv").html(htmlStr);
                }
            });*/

        }

    </script>

</head>
<body>

<!-- 修改市场活动备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
    <%-- 备注的id --%>
    <input type="hidden" id="remarkId">
    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="noteContent" class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="noteContent"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveEditRemarkBtn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>市场活动-${requestScope.activity.name}
            <small>${requestScope.activity.startDate} ~ ${requestScope.activity.endDate}</small></h3>
    </div>

</div>

<br/>
<br/>
<br/>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.owner}</b>
        </div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${requestScope.activity.name}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>

    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">开始日期</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.startDate}</b>
        </div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${requestScope.activity.endDate}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">成本</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.cost}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.createBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${requestScope.activity.createTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <c:if test="${not empty requestScope.activity.editBy}">
        <div style="position: relative; left: 40px; height: 30px; top: 40px;">
            <div style="width: 300px; color: gray;">修改者</div>
            <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.editBy}&nbsp;&nbsp;</b>
                <small style="font-size: 10px; color: gray;">${requestScope.activity.editTime}</small></div>
            <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
    </c:if>

    <input id="activityId" type="hidden" value="${requestScope.activity.id}">
    <input id="activityName" type="hidden" value="${requestScope.activity.name}">

    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${requestScope.activity.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div id="remarkDivList" style="position: relative; top: 30px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>

    <%--<!-- 备注1 -->
    <div class="remarkDiv" id="remarkDiv" style="height: 60px;">

    </div>--%>


    <!-- 备注2 -->
    <c:forEach items="${requestScope.remarkList}" var="remark">
        <div class="remarkDiv" id="div_${remark.id}" style="height: 60px;">
            <img id="remarkCreateBy" title="${remark.createBy}" src="image/user-thumbnail.png"
                 style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5 id="h5_${remark.id}">${remark.noteContent}</h5>
                <font color="gray">市场活动</font> <font color="gray">-</font> <b
                    id="activityNameByRemark">${requestScope.activity.name}</b>
                <small id="createTimeAndName"
                       style="color: gray;"> ${remark.editFlag == '0' ? remark.editTime : remark.createTime} 由                          ${remark.editFlag == '0' ? remark.editBy : remark.createBy}${remark.editFlag == "0" ? " 修改" : " 创建"}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" name="editRemark" id="a_${remark.id}" remarkId="${remark.id}"
                       href="javascript:void(0);">
                        <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" name="removeRemark" id="remove-remark" remarkId="${remark.id}"
                       href="javascript:void(0);">
                        <span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
                </div>
            </div>
        </div>
    </c:forEach>


    <div id="saveRemarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button type="button" id="saveActivityRemarkBtn" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>