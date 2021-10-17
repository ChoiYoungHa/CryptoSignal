package poly.persistance.mongo.impl;

import java.util.*;
import java.util.function.Consumer;

import com.mongodb.BasicDBObject;
import com.mongodb.Cursor;
import com.mongodb.DBCursor;
import com.mongodb.client.MongoCursor;
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


@Mapper("MongoMapper")
public class MongoMapper extends AbstractMongoDBComon implements IMongoMapper {

    @Autowired
    private MongoTemplate mongodb;

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
    public LinkedList<Map<String, String>> getRsiLog(String colNm, String collectTime, String userId, String minute) {
        log.info(this.getClass().getName() + "getRsiLog Start!");

        LinkedList<Map<String, String>> rList = new LinkedList<Map<String, String>>();
        MongoCollection<Document> col = mongodb.getCollection(colNm);
        
        BasicDBObject whereQuery = new BasicDBObject();

        // 테스트 버튼으로 테스트
        whereQuery.put("collectTime", new BasicDBObject()
                .append("$gt", collectTime)
        );

        
        whereQuery.put("userId", userId);
        whereQuery.put("minute", minute);

        FindIterable<Document> rs = col.find(whereQuery);

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


}
