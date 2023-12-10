package com.example.polihack_backend.mappers;

import com.example.polihack_backend.dto.CaregiverDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.repositories.CaregiverRepository;
import com.example.polihack_backend.states.Categories;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

@Component
public class CaregiverMapper implements Mapper<CaregiverDTO, Caregiver> {
    @Autowired
    CaregiverRepository caregiverRepository;
    @Override
    public CaregiverDTO toDTO(Caregiver entity) {
        CaregiverDTO caregiverDTO = new CaregiverDTO();
        BeanUtils.copyProperties(entity,caregiverDTO);
        return caregiverDTO;
    }

    @Override
    public Caregiver toEntity(CaregiverDTO caregiverDTO) {
        Caregiver caregiver = new Caregiver();
        BeanUtils.copyProperties(caregiverDTO,caregiver);
        MultipartFile profilePicture = caregiverDTO.getProfilePicture();
        if (profilePicture != null) {
            try {
                caregiver.setProfilePictureData(profilePicture.getBytes());
            } catch (IOException e) {
                // Handle the exception as needed
                e.printStackTrace();
            }
        }

        return caregiver;

    }
}
