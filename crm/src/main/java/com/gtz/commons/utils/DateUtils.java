package com.gtz.commons.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author 葛天助
 * @version 1.0
 */
public class DateUtils {

    public static String formateDateTime(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        return sdf.format(date);
    }
}
