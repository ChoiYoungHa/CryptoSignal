package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.persistance.mongo.IMongoMapper;
import poly.service.IMongoService;
import poly.util.DateUtil;

import javax.annotation.Resource;
import java.util.Date;

@Controller
public class MongoController {

    @Resource(name = "MongoService")
    private IMongoService mongoService;

    private Logger log = Logger.getLogger(this.getClass());

    // 컬렉션 생성 테스트
    @RequestMapping("mongoTest")
    @ResponseBody
    public String mongoTest() throws Exception {
        log.info("mongoTest Start!");

        String date = DateUtil.getDateTime("yyyyMMdd");

        boolean makeYn = mongoService.createCollection(date);

        log.info("이미 컬렉션이 존재하면 false : " + makeYn);
        log.info("mongoTest End!");
        return "success";
    }

















}
