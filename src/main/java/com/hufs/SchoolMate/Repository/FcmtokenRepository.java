package com.hufs.SchoolMate.Repository;

import com.hufs.SchoolMate.model.Fcmtoken;
import com.hufs.SchoolMate.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FcmtokenRepository extends JpaRepository<Fcmtoken, Integer> {
    Fcmtoken findByUser(User user);
}
