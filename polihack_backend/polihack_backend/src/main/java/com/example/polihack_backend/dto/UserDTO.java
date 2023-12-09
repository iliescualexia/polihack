package com.example.polihack_backend.dto;

import com.example.polihack_backend.states.Role;
import com.example.polihack_backend.states.Status;
import jakarta.persistence.Column;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private Role role;
    private Status status;
}
