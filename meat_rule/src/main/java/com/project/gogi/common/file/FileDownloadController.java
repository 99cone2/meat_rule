package com.project.gogi.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class FileDownloadController {
	private static final String GOGI_IMAGE_REPO = "C:\\meatrule\\file_repo\\goods";
	private static final String GOGI_IMAGE_REPO_PATH1 = "C:\\meatrule\\file_repo\\servBoard";
	private static final String GOGI_IMAGE_REPO_PATH2 = "C:\\meatrule\\file_repo\\reviewBoard";
	
	@RequestMapping(value = "/download")
	protected void download(@RequestParam("fileName") String fileName, @RequestParam("goods_id") int goods_id,
			HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath = GOGI_IMAGE_REPO + "\\" + goods_id + "\\" + fileName;
		File image = new File(filePath);

		response.setHeader("Cache-Controle", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + fileName);
		FileInputStream in = new FileInputStream(image);
		byte[] buffer = new byte[1024 * 8];
		while (true) {
			int count = in.read(buffer);
			if (count == 1)
				break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}
	
	@RequestMapping(value = "/download2")
	protected void download2(@RequestParam("img_name") String img_name, @RequestParam("cust_serv_no") int cust_serv_no,
			HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath = GOGI_IMAGE_REPO_PATH1 + "\\" + cust_serv_no + "\\" + img_name;
		File image = new File(filePath);
		
		 response.setHeader("Cache-Control", "no-cache");
         response.setHeader("Content-Transfer-Encoding", "binary");
         response.setHeader("Pragma", "no-cache;");
         response.setHeader("Expires", "-1;");
//		response.addHeader("Content-disposition", "attachment; img_name=" + img_name);
		FileInputStream in = new FileInputStream(image);
		byte[] buffer = new byte[1024 * 8];
		while (true) {
			int count = in.read(buffer);
			if (count == 1)
				break;
			out.write(buffer, 0, count);
			
		}
		in.close();
		out.close();
	}

	@RequestMapping("/thumbnails.do")
	protected void thumbnails(@RequestParam("fileName") String fileName, @RequestParam("goods_id") int goods_id,
			HttpServletResponse response) throws Exception {

		OutputStream out = response.getOutputStream();
		String filePath = GOGI_IMAGE_REPO + "\\" + goods_id + "\\" + fileName;
		File image = new File(filePath);
		System.out.println(filePath);
		
		 int lastIndex=fileName.lastIndexOf("."); 
		 String imageFileName=fileName.substring(0, lastIndex);
		 System.out.println("썸네일2"+imageFileName);
		 

		if (image.exists()) {
			Thumbnails.of(image).size(450, 450).outputFormat("png").toOutputStream(out);
		} else {
			return;
		}
		// 썸네일 파일 브라우저로 전송

		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);

		out.close();
	}
	
	
	@RequestMapping("/thumbnails2.do")
	protected void thumbnails2(@RequestParam("img_name") String img_name, @RequestParam("cust_serv_no") int cust_serv_no,
			HttpServletResponse response) throws Exception {
		
		OutputStream out = response.getOutputStream();
		String filePath = GOGI_IMAGE_REPO_PATH1 + "\\" + cust_serv_no + "\\" + img_name;
		File image = new File(filePath);
		System.out.println(filePath);
		
		int lastIndex=img_name.lastIndexOf("."); 
		String imageFileName=img_name.substring(0, lastIndex);
		System.out.println("serv 썸네일"+imageFileName);
		
		
		if (image.exists()) {
			Thumbnails.of(image).size(250, 250).outputFormat("png").toOutputStream(out);
		} else {
			return;
		}
		// 썸네일 파일 브라우저로 전송
		
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		
		out.close();
	}
	
	
	@RequestMapping("/thumbnails3.do")
	protected void thumbnails3(@RequestParam("img") String img_name, @RequestParam("revno") int rev_no,
			HttpServletResponse response) throws Exception {
		
		OutputStream out = response.getOutputStream();
		String filePath = GOGI_IMAGE_REPO_PATH2 + "\\" + rev_no + "\\" + img_name;
		File image = new File(filePath);
		System.out.println(filePath);
		
		int lastIndex=img_name.lastIndexOf("."); 
		String imageFileName=img_name.substring(0, lastIndex);
		System.out.println("review 썸네일"+imageFileName);
		
		
		if (image.exists()) {
			Thumbnails.of(image).size(450, 450).outputFormat("png").toOutputStream(out);
		} else {
			return;
		}
		// 썸네일 파일 브라우저로 전송
		
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		
		out.close();
	}

}
