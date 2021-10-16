package poly.persistance.mapper;

import config.Mapper;
import poly.dto.UserDTO;

import javax.jws.soap.SOAPBinding;

@Mapper("UserMapper")
public interface IUserMapper {

    // 로그인
    UserDTO getLogin(UserDTO pDTO) throws Exception;

    // 회원 가입하기(회원정보 등록)
    int insertUser(UserDTO pDTO) throws Exception;

    


}
