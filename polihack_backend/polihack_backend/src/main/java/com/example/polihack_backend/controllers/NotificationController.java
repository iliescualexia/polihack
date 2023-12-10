package com.example.polihack_backend.controllers;

import com.example.polihack_backend.dto.NotificationDTO;
import com.example.polihack_backend.dto.PostDTO;
import com.example.polihack_backend.dto.UserDTO;
import com.example.polihack_backend.entities.Notification;
import com.example.polihack_backend.entities.Post;
import com.example.polihack_backend.services.NotificationService;
import com.example.polihack_backend.validation.ErrorInfo;
import com.example.polihack_backend.validation.ErrorType;
import com.example.polihack_backend.validation.OperationResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/notification")
public class NotificationController {
    @Autowired
    NotificationService notificationService;
    @PostMapping("/save")
    public @ResponseBody ResponseEntity<OperationResponse> saveNotification(@RequestBody NotificationDTO notificationDTO){
        OperationResponse operationResponse = new OperationResponse();
        Notification notification = notificationService.toEntity(notificationDTO);
        notification = notificationService.save(notification);
        if(notification == null){
            operationResponse.addError(new ErrorInfo(ErrorType.INTERNAL_ERROR, "An errror occured"));
        }else{
            operationResponse.setDataObject(notification);
        }
        return new ResponseEntity<>(operationResponse, HttpStatus.OK);
    }
    @DeleteMapping("/remove")
    public @ResponseBody ResponseEntity<OperationResponse> removeNotification(@RequestBody NotificationDTO notificationDTO){
        OperationResponse operationResponse = new OperationResponse();
        Notification notification = notificationService.toEntity(notificationDTO);
        notification = notificationService.remove(notification);
        if(notification == null){
            operationResponse.addError(new ErrorInfo(ErrorType.INTERNAL_ERROR, "An errror occured"));
        }else{
            operationResponse.setDataObject(notification);
        }
        return new ResponseEntity<>(operationResponse, HttpStatus.OK);
    }
    @GetMapping("/findAllNotificationForUser/{email}")
    public @ResponseBody ResponseEntity<OperationResponse>  findAllNotificationForUser(@PathVariable String email){
        OperationResponse operationResponse = new OperationResponse();
        operationResponse.setDataObject(notificationService.findByReceiverEmail(email));
        return new ResponseEntity<>(operationResponse, HttpStatus.OK);
    }
}
