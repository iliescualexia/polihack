package com.example.polihack_backend.services;


import com.example.polihack_backend.dto.UserDTO;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.mappers.UserMapper;
import com.example.polihack_backend.repositories.UserRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    protected UserRepository userRepository;
    @Autowired
    protected UserMapper userMapper;
    @Override
    public User save(User user) {
        if(user!=null&& userRepository.findByEmail(user.getEmail()).isEmpty()){
            return userRepository.save(user);
        }
        return null;
    }

    @Override
    public User update(User user) {
        ///username is unique
        User fromDb = userRepository.findByEmail(user.getEmail()).orElse(null);
        if(fromDb==null){
            return null;
        }
        ///user can't be modified
        if(fromDb.getEmail().equals(user.getEmail())){
            BeanUtils.copyProperties(user,fromDb);
            return userRepository.save(fromDb);
        }
        return null;
    }

    @Override
    public User remove(User user) {
        User fromDb = userRepository.findByEmail(user.getEmail()).orElse(null);
        if(fromDb == null){
            return null;
        }
        userRepository.delete(fromDb);
        return fromDb;
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }


    @Override
    public User findById(long id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public User toEntity(UserDTO userDTO) {
        return userMapper.toEntity(userDTO);
    }

    @Override
    public UserDTO toDTO(User user) {
        return userMapper.toDTO(user);
    }
}
