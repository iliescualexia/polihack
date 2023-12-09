package com.example.polihack_backend.controllers;

import com.example.polihack_backend.dto.PostDTO;
import com.example.polihack_backend.entities.Post;
import com.example.polihack_backend.services.PostService;
import com.example.polihack_backend.validation.ErrorInfo;
import com.example.polihack_backend.validation.ErrorType;
import com.example.polihack_backend.validation.OperationResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/post")
public class PostController {
    @Autowired
    PostService postService;
    @PostMapping("/save")
    public @ResponseBody ResponseEntity<OperationResponse> savePost(@RequestBody PostDTO postDTO){
        OperationResponse operationResponse = new OperationResponse();
        Post post = postService.toEntity(postDTO);
        post = postService.save(post);
        if(post == null){
            operationResponse.addError(new ErrorInfo(ErrorType.INTERNAL_ERROR, "An errror occured"));
        }else{
            operationResponse.setDataObject(post);
        }
        return new ResponseEntity<>(operationResponse, HttpStatus.OK);
    }
    @DeleteMapping("/remove")
    public @ResponseBody ResponseEntity<OperationResponse> removePost(@RequestBody PostDTO postDTO){
        OperationResponse operationResponse = new OperationResponse();
        Post post = postService.toEntity(postDTO);
        post = postService.remove(post);
        if(post == null){
            operationResponse.addError(new ErrorInfo(ErrorType.INTERNAL_ERROR, "An errror occured"));
        }else{
            operationResponse.setDataObject(post);
        }
        return new ResponseEntity<>(operationResponse, HttpStatus.OK);
    }
    
}
