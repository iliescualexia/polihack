package com.example.polihack_backend.services;

import com.example.polihack_backend.dto.NotificationDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.Notification;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.mappers.NotificationMapper;
import com.example.polihack_backend.repositories.NotificationRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificationServiceImpl implements NotificationService{
    @Autowired
    NotificationRepository notificationRepository;
    @Autowired
    NotificationMapper notificationMapper;
    @Override
    public Notification save(Notification notification) {
        if(notification!=null && notificationRepository.findByNotificationIdentifier(notification.getNotificationIdentifier()).isEmpty()){
            return notificationRepository.save(notification);
        }
        return null;
    }

    @Override
    public Notification update(Notification notification) {
        Notification fromDb = notificationRepository.findByNotificationIdentifier(notification.getNotificationIdentifier()).orElse(null);
        if(fromDb==null){
            return null;
        }
        ///email can't be modified
        if(fromDb.getNotificationIdentifier().equals(notification.getNotificationIdentifier())){
            BeanUtils.copyProperties(notification,fromDb);
            return notificationRepository.save(fromDb);
        }
        return null;
    }

    @Override
    public Notification remove(Notification notification) {
        Notification fromDb = notificationRepository.findByNotificationIdentifier(notification.getNotificationIdentifier()).orElse(null);
        if(fromDb == null){
            return null;
        }
        notificationRepository.delete(fromDb);
        return fromDb;
    }

    @Override
    public List<Notification> findAll() {
        return notificationRepository.findAll();
    }

    @Override
    public Notification findByNotificationIdentifier(String identifier) {
        return notificationRepository.findByNotificationIdentifier(identifier).orElse(null);
    }

    @Override
    public List<Notification> findByReceiverEmail(String email) {
        return notificationRepository.findByReceiverEmail(email).orElse(null);
    }

    @Override
    public List<Notification> findBySenderEmail(String email) {
        return notificationRepository.findBySenderEmail(email).orElse(null);
    }

    @Override
    public Notification findById(long id) {
        return notificationRepository.findById(id).orElse(null);
    }

    @Override
    public Notification toEntity(NotificationDTO notificationDTO) {
        return notificationMapper.toEntity(notificationDTO);
    }

    @Override
    public NotificationDTO toDTO(Notification notification) {
        return notificationMapper.toDTO(notification);
    }
}
