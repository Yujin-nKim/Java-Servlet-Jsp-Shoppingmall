package com.nhnacademy.shoppingmall.user.service.impl;

import com.nhnacademy.shoppingmall.user.exception.UserAlreadyExistsException;
import com.nhnacademy.shoppingmall.user.exception.UserNotFoundException;
import com.nhnacademy.shoppingmall.user.service.UserService;
import com.nhnacademy.shoppingmall.user.domain.User;
import com.nhnacademy.shoppingmall.user.repository.UserRepository;

import java.time.LocalDateTime;
import java.util.Optional;

public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public User getUser(String userId){
        //todo#4-1 회원조회
        Optional<User> userOptional = userRepository.findById(userId);

        if(userOptional.isEmpty()) {
            //throw new UserNotFoundException(userId);
            return null;
        }
        return userOptional.get();
    }

    @Override
    public void saveUser(User user) {
        //todo#4-2 회원등록
        if(isExistUserId(user.getUserId())) {
            throw new UserAlreadyExistsException(user.getUserId());
        }
        int result = userRepository.save(user);
        if(result < 1) {
            throw new RuntimeException("fail - saveUser" + user.getUserId());
        }
    }

    @Override
    public void updateUser(User user) {
        //todo#4-3 회원수정
        if(!isExistUserId(user.getUserId())) {
            throw new UserNotFoundException(user.getUserId());
        }
        int result = userRepository.update(user);
        if(result < 1) {
            throw new RuntimeException("fail - updateUser" + user.getUserId());
        }
    }

    @Override
    public void deleteUser(String userId) {
        //todo#4-4 회원삭제
        if(!isExistUserId(userId)) {
            throw new UserNotFoundException(userId);
        }
        int result = userRepository.deleteByUserId(userId);
        if (result < 1) {
            throw new RuntimeException("fail - deleteUser" + userId);
        }
    }

    @Override
    public User doLogin(String userId, String userPassword) {
        //todo#4-5 로그인 구현, userId, userPassword로 일치하는 회원 조회
        Optional<User> userOptional = userRepository.findByUserIdAndUserPassword(userId, userPassword);

        if(userOptional.isEmpty()) {
            throw new UserNotFoundException(userId);
        }

        userRepository.updateLatestLoginAtByUserId(userId, LocalDateTime.now());

        return userOptional.get();
    }

    @Override
    public boolean isExistUserId(String userId) {
        // userId가 존재하면 true, 존재하지 않으면 false return
        int count = userRepository.countByUserId(userId);
        return count > 0;
    }


}
