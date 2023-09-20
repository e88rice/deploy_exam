package dao;

import com.example.mvc.model.BoardDAO;
import com.example.mvc.model.BoardDTO;
import org.junit.jupiter.api.Test;

public class BoardTests {

    @Test
    public void testBoardInsert() {
        BoardDAO boardDAO = BoardDAO.getInstance();
        BoardDTO boardDTO = new BoardDTO();
        boardDTO.setMemberId("test");
        boardDTO.setSubject("제목");
        boardDTO.setContent("내용");
        boardDTO.setName("작성자");
        boardDTO.setHit(1);
        boardDTO.setAddDate("2020-01-01");
        boardDAO.insertBoard(boardDTO);
    }

    @Test
    public void testBoardSelect() {
        BoardDAO boardDAO = BoardDAO.getInstance();
        BoardDTO boardDTO = boardDAO.getBoardByNum(4);
        System.out.println("보드 객체 : " + boardDTO.toString());
    }

    @Test
    public void testAddBoard() {
        BoardDAO boardDAO = BoardDAO.getInstance();
        for(int i=5; i<106; i++){
            BoardDTO boardDTO = new BoardDTO();
            boardDTO.setMemberId("test" + i);
            boardDTO.setSubject("제목" + i);
            boardDTO.setContent("내용" + i);
            boardDTO.setName("작성자" + i);
            boardDTO.setHit(0);
            boardDTO.setAddDate("2020-01-01");
            boardDAO.insertBoard(boardDTO);
        }
    }

    @Test
    public void testUpdateBoard() {
        BoardDAO boardDAO = BoardDAO.getInstance();
        BoardDTO board = boardDAO.getBoardByNum(101);
        System.out.println(board);
        board.setName("ㅎㅇ");
        board.setSubject("반갑습니다");
        board.setContent("안녕하세요");
        boardDAO.updateBoard(board);
    }

    @Test
    public void testDeleteBoard() {
        BoardDAO boardDAO = BoardDAO.getInstance();
        boardDAO.deleteBoard(51);
    }

}
