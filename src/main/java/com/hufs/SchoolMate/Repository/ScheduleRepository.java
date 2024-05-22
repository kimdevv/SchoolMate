package com.hufs.SchoolMate.Repository;


import com.hufs.SchoolMate.model.Location;
import com.hufs.SchoolMate.model.Schedule;
import com.hufs.SchoolMate.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
    Schedule findByUser(User user);
}
