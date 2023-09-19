package com.example.dao;

import java.util.ArrayList;
import com.example.dto.Member;

public class MemberRepository {
	private final ArrayList<Member> members = new ArrayList<>();
	private static final MemberRepository instance = new MemberRepository();
	
	public static MemberRepository getInstance() {
		return instance;
	}
	
	public Member getMemberMyId(String memberId) {
		Member member = null;
		
		// foreach로 목록 순회
		for(Member m : members) {
			if(m.getMemberId().equals(memberId)) {
				// 매개 변수와 객체의 Id가 같으면
				member = m;
				break;
			}
		}
		return member; // null 또는 해당ID를 가진 객체를 반환		
	}
	
	public void addMember(Member member) {
		members.add(member);
	}

	
	
}
