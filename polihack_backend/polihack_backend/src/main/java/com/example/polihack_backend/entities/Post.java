package com.example.polihack_backend.entities;

import com.example.polihack_backend.states.Role;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private long id;
    @OneToOne(targetEntity = User.class)
    private String email;
    private String categories;
    private String description;
    @Enumerated(EnumType.STRING)
    private Role postType;
    @Column(name = "post_identifier")
    private String postIdentifier;



}