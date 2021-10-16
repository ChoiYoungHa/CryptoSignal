package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import poly.dto.UserDTO;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
public class UserController {
	@Resource(name = "UserService")
	private IUserService userService;

	private Logger log = Logger.getLogger(this.getClass());


	@RequestMapping(value = "index")
	public String Index() {
		log.info(this.getClass());
		return "/index";
	}

	// 로그인 페이지 이동
	@RequestMapping(value = "loginPage")
	public String loginPage() {
		return "/user/login";
	}

	// 회원가입 페이지 이동
	@RequestMapping(name = "signUp")
	public String signUp() {
		return "/user/signup";
	}


	//회원가입 진행
	@RequestMapping(value = "insertUser", method = RequestMethod.POST)
	public String insertMember(HttpServletRequest request, ModelMap model, HttpSession session)
			throws Exception {
		log.info("insertUser Start!");
		// 회원가입 jsp 에서 입력받은 값 가져오기
		// 민감 정보인 이메일은 AES128-CBC로 암호화함
		String email = CmmUtil.nvl(EncryptUtil.encAES128CBC(request.getParameter("email")));
		// 비밀번호는 복호화되지 않도록 HASHSHA256 단일 알고리즘으로 암호화함
		String password = CmmUtil.nvl(EncryptUtil.encHashSHA256(request.getParameter("password")));
		String name = CmmUtil.nvl(request.getParameter("userName"));
		String nicName = CmmUtil.nvl(request.getParameter("userNicName"));

		UserDTO pDTO = new UserDTO();


		// 회원정보가 제대로 전달되었는지 로그를 통해 확인
		log.info("user_email : " + email);
		log.info("member_name : " + name);
		log.info("member_nic : " + nicName);
		log.info("password : " + password);

		// jsp에서 가져온 값을 DTO에 저장
		pDTO.setEmail(email);
		pDTO.setName(name);
		pDTO.setPassword(password);
		pDTO.setNicname(nicName);

		log.info("res 시작");

		// DB에 값이 잘 저장되었다면, 1 반환
		int res = userService.insertUser(pDTO);
		log.info("res : " + res);

		String msg = "";
		String url = "";

		if (res > 0) {
			msg = "회원가입을 축하드립니다.";
		} else {
			msg = "회원정보를 확인 후 가입을 진행해 주세요.";
		}

		url = "/index.do";

		log.info("model.addAttribute");
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		pDTO = null;
		log.info("insertUser End!");

		return "/redirect";
	}


	// 로그인
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, HttpSession session,
						ModelMap model) throws Exception {
		log.info("login Start!");
		String email = EncryptUtil.encAES128CBC(CmmUtil.nvl(request.getParameter("email")));
		String password = EncryptUtil.encHashSHA256(CmmUtil.nvl(request.getParameter("password")));

		log.info("email : " + email);
		log.info("password : " + password);

		UserDTO pDTO = new UserDTO();
		pDTO.setEmail(email);
		pDTO.setPassword(password);

		// email, password와 일치하는 회원정보 불러오기
		UserDTO rDTO = userService.getLogin(pDTO);

		pDTO = null;
		log.info("rDTO null? " + (rDTO == null));

		String msg = "";
		String url = "";

		// 로그인에 실패한 경우
		if (rDTO == null) {
			msg = "로그인에 실패했습니다. 다시 시도해 주세요.";
			url = "/loginPage.do"; //재 로그인
		}
		// 로그인 성공한 경우(rDTO != null)
		else {
			log.info("rDTO.getEmail : " + rDTO.getEmail());
			log.info("rDTO.getUserName: " + rDTO.getName());
			log.info("rDTO.getUserid : " + rDTO.getUser_id());
			msg = "환영합니다!";

			String user_id = rDTO.getUser_id();

			// 회원 번호로 세션 올림, "ㅇㅇㅇ님, 환영합니다" 같은 문구 표시를 위해 user_name도 세션에 올림
			// 작성자와 현재 로그인한 사용자를 구분해주기 위해 닉네임도 세션에 올림
			session.setAttribute("SS_USER_ID", user_id);
			session.setAttribute("SS_USER_NAME", rDTO.getName());
			session.setAttribute("SS_USER_NIC", rDTO.getNicname());
			log.info("session.setAttribute 완료");

			url = "/index.do"; //로그인 성공 후 리턴할 페이지
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		log.info("msg : " + msg);
		log.info("url : " + url);

		rDTO = null;

		log.info("rDTO null? : " + (rDTO == null));
		log.info("getLogin end");
		log.info("login End!");

		return "/redirect";
	}


	// 로그아웃
	@RequestMapping(value = "logout")
	public String logout(HttpServletRequest request, HttpSession session, ModelMap model)
			throws Exception {
		log.info("logout start!");
		// 로그아웃을 위해 세션 비우기
		session.removeAttribute("SS_USER_ID");
		session.removeAttribute("SS_USER_NIC");
		session.removeAttribute("SS_USER_NAME");

		String msg = "로그아웃 되었습니다.";
		String url = "/index.do";

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		log.info("session deleted? : " + session.getAttribute("SS_USER_NAME"));
		log.info("logout end!");

		return "/redirect";
	}


}
