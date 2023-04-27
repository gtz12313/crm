package com.gtz.crm;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.junit.Test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

/**
 * @author 葛天助
 * @version 1.0
 */
public class TestCreateExcel {

    @Test
    public void testCreate(){
        //创建一个HSSFWorkbook对象,对应一个Excel文件
        HSSFWorkbook workbook = new HSSFWorkbook();
        //使用workbook创建HSSFSheet对象,对应文件中的一页
        HSSFSheet sheet = workbook.createSheet("列表1");
        //使用 sheet创建HSSFRow对象,对应页中的一行
        HSSFRow row = sheet.createRow(0);//rowNum:行号(从0开始,依次增加)
        //使用row创建HSSFCell对象,对应一行中的列
        HSSFCell cell = row.createCell(0);//column:列号(从0开始,依次增加)
        cell.setCellValue("编号");
        row.createCell(1).setCellValue("姓名");
        row.createCell(2).setCellValue("年龄");

        HSSFCellStyle style = workbook.createCellStyle();
        //设置样式
        style.setAlignment(HorizontalAlignment.CENTER);

        for (int i = 1; i <= 10; i++) {
            HSSFRow sheetRow = sheet.createRow(i);

            sheetRow.setRowStyle(style);

            sheetRow.createCell(0).setCellValue( 1000 + i);
            sheetRow.createCell(1).setCellValue("jack" + i);
            sheetRow.createCell(2).setCellValue(i + 18);

        }

        try {
            FileOutputStream fos = new FileOutputStream("d:/yyy/testExcel.xls");
            //调用工具函数 生成excel文件
            workbook.write(fos);

            fos.close();
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("--------create OK----------");
    }
}

