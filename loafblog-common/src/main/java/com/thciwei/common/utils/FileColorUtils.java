package com.thciwei.common.utils;

import java.awt.*;
import java.util.Random;

public class FileColorUtils {
    public static String getColor() {
        Random mRandom = new Random();
        StringBuilder mBuilder = new StringBuilder(); //使用之前首先清空内容
        String haxString;
        for (int i = 0; i < 3; i++) {
            haxString = Integer.toHexString(mRandom.nextInt(0xFF));
            if (haxString.length() == 1) {
                haxString = "0" + haxString;
            }
            mBuilder.append(haxString);
        }

        Color color = Color.decode("#" + mBuilder.toString());
        String s = '#' + Integer.toHexString(color.getRGB() & 0xffffff);
        return s;
    }
}
