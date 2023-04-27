package com.gtz.controller;

import com.gtz.commons.contants.Code;
import com.gtz.commons.domain.Result;
import com.gtz.commons.utils.DateUtils;
import com.gtz.commons.utils.UUIDUtils;
import com.gtz.domain.Activity;
import com.gtz.domain.ActivityRemark;
import com.gtz.domain.User;
import com.gtz.service.ActivityRemarkService;
import com.gtz.service.ActivityService;
import com.gtz.service.UserService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;

/**
 * @author 葛天助
 * @version 1.0
 */

@Controller
public class ActivityController {
    @Autowired
    private UserService userService;
    @Autowired
    private ActivityService activityService;
    @Autowired
    private ActivityRemarkService activityRemarkService;

    @RequestMapping("/workbench/activity/fileDownloadByIds")
    @ResponseBody
    public void fileDownloadByIds(String[] id, HttpServletResponse resp) throws Exception {
        List<Activity> activityList = activityService.queryActivityByIds(id);
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("市场活动列表");

        HSSFRow row = sheet.createRow(0);
        row.createCell(0).setCellValue("ID");
        row.createCell(1).setCellValue("名称");
        row.createCell(2).setCellValue("所有者");
        row.createCell(3).setCellValue("开始时间");
        row.createCell(4).setCellValue("结束时间");
        row.createCell(5).setCellValue("成本");
        row.createCell(6).setCellValue("描述");
        row.createCell(7).setCellValue("创建日期");
        row.createCell(8).setCellValue("创建者");
        row.createCell(9).setCellValue("修改日期");
        row.createCell(10).setCellValue("修改者");

        if (activityList != null && activityList.size() != 0) {
            Activity activity = null;
            for (int i = 0; i < activityList.size(); i++) {
                activity = activityList.get(i);
                row = sheet.createRow(i + 1);
                row.createCell(0).setCellValue(activity.getId());
                row.createCell(1).setCellValue(activity.getName());
                row.createCell(2).setCellValue(activity.getOwner());
                row.createCell(3).setCellValue(activity.getStartDate());
                row.createCell(4).setCellValue(activity.getEndDate());
                row.createCell(5).setCellValue(activity.getCost());
                row.createCell(6).setCellValue(activity.getDescription());
                row.createCell(7).setCellValue(activity.getCreateTime());
                row.createCell(8).setCellValue(activity.getCreateBy());
                row.createCell(9).setCellValue(activity.getEditTime());
                row.createCell(10).setCellValue(activity.getEditBy());
            }
        }

        /*FileOutputStream fos = new FileOutputStream("D:\\yyy\\servletFile/activityExcel.xls");
        //调用工具函数 生成excel文件
        workbook.write(fos);*/


        resp.setContentType("application/octet-stream;charset=utf8");
        //设置响应头,告知浏览器,直接激活文件下载
        resp.addHeader("Content-Disposition", "attachment;filename=activityExcel.xls");

        ServletOutputStream os = resp.getOutputStream();
        workbook.write(os);

        /*bis = new BufferedInputStream(new FileInputStream("d:/yyy/servletFile/activityExcel.xls"));
        byte[] read = new byte[1024];
        int readLen = 0;
        while ((readLen = bis.read(read)) != -1) {
            os.write(read, 0, readLen);
        }*/

        workbook.close();
        os.flush();
    }

    @RequestMapping("/workbench/activity/fileDownload")
    public void fileDownload(HttpServletResponse resp) throws Exception {
        List<Activity> activityList = activityService.queryAllActivity();
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("市场活动列表");

        HSSFRow row = sheet.createRow(0);
        row.createCell(0).setCellValue("ID");
        row.createCell(1).setCellValue("名称");
        row.createCell(2).setCellValue("所有者");
        row.createCell(3).setCellValue("开始时间");
        row.createCell(4).setCellValue("结束时间");
        row.createCell(5).setCellValue("成本");
        row.createCell(6).setCellValue("描述");
        row.createCell(7).setCellValue("创建日期");
        row.createCell(8).setCellValue("创建者");
        row.createCell(9).setCellValue("修改日期");
        row.createCell(10).setCellValue("修改者");

        if (activityList != null && activityList.size() != 0) {
            Activity activity = null;
            for (int i = 0; i < activityList.size(); i++) {
                activity = activityList.get(i);
                row = sheet.createRow(i + 1);
                row.createCell(0).setCellValue(activity.getId());
                row.createCell(1).setCellValue(activity.getName());
                row.createCell(2).setCellValue(activity.getOwner());
                row.createCell(3).setCellValue(activity.getStartDate());
                row.createCell(4).setCellValue(activity.getEndDate());
                row.createCell(5).setCellValue(activity.getCost());
                row.createCell(6).setCellValue(activity.getDescription());
                row.createCell(7).setCellValue(activity.getCreateTime());
                row.createCell(8).setCellValue(activity.getCreateBy());
                row.createCell(9).setCellValue(activity.getEditTime());
                row.createCell(10).setCellValue(activity.getEditBy());
            }
        }

        /*FileOutputStream fos = new FileOutputStream("D:\\yyy\\servletFile/activityExcel.xls");
        //调用工具函数 生成excel文件
        workbook.write(fos);*/


        resp.setContentType("application/octet-stream;charset=utf8");
        //设置响应头,告知浏览器,直接激活文件下载
        resp.addHeader("Content-Disposition", "attachment;filename=activityExcel.xls");

        ServletOutputStream os = resp.getOutputStream();
        workbook.write(os);

        /*bis = new BufferedInputStream(new FileInputStream("d:/yyy/servletFile/activityExcel.xls"));
        byte[] read = new byte[1024];
        int readLen = 0;
        while ((readLen = bis.read(read)) != -1) {
            os.write(read, 0, readLen);
        }*/

        workbook.close();
        os.flush();
    }

