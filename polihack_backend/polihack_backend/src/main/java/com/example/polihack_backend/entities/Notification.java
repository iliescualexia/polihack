package com.example.polihack_backend.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Table(name="notification_table")
@Data
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private long id;
    @OneToOne(targetEntity = User.class)
    private String receiverEmail;
    @OneToOne(targetEntity = User.class)
    private String senderEmail;
    @Column(name = "notification_identifier")
    private String notificationIdentifier;
}
