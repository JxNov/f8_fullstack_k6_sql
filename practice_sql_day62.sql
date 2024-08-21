CREATE DATABASE database_01_nguyenmanhdung;

-- Tạo bảng courses
CREATE TABLE IF NOT EXISTS courses (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name CHARACTER VARYING(255) NOT NULL,
    price FLOAT,
    detail TEXT,
    teacher_id INT NOT NULL,
    active INT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    FOREIGN KEY (teacher_id) REFERENCES teacher(id) ON DELETE CASCADE
);
DROP TABLE IF EXISTS courses;

-- Thêm trường description trước trường detail với kiểu dữ liệu và ràng buộc sau:
-- Kiểu text
-- NULL
ALTER TABLE courses ADD COLUMN description TEXT NULL;

-- Đổi tên trường detail thành content và ràng buộc chuyển thành NOT NULL
ALTER TABLE courses RENAME COLUMN detail TO content;
ALTER TABLE courses ALTER COLUMN content SET NOT NULL;

-- Tạo bảng teacher
CREATE TABLE IF NOT EXISTS teacher (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name CHARACTER VARYING(255) NOT NULL,
    bio TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);
DROP TABLE IF EXISTS teacher;

-- Thêm 3 giảng viên vào bảng teacher, mỗi giảng viên thêm 3 khóa học
INSERT INTO teacher(name, bio) VALUES ('Teacher 1', 'Bio 1');
INSERT INTO teacher(name, bio) VALUES ('Teacher 2', 'Bio 2');
INSERT INTO teacher(name, bio) VALUES ('Teacher 3', 'Bio 3');

INSERT INTO courses(name, price, content, teacher_id) VALUES ('Course 1', 100, 'Content 1', 1);
INSERT INTO courses(name, price, content, teacher_id) VALUES ('Course 2', 200, 'Content 2', 1);
INSERT INTO courses(name, price, content, teacher_id) VALUES ('Course 3', 300, 'Content 3', 1);

INSERT INTO courses(name, price, content, teacher_id) VALUES ('Course 4', 400, 'Content 4', 2);
INSERT INTO courses(name, price, content, teacher_id) VALUES ('Course 5', 500, 'Content 5', 2);
INSERT INTO courses(name, price, content, teacher_id) VALUES ('Course 6', 600, 'Content 6', 2);

INSERT INTO courses(name, price, content, teacher_id) VALUES ('Course 7', 700, 'Content 7', 3);
INSERT INTO courses(name, price, content, teacher_id) VALUES ('Course 8', 800, 'Content 8', 3);
INSERT INTO courses(name, price, content, teacher_id) VALUES ('Course 9', 900, 'Content 9', 3);

-- Sửa tên và giá từng khóa học thành tên mới và giá mới (Tên khóa học, giá khóa học các khóa học không được giống nhau)
UPDATE courses SET name='Course 1 - Update', updated_at=NOW() WHERE id=1;
UPDATE courses SET name='Course 2 - Update', updated_at=NOW() WHERE id=2;
UPDATE courses SET name='Course 3 - Update', updated_at=NOW() WHERE id=3;

UPDATE courses SET name='Course 4 - Update', updated_at=NOW() WHERE id=4;
UPDATE courses SET name='Course 5 - Update', updated_at=NOW() WHERE id=5;
UPDATE courses SET name='Course 6 - Update', updated_at=NOW() WHERE id=6;

UPDATE courses SET name='Course 7 - Update', updated_at=NOW() WHERE id=7;
UPDATE courses SET name='Course 8 - Update', updated_at=NOW() WHERE id=8;
UPDATE courses SET name='Course 9 - Update', updated_at=NOW() WHERE id=9;

-- Sửa lại bio của từng giảng viên (Bio từng giảng viên không được giống nhau)
UPDATE teacher SET bio='Bio 1 - Update', updated_at=NOW() WHERE id=1;
UPDATE teacher SET bio='Bio 2 - Update', updated_at=NOW() WHERE id=2;
UPDATE teacher SET bio='Bio 3 - Update', updated_at=NOW() WHERE id=3;

-- Hiển thị danh sách giảng viên, danh sách khóa học
SELECT * FROM teacher;
SELECT * FROM courses;
