package com.yi.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.yi.domain.SampleVO;

@RestController //data만 전송하는 controller(화면없음), 아작스 전용 컨트롤러로 사용
@RequestMapping("/sample/*")
public class SampleController {
	
	@RequestMapping(value = "hello", method = RequestMethod.GET)
	public String sayHello() {
		return "Hello World";
	}
	
	@RequestMapping(value = "sendVO", method = RequestMethod.GET)
	public SampleVO sendVO() {
		SampleVO vo = new SampleVO();
		vo.setNo(1);
		vo.setFirstName("재승");
		vo.setLastName("현");
		
		return vo;
	}
	
	@RequestMapping(value = "sendList", method = RequestMethod.GET)
	public List<SampleVO> sendList(){
		List<SampleVO> list = new ArrayList<SampleVO>();
		for(int i=1; i <= 10; i++) {
			SampleVO vo = new SampleVO();
			vo.setNo(i);
			vo.setFirstName("재승"+i);
			vo.setLastName("현"+i);
			list.add(vo);
		}
		return list;
	}
	
	@RequestMapping(value = "sendAuth", method = RequestMethod.GET)
	public ResponseEntity<String> sendAuth(){
		ResponseEntity<String> entity = new ResponseEntity<String>("hello", HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value = "sendListAuth", method = RequestMethod.GET)
	public ResponseEntity<List<SampleVO>> sendListAuth(){
		List<SampleVO> list = new ArrayList<SampleVO>();
		for(int i=1; i <= 10; i++) {
			SampleVO vo = new SampleVO();
			vo.setNo(i);
			vo.setFirstName("재승"+i);
			vo.setLastName("현"+i);
			list.add(vo);
		}
		ResponseEntity<List<SampleVO>> entity = new ResponseEntity<List<SampleVO>>( list, HttpStatus.NOT_FOUND);
		return entity;
	}
}
