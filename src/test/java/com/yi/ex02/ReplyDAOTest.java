package com.yi.ex02;

import java.util.Date;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yi.domain.ReplyVO;
import com.yi.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ReplyDAOTest {
	
	@Autowired
	private ReplyDAO dao;
	
	@Test
	public void test01DAO() {
		System.out.println(dao);
	}
	
	@Test
	public void test02Insert() throws Exception {
		ReplyVO vo = new ReplyVO();
		vo.setBno(2043);
		vo.setReplytext("댓글입니다.");
		vo.setReplyer("테스트");
		dao.insert(vo);
	}
	
	@Test
	public void test03List() throws Exception {
		dao.list(2043);
	}
	
	@Test
	public void test04Update() throws Exception {
		ReplyVO vo = new ReplyVO();
		vo.setReplytext("댓글 수정입니다.");
		vo.setUpdatedate(new Date());
		vo.setRno(3);
		dao.update(vo);
	}
	
	@Test
	public void test04Delete() throws Exception {
		ReplyVO vo = new ReplyVO();
		vo.setRno(2);
		dao.delete(vo.getRno());
		
	}
}
