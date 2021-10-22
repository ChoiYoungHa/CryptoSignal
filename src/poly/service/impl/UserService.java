package poly.service.impl;

import org.springframework.stereotype.Service;
import poly.dto.UserDTO;
import poly.persistance.mapper.IUserMapper;
import poly.service.IUserService;

import javax.annotation.Resource;

@Service("UserService")
public class UserService implements IUserService {
    @Resource(name = "UserMapper")
    private IUserMapper userMapper;

    // 회원가입
    @Override
    public int insertUser(UserDTO pDTO) throws Exception {
        return userMapper.insertUser(pDTO);
    }

    // 로그인
    @Override
    public UserDTO getLogin(UserDTO pDTO) throws Exception {
        return userMapper.getLogin(pDTO);
    }

    
}
