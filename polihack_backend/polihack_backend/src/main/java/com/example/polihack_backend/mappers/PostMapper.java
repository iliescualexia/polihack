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
        postDTO.setCategories(generateCategoriesList(entity.getCategories()));
        return postDTO;
    }

    @Override
    public Post toEntity(PostDTO postDTO) {
        Post post = new Post();
        BeanUtils.copyProperties(postDTO,post);
        if(post.getPostIdentifier() == null){
            post.setPostIdentifier(UUID.randomUUID().toString());
        }
        if(postDTO.getCategories()!=null){
            post.setCategories(generateCategoriesString(postDTO.getCategories()));
        }
        return post;
    }
    public String generateCategoriesString(List<Categories> categories) {
        StringBuilder categoriesString = new StringBuilder();
        for (Categories category : categories ) {
            categoriesString.append(category);
            categoriesString.append(",");
        }
        if(categoriesString.length() >= 1){
            categoriesString.deleteCharAt(categoriesString.length() - 1);
        }
        return categoriesString.toString();
    }

    public List<Categories> generateCategoriesList(String rights) {
        String op = "";
        for (int i = 0; i < rights.length(); i++) {
            char ch = rights.charAt(i);
            if (!Character.isWhitespace(ch)) {
                op += ch;
            }
        }
        String[] categoryArray = op.split(",");
        List<Categories> categoriesList = new LinkedList<>();
        for(String category : categoryArray) {
            categoriesList.add(Categories.valueOf(category));
        }
        return categoriesList;
    }
}
