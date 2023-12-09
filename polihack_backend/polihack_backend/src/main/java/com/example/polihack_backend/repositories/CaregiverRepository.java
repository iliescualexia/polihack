package com.example.polihack_backend.repositories;

import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.User;
import jakarta.validation.constraints.Email;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface CaregiverRepository extends JpaRepository<Caregiver,Long> {
    Optional<Caregiver> findById(long id);
    Optional<Caregiver> findByEmail(String email);

}
