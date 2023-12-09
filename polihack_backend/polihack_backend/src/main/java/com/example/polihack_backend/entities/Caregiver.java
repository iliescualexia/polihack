package com.example.polihack_backend.entities;

import com.example.polihack_backend.states.Categories;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@NoArgsConstructor
@Table(name="caregiver_table")
@Data
public class Caregiver {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private long id;
    private String email;
    private String categories;
    private String description;
    private Integer hourlyWage;
}
