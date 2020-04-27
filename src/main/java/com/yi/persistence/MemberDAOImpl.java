package com.yi.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.domain.MemberVO;

@Repository //<context:component-scan>에서 @repository로 등록된 class만 bean으로 설정이 됨 
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired //@Inject 같은 의미로 사용 가능(root-context에서 주입 받음)
	private SqlSession sqlSession;
	
	private static final String namespace = "mappers.MemberMapper.";

	@Override
	public void createMember(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+"createMember", vo);

	}

	@Override
	public MemberVO readMember(String userid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+"readMember", userid);
	}

	@Override
	public List<MemberVO> list() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"list");
	}

	@Override
	public void updateMember(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+"updateMember", vo);
	}

	@Override
	public void deleteMember(String	userid) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace+"deleteMember", userid);
		
	}

}
