
package org.geongrid.sdsc.portlets.workflows;

import java.io.*;
import java.util.*;
import javax.servlet.UnavailableException; 
import org.gridlab.gridsphere.portlet.*; 
import org.gridlab.gridsphere.event.*;
//import org.geongrid.sdsc.portlets.log.*;
//import org.geongrid.mediator.*;


public class LidarPortlet extends AbstractPortlet {

    public PortletContext pcontext = null;
    String actionName;
//    String fromSubmit;

    public void init(PortletConfig config) throws UnavailableException {
        super.init(config);
        pcontext = getConfig().getContext();
    }


    public void doView(PortletRequest req, PortletResponse res)
	throws PortletException, IOException {

	PortletURI lidarUri = res.createURI();
	lidarUri.addAction("lidar");
	req.setAttribute("lidarUri", lidarUri.toString());

	PortletURI lidarProcUri = res.createURI();
	lidarProcUri.addAction("lidarProc");
	req.setAttribute("lidarProcUri", lidarProcUri.toString());
	System.out.print("lidarProcUri = " + lidarProcUri.toString());

	PortletURI lidarSubmitUri = res.createURI();
	lidarSubmitUri.addAction("lidarSubmit");
	req.setAttribute("lidarSubmitUri", lidarSubmitUri.toString());

        String username = req.getUser().getUserName();
        req.setAttribute("username", username);

	String appPath = pcontext.getRealPath("/");
	req.setAttribute("appPath", appPath);

	if (actionName == null ) {
/*	    if (fromSubmit != null && fromSubmit.equals("true")) {
                pcontext.include("/jsp/lidarProc.jsp", req, res);
	    } else {*/
            pcontext.include("/jsp/lidar.jsp", req, res);
//	    }
        } else if (actionName.equals("lidarSubmit")) {

            pcontext.include("/jsp/lidarSubmitNotification.jsp", req, res);

        } else if (actionName.equals("lidarProc")) {

            pcontext.include("/jsp/lidarProc.jsp", req, res);

	} else {

	    pcontext.include("/jsp/lidar.jsp", req, res);

	}

	this.actionName = null;
    }


    public void actionPerformed(ActionEvent evt) throws PortletException {

        PortletRequest req = evt.getPortletRequest();
        PortletResponse res = evt.getPortletResponse();

	this.actionName = evt.getActionString();
	System.out.println("action name => " + actionName);
        
/*	if (this.actionName == null) {
            this.fromSubmit = req.getParameter("fromSubmit");
	    System.out.println("fromSubmit? " + fromSubmit);
        }
*/
    }

}
          
