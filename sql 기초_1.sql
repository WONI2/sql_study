

-- 테이블(엔터티) 생성
-- 성적정보 저장 테이블 

CREATE TABLE tbl_score (
	name varchar2(4) NOT NULL,
	kor number(3) NOT NULL CHECK(kor>0 AND kor<=100),
	eng number(3) NOT NULL CHECK(eng>0 AND eng<=100),
	math number(3) NOT NULL CHECK(math>0 AND math<=100),
	total NUMBER(3) NULL, 
	average NUMBER(5,2),
	grade char(1),
	stu_num NUMBER(6), 
	--pk 거는 법 
	CONSTRAINT pk_stu_num
	PRIMARY KEY (stu_num)
	
);



-- 컬럼 추가하기

ALTER TABLE tbl_score ADD (sci NUMBER(3) NOT NULL);


-- 컬럼 제거하기
ALTER TABLE tbl_score DROP COLUMN sci;

--테이블 생성 후 pk적용 하기 
ALTER TABLE tbl_score 
ADD CONSTRAINT pk_stu_num
	PRIMARY KEY (stu_num);




--테이블 복사(tb_emp)
--CTAS 
CREATE TABLE tb_emp_copy AS SELECT * FROM tb_emp;

--복사테이블 조회
SELECT * FROM tb_emp_copy;

--drop table
DROP TABLE TB_EMP_COPY;

--TRUNCATE table : 데이터만 전체 삭제. 롤백 불가 
TRUNCATE TABLE TB_EMP_COPY; 



--예시 테이블 
CREATE TABLE goods(
	id number(6) PRIMARY KEY,
	g_name varchar2(10) NOT NULL,
	price number(10) DEFAULT 1000,
	reg_date DATE 
	
);

--insert 
INSERT INTO goods (id, g_name, price, reg_date)
VALUES (1,'선풍기',100000,sysdate);

INSERT INTO goods (id, g_name, reg_date)
VALUES (2,'냉풍기',sysdate);

INSERT INTO goods (id, g_name, price)
VALUES (3,'달고나', 900);

--컬럼명 생략시 모든 컬럼에 대해 순서대로 넣어야 함. 되도록 쓰지 말 것. 
INSERT INTO goods
VALUES (4,'쫀디기', 500, sysdate);

INSERT INTO goods (id, g_name, price, reg_date)
VALUES (5,'쫀디기', 500, sysdate),
	   (6, '나나콘', 700, sysdate),
	  	(7, '고구마깡', 1500, sysdate);



SELECT * FROM goods;

--수정 UPDATE 

UPDATE goods SET g_name = '쥐포' WHERE id = 2;


UPDATE goods SET g_name = '아폴로', price = 500 WHERE id = 1;
--where 절이 없으면 모든 행의 값이 변경됨. 
--dml은 복구가 쉽다. 

-- 한 행을 삭제하는 delete 

DELETE FROM goods WHERE id = 4 ; 

-- 모든 행 삭제. 
-- TRUNCATE 와의 차이는? 
DELETE FROM goods


--select 조회 , 모든 컬럼조회시 * 로 대체 가능 실무적으로는 사용하지 말 것  
SELECT 
	CERTI_CD 
	,CERTI_NM 
	,ISSUE_INSTI_NM 
FROM TB_CERTI;


--중복제거 distinct , 안써주면 기본값으로 all이 들어감(생략가능). 
SELECT DISTINCT 
	ISSUE_INSTI_NM 
FROM TB_CERTI;



SELECT 
	CERTI_CD 
	,CERTI_NM 
	,ISSUE_INSTI_NM 
FROM TB_CERTI;

--열의 별칭 지정 가능. as는 생략가능. 띄어쓰기 없으면 "" 도 생략 가능.
SELECT 
	emp_nm AS "사원이름" 
	,addr AS "거주지 주소"
FROM tb_emp;

--테이블명 변경에서는 AS 를 사용 하지 않음
SELECT 
	emp_nm AS "사원이름" 
	,addr AS "거주지 주소"
FROM tb_emp;



--문자열 연결하기 || 사용해서 결합

SELECT 
	CERTI_NM || '('|| ISSUE_INSTI_NM || ')' AS "자격증 정보"
FROM TB_CERTI;


















 