package com.example.polihack_backend.mappers;

public interface Mapper <DTO, ENT> {
    DTO toDTO(ENT entity);
    ENT toEntity(DTO dto);
}
