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
        private Date dateF;

    /**
    *   
    */
    private String rankF;


    /**
    *   
    */
    private String nameF;


    /**
    *   
    */
    private Double longF;


    /**
    *   
    */
    private Double longChangeF;


    /**
    *   
    */
    private String longPercentF;


    /**
    *   
    */
    private Double shoftF;


    /**
    *   
    */
    private Double shortChangeF;


    /**
    *   
    */
    private String shortPercentF;


    /**
    *   
    */
    private Double netLongF;


    /**
    *   
    */
    private Double netLongChangeF;


    /**
    *   
    */
    private Double netShortF;


    /**
    *   
    */
    private Double netShortChangeF;


    /**
    *   
    */
    private String netShortChangePercentF;


    /**
    *   
    */
    private Double volumneF;


    /**
    *   
    */
    private Double volumneChangeF;


    /**
    *   
    */
    private String volumePercentF;


    /**
    *   
    */
    private Double clearPriceF;

    public Date getDateF() {
        return dateF;
    }

    public void setDateF(Date dateF) {
        this.dateF = dateF;
    }

    public String getRankF() {
        return this.rankF;
    }

    public void setRankF(String rankF) {
        this.rankF = rankF;
    }

    public String getNameF() {
        return this.nameF;
    }

    public void setNameF(String nameF) {
        this.nameF = nameF;
    }

    public Double getLongF() {
        return this.longF;
    }

    public void setLongF(Double longF) {
        this.longF = longF;
    }

    public Double getLongChangeF() {
        return this.longChangeF;
    }

    public void setLongChangeF(Double longChangeF) {
        this.longChangeF = longChangeF;
    }

    public String getLongPercentF() {
        return this.longPercentF;
    }

    public void setLongPercentF(String longPercentF) {
        this.longPercentF = longPercentF;
    }

    public Double getShoftF() {
        return this.shoftF;
    }

    public void setShoftF(Double shoftF) {
        this.shoftF = shoftF;
    }

    public Double getShortChangeF() {
        return this.shortChangeF;
    }

    public void setShortChangeF(Double shortChangeF) {
        this.shortChangeF = shortChangeF;
    }

    public String getShortPercentF() {
        return this.shortPercentF;
    }

    public void setShortPercentF(String shortPercentF) {
        this.shortPercentF = shortPercentF;
    }

    public Double getNetLongF() {
        return this.netLongF;
    }

    public void setNetLongF(Double netLongF) {
        this.netLongF = netLongF;
    }

    public Double getNetLongChangeF() {
        return this.netLongChangeF;
    }

    public void setNetLongChangeF(Double netLongChangeF) {
        this.netLongChangeF = netLongChangeF;
    }

    public Double getNetShortF() {
        return this.netShortF;
    }

    public void setNetShortF(Double netShortF) {
        this.netShortF = netShortF;
    }

    public Double getNetShortChangeF() {
        return this.netShortChangeF;
    }

    public void setNetShortChangeF(Double netShortChangeF) {
        this.netShortChangeF = netShortChangeF;
    }

    public String getNetShortChangePercentF() {
        return this.netShortChangePercentF;
    }

    public void setNetShortChangePercentF(String netShortChangePercentF) {
        this.netShortChangePercentF = netShortChangePercentF;
    }

    public Double getVolumneF() {
        return this.volumneF;
    }

    public void setVolumneF(Double volumneF) {
        this.volumneF = volumneF;
    }

    public Double getVolumneChangeF() {
        return this.volumneChangeF;
    }

    public void setVolumneChangeF(Double volumneChangeF) {
        this.volumneChangeF = volumneChangeF;
    }

    public String getVolumePercentF() {
        return this.volumePercentF;
    }

    public void setVolumePercentF(String volumePercentF) {
        this.volumePercentF = volumePercentF;
    }

    public Double getClearPriceF() {
        return this.clearPriceF;
    }

    public void setClearPriceF(Double clearPriceF) {
        this.clearPriceF = clearPriceF;
    }


    @Override
    public String toString() {
        return "Ap805{" +
                    "dateF=" + dateF +
                    ", rankF='" + rankF + '\'' +
                    ", nameF='" + nameF + '\'' +
                    ", longF=" + longF +
                    ", longChangeF=" + longChangeF +
                    ", longPercentF='" + longPercentF + '\'' +
                    ", shoftF=" + shoftF +
                    ", shortChangeF=" + shortChangeF +
                    ", shortPercentF='" + shortPercentF + '\'' +
                    ", netLongF=" + netLongF +
                    ", netLongChangeF=" + netLongChangeF +
                    ", netShortF=" + netShortF +
                    ", netShortChangeF=" + netShortChangeF +
                    ", netShortChangePercentF='" + netShortChangePercentF + '\'' +
                    ", volumneF=" + volumneF +
                    ", volumneChangeF=" + volumneChangeF +
                    ", volumePercentF='" + volumePercentF + '\'' +
                    ", clearPriceF=" + clearPriceF +
                '}';
    }

    public Ap805() {
    }

    //构造函数
    public Ap805(String rankF, String nameF, Double longF, Double longChangeF, String longPercentF, Double shoftF, Double shortChangeF, String shortPercentF, Double netLongF, Double netLongChangeF, Double netShortF, Double netShortChangeF, String netShortChangePercentF, Double volumneF, Double volumneChangeF, String volumePercentF, Double clearPriceF) {
            this.dateF=dateF;
            this.rankF=rankF;
            this.nameF=nameF;
            this.longF=longF;
            this.longChangeF=longChangeF;
            this.longPercentF=longPercentF;
            this.shoftF=shoftF;
            this.shortChangeF=shortChangeF;
            this.shortPercentF=shortPercentF;
            this.netLongF=netLongF;
            this.netLongChangeF=netLongChangeF;
            this.netShortF=netShortF;
            this.netShortChangeF=netShortChangeF;
            this.netShortChangePercentF=netShortChangePercentF;
            this.volumneF=volumneF;
            this.volumneChangeF=volumneChangeF;
            this.volumePercentF=volumePercentF;
            this.clearPriceF=clearPriceF;
    }

}

