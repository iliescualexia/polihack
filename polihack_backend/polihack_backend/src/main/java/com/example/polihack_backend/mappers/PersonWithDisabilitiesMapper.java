package com.example.polihack_backend.mappers;

import com.example.polihack_backend.dto.PersonWithDisabilitiesDTO;
import com.example.polihack_backend.entities.PersonWithDisabilities;
import com.example.polihack_backend.states.Categories;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;

@Component
public class PersonWithDisabilitiesMapper implements Mapper<PersonWithDisabilitiesDTO, PersonWithDisabilities> {

    @Override
    public PersonWithDisabilitiesDTO toDTO ( PersonWithDisabilities entity ) {
        PersonWithDisabilitiesDTO personWithDisabilitiesDTO = new PersonWithDisabilitiesDTO (  );
        BeanUtils.copyProperties( entity, personWithDisabilitiesDTO );
        personWithDisabilitiesDTO.setCategories ( generateCategoriesList ( entity.getCategories () ) );
        return personWithDisabilitiesDTO;
    }

    @Override
    public PersonWithDisabilities toEntity ( PersonWithDisabilitiesDTO personWithDisabilitiesDTO ) {
        PersonWithDisabilities personWithDisabilities = new PersonWithDisabilities ();
        BeanUtils.copyProperties ( personWithDisabilitiesDTO, personWithDisabilities );

        if ( personWithDisabilitiesDTO.getCategories () != null && personWithDisabilities != null) {
            personWithDisabilities.setCategories ( generateCategoriesString ( personWithDisabilitiesDTO.getCategories () ) );
        }

        return personWithDisabilities;
    }

    public String generateCategoriesString( List<Categories> categories) {
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
        List<Categories> categoriesList = new LinkedList<> ();
        for(String category : categoryArray) {
            categoriesList.add(Categories.valueOf(category));
        }
        return categoriesList;
    }
}