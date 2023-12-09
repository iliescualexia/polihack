package com.example.polihack_backend.services;


import com.example.polihack_backend.dto.UserDTO;
import com.example.polihack_backend.entities.User;

import java.util.List;

public interface UserService {
    User save(User user);
    User update(User user);
    User remove(User user);
    List<User> findAll();
    User findByUsername(String username);
    User findById(long id);
    User toEntity(UserDTO userDTO);
    UserDTO toDTO(User user);
}
