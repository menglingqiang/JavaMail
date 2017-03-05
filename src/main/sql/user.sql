------创建user表
create database javamail;
use javamail;
CREATE TABLE user(
user_id bigint NOT NULL AUTO_INCREMENT COMMENT '用户id',
name VARCHAR(120) NOT NULL COMMENT '用户姓名',
password VARCHAR(30) NOT NULL COMMENT '用户密码',
email varchar(30)not null comment '用户邮箱',
code  varchar(100) comment '激活邮箱代码',
status int not null comment '用户状态',
create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '邮箱创建时间',
PRIMARY KEY (user_id)

) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='用户注册表';
