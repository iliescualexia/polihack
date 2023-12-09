package com.example.polihack_backend.mappers;

import com.example.polihack_backend.dto.CaregiverDTO;
import com.example.polihack_backend.entities.Caregiver;
import com.example.polihack_backend.repositories.CaregiverRepository;
import com.example.polihack_backend.states.Categories;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;

@Component
public class CaregiverMapper implements Mapper<CaregiverDTO, Caregiver> {
    @Autowired
    CaregiverRepository caregiverRepository;
    @Override
    public CaregiverDTO toDTO(Caregiver entity) {
        CaregiverDTO caregiverDTO = new CaregiverDTO();
        BeanUtils.copyProperties(entity,caregiverDTO);
        caregiverDTO.setCategories(generateCategoriesList(entity.getCategories()));
        return caregiverDTO;
    }

    @Override
    public Caregiver toEntity(CaregiverDTO caregiverDTO) {
        Caregiver caregiver = new Caregiver();
        caregiver = caregiverRepository.findByEmail(caregiver.getEmail()).orElse(null);
        if(caregiverDTO.getCategories()!=null && caregiver != null){
            caregiver.setCategories(generateCategoriesString(caregiverDTO.getCategories()));
        }
        return caregiver;

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
