package com.tlgc.utils.msg.demo;

import com.tlgc.utils.msg.config.AppConfig;
import com.tlgc.utils.msg.lib.MESSAGEXsend;
import com.tlgc.utils.msg.utils.ConfigLoader;

public class MessageXSendDemo {

	public static void main(String[] args) {
		AppConfig config = ConfigLoader.load(ConfigLoader.ConfigType.Message);
		MESSAGEXsend submail = new MESSAGEXsend(config);
		submail.addTo("18516693801");
		submail.setProject("13698");
		submail.addVar("code", "测试短信12345");

		submail.xsend();
	}	
}
