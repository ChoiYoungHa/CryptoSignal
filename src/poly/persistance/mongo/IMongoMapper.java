package poly.persistance.mongo;

import poly.dto.RsiDTO;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

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
    public int insertRsiLog(Map<String, Object> pMap, String colNm) throws Exception;

    // RSI 가져오기
    public LinkedList<Map<String, String>> getRsiLog(String colNm, String collectTime, String userId, String minute);

    // Crawling 데이터 저장
    public int insertCrawler(List<Map<String, Object>> pList) throws Exception;

    // CryptoNews 가져오기
    public LinkedList<Map<String, String>> getCryptoNews() throws Exception;

    // 뉴스 컬렉션 삭제
    public int deleteNewsInfo() throws Exception;


}
