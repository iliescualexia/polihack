package com.example.polihack_backend.services;

import com.example.polihack_backend.dto.UserDTO;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.states.Status;
import com.example.polihack_backend.validation.ErrorInfo;
import com.example.polihack_backend.validation.ErrorType;
import com.example.polihack_backend.validation.OperationResponse;
import com.example.polihack_backend.validation.PasswordAuthentication;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService{
    @Autowired
    UserService userService;
    @Autowired
    PasswordAuthentication passwordAuthentication;

    @Override
    public OperationResponse login(String email, String password) {
        OperationResponse response = new OperationResponse();
        User user = userService.findByEmail(email);
        if(user == null) {
            response.addError(new ErrorInfo(ErrorType.AUTHENTICATION_ERROR, "Invalid username or password"));
            return response;
        }
        Status status = user.getStatus();
        boolean okStatus = !status.equals(Status.APPROVE);
        if(!okStatus){
            response.addError(new ErrorInfo(ErrorType.AUTHENTICATION_ERROR, "Your status is "+
                    status.name().toLowerCase()+". Please contact the administrator."));
            return response;
        }
        boolean okPassword = passwordAuthentication.authenticate(password.toCharArray(), user.getPassword());
        if(!okPassword){
            response.addError(new ErrorInfo(ErrorType.AUTHENTICATION_ERROR, "Password is incorrect"));
            return response;
        }
        UserDTO userDTO = new UserDTO();
        userDTO.setEmail(user.getEmail());
        response.setDataObject(userDTO);
        return response;
    }
}
