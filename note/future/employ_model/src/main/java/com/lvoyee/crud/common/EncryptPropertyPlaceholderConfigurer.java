package com.lvoyee.crud.common;

import com.github.pagehelper.util.StringUtil;
import com.lvoyee.crud.utils.AesUtil;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

import java.util.Properties;

public class EncryptPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
    //第二种方式
    protected void processProperties(ConfigurableListableBeanFactory beanFactory, Properties props){
        String key = "AkxfGVoMiKDxUiJM";
        String iv = "1841611841611010";

        try {
            String userKey = "jdbc.user";
            String passwordKey = "jdbc.password";

            String user = props.getProperty(userKey);
            String password = props.getProperty(passwordKey);

            if (StringUtil.isNotEmpty(user)) {
                props.setProperty(userKey, AesUtil.decrypt(user, key, iv));
            }

            if (StringUtil.isNotEmpty(password)) {
                props.setProperty(passwordKey, AesUtil.decrypt(password, key, iv));
            }
            super.processProperties(beanFactory, props);
        }catch(Exception e){
            throw new BeanInitializationException(e.getMessage());
        }
    }
}
