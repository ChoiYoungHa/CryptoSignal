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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

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

    // flask 서버로부터 받은 전체 로그 mongoDB 저장
    @RequestMapping(value = "/rsiLogSave")
    public void rsiResponse(HttpServletRequest request) throws Exception {
        String symbol = CmmUtil.nvl(request.getParameter("symbol"));
        String minute = CmmUtil.nvl(request.getParameter("minute"));
        String userId = CmmUtil.nvl(request.getParameter("userId"));
        String rsi = CmmUtil.nvl(request.getParameter("rsi"));
        String collectTime = CmmUtil.nvl(request.getParameter("collectTime"));

        //       String collectTime = DateUtil.getDateTime("yyyyMMddHHmmss");

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
    }


    // RSI 로그 데이터 요청
    @RequestMapping("getRsiLog")
    @ResponseBody
    public List<Map<String, String>> getRsiLog(HttpServletRequest request) throws Exception {
        log.info("getRsiLog Start!");

        // 데이터를 가져올 컬렉션
        String colNm = DateUtil.getDateTime("yyyy-MM-dd");
        String collectTime = CmmUtil.nvl(request.getParameter("currentDate"));

        // 요청한 시간 이후에 데이터만 요청
//        String collectTime = DateUtil.getDateTime("yyyyMMddHHmmss");
//        long requestTime = Long.parseLong(collectTime) - 30;
//        log.info("requestTime : " + requestTime);
//        String strRequestTime = String.valueOf(requestTime);

        String userId = CmmUtil.nvl(request.getParameter("userId"));
        String minute = CmmUtil.nvl(request.getParameter("minute"));

        log.info("colNm : " + colNm);
        log.info("collectTime : " + collectTime);
        log.info("userId : " + userId);
        log.info("minute : " + minute);

        LinkedList<Map<String, String>> rList = mongoService.getRsiLog(colNm, collectTime, userId, minute);

        if (rList == null) {
            rList = new LinkedList<>();
        }

        Iterator<Map<String, String>> it = rList.iterator();

        while (it.hasNext()) {
            Map<String, String> rMap = it.next();
            log.info("rMap.getSymbol : " + rMap.get("symbol"));
            log.info("rMap.getRsi : " + rMap.get("rsi"));
            log.info("rMap.getMinute : " + rMap.get("getMinute"));
            log.info("rMap.getCollectTime : " + rMap.get("getCollectTime"));
        }
        log.info("getRsiLog End!");

        return rList;
    }


    // 크롤링 후 오피니언 마이닝 mongo 저장
    @RequestMapping(value = "getCryptoNews")
    public void getCryptoNews() throws Exception {
        log.info("getCryptoNews Start!");
        int i = mongoService.insertCrawler();
        log.info(i);

        log.info("크롤링 중");
        log.info("getCryptoNews End!");
    }


}
