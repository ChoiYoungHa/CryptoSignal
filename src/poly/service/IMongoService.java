package poly.service;

import poly.dto.RsiDTO;

public interface IMongoService {

    // 컬렉션 생성
    public boolean createCollection(String date) throws Exception;

    /**
     * RSI 로그 저장하기
     */
    public int insertRsiLog(RsiDTO pDTO, String colNm) throws Exception;
}
