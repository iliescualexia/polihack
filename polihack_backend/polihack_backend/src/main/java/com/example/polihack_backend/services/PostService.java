package com.example.polihack_backend.services;

import com.example.polihack_backend.dto.NotificationDTO;
import com.example.polihack_backend.dto.PostDTO;
import com.example.polihack_backend.entities.Notification;
import com.example.polihack_backend.entities.PersonWithDisabilities;
import com.example.polihack_backend.entities.Post;
import com.example.polihack_backend.entities.User;

import java.util.List;

public interface PostService {
    Post save(Post post);
    Post update(Post post);
    Post remove(Post post);
    List<Post> findAll();
    Post findByPostIdentifier(String identifier);
    List<Post> findByEmail(String email);
    Post findById(long id);
    Post toEntity(PostDTO postDTO);
    PostDTO toDTO(Post post);
    List<Post> getPostsMatched(PersonWithDisabilities personWithDisabilities);
}
