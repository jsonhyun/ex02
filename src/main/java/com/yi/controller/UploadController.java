package com.yi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.yi.util.UploadFileUtils;

@Controller
public class UploadController {
	private String innerUploadPath="/resources/upload";
	
	@Resource(name="uploadPath") //id명으로 주입함
	private String uploadPath;
	
	@RequestMapping(value = "inUp", method = RequestMethod.GET)
	public String innerUploadForm() {
		return "innerUploadForm";
	}
	
	@RequestMapping(value = "inUp", method = RequestMethod.POST)
	public String innerUploadResult(String test, MultipartFile file, HttpServletRequest request, Model model) throws IOException {
		System.out.println("test : "+test);
		System.out.println("file : "+file);
		System.out.println(file.getOriginalFilename());
		System.out.println(file.getSize());
		
		String root = request.getSession().getServletContext().getRealPath("/");
		File dir = new File(root+innerUploadPath);
		if(dir.exists() == false) {
			dir.mkdir();
		}
		UUID uid = UUID.randomUUID();//중복되지 않는 고유한 키값을 반환함
		String savedName = uid.toString()+"_"+file.getOriginalFilename();//중복되지 않게 이름 맞춤
		File target = new File(root+innerUploadPath+"/"+savedName);
		FileCopyUtils.copy(file.getBytes(), target);//서버 upload 폴더 안에 파일이 생성됨
		
		//파일 이름, 
		model.addAttribute("test", test);
		model.addAttribute("file",savedName);
		
		return "innerUploadFileResult";
	}
	
	@RequestMapping(value = "inMultiUp", method = RequestMethod.GET)
	public String innerMultiUploadForm() {
		return "innerMultiUploadForm";
	}
	
	@RequestMapping(value = "inMultiUp", method = RequestMethod.POST)
	public String innerMultiUploadResult(String test, List<MultipartFile> files, HttpServletRequest request, Model model) throws IOException {
		System.out.println("test : " + test);
		for(MultipartFile file : files) {
			System.out.println(file.getOriginalFilename());
			System.out.println(file.getSize());
		}
		
		String root = request.getSession().getServletContext().getRealPath("/");
		File dir = new File(root+innerUploadPath);
		if(dir.exists() == false) {
			dir.mkdir();
		}
		
		List<String> fileList = new ArrayList<String>();
		for(MultipartFile file : files) {
			UUID uid = UUID.randomUUID();//중복되지 않는 고유한 키값을 반환함
			String savedName = uid.toString()+"_"+file.getOriginalFilename();//중복되지 않게 이름 맞춤
			File target = new File(root+innerUploadPath+"/"+savedName);
			FileCopyUtils.copy(file.getBytes(), target);//서버 upload 폴더 안에 파일이 생성됨
			fileList.add(savedName);
		}
		
		model.addAttribute("test", test);
		model.addAttribute("fileList", fileList);
		
		return "innerMultiUploadResult";
	}
	
	@RequestMapping(value = "outUp", method = RequestMethod.GET)
	public String outUploadFile() {
		return "outUploadFile";
	}
	
	@RequestMapping(value = "outUp", method = RequestMethod.POST)
	public String outUploadResult(String test, MultipartFile file, Model model) throws IOException {
		//폴더 만들기
		String savedName = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
//		File dir = new File(uploadPath);
//		if(dir.exists() == false) {
//			dir.mkdir();
//		}
//		//년-월-일
//		
//		UUID uid = UUID.randomUUID();//중복되지 않는 고유한 키값을 반환함
//		String savedName = uid.toString()+"_"+file.getOriginalFilename();//중복되지 않게 이름 맞춤
//		File target = new File(uploadPath+"/"+savedName);
//		FileCopyUtils.copy(file.getBytes(), target);//서버 upload 폴더 안에 파일이 생성됨
		
		model.addAttribute("test", test);
		model.addAttribute("file", savedName);
		return "outUploadFileResult";
	}
	
	@ResponseBody
	@RequestMapping(value = "displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String filename){
		ResponseEntity<byte[]> entity = null;
		
		System.out.println("displayFile -------------" + filename);
		InputStream in = null;
		try {
			in = new FileInputStream(uploadPath+filename);
			String format = filename.substring(filename.lastIndexOf(".")+1);//확장자
			MediaType mType = null;
			if(format.equalsIgnoreCase("png")) {
				mType = MediaType.IMAGE_PNG;
			}else if(format.equalsIgnoreCase("jpg")||format.equalsIgnoreCase("jpeg")) {
				mType = MediaType.IMAGE_JPEG;
			}else if(format.equalsIgnoreCase("gif")) {
				mType = MediaType.IMAGE_GIF;
			}
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mType);
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	
	@RequestMapping(value = "drag", method = RequestMethod.GET)
	public String dragUploadFile() {
		return "dragUploadFile";
	}
	
	@ResponseBody
	@RequestMapping(value = "drag", method = RequestMethod.POST)
	public ResponseEntity<List<String>> dragResult(String test, List<MultipartFile> files) throws IOException {
		ResponseEntity<List<String>> entity = null;
		System.out.println("test : "+test);
		System.out.println(files);
		for(MultipartFile file : files) {
			System.out.println(file.getOriginalFilename());
			System.out.println(file.getSize());
		}
		//폴더 만들기
		File dir = new File(uploadPath);
		if(dir.exists() == false) {
			dir.mkdir();
		}
		try {
			//업로드 처리
			List<String> fileList = new ArrayList<String>();
			for(MultipartFile file : files) {
				UUID uid = UUID.randomUUID();//중복되지 않는 고유한 키값을 반환함
				String savedName = uid.toString()+"_"+file.getOriginalFilename();//중복되지 않게 이름 맞춤
				File target = new File(uploadPath+"/"+savedName);
				FileCopyUtils.copy(file.getBytes(), target);//서버 upload 폴더 안에 파일이 생성됨
				fileList.add(savedName);
			}
			entity = new ResponseEntity<List<String>>(fileList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<String>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteFile", method = RequestMethod.GET)
	public ResponseEntity<String> deleteFile(String filename){
		ResponseEntity<String> entity = null;
		System.out.println(filename);
		try {
			//file을 지움
			File file = new File(uploadPath+filename);
			file.delete();
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "outMultiUp", method = RequestMethod.GET)
	public String outMultiUp() {
		return "outMultiUploadForm";
	}
}
