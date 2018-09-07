package webservice.axis.wsdd;

import org.apache.axis.AxisFault;
import org.apache.axis.MessageContext;
import org.apache.axis.handlers.BasicHandler;

public class HelloWorldHandler extends BasicHandler{

	private static final long serialVersionUID = 35629593982109022L;
	
	private static long COUNT =0L;
	
	private int requestCount =0;
	
	@Override
	public void invoke(MessageContext arg0) throws AxisFault {
		
		requestCount++;
		COUNT++;
		String status = (String) this.getOption("status");
		System.out.println("HelloWorldHandler's status is: "+status
				+", COUNT="+COUNT+", HandlerRequestCount="+requestCount);
	}

}
