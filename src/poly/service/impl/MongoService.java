package poly.service.impl;

import org.apache.log4j.Logger;

import org.springframework.stereotype.Service;
import poly.dto.NlpDTO;
import poly.persistance.mongo.IMongoMapper;
import poly.service.IMongoService;

import javax.annotation.Resource;
import java.io.*;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.*;
import java.util.regex.Matcher;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import poly.service.INlpService;

@Service("MongoService")
public class MongoService implements IMongoService {

    @Resource(name = "MongoMapper")
    private IMongoMapper mongoMapper;

    @Resource(name = "NlpService")
    private INlpService nlpService;

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
    public LinkedList<Map<String, String>> getRsiLog(String colNm, String collectTime, String userId, String minute, String coinCnt) throws Exception {
        return mongoMapper.getRsiLog(colNm, collectTime, userId, minute, coinCnt);
    }


    // 크롤링한 데이터 mongoDB 저장
    @Override
    public int insertCrawler() throws Exception {
        String url = "https://www.coinreaders.com/sub.html?page=";

        Document doc = null;

        String testPath = "/crawlData/coinReaders.txt";
        String OsFilePath = testPath.replaceAll("/", Matcher.quoteReplacement(File.separator));
        String reverseSlashPath = OsFilePath.replaceAll(Matcher.quoteReplacement(File.separator), "/");


        // 10페이지 링크주소가 담길 파일객체 생성
        FileWriter fw = new FileWriter(reverseSlashPath);
        BufferedWriter bw = new BufferedWriter(fw);

        // 10페이지 Document 객체 요청
        for (int i = 1; i <= 10; i++) {
            doc = Jsoup.connect(url + i).get();
            // iterator로 해당하는 element 태그들을 모두 저장
            Iterator<Element> title_list = doc.select("div.sub_read_list_box>dl>dt").iterator();
            while (title_list.hasNext()) {
                // href 속성의 데이터가 파라미터값만 존재하여 앞에 https 주소를 붙힘
                bw.write("https://www.coinreaders.com/" + title_list.next().
                        getElementsByAttribute("href").attr("href"));
                bw.newLine();
                bw.flush();
            }
        }

        // 링크주소를 불러옴
        FileReader rw = new FileReader(reverseSlashPath);

        BufferedReader br = new BufferedReader(rw);

        String readLine = null;

        ArrayList<Map<String, Object>> pList = new ArrayList<Map<String, Object>>();
        NlpDTO pDTO = new NlpDTO();

        while ((readLine = br.readLine()) != null) {
            doc = Jsoup.connect(readLine).get();

            // 메타데이터의 title 정보 크롤링
            String title = doc.select("head>title").text() + "\n";
            String content = doc.head().select("meta[name=description]").
                    first().attr("content") + "\n";
            // 메타데이터에서 게시일자 크롤링
            String date = doc.head().select("meta[property=article:published_time]").
                    first().attr("content") + "\n";

            pDTO.setWord(title);
            int point = nlpService.preProcessWordAnalysisForMind(pDTO);

            HashMap<String, Object> pMap = new HashMap<>();

            pMap.put("title", title);
            pMap.put("content", content);
            pMap.put("date", date);
            pMap.put("point", point);
            pMap.put("link", readLine);

            // pmap에 오피니언 마이닝한 결과 최종저장

            pList.add(pMap);
            pMap = null;
        }
        return mongoMapper.insertCrawler(pList);
    }

    @Override
    public List<Map<String, String>> getCryptoNews() throws Exception {
        return mongoMapper.getCryptoNews();
    }
}
