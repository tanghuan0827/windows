package webservice.axis.wsdd;

import java.rmi.RemoteException;

import javax.xml.namespace.QName;
import javax.xml.rpc.ServiceException;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

public class ClientWSDDHandler {

	public static void main(String[] args) {
		try{
			String url="http://127.0.0.1:8080/axis/services/HelloWorldWSDDHandler";
			Service serv  = new Service();
			Call call = (Call) serv.createCall();
			call.setTargetEndpointAddress(url);
			
			call.setOperationName(new QName(url, "hello"));
			String result = (String) call.invoke(new Object[]{"Quhailong"});
			System.out.println("result ="+result);
			
			call.setOperationName(new QName(url, "add"));
			Float returnValue = (Float) call.invoke(new Object[]{new Float(3.2), new Float(2.3)});
			
			
		}catch(ServiceException e){
			e.printStackTrace();
		}catch(RemoteException e){
			e.printStackTrace();
		}
	}
}
