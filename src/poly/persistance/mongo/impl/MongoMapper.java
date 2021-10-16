package poly.persistance.mongo.impl;

import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

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
        mongodb.createCollection(colNm).createIndex(new BasicDBObject("collectTime",1).append("userId",1)
        , "rsiIdx");
        log.info("createCollection End!");

        return true;
    }

    // RSI 저장
    @Override
    public int insertRsiLog(RsiDTO pDTO, String colNm) throws Exception {
        log.info(this.getClass().getName() + ".insertRsiLog Start!");

        int res = 0;

        if (pDTO == null) {
            pDTO = new RsiDTO();
        }

        // 데이터를 저장할 컬렉션 생성
        super.createCollection(colNm, "collectTime");

        // 저장할 컬렉션 객체 생성
        MongoCollection<Document> col = (MongoCollection<Document>) mongodb.getCollection(colNm);

        String collectTime = CmmUtil.nvl(pDTO.getCollectTime());
        String minute = CmmUtil.nvl(pDTO.getMinute());
        String userId = CmmUtil.nvl(pDTO.getUser_id());
        String rsi = CmmUtil.nvl(pDTO.getRsi());

        log.info("collectTime : " + collectTime);
        log.info("minute : " + minute);
        log.info("userId : " + userId);
        log.info("rsi : " + rsi);

        // 2.xx 버전의 MongoDB 저장은 Document 단위로 구성됨
        Document doc = new Document();

        doc.append("collectTime", collectTime);
        doc.append("minute", minute);
        doc.append("userId", userId);
        doc.append("rsi", rsi);

        // 레코드 한개씩 저장하기
        col.insertOne(doc);

        doc = null;

        col = null;

        res = 1;

        log.info(this.getClass().getName() + ".insertRsiLog End!");

        return res;
    }


}
