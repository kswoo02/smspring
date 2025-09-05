package edu.sm.config;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;
import org.jasypt.encryption.StringEncryptor;
import org.jasypt.encryption.pbe.PooledPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimpleStringPBEConfig;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration // 이 클래스가 스프링의 설정 파일임을 나타냅니다.
@EnableEncryptableProperties // Jasypt를 사용해 application.yml의 속성을 복호화할 수 있도록 활성화합니다.
public class JasyptConfig {

    // application.yml 파일의 app.key.skey 값을 읽어와 skey 변수에 저장합니다.
    @Value("${app.key.skey}")
    private String skey;

    // 사용할 암호화 알고리즘을 상수로 정의합니다.
    private static final String ALGORITHM =  "PBEWithMD5AndDES";

    // "jasyptStringEncryptor"라는 이름으로 스프링 Bean을 등록합니다.
    // 이 Bean이 실제 암호화/복호화 작업을 수행합니다.
    @Bean("jasyptStringEncryptor")
    public StringEncryptor stringEncryptor() {
        PooledPBEStringEncryptor encryptor = new PooledPBEStringEncryptor();
        SimpleStringPBEConfig config = new SimpleStringPBEConfig();

        // ------------------- [수정된 부분] -------------------
        // config.setPassword(KEY); 또는 config.setPassword(mykey); 와 같이
        // 존재하지 않는 변수를 사용하던 오류를 수정합니다.
        config.setPassword(skey); // @Value로 주입받은 skey 변수를 사용하도록 고정합니다.
        // ---------------------------------------------------

        config.setAlgorithm(ALGORITHM); // 암호화 알고리즘 설정
        config.setKeyObtentionIterations("1000"); // 암호화 키를 얻기 위해 해시를 반복하는 횟수 (보안 강화)
        config.setPoolSize("1"); // 암호화/복호화 인스턴스를 하나만 생성
        config.setProviderName("SunJCE"); // 사용할 암호화 라이브러리 지정
        config.setSaltGeneratorClassName("org.jasypt.salt.RandomSaltGenerator"); // Salt(추가적인 암호화 값) 생성 방식 지정
        config.setStringOutputType("base64"); // 암호화된 결과물을 Base64로 인코딩하여 표현
        encryptor.setConfig(config); // 설정 정보를 암호화기에 적용

        return encryptor;
    }
}

