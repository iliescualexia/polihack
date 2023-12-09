package com.example.polihack_backend.services;

import com.example.polihack_backend.dto.CaregiverDTO;
import com.example.polihack_backend.dto.PersonWithDisabilitiesDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.PersonWithDisabilities;
import com.example.polihack_backend.entities.User;

import java.util.List;

public interface PersonWithDisabilitiesService {
    PersonWithDisabilities save(PersonWithDisabilities personWithDisabilities);
    PersonWithDisabilities update(PersonWithDisabilities personWithDisabilities);
    PersonWithDisabilities remove(PersonWithDisabilities personWithDisabilities);
    List<PersonWithDisabilities> findAll();
    PersonWithDisabilities findByEmail(String email);
    PersonWithDisabilities findById(long id);
    PersonWithDisabilities toEntity(PersonWithDisabilitiesDTO personWithDisabilitiesDTO);
    PersonWithDisabilitiesDTO toDTO(PersonWithDisabilities personWithDisabilities);
}
