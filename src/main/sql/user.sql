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

) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COMMENT='用户注册表';

-- 注册的时候先查询表，如果邮箱已经注册，提示用户该邮箱已经注册，同时页面显示找回密码的选项
-- 登陆的时候用邮箱登录，登录成功显示用户的昵称
-- 激活的时候插入userInfo
-- userInfo表   id, email projectname,, startDate, endDate, 每一个项目有一个Id
-- userDetailInfo id userInfoId projectDetailName  startDate endDate,每一个项目有一个详细的项目列表 
CREATE TABLE user_info(
project_id bigint NOT NULL AUTO_INCREMENT COMMENT '总项目id',
email varchar(30)not null comment '用户邮箱',
project_name VARCHAR(120) NOT NULL COMMENT '项目名称',
start_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '项目开始时间',
end_time TIMESTAMP NOT NULL  COMMENT'项目结束时间',
modify int default 0 COMMENT'项目修改次数',
PRIMARY KEY (porject_id)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COMMENT='用户总项目表'

CREATE TABLE user_detail_info(
project_detail_id bigint NOT NULL AUTO_INCREMENT COMMENT '分项目id',
project_id bigint NOT NULL  COMMENT '分项目所属总项目id',
project_detail_name VARCHAR(120) NOT NULL COMMENT '项目名称',
detail_start_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '项目开始时间',
detail_end_time TIMESTAMP NOT NULL  COMMENT'项目结束时间',
detail_modify int default 0 COMMENT'项目修改次数',
PRIMARY KEY (porject_detail_id)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COMMENT='用户分项目表'



