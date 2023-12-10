package com.example.polihack_backend.controllers;

import com.example.polihack_backend.dto.UserDTO;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.services.UserService;
import com.example.polihack_backend.states.Role;
import com.example.polihack_backend.validation.ErrorInfo;
import com.example.polihack_backend.validation.ErrorType;
import com.example.polihack_backend.validation.OperationResponse;
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
    @GetMapping("/{email}")
    public @ResponseBody ResponseEntity<OperationResponse> findByEmail(@PathVariable String email){
        User user = userService.findByEmail(email);
        OperationResponse response = new OperationResponse();
        if(user!=null){
            UserDTO userDTO = userService.toDTO(user);
            response.setDataObject(userDTO);
        }else{
            response.addError(new ErrorInfo(ErrorType.NOT_FOUND_ERROR,"User does not exist"));
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

}
