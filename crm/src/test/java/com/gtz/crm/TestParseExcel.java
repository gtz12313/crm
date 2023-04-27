package com.gtz.crm;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

/**
 * @author 葛天助
 * @version 1.0
 */

/**
 * 使用apache-poi解析excel文件
 */
public class TestParseExcel {
    public static void main(String[] args) throws IOException {
        InputStream fis = new FileInputStream("d:/yyy/servletFile/activityExcel.xls");
        //根据excel文件，生成HSSFWorkbook对象
        HSSFWorkbook workbook = new HSSFWorkbook(fis);
        //根据workbook，获取HSSFSheet对象
        HSSFSheet sheet = workbook.getSheetAt(0);
        System.out.println("sheet.getLastRowNum() = " + sheet.getLastRowNum());
        HSSFRow row = null;
        HSSFCell cell = null;
        for (int i = 0; i <= sheet.getLastRowNum(); i++) {
            row = sheet.getRow(i);

            for (int j = 0; j < row.getLastCellNum(); j++) {
                cell = row.getCell(j);

                System.out.print(cell.getStringCellValue() + "   ");
            }
            System.out.println();
        }


    }
}
