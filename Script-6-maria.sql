

select * from person;

create table tbl_board(
	board_no int(10) auto_increment primary key,
	title varchar(80) not null,
	content varchar(2000), 
	view_count int(10) default 0,
	reg_date_time datetime default current_timestamp
);

select * from tbl_board;

SELECT board_no, title, content, view_count, reg_date_time
FROM tbl_board
ORDER BY BOARD_NO desc;

insert into tbl_board
(title, content)
values ('안녕안녕안녕', '어려운 게시판만들기');



update tbl_board
set view_count = view_count +1
;


select *
from tbl_board
where title like '%30%'
order by board_no 
;


-- maria에서는 concat으로 더하기 역할
select *
from tbl_board
where title like concat('%', '30' , '%')
order by board_no 
;

-- 댓글 테이블 구성(fk를 가짐. 게시글의 글번호가 pk)

create table tbl_reply(
	reply_no int(10) auto_increment,
	reply_text varchar(1000) not null,
	reply_writer varchar(100) not null,
	reply_date DATETIME default current_timestamp,
	board_no int(10),
	constraint pk_reply primary key (reply_no),
	constraint fk_reply
	foreign key (board_no)
	references tbl_board (board_no)
	on delete cascade
);




select *
from tbl_board
order by board_no desc
limit 0, 10 -- 인덱스, 불러올 개수
;


select *
from tbl_reply 
where board_no = 3;



truncate table tbl_board;  
