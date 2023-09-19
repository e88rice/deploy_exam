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

}
