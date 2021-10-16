package poly.service.impl;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import poly.dto.RsiDTO;
import poly.persistance.mongo.IMongoMapper;
import poly.service.IMongoService;

import javax.annotation.Resource;
import java.time.LocalDate;

@Service("MongoService")
public class MongoService implements IMongoService {

    @Resource(name = "MongoMapper")
    private IMongoMapper mongoMapper;

    private Logger log = Logger.getLogger(this.getClass());

    // 컬렉션 생성
    @Override
    public boolean createCollection(String date) throws Exception {
        // 컬렉션명은 현재날짜
        return mongoMapper.createCollection(date);
    }

    // RSI 로그 저장
    @Override
    public int insertRsiLog(RsiDTO pDTO, String ColNm) throws Exception {
        return mongoMapper.insertRsiLog(pDTO, ColNm);
    }
}
