package com.example.polihack_backend.services;

import com.example.polihack_backend.dto.PersonWithDisabilitiesDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.PersonWithDisabilities;
import com.example.polihack_backend.mappers.PersonWithDisabilitiesMapper;
import com.example.polihack_backend.repositories.PersonWithDisabilitiesRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PersonWIthDisabilitiesServiceImpl implements PersonWithDisabilitiesService{
    @Autowired
    protected PersonWithDisabilitiesRepository personWithDisabilitiesRepository;
    @Autowired
    protected PersonWithDisabilitiesMapper personWithDisabilitiesMapper;

    @Override
    public PersonWithDisabilities save(PersonWithDisabilities personWithDisabilities) {
        if(personWithDisabilities!=null && personWithDisabilitiesRepository.findByEmail(personWithDisabilities.getEmail()).isEmpty()){
            return personWithDisabilitiesRepository.save(personWithDisabilities);
        }
        return null;
    }

    @Override
    public PersonWithDisabilities update(PersonWithDisabilities personWithDisabilities) {
        PersonWithDisabilities fromDb = personWithDisabilitiesRepository.findByEmail(personWithDisabilities.getEmail()).orElse(null);
        if(fromDb==null){
            return null;
        }
        ///email can't be modified
        if(fromDb.getEmail().equals(personWithDisabilities.getEmail())){
            BeanUtils.copyProperties(personWithDisabilities,fromDb);
            return personWithDisabilitiesRepository.save(fromDb);
        }
        return null;
    }

    @Override
    public PersonWithDisabilities remove(PersonWithDisabilities personWithDisabilities) {
        PersonWithDisabilities fromDb = personWithDisabilitiesRepository.findByEmail(personWithDisabilities.getEmail()).orElse(null);
        if(fromDb == null){
            return null;
        }
        personWithDisabilitiesRepository.delete(fromDb);
        return fromDb;
    }

    @Override
    public List<PersonWithDisabilities> findAll() {
        return personWithDisabilitiesRepository.findAll();
    }

    @Override
    public PersonWithDisabilities findByEmail(String email) {
        return personWithDisabilitiesRepository.findByEmail(email).orElse(null);
    }

    @Override
    public PersonWithDisabilities findById(long id) {
        return personWithDisabilitiesRepository.findById(id).orElse(null);
    }

    @Override
    public PersonWithDisabilities toEntity(PersonWithDisabilitiesDTO personWithDisabilitiesDTO) {
        return personWithDisabilitiesMapper.toEntity(personWithDisabilitiesDTO);
    }

    @Override
    public PersonWithDisabilitiesDTO toDTO(PersonWithDisabilities personWithDisabilities) {
        return personWithDisabilitiesMapper.toDTO(personWithDisabilities);
    }

}
