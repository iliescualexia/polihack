package com.example.polihack_backend.repositories;

import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.PersonWithDisabilities;
import com.example.polihack_backend.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PersonWithDisabilitiesRepository extends JpaRepository<PersonWithDisabilities,Long> {
    Optional<PersonWithDisabilities> findById(long id);
    Optional<PersonWithDisabilities> findByEmail(String email);

}
