package com.lec.spring.service.calendar;

import com.lec.spring.domain.QryResult;
import com.lec.spring.domain.calendar.Calendar;
import com.lec.spring.domain.calendar.QryCalendarList;
import com.lec.spring.domain.menu.Menu;
import com.lec.spring.repository.calendar.CalendarRepository;
import com.lec.spring.repository.menu.MenuRepository;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class CalendarServiceImpl implements CalendarService {

    private CalendarRepository calendarRepository;

    private MenuRepository menuRepository;

    @Autowired
    public CalendarServiceImpl(SqlSession sqlSession) {
        calendarRepository = sqlSession.getMapper(CalendarRepository.class);
        menuRepository = sqlSession.getMapper(MenuRepository.class);
    }

    // 모든 일정 불러오기
    @Override
    public QryCalendarList findAll() {
        QryCalendarList list = new QryCalendarList();

        List<Calendar> calendars = calendarRepository.selectAll();

        list.setCount(calendars.size());
        list.setList(calendars);
        list.setStatus("OK");

        return list;
    }

    // 특정 날짜 불러오기
    public Calendar findById(Long id) {
        Calendar calendar = calendarRepository.findById(id);
        return calendar;
    }

    // 메모 추가
    @Override
    public QryResult addByMemo(String memo, String dateString){

        QryResult result = new QryResult();

        try {
            // 날짜 문자열을 "yyyyMMdd" 형식의 정수로 변환
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate date = LocalDate.parse(dateString, formatter);
            int id = Integer.parseInt(date.format(DateTimeFormatter.ofPattern("yyyyMMdd")));

            // Calendar 객체 생성
            Calendar calendar = Calendar.builder()
                    .id((long) id)
                    .date(dateString)
                    .memo(memo)
                    .build();

            // 데이터베이스에 삽입
            int cnt = calendarRepository.insertByMemo(calendar);

            result.setCount(cnt);
            result.setStatus("OK");
        } catch (Exception e) {
            result.setCount(0);
            result.setStatus("Error: " + e.getMessage());
        }
        return result;
    }

    // 오늘의 메뉴 추가
    @Override
    public QryResult addByMenu(Long menu_id, String comment, String dateString) {
        QryResult result = new QryResult();
        Menu menu = menuRepository.findById(menu_id);

        try {
            // 날짜 문자열을 "yyyyMMdd" 형식의 정수로 변환
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate date = LocalDate.parse(dateString, formatter);
            int id = Integer.parseInt(date.format(DateTimeFormatter.ofPattern("yyyyMMdd")));

            // Calendar 객체 생성
            Calendar calendar = Calendar.builder()
                    .id((long) id)
                    .date(dateString)
                    .menu_id(menu.getId())
                    .comment(comment)
                    .build();

            // 데이터베이스에 삽입
            int cnt = calendarRepository.insertByMenu(calendar);

            result.setCount(cnt);
            result.setStatus("OK");
        }catch (Exception e) {
            result.setCount(0);
            result.setStatus("Error: " + e.getMessage());
        }
        return result;
    }

    // 캘린더 데이터(메모, 오늘의 메뉴) 수정
    @Override
    public QryResult update(Long id, Long menu_id, String comment, String memo){
        Menu menu = null;
        Long menuId = null;

        if (menu_id != null) {
            menu = menuRepository.findById(menu_id);
            if (menu != null) {
                menuId = menu.getId();
            }
        }

        Calendar calendar = Calendar.builder()
                .id(id)
                .menu_id(menuId) // menuId 변수를 사용하여 메뉴 ID를 설정
                .comment(comment)
                .memo(memo)
                .build();

        // 필요한 경우 메뉴가 존재하는지 확인 후 추가 작업 수행
        if (menu != null) {
            calendar.setMenu_id(menu.getId());
        }

        int cnt = calendarRepository.updateCalendar(calendar);

        QryResult result = QryResult.builder()
                .count(cnt)
                .status("OK")
                .build();

        return result;
    }

    // 메모 삭제
    @Override
    public QryResult updateToDeleteMemo(Long id, String memo) {
        Calendar calendar = Calendar.builder()
                .id(id)
                .memo(memo)
                .build();

        int cnt = calendarRepository.updateToDeleteMemo(calendar);

        QryResult result = QryResult.builder()
                .count(cnt)
                .status("OK")
                .build();

        return result;
    }

    // 오늘의 메뉴 삭제
    @Override
    public QryResult updateToDeleteMenu(Long id, Long menu_id, String comment) {
        Menu menu = menuRepository.findById(menu_id);

        Calendar calendar = Calendar.builder()
                .id(id)
                .menu_id(menu.getId())
                .comment(comment)
                .build();

        int cnt = calendarRepository.updateToDeleteMenu(calendar);

        QryResult result = QryResult.builder()
                .count(cnt)
                .status("OK")
                .build();

        return result;
    }

    // 캘린더 데이터 삭제 (전체 삭제)
    @Override
    public QryResult deleteById(Long id) {
        int cnt = calendarRepository.deleteById(id);

        QryResult result = QryResult.builder()
                .count(cnt)
                .status("OK")
                .build();

        return result;
    }
}
