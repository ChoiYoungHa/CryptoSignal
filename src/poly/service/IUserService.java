package poly.service;

import poly.dto.UserDTO;

public interface IUserService {

    // 로그인
    UserDTO getLogin(UserDTO pDTO) throws Exception;

    // 회원 가입하기(회원정보 등록)
    int insertUser(UserDTO pDTO) throws Exception;

}
