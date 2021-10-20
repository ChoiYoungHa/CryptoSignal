package poly.persistance.mongo.impl;

import java.util.*;
import java.util.function.Consumer;

import com.mongodb.BasicDBObject;
import com.mongodb.Cursor;
import com.mongodb.DBCursor;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.result.DeleteResult;
import config.Mapper;
import org.apache.log4j.Logger;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Component;

import com.mongodb.client.AggregateIterable;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;


import poly.dto.RsiDTO;
import poly.persistance.mongo.IMongoMapper;
import poly.persistance.mongo.comm.AbstractMongoDBComon;
import poly.util.CmmUtil;

import javax.annotation.Resource;


@Mapper("MongoMapper")
public class MongoMapper extends AbstractMongoDBComon implements IMongoMapper {

    @Autowired
    private MongoTemplate mongodb;

    @Resource(name = "MongoMapper")
    private IMongoMapper mongoMapper;

    private Logger log = Logger.getLogger(this.getClass());


    // 컬렉션 생성
    @Override
    public boolean createCollection(String colNm) throws Exception {
        log.info("createCollection Start!");

        if (mongodb.collectionExists(colNm)) {
            // 파일이 이미 있으면 return false
            return false;
        }

        // 복합키 생성 및 인덱스 생성 (복합키로 수집시간, 유저번호)
//        mongodb.createCollection(colNm).createIndex(new BasicDBObject("collectTime",1).append("userId",1)
//        , "rsiIdx");
        log.info("createCollection End!");

        return true;
    }

    // RSI 저장
    @Override
    public int insertRsiLog(Map<String, Object> pMap, String colNm) throws Exception {
        log.info(this.getClass().getName() + ".insertRsiLog Start!");

        int res = 0;

        if (pMap == null) {
            pMap = new HashMap();
        }

        String[] it = {"collectTime", "userId"};

        // 데이터를 저장할 컬렉션 생성
        super.createCollection(colNm, it);

        // 저장할 컬렉션 객체 생성
        MongoCollection<Document> collection = mongodb.getCollection(colNm);

        collection.insertOne(new Document(pMap));

        res = 1;

        log.info(this.getClass().getName() + ".insertRsiLog End!");

        return res;
    }

    // RSI 데이터 가져오기
    @Override
    public LinkedList<Map<String, String>> getRsiLog(String colNm, String collectTime, String userId, String minute, String coinCnt) {
        log.info(this.getClass().getName() + "getRsiLog Start!");

        LinkedList<Map<String, String>> rList = new LinkedList<Map<String, String>>();
        MongoCollection<Document> col = mongodb.getCollection(colNm);
        
        BasicDBObject whereQuery = new BasicDBObject();

        int limit = Integer.parseInt(coinCnt);

        // 테스트 버튼으로 테스트
//        whereQuery.put("collectTime", new BasicDBObject()
//                .append("$gt", collectTime)
//        );

        whereQuery.put("userId", userId);
        whereQuery.put("collectTime", collectTime);
        whereQuery.put("minute", minute);


        FindIterable<Document> rs = col.find(whereQuery).sort(new BasicDBObject("_id",-1)).limit(limit);

        Iterator<Document> cursor = rs.iterator();

        while (cursor.hasNext()) {
            Document doc = cursor.next();

            if (doc == null) {
                doc = new Document();
            }

            String symbol = CmmUtil.nvl(doc.getString("symbol"));
            String rsi = CmmUtil.nvl(doc.getString("rsi"));
            String getMinute = CmmUtil.nvl(doc.getString("minute"));
            String getCollectTime = CmmUtil.nvl(doc.getString("collectTime"));

            log.info("symbol : " + symbol);
            log.info("rsi : " + rsi);
            log.info("getMinute : " + getMinute);
            log.info("getCollectTime : " + getCollectTime);

            Map<String, String> rMap = new LinkedHashMap<String, String>();

            rMap.put("symbol", symbol);
            rMap.put("rsi", rsi);
            rMap.put("getMinute", getMinute);
            rMap.put("getCollectTime", getCollectTime);
            rList.add(rMap);

            rMap = null;
            doc = null;
        }

        cursor = null;
        rs = null;
        col = null;

        log.info(this.getClass().getName() + "getRsiLog End!");

        return rList;
    }