    @RequestMapping("/workbench/activity/index")
    public String index(Model model) {
        List<User> users = userService.queryAllUser();
        model.addAttribute("users", users);

        return "workbench/activity/index";
    }

    @RequestMapping("/workbench/activity/queryActivityById")
    @ResponseBody
    public Result queryActivityById(String id, Model model) {
        Result result = new Result();
        Activity activity = activityService.queryActivityById(id);

        /*List<User> users = userService.queryAllUser();
        model.addAttribute("users",users);*/

        if (activity == null) {
            result.resError();
        } else {
            result.resOk(activity);
        }

        return result;
    }

    @RequestMapping("/workbench/activity/updateActivity")
    @ResponseBody
    public Result updateActivity(Activity activity, HttpSession session) {
        Result result = new Result();
        User user = (User) session.getAttribute(Code.SESSION_USER);
        activity.setEditTime(DateUtils.formateDateTime(new Date()));
        activity.setEditBy(user.getId());
        try {
            int ret = activityService.updateActivity(activity);
            if (ret > 0) {
                result.resOk(activity);
            } else {
                result.resError();
            }
        } catch (Exception e) {
            result.resError();
            e.printStackTrace();
        }
        return result;
    }


    @ResponseBody
    @RequestMapping("/workbench/activity/saveActivity")
    public Result saveActivity(Activity activity, HttpSession session) {
        User user = (User) session.getAttribute(Code.SESSION_USER);
        activity.setId(UUIDUtils.getId());
        activity.setCreateTime(DateUtils.formateDateTime(new Date()));
        activity.setCreateBy(user.getId());

        Integer integer = null;
        Result result = new Result();
        try {
            integer = activityService.saveCreateActivity(activity);
        } catch (Exception e) {
            result.resError();
            throw new RuntimeException(e);
        }

        if (integer > 0) {
            result.setCode(Code.RETURN_CODE_OK);
            result.setData(activity);
        } else {
            result.resError();
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/workbench/activity/queryActivityByPage")
    public Object queryActivityByPage(String name, String owner,
                                      String startDate, String endDate,
                                      int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<>();
        map.put("name", name);
        map.put("owner", owner);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        map.put("pageSize", pageSize);
        map.put("beginNo", (pageNo - 1) * pageSize);

        List<Activity> activityList = activityService.queryActivityByPage(map);
        int totalRows = activityService.queryCountActivityByMap(map);
        Map<String, Object> resMap = new HashMap<>();
        resMap.put("activityList", activityList);
        resMap.put("totalRows", totalRows);

        return resMap;
    }

    @ResponseBody
    @RequestMapping("/workbench/activity/deleteActivityByIds")
    public Result deleteActivityById(String[] id) {
        Result result = new Result();
        int res = 0;
        try {
            res = activityService.deleteActivityByIds(id);
            if (res > 0) {
                result.setCode(Code.RETURN_CODE_OK);
                result.setData(id);
            } else {
                result.resError();
            }
        } catch (Exception e) {
            result.resError();
            e.printStackTrace();
        }

        return result;
    }


    @RequestMapping("/workbench/activity/fileUpload")
    @ResponseBody
    public Object fileUpload(String userName, MultipartFile myFile) throws IOException {

        /*File file = new File("d:/yyy/servletFile/" + myFile.getOriginalFilename());
        myFile.transferTo(file);*/
        HSSFWorkbook workbook = new HSSFWorkbook(myFile.getInputStream());
        HSSFSheet sheet = workbook.getSheetAt(0);

        for (int i = 1; i < sheet.getLastRowNum(); i++) {
            HSSFRow row = sheet.getRow(i);
        }

        Result result = new Result();
        result.setCode(Code.RETURN_CODE_OK);
        result.setMsg("up ok");
        return result;
    }



    @RequestMapping("/workbench/activity/importActivity")
    @ResponseBody
    public Object importActivity(HttpSession session, MultipartFile activityFile) {
        HSSFSheet sheet = null;
        Result result = new Result();
        User user = (User) session.getAttribute(Code.SESSION_USER);

        try {
            HSSFWorkbook workbook = new HSSFWorkbook(activityFile.getInputStream());
            sheet = workbook.getSheetAt(0);

            HSSFRow row = null;
            Activity activity = null;
            HSSFCell cell = null;
            List<Activity> activityList = new ArrayList<>();
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                row = sheet.getRow(i);
                activity = new Activity();
                activity.setId(UUIDUtils.getId());
                activity.setCreateBy(user.getId());
                activity.setCreateTime(DateUtils.formateDateTime(new Date()));
                cell = row.getCell(1);
                activity.setName(getCellValForStr(cell));
                cell = row.getCell(2);
                activity.setOwner(getCellValForStr(cell));
                cell = row.getCell(3);
                activity.setStartDate(getCellValForStr(cell));
                cell = row.getCell(4);
                activity.setEndDate(getCellValForStr(cell));
                cell = row.getCell(5);
                activity.setCost(getCellValForStr(cell));
                cell = row.getCell(6);
                activity.setDescription(getCellValForStr(cell));

                activityList.add(activity);
            }
            int ret = activityService.saveCreateActivityByList(activityList);
            result.resOk(ret);

        } catch (IOException e) {
            result.resError("导入失败");
            System.out.println("activityFile = " + activityFile);
            throw new RuntimeException(e);
        }

        return result;
    }


    @RequestMapping("/workbench/activity/saveCreateActivityRemark")
    @ResponseBody
    public Result saveCreateActivityRemark(ActivityRemark activityRemark,HttpSession session){
        User user = (User) session.getAttribute(Code.SESSION_USER);
        activityRemark.setEditFlag(Code.RETURN_CODE_OK);
        activityRemark.setCreateBy(user.getId());
        activityRemark.setCreateTime(DateUtils.formateDateTime(new Date()));
        activityRemark.setId(UUIDUtils.getId());

        Result result = new Result();
        try {
            int ret = activityRemarkService.saveCreateActivityRemark(activityRemark);

            if (ret > 0){
                result.resOk(activityRemark);
            }else {
                result.resError();
            }
        } catch (Exception e) {
            result.resError();
            e.printStackTrace();
        }

        return result;
    }

    @RequestMapping("/workbench/activity/queryRemark")
    @ResponseBody
    public Result queryRemark(String activityId,Model model){
        List<ActivityRemark> activityRemarkList = activityRemarkService.queryActivityRemarkByActivityId(activityId);
        Result result = new Result();
        model.addAttribute("remarkList",activityRemarkList);
        result.resOk(activityRemarkList);

        return result;
    }

    @RequestMapping("/workbench/activity/detail")
    public String detail(String activityId,Model model){
        Activity activity = activityService.queryActivityById(activityId);
        List<ActivityRemark> activityRemarkList = activityRemarkService.queryActivityRemarkByActivityId(activityId);
        model.addAttribute("remarkList",activityRemarkList);
        model.addAttribute("activity",activity);

        return "workbench/activity/detail";
    }

    @RequestMapping("/workbench/activity/queryRemarkById")
    @ResponseBody
    public Result queryRemarkById(String id){
        ActivityRemark activityRemark = activityRemarkService.queryActivityRemarkById(id);
        Result result = new Result();
        result.resOk(activityRemark);
        return result;
    }

    @RequestMapping("/workbench/activity/deleteActivityRemarkById")
    @ResponseBody
    public Result deleteActivityRemarkById(String id){
        Result result = new Result();
        try {
            int ret = activityRemarkService.deleteActivityRemarkById(id);
            if (ret > 0){
                result.resOk(ret);
            }else {
                result.resError();
            }
        } catch (Exception e) {
            result.resError();
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/workbench/activity/saveEditActivityRemark")
    @ResponseBody
    public Result saveEditActivityRemark(String id,String noteContent,HttpSession session){
        ActivityRemark activityRemark = activityRemarkService.queryActivityRemarkById(id);
        Result result = new Result();
        User user = (User) session.getAttribute(Code.SESSION_USER);

        try {
            activityRemark.setEditBy(user.getId());
            activityRemark.setNoteContent(noteContent);
            activityRemark.setEditFlag(Code.RETURN_CODE_ERR);
            activityRemark.setEditTime(DateUtils.formateDateTime(new Date()));
            int ret = activityRemarkService.saveEditActivityRemark(activityRemark);

            if (ret > 0){
                result.resOk(activityRemark);
            }else {
                result.resError();
            }
        } catch (Exception e) {
            result.resError();
            e.printStackTrace();
        }

        return result;
    }

    public static String getCellValForStr(HSSFCell cell){
        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC){
            return cell.getNumericCellValue() + "";
        }
        return cell.getStringCellValue();
    }
}
