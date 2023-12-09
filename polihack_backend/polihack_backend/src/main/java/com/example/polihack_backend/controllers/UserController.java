package com.example.polihack_backend.controllers;

import com.example.polihack_backend.dto.UserDTO;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.services.UserService;
import com.example.polihack_backend.states.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Autowired
    UserService userService;


    @PostMapping("/save")
    public @ResponseBody ResponseEntity<User> save(@RequestBody UserDTO userDTO){
        User user = userService.toEntity(userDTO);
        try {
            userService.save(user);
            return new ResponseEntity<>(user,HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
