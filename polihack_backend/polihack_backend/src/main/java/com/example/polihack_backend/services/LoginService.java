package com.example.polihack_backend.services;

import com.example.polihack_backend.validation.OperationResponse;

public interface LoginService {
    OperationResponse login(String email, String password);

}
