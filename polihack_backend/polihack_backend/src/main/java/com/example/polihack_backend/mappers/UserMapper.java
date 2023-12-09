package com.example.polihack_backend.mappers;

import com.example.polihack_backend.dto.UserDTO;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.repositories.UserRepository;
import com.example.polihack_backend.validation.PasswordAuthentication;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserMapper implements Mapper<UserDTO, User> {
    @Autowired
    UserRepository userRepository;

    @Override
    public UserDTO toDTO(User entity) {
        UserDTO userDTO = new UserDTO();
        BeanUtils.copyProperties(entity,userDTO);
        userDTO.setPassword(null);
        return userDTO;
    }

    @Override
    public User toEntity(UserDTO userDTO) {
        User user = new User();
        BeanUtils.copyProperties(userDTO,user);

        if(user.getPassword() != null){ // must be hashed
            PasswordAuthentication passwordAuthentication = new PasswordAuthentication();
            user.setPassword(passwordAuthentication.hash(user.getPassword().toCharArray()));
        }
        else { // must be taken from db
            User dbUser = userRepository.findByEmail(userDTO.getEmail()).orElse(null);
            if(dbUser == null) return null;
            user.setPassword(dbUser.getPassword());
        }
        return user;
    }
}
