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

    // dao의 전체 게시글 or 검색 게시글을 가져와서 페이징하고 일부만 가져오는 메소드
    public void requestBoardList(HttpServletRequest request) {
        // 등록된 글 목록 가져오기
        BoardDAO dao = BoardDAO.getInstance();
        List<BoardDTO> boardList;

        int pageNum = 1; // 페이지 번호의 기본 값
        int limit = LISTCOUNT; // 페이지당 게시물 수
        if(request.getParameter("pageNum") != null) { // 페이지 번호를 넘겨받았다면
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }

        String items = request.getParameter("items"); // 검색 종류
        String text = request.getParameter("text"); // 검색어
        int totalRecord = dao.getListCount(items, text); // 검색어가 null이면 전체 게시글 카운트, 아니면 해당하는 게시글 카운트
        boardList = dao.getBoardList(pageNum, limit, items, text); //검색어가 null이면 전체로 가져옴, 아니면 해당하는 게시글만 가져옴

        int totalPage; // 전체 페이지 계산

        if(totalRecord % limit == 0) {      // 가져온 데이터가 리밋으로 나눴을 때 나머지 없이 딱 떨어진다면
            totalPage = totalRecord / limit;  // 딱 떨어지니까 나누기만 하면 총 페이지수가 나옴
            Math.floor(totalPage);          // 소수점 버림
        } else {                            // 총 페이지당 게시물이 딱 떨어지지 않았을 때
            totalPage = totalRecord / limit;// 일단 나눔
            Math.floor(totalPage);          // 소수점 버림
            totalPage = totalPage + 1;      // 총 페이지에 +1 추가 (나머지들 보여줄 영역)
        }
        // 페이지 시작 일련번호
        int startNum = totalRecord - (pageNum - 1) * limit; // 100 - 0 * 5
        System.out.println("startNum : " + startNum);

        request.setAttribute("pageNum", pageNum);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("totalRecord", totalRecord);
        request.setAttribute("boardList", boardList);
        request.setAttribute("startNum", startNum);

    }

    // dao의 insert 쿼리문에 필요한 정보를 세팅한 board 객체를 넘기는 메소드
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

    // dao의 해당 num을 가진 게시글의 정보를 넘겨주는 메소드를 이용해 request에 게시글 정보를 저장
    public void getBoardView(HttpServletRequest request) {
        // 선택된 글 상세 페이지 가져오기
        BoardDAO dao = BoardDAO.getInstance();
        int num = Integer.parseInt(request.getParameter("num"));
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));

        BoardDTO board = dao.getBoardByNum(num); // 전달받은 num으로 해당 num을 가진 게시글의 정보를 가져옴
        
        request.setAttribute("board", board); // 해당 num을 가진 게시글의 정보를 request로 넘김. num, pageNum은 jsp?num=13 이런식으로 리퀘스트로 넘어옴
    }

    //
    public void modifyBoard(HttpServletRequest request) {
        // 선택된 글 내용 수정하기
        // request로 넘어온 값을 BoardDTO 객체에 저장해서 DAO에 전달
        int num = Integer.parseInt(request.getParameter("num"));

        BoardDAO dao = BoardDAO.getInstance();

        BoardDTO board = new BoardDTO();
        board.setNum(num);
        board.setName(request.getParameter("name"));
        board.setSubject(request.getParameter("subject"));
        board.setContent(request.getParameter("content"));

        dao.updateBoard(board);
    }

    public void removeBoard(HttpServletRequest request) {
        // 선택된 글 삭제하기
        int num = Integer.parseInt(request.getParameter("num"));

        BoardDAO dao = BoardDAO.getInstance();
        dao.deleteBoard(num);
    }

}
