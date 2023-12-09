package com.example.polihack_backend.mappers;

import com.example.polihack_backend.dto.NotificationDTO;
import com.example.polihack_backend.entities.Notification;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class NotificationMapper implements Mapper<NotificationDTO, Notification>{
    @Override
    public NotificationDTO toDTO(Notification entity) {
        NotificationDTO notificationDTO = new NotificationDTO();
        BeanUtils.copyProperties(entity,notificationDTO);
        return notificationDTO;
    }

    @Override
    public Notification toEntity(NotificationDTO notificationDTO) {
        Notification notification = new Notification();
        BeanUtils.copyProperties(notificationDTO,notification);
        if(notification.getNotificationIdentifier() == null){
            notification.setNotificationIdentifier(UUID.randomUUID().toString());
        }
        return notification;
    }
}
