package com.ezen.spring.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.spring.domain.UserVO;
import com.ezen.spring.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user/**")
@Controller
public class UserController {
	
	private final UserService usv;
	private final BCryptPasswordEncoder bcEncoder;
	
	// mapping 경로와 jsp의 경로가 같다면 void 처리 가능.
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(UserVO uvo) {
		log.info(">>> UserVO > {}", uvo);
		// encode : 암호화
		uvo.setPwd(bcEncoder.encode(uvo.getPwd()));
		
		int isOk = usv.register(uvo);
		return "redirect:/";
	}
	
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public String login(HttpServletRequest request, RedirectAttributes re) {
		// 실제 로그인은 Sercurity 의 필터에서 가져감.
		// 로그인 실패 시 다시 로그인 페이지로 돌아와 오류 메시지 전송
		// 재 로그인을 유도
		log.info(">>> errMsg > {}", request.getAttribute("errMsg").toString());
		
		re.addAttribute("email", request.getAttribute("email"));
		re.addAttribute("errMsg", request.getAttribute("errMsg"));
		
		return "redirect:/user/login";
	}
	
	
}
