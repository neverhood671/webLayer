/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.java.dbobjects;

import java.util.Date;
import src.java.dao.*;

/**
 *
 * @author Настя
 */
public class Student implements Identified<Integer> {

    private int id;
    private String name;
    private Date birhtday;
    private int group;
    private int sal;

    public Integer getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBirhtday() {
        return birhtday;
    }

    public void setBirhtday(Date birhtday) {
        this.birhtday = birhtday;
    }

    public int getGroup() {
        return group;
    }

    public void setGroup(int group) {
        this.group = group;
    }

    public int getSal() {
        return sal;
    }

    public void setSal(int sal) {
        this.sal = sal;
    }

}
