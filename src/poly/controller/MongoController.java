package poly.controller;

import org.apache.log4j.Logger;
import org.jsoup.helper.DataUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import poly.dto.RsiDTO;
import poly.persistance.mongo.IMongoMapper;
import poly.service.IMongoService;
import poly.util.CmmUtil;
import poly.util.DateUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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

        String date = DateUtil.getDateTime("yyyy-MM-dd");
        boolean makeYn = mongoService.createCollection(date);

        log.info("이미 컬렉션이 존재하면 false : " + makeYn);
        log.info("mongoTest End!");
        return "success";
    }

    // 전체 로그저장
    @RequestMapping(value = "/rsiLogSave")
    public void rsiResponse(HttpServletRequest request) throws Exception {
        String symbol = CmmUtil.nvl(request.getParameter("symbol"));
        String minute = CmmUtil.nvl(request.getParameter("minute"));
        String userId = CmmUtil.nvl(request.getParameter("userId"));
        String rsi = CmmUtil.nvl(request.getParameter("rsi"));

        String collectTime = DateUtil.getDateTime("yyyyMMddHHmmss");

        // 파이썬 서버로부터 rsi 받고 세션에서 회원번호받고 컬렉션저장데이터는 년월일시분초 단위
        // 그냥 컬렉션은 년월일만

        log.info("symbol :" + symbol);
        log.info("minute : " + minute);
        log.info("userId : " + userId);
        log.info("rsi : " + rsi);

        Map pMap = new HashMap();

        pMap.put("symbol", symbol);
        pMap.put("minute", minute);
        pMap.put("userId", userId);
        pMap.put("rsi", rsi);
        pMap.put("collectTime", collectTime);


        // 현재일자로 컬렉션 생성
        String date = DateUtil.getDateTime("yyyy-MM-dd");
        int res = mongoService.insertRsiLog(pMap, date);
        log.info("저장 성공 1, 아님 0 : " + res);

        String result = symbol + "코인은" + minute + "분봉기준" + "RSI 30 과매도 구간입니다.";

        // mongo 저장하고 프론트에서 5초마다 ajax로 몽고디비에 저장된 로그 요청
    }



















}
