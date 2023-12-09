package com.example.polihack_backend.repositories;

import com.example.polihack_backend.entities.Post;
import com.example.polihack_backend.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PostRepository extends JpaRepository<Post,Long> {
    Optional<Post> findById(long id);
    Optional<List<Post>> findByEmail(String email);
    Optional<Post> findByPostIdentifier(String postIdentifier);
}
