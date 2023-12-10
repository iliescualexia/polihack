package com.example.polihack_backend.dto;

import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.states.Categories;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CaregiverDTO {
    private String email;
    private String description;
    private MultipartFile profilePicture;
}
