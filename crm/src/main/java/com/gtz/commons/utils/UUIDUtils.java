package com.gtz.commons.utils;

import java.util.UUID;

/**
 * @author 葛天助
 * @version 1.0
 */
public class UUIDUtils {

    public static String getId(){
        return UUID.randomUUID().toString().replaceAll("-","");
    }
}
