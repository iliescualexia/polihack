package com.example.polihack_backend.dto;

import com.example.polihack_backend.entities.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CaregiverDTO {
    private String email;
    private String categories;
    private String description;
    private Integer hourlyWage;
}
