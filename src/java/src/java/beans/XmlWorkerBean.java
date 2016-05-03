/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.java.beans;

import java.io.ByteArrayOutputStream;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
//import javax.ejb.Stateless;
//import javax.ws.rs.Path;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import src.java.dao.Identified;

/**
 *
 * @author Настя
 */

//@Stateless
public class XmlWorkerBean implements XmlWorker {

    @Override
    public String convertToHtml(List<Identified> objs) {
        StringBuilder xmlSrt = new StringBuilder();
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(objs.iterator().next().getClass());
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            for (Identified object : objs) {
                jaxbMarshaller.marshal(object, outStream);
            }
            return new String(outStream.toByteArray());
        } catch (JAXBException ex) {
            Logger.getLogger(XmlWorkerBean.class.getName()).log(Level.SEVERE, null, ex);

        }
        return null;
    }
}
