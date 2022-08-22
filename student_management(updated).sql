--
-- Create model User
--
CREATE TABLE "project_user" ("id" serial NOT NULL PRIMARY KEY  , "password" varchar(128) NOT NULL, "is_superuser" bool NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "first_name" varchar(150) NOT NULL, "last_name" varchar(150) NOT NULL, "birth_date" date NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "auth_provider" varchar(255) NOT NULL, "is_student" bool NOT NULL, "is_teacher" bool NOT NULL, "email" varchar(254) NOT NULL UNIQUE, "phone_number" varchar(15) NULL, "profile" varchar(100) NOT NULL, "gender" varchar(10) NULL, "text" text NOT NULL, "notes" text NOT NULL);
-- 
-- Create model Classroom
--
CREATE TABLE "project_classroom" ("id" serial NOT NULL PRIMARY KEY, "name" varchar(100) NULL);
--
-- Create model Fees
--
CREATE TABLE "project_fees" ("id" serial NOT NULL PRIMARY KEY, "price" real NULL, "is_paid" bool NOT NULL, "remain_price" real NULL);
--
-- Create model Report
--
CREATE TABLE "project_report" ("id" serial NOT NULL PRIMARY KEY, "data" varchar(2000) NULL);
--
-- Create model Subject
--
CREATE TABLE "project_subject" ("id" serial NOT NULL PRIMARY KEY , "name" varchar(200) NULL);
--
-- Create model Teacher
--
CREATE TABLE "project_teacher" ("id" serial NOT NULL PRIMARY KEY , "user_id" bigint NULL UNIQUE REFERENCES "project_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "project_teacher_subjects" ("id" serial NOT NULL PRIMARY KEY , "teacher_id" bigint NOT NULL REFERENCES "project_teacher" ("id") DEFERRABLE INITIALLY DEFERRED, "subject_id" bigint NOT NULL REFERENCES "project_subject" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model Student
--
CREATE TABLE "project_student" ("id" serial NOT NULL PRIMARY KEY , "classroom_id" bigint NULL REFERENCES "project_classroom" ("id") DEFERRABLE INITIALLY DEFERRED, "fees_id" bigint NULL REFERENCES "project_fees" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" bigint NULL UNIQUE REFERENCES "project_user" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model Programme
--
CREATE TABLE "project_programme" ("id" serial NOT NULL PRIMARY KEY , "name" varchar(200) NULL);
CREATE TABLE "project_programme_subjects" ("id" serial NOT NULL PRIMARY KEY , "programme_id" bigint NOT NULL REFERENCES "project_programme" ("id") DEFERRABLE INITIALLY DEFERRED, "subject_id" bigint NOT NULL REFERENCES "project_subject" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Add field subjects to classroom
--
-- CREATE TABLE "new__project_classroom" ("id" serial NOT NULL PRIMARY KEY , "name" varchar(100) NULL);
-- INSERT INTO "new__project_classroom" ("id", "name") SELECT "id", "name" FROM "project_classroom";


-- ALTER TABLE "new__project_classroom" RENAME TO "project_classroom";
CREATE UNIQUE INDEX "project_teacher_subjects_teacher_id_subject_id_07a8da1d_uniq" ON "project_teacher_subjects" ("teacher_id", "subject_id");
CREATE INDEX "project_teacher_subjects_teacher_id_4b624cb5" ON "project_teacher_subjects" ("teacher_id");
CREATE INDEX "project_teacher_subjects_subject_id_3f723946" ON "project_teacher_subjects" ("subject_id");
CREATE INDEX "project_student_classroom_id_31f099a5" ON "project_student" ("classroom_id");
CREATE INDEX "project_student_fees_id_fb9a236e" ON "project_student" ("fees_id");
CREATE UNIQUE INDEX "project_programme_subjects_programme_id_subject_id_1087fab8_uniq" ON "project_programme_subjects" ("programme_id", "subject_id");
CREATE INDEX "project_programme_subjects_programme_id_9cfd92f1" ON "project_programme_subjects" ("programme_id");
CREATE INDEX "project_programme_subjects_subject_id_af82ff2a" ON "project_programme_subjects" ("subject_id");
-- CREATE UNIQUE INDEX "project_classroom_subjects_classroom_id_subject_id_6b2bb975_uniq" ON "project_classroom_subjects" ("classroom_id", "subject_id");
-- CREATE INDEX "project_classroom_subjects_classroom_id_b6bccf19" ON "project_classroom_subjects" ("classroom_id");
-- CREATE INDEX "project_classroom_subjects_subject_id_1f53e16a" ON "project_classroom_subjects" ("subject_id");
COMMIT;