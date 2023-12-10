package com.example.polihack_backend.controllers;

import com.example.polihack_backend.dto.CaregiverDTO;
import com.example.polihack_backend.dto.PersonWithDisabilitiesDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.PersonWithDisabilities;
import com.example.polihack_backend.services.CaregiverService;
import com.example.polihack_backend.services.PersonWithDisabilitiesService;
import com.example.polihack_backend.validation.ErrorInfo;
import com.example.polihack_backend.validation.ErrorType;
import com.example.polihack_backend.validation.OperationResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/disability")
public class PersonWithDisabilitiesController {
    @Autowired
    PersonWithDisabilitiesService personWithDisabilitiesService;
    @GetMapping("/{email}")
    public @ResponseBody ResponseEntity<OperationResponse> findByEmail(@PathVariable String email){
        PersonWithDisabilities personWithDisabilities = personWithDisabilitiesService.findByEmail(email);

        OperationResponse response = new OperationResponse();
        if(personWithDisabilities!=null){
            PersonWithDisabilitiesDTO personWithDisabilitiesDTO = personWithDisabilitiesService.toDTO(personWithDisabilities);
            response.setDataObject(personWithDisabilitiesDTO);
        }else{
            response.addError(new ErrorInfo(ErrorType.NOT_FOUND_ERROR,"User does not exist"));
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
