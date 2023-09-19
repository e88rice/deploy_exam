package com.example.mvc.service;


import com.example.mvc.model.BoardDAO;
import com.example.mvc.model.BoardDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

public class BoardService {
    static final int LISTCOUNT = 5; // 페이지당 보여줄 게시물 숫자
    // 싱글톤 타입으로 작성
    private static BoardService instance;

    public static BoardService getInstance() {
        if (instance == null) instance = new BoardService();
        return instance;
    }

    public void requestBoardList(HttpServletRequest request) {
        // 등록된 글 목록 가져오기
        BoardDAO dao = BoardDAO.getInstance();
        List<BoardDTO> boardList;

        int pageNum = 1; // 페이지 번호의 기본 값
        int limit = LISTCOUNT; // 페이지당 게시물 수
        if(request.getParameter("pageNum") != null) { // 페이지 번호를 넘겨받았다면
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }

        String items = request.getParameter("items"); // 검색어
        String text = request.getParameter("text"); //

        int totalRecord = dao.getListCount(items, text);
        boardList = dao.getBoardList(pageNum, limit, items, text);

        int totalPage; // 전체 페이지 계산

        if(totalRecord % limit == 0) {      // 가져온 데이터가 리밋으로 나눴을 때 나머지 없이 딱 떨어진다면
            totalPage = totalRecord/limit;  // 딱 떨어지니까 나누기만 하면 총 페이지수가 나옴
            Math.floor(totalPage);          // 소수점 버림
        } else {                            // 총 페이지당 게시물이 딱 떨어지지 않았을 때
            totalPage = totalRecord / limit;// 일단 나눔
            Math.floor(totalPage);          // 소수점 버림
            totalPage = totalPage + 1;      // 총 페이지에 +1 추가 (나머지들 보여줄 영역)
        }

        request.setAttribute("pageNum", pageNum);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("totalRecord", totalRecord);
        request.setAttribute("boardList", boardList);

    }


    public void addBoard(HttpServletRequest request) {
        // 새로운 글 등록하기
        BoardDAO dao = BoardDAO.getInstance();
        HttpSession session = request.getSession(); // request에 session 가져오기

        BoardDTO board = new BoardDTO();
        board.setMemberId((String) session.getAttribute("sessionMemberId"));
        board.setName(request.getParameter("name"));
        board.setSubject(request.getParameter("subject"));
        board.setContent(request.getParameter("content"));

        System.out.println(request.getParameter("name"));
        System.out.println(request.getParameter("subject"));
        System.out.println(request.getParameter("content"));

        board.setHit(0);
        board.setIp(request.getRemoteAddr());
        dao.insertBoard(board);
    }



}
