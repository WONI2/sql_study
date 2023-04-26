
reate table score (
	name varchar(30) not null,
	kor INT(3) not null,
	eng INT(3) not null,
	math INT(3) not null,
	STU_NUM INT(10) auto_increment,
	TOTAL INT(3),
	AVERAGE FLOAT(5, 2),
	GRADE CHAR(1),
	constraint PK_STU_NUM
	primary key (STU_NUM)
);
select * from score;

select * from person;