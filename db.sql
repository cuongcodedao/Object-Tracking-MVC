create database objecttracking;
use objecttracking;

create table user(
                     id INT AUTO_INCREMENT PRIMARY KEY,
                     username varchar(255),
                     password varchar(255)
);
create table project(
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        user_id int not null,
                        input_path varchar(255),
                        output_path varchar(255),
                        progress double,
                        foreign key (user_id) references user(id)
);