package com.teulda.web.photo;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.teulda.common.Group;
import com.teulda.common.Photo;
import com.teulda.service.domain.User;
import com.teulda.service.photo.PhotoService;


//PhotoList(삭제, 삭제 아닌 사진)
//PhotoGroupList(삭제, 삭제 아닌 그룹)

@Controller
@RequestMapping("/photo/*")
public class PhotoController {

	@Autowired
	@Qualifier("photoServiceImpl")
	private PhotoService photoService;
	
	public PhotoController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
//	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
//	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//지도로 보기(photoList랑 별 다를거 없는 듯?)
	@RequestMapping(value="getPhotoMap")
	public String getPhotoMap(Model model, HttpSession session) throws Exception{
		
		System.out.println("/listPhoto");
		
		User user = (User)session.getAttribute("user");
//		Group group = (Group)session.getAttribute("groupList");
//		group.setNickname(user.getNickname());
//		group.setGroupNo(group.getGroupNo());
		
		//로그인 없이 그냥 바로 테스트 해보려고 넣음
		Group group = new Group();
		group.setNickname("king정인");
		group.setGroupNo(10012);
		
		//그룹에 있는 nickname, groupNo를 받아와서 getPhotoList로 넘겨야됨
		Map<String, Object> map = photoService.getPhotoList(group);
		
		model.addAttribute("photoList", map.get("photoList"));
		model.addAttribute("totalCount", map.get("totalCount"));
		
		return "forward:/photo/getPhotoMap.jsp";
	}
	
	
	@RequestMapping(value="album")
	public String photoList(Model model, HttpSession session, HttpServletRequest request) throws Exception{
		
		System.out.println("/listPhoto");
		
		User user = (User)session.getAttribute("user");
//		Group group = (Group)session.getAttribute("groupList");
//		group.setNickname(user.getNickname());
//		group.setGroupNo(group.getGroupNo());
		int groupNo = Integer.parseInt(request.getParameter("groupNo"));
		System.out.println("GroupNo : "+groupNo);
		
		//로그인 없이 그냥 바로 테스트 해보려고 넣음
		Group group = new Group();
		group.setNickname(user.getNickname());
		group.setGroupNo(groupNo);
//		group.setGroupNo(10012);
		
		//그룹에 있는 nickname, groupNo를 받아와서 getPhotoList로 넘겨야됨
		Map<String, Object> map = photoService.getPhotoList(group);
		
		model.addAttribute("photoList", map.get("photoList"));
		model.addAttribute("totalCount", map.get("totalCount"));
		
		return "forward:/photo/album.jsp";
	}
	
	//그룹 가지고 오기
	@RequestMapping(value="listPhoto")
	public String listPhoto(Model model, HttpSession session) throws Exception{
		
		User user = (User)session.getAttribute("user");
		
		Group group = new Group();
		group.setNickname(user.getNickname());
		
		//로그인 없이 그냥 바로 테스트 해보려고 넣음
//		group.setNickname("king정인");
		
		Map<String, Object> map = photoService.getGroupList(group);
		
		model.addAttribute("groupList", map.get("groupList"));
		model.addAttribute("totalCount", map.get("totalCount"));
		
		System.out.println(map.get("groupList"));
		
		return "forward:/photo/listPhoto.jsp";
	}
	
	//사진 휴지통
	@RequestMapping(value="photoBin")
	public String deletePhotoList(Model model, HttpSession session) throws Exception{
		
		User user = (User)session.getAttribute("user");
		
		Group group = new Group();
		group.setNickname(user.getNickname());

		
		Map<String, Object> map = photoService.deleteGroupList(group);
		Map<String, Object> list = photoService.deletePhotoList(group);
		
		model.addAttribute("groupList",  map.get("groupList"));
		model.addAttribute("photoList", list.get("photoList"));
		
		return "forward:/photo/photoBin.jsp";
	}
	
    @RequestMapping(value = "addPhoto", method=RequestMethod.POST)
    public String addPhoto(MultipartHttpServletRequest mtfRequest, HttpSession session) throws Exception{
        
    	User user = (User)session.getAttribute("user");
    	
    	List<MultipartFile> fileList = mtfRequest.getFiles("file");
        String src = mtfRequest.getParameter("src");
        System.out.println("src value : " + src);

        String path = "/Users/tjcpji/Pictures";

        for (MultipartFile mf : fileList) {
            String originFileName = mf.getOriginalFilename(); // 원본 파일 명
            long fileSize = mf.getSize(); // 파일 사이즈

            System.out.println("originFileName : " + originFileName);
            System.out.println("fileSize : " + fileSize);
            System.out.println("Nickname : "+ user.getNickname());

            String safeFile = path + System.currentTimeMillis() + originFileName;
            
            System.out.println("safeFile : "+safeFile);
            
            Photo photo = new Photo();
            photo.setPhotoName(originFileName);
            photo.setNickname(user.getNickname());
            
            photoService.addPhoto(photo);
            
            try {
                mf.transferTo(new File(safeFile));
            } catch (IllegalStateException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

        return "forward:/photo/album";
    }
    
    //그룹, 사진 영구삭제(휴지통)
  	@RequestMapping(value="deletePhoto")
  	public String deleteGroup(HttpSession session) throws Exception{
  		
  		System.out.println("photo/deleteGroup");
  		
  		User user = (User)session.getAttribute("user");
  		
  		photoService.deletePhoto(user.getNickname());
  		photoService.deleteGroup(user.getNickname());
  		
  		return "redirect:/photo/photoBin.jsp";
  	}
  	
  	//그룹 삭제 플래그처리
}
