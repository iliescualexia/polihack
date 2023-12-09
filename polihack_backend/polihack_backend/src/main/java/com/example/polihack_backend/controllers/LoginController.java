package com.example.polihack_backend.controllers;

import com.example.polihack_backend.dto.LoginDTO;
import com.example.polihack_backend.services.LoginService;
import com.example.polihack_backend.validation.ErrorInfo;
import com.example.polihack_backend.validation.ErrorType;
import com.example.polihack_backend.validation.OperationResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginController {
    @Autowired
    LoginService loginService;

    @PostMapping("/api/login")
    public ResponseEntity<OperationResponse> login(@RequestBody LoginDTO loginDTO) {
        try {
            OperationResponse response = loginService.login(loginDTO.getEmail(), loginDTO.getPassword());
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            // Log the exception for debugging purposes
            e.printStackTrace();

            // Create a meaningful error response
            OperationResponse errorResponse = new OperationResponse();
            errorResponse.addError(new ErrorInfo(ErrorType.INTERNAL_ERROR, "Internal Server Error"));

            // Return the error response with a 500 status code
            return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}