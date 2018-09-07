package com.lvoyee.crud.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

/**
* 描述：模型
* @author Ay
* @date 2017/05/03
*/
public class Ap805 {
    //private static final long serialVersionUID = 1L;

    /**
    *   
    */

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        @JsonFormat(pattern = "yyyy-MM-dd", timezone="GMT+8")
        private Date dateP;

    /**
    *   
    */
    private Double openP;


    /**
    *   
    */
    private Double highF;


    /**
    *   
    */
    private Double lowF;


    /**
    *   
    */
    private Double closeF;


    /**
    *   
    */
    private Integer holdNumberF;


    public Double getOpenP() {
        return this.openP;
    }

    public void setOpenP(Double openP) {
        this.openP = openP;
    }

    public Double getHighF() {
        return this.highF;
    }

    public void setHighF(Double highF) {
        this.highF = highF;
    }

    public Double getLowF() {
        return this.lowF;
    }

    public void setLowF(Double lowF) {
        this.lowF = lowF;
    }

    public Double getCloseF() {
        return this.closeF;
    }

    public void setCloseF(Double closeF) {
        this.closeF = closeF;
    }

    public Integer getHoldNumberF() {
        return this.holdNumberF;
    }

    public void setHoldNumberF(Integer holdNumberF) {
        this.holdNumberF = holdNumberF;
    }


    @Override
    public String toString() {
        return "Ap805{" +
                    "dateP=" + dateP +
                    ", openP=" + openP +
                    ", highF=" + highF +
                    ", lowF=" + lowF +
                    ", closeF=" + closeF +
                    ", holdNumberF=" + holdNumberF +
                '}';
    }

    public Ap805() {
    }

    //构造函数
    public Ap805(Double openP, Double highF, Double lowF, Double closeF, Integer holdNumberF) {
            this.dateP=dateP;
            this.openP=openP;
            this.highF=highF;
            this.lowF=lowF;
            this.closeF=closeF;
            this.holdNumberF=holdNumberF;
    }

}

