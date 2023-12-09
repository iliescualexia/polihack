package com.example.polihack_backend.dto;

import com.example.polihack_backend.states.Role;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PostDTO {
    private String postIdentifier;
    private String email;
    private String categories;
    private String description;
    private Role postType;
}
