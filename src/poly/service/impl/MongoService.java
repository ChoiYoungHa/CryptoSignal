package poly.service.impl;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import poly.dto.RsiDTO;
import poly.persistance.mongo.IMongoMapper;
import poly.service.IMongoService;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

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
    public int insertRsiLog(Map<String, Object> pMap, String ColNm) throws Exception {
        return mongoMapper.insertRsiLog(pMap, ColNm);
    }

    // RSI 로그 가져오기
    @Override
    public List<Map<String, String>> getUserInfo(Map<String, Object> pMap, String colNm) throws Exception {
        return mongoMapper.getRsiLog(pMap, colNm);
    }
}
