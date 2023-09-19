package com.example.mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.example.mvc.database.DBConnection;

public class BoardDAO {
	// 싱글톤 타입으로 작성
	private static BoardDAO instance;
	
	private BoardDAO() {};
	
	public static BoardDAO getInstance() {
		if (instance == null) instance = new BoardDAO();
		return instance;
	}

	// 전체 게시물 수 구하는 메소드
	public int getListCount(String items, String text) {
		// board 테이블의 전체 레코드 개수 반환
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cnt = 0;
		String sql;
		if(items == null || text == null) { // 검색어가 없는 경우의 쿼리문
			sql = "SELECT count(*) FROM board";
		} else { // 검색어가 없는 경우의 쿼리문
			sql = "SELECT count(*) FROM board WHERE " + items + " LIKE '%" + text + "%'";
		}
		
		try {
			connection = DBConnection.getConnection();
			pstmt = connection.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) { // 데이터가 있는 경우
				cnt = rs.getInt(1); // 해당하는 글 번호 (PK)
			}
		} catch (Exception ex) {
			System.out.println("getListCount() 에러: " + ex);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (connection != null) connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}	
		return cnt;
	}

	// 전체 게시글 또는 검색어가 포함된 게시글 가져오는 메소드
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text){
		// board 테이블의 레코드 가져오기
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int start = (page - 1) * limit; 
		String sql;
		if (items == null && text == null) { // 검색어가 없는 경우
			sql = "SELECT * FROM board ORDER BY num DESC"; // 전체 보드를 가져와서 최신순으로 가져옴
		} else { // 검색어가 있는 경우
			// 해당하는 검색어를 기준으로 최신순으로 가져옴
			sql = "SELECT * FROM board WHERE " + items + " LIKE '%" + text + "%' ORDER BY num DESC ";
		}
		sql += " LIMIT " + start + ", " + limit;
		
		// 조건을 설정하고 데이터를 LIMIT만큼 가져옴
		
		ArrayList<BoardDTO> list = new ArrayList<>(); // 가져온 데이터를 모아놓을 그릇
		
		try {
			connection = DBConnection.getConnection();
			pstmt = connection.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) { // 쿼리문으로 가져온 데이터들을 순회하며 리스트에 추가
				BoardDTO board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setMemberId(rs.getString("memberId"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setAddDate(rs.getString("addDate"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				list.add(board);
			}
			return list; // 작업이 끝난 리스트를 반환하고 종료
		} catch (Exception ex) {
			System.out.println("getListCount() 에러: " + ex);
		} finally { // 리턴을 만나도 파이널리는 실행됨.
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (connection != null) connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}

		return list;
	}

	// 게시글 등록 메소드
	public void insertBoard(BoardDTO board) {
		// board 테이블에 새로운 글 삽입하기
		Connection connection = null;
		PreparedStatement pstmt = null;
		try {
			connection = DBConnection.getConnection();

			String sql = "INSERT INTO board (memberId, name, subject, content, hit, ip, addDate) " +
					" VALUES (?, ?, ?, ?, ?, ?, now())";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, board.getMemberId());
			pstmt.setString(2, board.getName());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, board.getHit());
			pstmt.setString(6, board.getIp());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertBoard() 에러 : " + ex);
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (connection != null) connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

	// 조회수 업데이트 메소드
	private void updateHit(int num) {
		// 선택된 글의 조회수 증가하기
		Connection connection = null;
		PreparedStatement pstmt = null;
		try {
			connection = DBConnection.getConnection();

			String sql = "UPDATE board SET hit = hit + 1 where num = ? "; // 해당 인덱스번호로 조회수 1 증가
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateHit() 에러 : " + ex);
		} finally {
			try{
				if (pstmt != null) pstmt.close();
				if (connection != null) connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

	// 인덱스로 해당 게시글 가져오는 메소드
	public BoardDTO getBoardByNum(int num) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO board = null;

		updateHit(num); // 이 메소드가 실행됐다면 게시글에 접속하는거니 조회수 +1
		String sql = "SELECT * FROM board WHERE num = ? "; // 인덱스에 해당하는 게시글 정보 모두 가져옴
		try {
			connection = DBConnection.getConnection();
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if(rs.next()) { // 가져온 데이터를 boardDTO 객체에 저장하고
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setMemberId(rs.getString("memberId"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setAddDate(rs.getString("addDate"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
			}
			return board; // 게시글의 정보를 담고있는 객체를 반환
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 에러 : " + ex);
		}  finally {
			try{
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (connection != null) connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return board;
	}

}
