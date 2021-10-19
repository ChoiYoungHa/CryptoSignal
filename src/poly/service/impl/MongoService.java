package poly.service.impl;

import org.apache.log4j.Logger;

import org.springframework.stereotype.Service;
import poly.persistance.mongo.IMongoMapper;
import poly.service.IMongoService;

import javax.annotation.Resource;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.time.LocalDate;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

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
    public LinkedList<Map<String, String>> getRsiLog(String colNm, String collectTime, String userId, String minute) throws Exception {
        return mongoMapper.getRsiLog(colNm, collectTime, userId, minute);
    }


    // 크롤링한 데이터 mongoDB 저장
    @Override
    public int insertCrawler() throws Exception {
        String url = "https://www.coinreaders.com/sub.html?page=";

        Document doc = null;

        // 10페이지 링크주소가 담길 파일객체 생성
        FileWriter fw = new FileWriter("/crawlData/coinReaders.txt");
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
        FileReader rw = new FileReader("Base.코인리더스.txt");
        BufferedReader br = new BufferedReader(rw);

        String readLine = null;

        // 링크주소의 제목, 내용, 작성일 등을 SCD 형태로 저장할 파일 객체생성
        FileWriter result = new FileWriter("코인리더스_결과.scd");
        BufferedWriter rs = new BufferedWriter(result);

        while ((readLine = br.readLine()) != null) {
            doc = Jsoup.connect(readLine).get();

            // 메타데이터의 title 정보 크롤링
            String title = "^title : " + doc.select("head>title").text() + "\n";

            // 본문내용 p태그 4개 크롤링 후 이어붙히기
            String contentResult = "";
            for (int n = 0; n <= 4; n++) {
                String content = doc.select("div#textinput>p:eq(" + n + ")").text();
                contentResult += content;
            }

            // 메타데이터에서 게시일자 크롤링
            String date = "^date : " + doc.head().select("meta[property=article:published_time]").
                    first().attr("content") + "\n";
            String writer = "^writer : " + doc.select("div.writer_time>span.writer").first().text() + "\n";

            rs.write(title);
            // 이어붙힌 최종결과값 SCD 형태로 변환 후 저장
            rs.write("^content : " + contentResult + "\n");
            rs.write(date);
            rs.write(writer);
            rs.flush();

//          return mongoMapper.insertCrawler(pList);
    }
        return 1;
    }

}
