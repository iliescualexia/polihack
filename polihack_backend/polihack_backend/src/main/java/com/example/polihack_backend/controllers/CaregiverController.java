package com.example.polihack_backend.controllers;

import com.example.polihack_backend.dto.CaregiverDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.services.CaregiverService;
import com.example.polihack_backend.validation.ErrorInfo;
import com.example.polihack_backend.validation.ErrorType;
import com.example.polihack_backend.validation.OperationResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/caregiver")
public class CaregiverController {
    @Autowired
    CaregiverService caregiverService;
    @GetMapping("/{email}")
    public @ResponseBody ResponseEntity<OperationResponse> findByEmail(@PathVariable String email){
        Caregiver caregiver = caregiverService.findByEmail(email);

        OperationResponse response = new OperationResponse();
        if(caregiver!=null){
            CaregiverDTO caregiverDTO = caregiverService.toDTO(caregiver);
            response.setDataObject(caregiverDTO);
        }else{
            response.addError(new ErrorInfo(ErrorType.NOT_FOUND_ERROR,"User does not exist"));
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
