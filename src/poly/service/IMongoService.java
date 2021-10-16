package poly.service;

import poly.dto.RsiDTO;

import java.util.List;
import java.util.Map;

public interface IMongoService {

    // 컬렉션 생성
    public boolean createCollection(String date) throws Exception;

    /**
     * RSI 로그 저장하기
     */
    public int insertRsiLog(Map<String, Object> pMap, String colNm) throws Exception;

    // RSI 로그 가져오기
    public List<Map<String, String>> getUserInfo(Map<String, Object> pMap, String colNm) throws Exception;

}
