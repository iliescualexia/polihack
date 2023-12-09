package com.example.polihack_backend.services;

import com.example.polihack_backend.dto.CaregiverDTO;
import com.example.polihack_backend.dto.UserDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.User;

import java.util.List;

public interface CaregiverService {
    Caregiver save(Caregiver caregiver);
    Caregiver update(Caregiver caregiver);
    Caregiver remove(Caregiver caregiver);
    List<Caregiver> findAll();
    Caregiver findByEmail(String email);
    Caregiver findById(long id);
    Caregiver toEntity(CaregiverDTO caregiverDTO);
    CaregiverDTO toDTO(Caregiver caregiver);
}
