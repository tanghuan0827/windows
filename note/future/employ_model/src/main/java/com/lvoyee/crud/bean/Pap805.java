package com.lvoyee.crud.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

/**
* 描述：模型
* @author Ay
* @date 2017/05/03
*/
public class Pap805 {
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
    private Double highP;


    /**
    *   
    */
    private Double lowP;


    /**
    *   
    */
    private Double closeP;


    /**
    *   
    */
    private Integer holdNumberP;

    public Date getDateP() {
        return dateP;
    }

    public void setDateP(Date dateP) {
        this.dateP = dateP;
    }

    public Double getOpenP() {
        return this.openP;
    }

    public void setOpenP(Double openP) {
        this.openP = openP;
    }

    public Double getHighP() {
        return this.highP;
    }

    public void setHighP(Double highP) {
        this.highP = highP;
    }

    public Double getLowP() {
        return this.lowP;
    }

    public void setLowP(Double lowP) {
        this.lowP = lowP;
    }

    public Double getCloseP() {
        return this.closeP;
    }

    public void setCloseP(Double closeP) {
        this.closeP = closeP;
    }

    public Integer getHoldNumberP() {
        return this.holdNumberP;
    }

    public void setHoldNumberP(Integer holdNumberP) {
        this.holdNumberP = holdNumberP;
    }


    @Override
    public String toString() {
        return "Pap805{" +
                    "dateP=" + dateP +
                    ", openP=" + openP +
                    ", highP=" + highP +
                    ", lowP=" + lowP +
                    ", closeP=" + closeP +
                    ", holdNumberP=" + holdNumberP +
                '}';
    }

    public Pap805() {
    }

    //构造函数
    public Pap805(Double openP, Double highP, Double lowP, Double closeP, Integer holdNumberP) {
            this.dateP=dateP;
            this.openP=openP;
            this.highP=highP;
            this.lowP=lowP;
            this.closeP=closeP;
            this.holdNumberP=holdNumberP;
    }

}

