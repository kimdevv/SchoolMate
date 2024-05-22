package com.hufs.SchoolMate.Repository;


import com.hufs.SchoolMate.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {

    User findByStudentId(String studentId);
}
