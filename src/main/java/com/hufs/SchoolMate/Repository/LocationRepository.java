package com.hufs.SchoolMate.Repository;


import com.hufs.SchoolMate.model.Location;
import com.hufs.SchoolMate.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LocationRepository extends JpaRepository<Location, Integer> {
    Location findByUser(User user);
    void deleteByUser(User user);
}
