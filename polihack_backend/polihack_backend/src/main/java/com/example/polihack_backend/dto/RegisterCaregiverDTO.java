package com.example.polihack_backend.dto;

import com.example.polihack_backend.states.Categories;
import com.example.polihack_backend.states.Role;
import com.example.polihack_backend.states.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RegisterCaregiverDTO {
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private Role role;
    private Status status;
    private List<Categories> categories;
    private String description;
    private Integer hourlyWage;
}