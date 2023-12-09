package com.example.polihack_backend.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
@Entity
@NoArgsConstructor
@Table(name="user_table")
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private long id;
    @Column(nullable=false)
    private String username;
    @Column(nullable = false)
    private String password;
    @Column(name = "full_name")
    private String fullName;
}
