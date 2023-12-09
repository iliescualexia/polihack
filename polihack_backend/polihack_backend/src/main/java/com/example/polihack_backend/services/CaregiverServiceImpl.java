package com.example.polihack_backend.services;

import com.example.polihack_backend.dto.CaregiverDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.mappers.CaregiverMapper;
import com.example.polihack_backend.repositories.CaregiverRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CaregiverServiceImpl implements CaregiverService{
    @Autowired
    protected CaregiverRepository caregiverRepository;
    @Autowired
    protected CaregiverMapper caregiverMapper;
    @Override
    public Caregiver save(Caregiver caregiver) {
        if(caregiver!=null && caregiverRepository.findByEmail(caregiver.getEmail()).isEmpty()){
            return caregiverRepository.save(caregiver);
        }
        return null;
    }

    @Override
    public Caregiver update(Caregiver caregiver) {
        Caregiver fromDb = caregiverRepository.findByEmail(caregiver.getEmail()).orElse(null);
        if(fromDb==null){
            return null;
        }
        ///email can't be modified
        if(fromDb.getEmail().equals(caregiver.getEmail())){
            BeanUtils.copyProperties(caregiver,fromDb);
            return caregiverRepository.save(fromDb);
        }
        return null;
    }

    @Override
    public Caregiver remove(Caregiver caregiver) {
        Caregiver fromDb = caregiverRepository.findByEmail(caregiver.getEmail()).orElse(null);
        if(fromDb == null){
            return null;
        }
        caregiverRepository.delete(fromDb);
        return fromDb;
    }

    @Override
    public List<Caregiver> findAll() {
        return caregiverRepository.findAll();
    }

    @Override
    public Caregiver findByEmail(String email) {
        return caregiverRepository.findByEmail(email).orElse(null);
    }

    @Override
    public Caregiver findById(long id) {
        return caregiverRepository.findById(id).orElse(null);
    }

    @Override
    public Caregiver toEntity(CaregiverDTO caregiverDTO) {
        return caregiverMapper.toEntity(caregiverDTO);
    }

    @Override
    public CaregiverDTO toDTO(Caregiver caregiver) {
        return caregiverMapper.toDTO(caregiver);
    }
}
