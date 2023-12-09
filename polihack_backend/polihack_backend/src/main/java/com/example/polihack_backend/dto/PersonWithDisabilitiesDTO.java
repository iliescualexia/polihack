package com.example.polihack_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PersonWithDisabilitiesDTO{
        private String email;
        private String categories;
        private String description;
        private Integer hourlyWage;
}
