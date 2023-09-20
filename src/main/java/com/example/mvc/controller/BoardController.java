package com.example.mvc.controller;


import com.example.mvc.service.BoardService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"*.do"})
public class BoardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp); // doGet으로 오든 doPost로 오든 doPost로 작업. 이렇게 하면 코드를 하나의 영역에만 작성해도 됨.
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BoardService boardService = BoardService.getInstance();
        String RequestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String command = RequestURI.substring(contextPath.length());  //      localhost:8082// 이런거 다 빼고
        System.out.println("command : " + command); // 도메인 이후의 경로를 불러옴.

        resp.setContentType("text/html; charset=utf-8");
        req.setCharacterEncoding("UTF-8");

        switch (command) {
            case "/boardController/boardList.do" -> { // 등록된 글 목록 페이지 출력하기
                boardService.requestBoardList(req);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/list.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardAddForm.do" -> { // 글 등록 폼 출력하기
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/addForm.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardAddAction.do" -> { // 새로운 글 등록하기
                boardService.addBoard(req);
                resp.sendRedirect("./boardList.do");
                break;
            }
            case "/boardController/boardView.do" -> { // 선택된 글 상세 페이지 가져오기
                boardService.getBoardView(req);  // 메소드를 실행하고 num을 넘겨주면 getBoardView() 메소드는 보드 객체를 리퀘스트에 저장해줌
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/view.jsp");  // 이동할 페이지 저장
                requestDispatcher.forward(req, resp); // 보드 객체가 저장된 리퀘스트와 리스폰스를 포함해서 저장된 페이지로 이동
                break;
            }
            case "/boardController/boardModifyForm.do" -> { // 글 수정
                // 컨트롤러로 넘어온 리퀘스트를 서비스에 전달. => 서비스는 전달된 정보로 게시글 정보를 저장한 객체를 리퀘스트에 저장 => 게시글 정보를 담은 리퀘스트를 가지고 글 수정 페이지로 이동
                boardService.getBoardView(req);
                System.out.println("ㅎㅇ"+req.getParameter("num"));
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/modifyForm.jsp");  // 이동할 페이지 저장
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardModifyAction.do" -> { // 글 수정
                // 컨트롤러로 넘어온 리퀘스트를 서비스에 전달. => 서비스는 전달된 정보로 board 객체 생성 => 서비스는 생성된 객체로 dao의 updateBoard() 메소드 실행 => 데이터베이스 업데이트
                boardService.modifyBoard(req);
                resp.sendRedirect("./boardList.do");
                break;
            }
            case "/boardController/boardRemoveAction.do" -> { // 글 삭제
                // 컨트롤러로 넘어온 리퀘스트를 서비스에 전달. => 서비스는 전달된 인덱스 번호를 removeBoard() 메소드에 전달 -> removeBoard() 메소드에서 쿼리문을 통해 데이터 삭제
                boardService.removeBoard(req);
                resp.sendRedirect("./boardList.do");
                break;
            }
        }

    }

}
