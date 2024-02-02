package com.nhnacademy.shoppingmall.common.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Prop {
    private static String PROPERTIES_FILE = "/Users/yujinkimvv/Documents/NHNAcademy/lecture/project/java-servlet-jsp-shoppingmall/src/main/java/config/db.properties";

    public static String getProperty(String keyName) {
        String value = null;

        Properties prop = new Properties();

        InputStream inputStream = Prop.class.getClassLoader().getResourceAsStream("db.properties");

        try {
            if (inputStream != null) {
                prop.load(inputStream);
                value = prop.getProperty(keyName).trim();
            }
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
        return value;
    }
}
