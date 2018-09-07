package com.hello;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.List;

/**
 * 将list按行写或者行一行写多个
 */
public class WriteUtils {
    public static void write(List<String> list, boolean flag) throws IOException {
        BufferedWriter bufw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("b.csv")));

        if(flag) {
            for (String str : list) {
                bufw.write(str);
                bufw.newLine();
                bufw.flush();
            }
        }else{
            for (String str : list) {
                bufw.write(str);
                bufw.write(",");
                bufw.flush();
            }
        }
        bufw.close();

    }
}
