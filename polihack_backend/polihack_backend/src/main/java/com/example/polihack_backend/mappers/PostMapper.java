package com.example.polihack_backend.mappers;

import com.example.polihack_backend.dto.PostDTO;
import com.example.polihack_backend.entities.Post;
import com.example.polihack_backend.states.Categories;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

@Component
public class PostMapper implements Mapper<PostDTO, Post> {
    @Override
    public PostDTO toDTO(Post entity) {
        PostDTO postDTO = new PostDTO();
        BeanUtils.copyProperties(entity,postDTO);
        return postDTO;
    }

    @Override
    public Post toEntity(PostDTO postDTO) {
        Post post = new Post();
        BeanUtils.copyProperties(postDTO,post);
        if(post.getPostIdentifier() == null){
            post.setPostIdentifier(UUID.randomUUID().toString());
        }
        return post;
    }
}
