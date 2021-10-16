package poly.persistance.mongo.impl;

import java.util.*;
import java.util.function.Consumer;

import com.mongodb.BasicDBObject;
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

    @Override
    public List<Map<String, String>> getRsiLog(Map<String, Object> pMap, String colNm) {
        log.info(this.getClass().getName() + "getUserInfo Start!");

        List<Map<String, String>> rList = new LinkedList<>();

        MongoCollection<Document> collection = mongodb.getCollection(colNm);

        Document query = new Document(pMap);

        Consumer<Document> processBlock = document -> {

            Map<String, String> rMap = new HashMap<>();

            String site_name = document.getString("site_name");
            String site_address = document.getString("site_address");
            String site_id = document.getString("site_id");
            String site_pw = document.getString("site_pw");

            rMap.put("site_name", site_name);
            rMap.put("site_address", site_address);
            rMap.put("site_id", site_id);
            rMap.put("site_pw", site_pw);

            rList.add(rMap);

            rMap = null;
        };

        collection.find(query).forEach(processBlock);

        log.info(this.getClass().getName() + "getUserInfo End!");

        return rList;
    }


}
