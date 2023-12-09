package com.example.polihack_backend.repositories;

import com.example.polihack_backend.entities.Notification;
import com.example.polihack_backend.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface NotificationRepository extends JpaRepository <Notification, Long>{
    Optional<Notification> findById(long id);
    Optional<List<Notification>> findByReceiverEmail(String email);
    Optional<List<Notification>> findBySenderEmail(String email);
    Optional<Notification> findByNotificationIdentifier(String notificationIdentifier);
}
