package com.example.polihack_backend.controllers;

import com.example.polihack_backend.dto.*;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.PersonWithDisabilities;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.services.CaregiverService;
import com.example.polihack_backend.services.PersonWithDisabilitiesService;
import com.example.polihack_backend.services.UserService;
import com.example.polihack_backend.validation.ErrorInfo;
import com.example.polihack_backend.validation.ErrorType;
import com.example.polihack_backend.validation.OperationResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/register")
public class RegisterController {
    @Autowired
    UserService userService;
    @Autowired
    CaregiverService caregiverService;
    @Autowired
    PersonWithDisabilitiesService personWithDisabilitiesService;

    @PostMapping("/caregiver")
    public @ResponseBody ResponseEntity<OperationResponse> saveCaregiver(@RequestBody RegisterCaregiverDTO registerCaregiverDTO){
        OperationResponse operationResponse = new OperationResponse();
        UserDTO userDTO = new UserDTO();
        CaregiverDTO caregiverDTO = new CaregiverDTO();
        BeanUtils.copyProperties(registerCaregiverDTO,userDTO);
        BeanUtils.copyProperties(registerCaregiverDTO,caregiverDTO);
        User user = userService.toEntity(userDTO);
        Caregiver caregiver = caregiverService.toEntity(caregiverDTO);
        try{
            userService.save(user);
            if(user!=null){
                caregiverService.save(caregiver);
                operationResponse.setDataObject(caregiver);
            }
            else{
                operationResponse.addError(new ErrorInfo(ErrorType.AUTHENTICATION_ERROR, "Email already is registered"));
            }
            return new ResponseEntity<>(operationResponse, HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @PostMapping("/disability")
    public @ResponseBody ResponseEntity<OperationResponse> savePersonWithDisabilities(@RequestBody RegisterPersonWithDisabilitiesDTO registerPersonWithDisabilitiesDTO){
        OperationResponse operationResponse = new OperationResponse();
        UserDTO userDTO = new UserDTO();
        PersonWithDisabilitiesDTO personWithDisabilitiesDTO = new PersonWithDisabilitiesDTO();
        BeanUtils.copyProperties(registerPersonWithDisabilitiesDTO,userDTO);
        BeanUtils.copyProperties(registerPersonWithDisabilitiesDTO,personWithDisabilitiesDTO);
        User user = userService.toEntity(userDTO);
        PersonWithDisabilities personWithDisabilities = personWithDisabilitiesService.toEntity(personWithDisabilitiesDTO);
        try{
            user = userService.save(user);
            if(user!=null){
                personWithDisabilitiesService.save(personWithDisabilities);
                operationResponse.setDataObject(personWithDisabilities);
            }
            else{
                operationResponse.addError(new ErrorInfo(ErrorType.AUTHENTICATION_ERROR, "Email already is registered"));
            }
            return new ResponseEntity<>(operationResponse, HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
