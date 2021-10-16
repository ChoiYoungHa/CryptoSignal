package poly.persistance.mongo;

import poly.dto.RsiDTO;

import java.util.Iterator;
import java.util.List;

public interface IMongoMapper {

    // 컬렉션 생성
    public boolean createCollection(String colNm) throws Exception;

    // RSI 저장
    /**
     * 멜론 노래 리스트 저장하기
     *
     * @param pList 저장될 정보
     * @param colNm 저장할 컬렉션 이름
     * @return 저장 결과
     */
    public int insertRsiLog(RsiDTO pDTO, String colNm) throws Exception;


}
