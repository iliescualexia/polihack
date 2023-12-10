package com.example.polihack_backend.services;

import com.example.polihack_backend.dto.PostDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.entities.PersonWithDisabilities;
import com.example.polihack_backend.entities.Post;
import com.example.polihack_backend.entities.User;
import com.example.polihack_backend.mappers.PostMapper;
import com.example.polihack_backend.repositories.PostRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PostServiceImpl implements PostService {
    @Autowired
    protected PostRepository postRepository;
    @Autowired
    protected PostMapper postMapper;

    @Override
    public Post save(Post post) {
        if(post!=null&&postRepository.findByPostIdentifier(post.getPostIdentifier()).isEmpty()){
            return postRepository.save(post);
        }
        return null;
    }

    @Override
    public Post update(Post post) {
        Post fromDb = postRepository.findByPostIdentifier(post.getPostIdentifier()).orElse(null);
        if(fromDb==null){
            return null;
        }
        ///email can't be modified
        if(fromDb.getPostIdentifier().equals(post.getPostIdentifier())){
            BeanUtils.copyProperties(post,fromDb);
            return postRepository.save(fromDb);
        }
        return null;
    }

    @Override
    public Post remove(Post post) {
        Post fromDb = postRepository.findByPostIdentifier(post.getPostIdentifier()).orElse(null);
        if(fromDb == null){
            return null;
        }
        postRepository.delete(fromDb);
        return fromDb;
    }

    @Override
    public List<Post> findAll() {
        return postRepository.findAll();
    }

    @Override
    public Post findByPostIdentifier(String identifier) {
        return postRepository.findByPostIdentifier(identifier).orElse(null);
    }

    @Override
    public List<Post> findByEmail(String email) {
        return postRepository.findByEmail(email).orElse(null);
    }

    @Override
    public Post findById(long id) {
        return postRepository.findById(id).orElse(null);
    }

    @Override
    public Post toEntity(PostDTO postDTO) {
        return postMapper.toEntity(postDTO);
    }

    @Override
    public PostDTO toDTO(Post post) {
        return postMapper.toDTO(post);
    }
    @Override
    public List<Post> getPostsMatched (PersonWithDisabilities personWithDisabilities ) {
        List<Post> list = postRepository.findAll();

        return list.stream().filter( post -> personWithDisabilities.getCategories ().contains(post.getCategory ().name ()) ).collect( Collectors.toList());
    }
}
