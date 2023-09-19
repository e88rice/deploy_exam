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
                System.out.println("end1");
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/list.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardAddForm.do" -> { // 글 등록 폼 출력하기
                System.out.println("end2");
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/addForm.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardAddAction.do" -> { // 새로운 글 등록하기
                boardService.addBoard(req);
                System.out.println("end3");
                resp.sendRedirect("./boardList.do");
                break;
            }
        }

    }

}
