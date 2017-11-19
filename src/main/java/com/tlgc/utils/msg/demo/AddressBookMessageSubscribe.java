package com.tlgc.utils.msg.demo;

import com.tlgc.utils.msg.config.AppConfig;
import com.tlgc.utils.msg.lib.ADDRESSBOOKMessage;
import com.tlgc.utils.msg.utils.ConfigLoader;

public class AddressBookMessageSubscribe {

	public static void main(String[] args) {

		AppConfig config = ConfigLoader.load(ConfigLoader.ConfigType.Message);
		ADDRESSBOOKMessage addressbook = new ADDRESSBOOKMessage(config);
		//addressbook.setAddress("186****7150");
		addressbook.subscribe();
	}	
}
