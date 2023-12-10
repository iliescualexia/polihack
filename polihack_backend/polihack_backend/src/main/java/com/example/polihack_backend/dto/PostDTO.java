package com.example.polihack_backend.dto;

import com.example.polihack_backend.states.Categories;
import com.example.polihack_backend.states.Role;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PostDTO {
    private String postIdentifier;
    private String email;
    private Categories category;
    private String description;
    private Role postType;
    private Integer hourlyWage;
}
