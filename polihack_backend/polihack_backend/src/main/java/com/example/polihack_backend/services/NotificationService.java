package com.example.polihack_backend.services;

import com.example.polihack_backend.dto.CaregiverDTO;
import com.example.polihack_backend.dto.NotificationDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.Notification;
import com.example.polihack_backend.entities.User;

import java.util.List;

public interface NotificationService {
    Notification save(Notification notification);
    Notification update(Notification notification);
    Notification remove(Notification notification);
    List<Notification> findAll();
    Notification findByNotificationIdentifier(String identifier);
    List<Notification> findByReceiver(String email);
    List<Notification> findBySender(String email);
    Notification findById(long id);
    Notification toEntity(NotificationDTO notificationDTO);
    NotificationDTO toDTO(Notification notification);
}
