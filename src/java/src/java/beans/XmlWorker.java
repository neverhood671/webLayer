/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.java.beans;

import java.util.List;
//import javax.ejb.EJB;
//import javax.inject.Named;
//import javax.ws.rs.Path;


import src.java.dao.Identified;

/**
 *
 * @author Настя
 */

//@EJB
public interface XmlWorker {
    
    String convertToHtml(List<Identified> objs);
    
}
