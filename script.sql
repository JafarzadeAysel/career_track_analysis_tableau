select ROW_NUMBER() OVER(PARTITION BY a.student_id) student_track_id,
b.track_Name,
a.date_enrolled,
CASE WHEN a.date_completed IS NOT NULL then 1 else 0 END AS track_completed,
datediff(date_completed,a.date_enrolled) days_for_completion,
CASE WHEN datediff(date_completed,a.date_enrolled) = 0 then "Same day"
WHEN datediff(date_completed,a.date_enrolled) between 1 and 7 then "1 to 7 days"
WHEN datediff(date_completed,a.date_enrolled) between 8 and 30 then "8 to 30 days"
WHEN datediff(date_completed,a.date_enrolled) between 31 and 60 then "31 to 60 days"
WHEN datediff(date_completed,a.date_enrolled) between 61 and 90 then "61 to 90 days"
WHEN datediff(date_completed,a.date_enrolled) between 91 and 365 then "91 to 365 days"
WHEN datediff(date_completed,a.date_enrolled) >366 then "366+"
END AS completion_bucket
FROM career_track_student_enrollments a
Left JOIN career_track_info b
on a.track_id = b.track_id;