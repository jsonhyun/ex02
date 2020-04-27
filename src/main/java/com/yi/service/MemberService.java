package com.yi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yi.domain.MemberVO;
import com.yi.persistence.MemberDAO;

@Service
public class MemberService {
	
	@Autowired
	MemberDAO dao;
	
	public void insert(MemberVO vo) throws Exception {
		dao.createMember(vo);
	}
	
	public List<MemberVO> list() throws Exception {
		return dao.list();
	}
	
	public void update(MemberVO vo) throws Exception {
		dao.updateMember(vo);
	}
	
	public void delete(String userid) throws Exception {
		dao.deleteMember(userid);
	}
}