    // MongoDB에 크롤링한 데이터저장
    @Override
    public int insertCrawler(List<Map<String, Object>> pList) throws Exception {
        log.info(this.getClass().getName() + ".insertRsiLog Start!");

        int res = 0;

        if (pList == null) {
            pList = new ArrayList<>();
        }

        String colNm = "Crawler";
        int deleteNewsResult = mongoMapper.deleteNewsInfo();
        log.info("deleteNewsResult 성공 1, 실패 0" + deleteNewsResult);
        super.createCollection(colNm);

        // 저장할 컬렉션 객체 생성
        MongoCollection<Document> collection = mongodb.getCollection(colNm);

        Iterator<Map<String, Object>> it = pList.iterator();
        while (it.hasNext()) {
            Map<String, Object> rMap = it.next();
            collection.insertOne(new Document(rMap));
        }

        res = 1;

        log.info(this.getClass().getName() + ".insertRsiLog End!");

        return res;
    }


    // 몽고디비 news 데이터 요청
    @Override
    public List<Map<String, String>> getCryptoNews() throws Exception {
        log.info(this.getClass().getName() + "getCryptoNews Start!");

        List<Map<String, String>> rList = new LinkedList<Map<String, String>>();

        String colNm = "Crawler";

        MongoCollection<Document> col = mongodb.getCollection(colNm);

      //  MongoCursor<Document> cursor = col.find().iterator();
        FindIterable<Document> rs = col.find();
        Iterator<Document> cursor = rs.iterator();
        log.info("cursor 까지");

        if (cursor == null) {
            log.info("cursor is null");
        }

        log.info("iterator 시작");
        try{
            while (cursor.hasNext()) {
                Document doc = cursor.next();

                if (doc == null) {
                    doc = new Document();
                }

                log.info("데이터 받기 시작!");
                String title = CmmUtil.nvl(doc.getString("title"));
                log.info("title : " + title);
                String content = CmmUtil.nvl(doc.getString("content"));
                log.info("content : " + content);
                String date = CmmUtil.nvl(doc.getString("date"));
                log.info("date : " + date);
                String point = Integer.toString(doc.getInteger("point"));
                log.info("point : " + point);
                String link = CmmUtil.nvl(doc.getString("link"));
                log.info("link : " + link);
                log.info("데이터 받기 끝!");


                Map<String, String> rMap = new HashMap<String, String>();

                rMap.put("title", title);
                rMap.put("content", content);
                rMap.put("date", date);
                rMap.put("point", point);
                rMap.put("link", link);
                rList.add(rMap);

                rMap = null;
                doc = null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        cursor = null;
        col = null;

        log.info(this.getClass().getName() + "getRsiLog End!");

        return rList;
    }



    // 몽고디비 데이터 삭제
    @Override
    public int deleteNewsInfo() {
        log.info(this.getClass().getName() + "deleteNewsInfo start");

        MongoCollection<Document> col = null;
        Iterator<Document> cursor = null;
        FindIterable<Document> dRs = null;

        /*
         * #############################################################################
         * 기 등록된 데이터 사전 삭제 시작!
         * #############################################################################
         */

        String colNm = "Crawler";
        col = mongodb.getCollection(colNm);

        Document document = new Document();

        dRs = col.find(document);
        cursor = dRs.iterator();
        DeleteResult deleteResult = null;
        int res = 0;

        if(cursor.hasNext()) {

            while (cursor.hasNext()) {
                deleteResult = col.deleteOne(cursor.next());
            }

            res = (int) deleteResult.getDeletedCount();

        }
        cursor = null;
        dRs = null;
        col = null;
        deleteResult = null;
		/*
	    MongoCollection<Document> collection = mongodb.getCollection(colNm);

	    DeleteResult deleteResult = collection.deleteOne(new Document(pMap));
	    int res = (int) deleteResult.getDeletedCount();
		*/
        log.info(this.getClass().getName() + "deleteUserInfo end");

        return res;
    }


}
