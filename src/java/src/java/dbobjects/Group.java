/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.java.dbobjects;

import src.java.dao.*;

/**
 *
 * @author Настя
 */
public class Group implements Identified<Integer> {

    private int groupnum;
    private int chiefId;
    private String profession;

  

    public void setId(int groupnum) {
        this.groupnum = groupnum;
    }

    public int getChiefId() {
        return chiefId;
    }

    public void setChiefId(int chiefId) {
        this.chiefId = chiefId;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    @Override
    public Integer getId() {
        return groupnum;
    }

}
