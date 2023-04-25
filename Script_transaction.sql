DROP TABLE EMPLOYEES;

CREATE TABLE employees (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER(8,2)
);

INSERT INTO employees VALUES (1, 'Alice', 5000);
INSERT INTO employees VALUES (2, 'Bob', 6000);
INSERT INTO employees VALUES (3, 'Charlie', 7000);

SELECT * FROM EMPLOYEES;

SELECT sum(salary) FROM EMPLOYEES;


COMMIT; --변경사항을 완전히 DB에 반영, 실무적으로는 수동커밋으로 사용

-- 트랜잭션 시작

BEGIN
	--모든 사원들의 급여를 1000씩 올려준다
	UPDATE EMPLOYEES 
	SET SALARY  = SALARY + 1000; 

	ROLLBACK;

	SELECT sum(salary) FROM EMPLOYEES;


END;





--WHERE 조건절

SELECT EMP_NO , EMP_NM , ADDR, SEX_CD  
FROM TB_EMP
WHERE SEX_CD = 2
;

--WHERE 절로 PK 동등조건을 걸면 무조건 단일행!
SELECT EMP_NO , EMP_NM , ADDR, SEX_CD  
FROM TB_EMP
WHERE EMP_NO = 1000000004;


--비교연산자(90년대생만 조회 )
SELECT EMP_NO , EMP_NM , BIRTH_DE , TEL_NO 
FROM TB_EMP
WHERE BIRTH_DE >= '19900101'
AND BIRTH_DE <='19991231'
;

--between 연산자
SELECT EMP_NO , EMP_NM , BIRTH_DE , TEL_NO 
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19900101' AND '19991231'
;


--OR 연산
SELECT EMP_NO , EMP_NM ,DEPT_CD 
FROM TB_EMP
WHERE DEPT_CD = '100004' OR DEPT_CD ='100006'
;


--IN 연산: OR을 대신해서 사용 가능.
SELECT EMP_NO , EMP_NM ,DEPT_CD 
FROM TB_EMP
WHERE DEPT_CD IN ('100004','100006')
;

--NOT IN 연산: 두 숫자 둘다 아닌 값을 조회
SELECT EMP_NO , EMP_NM ,DEPT_CD 
FROM TB_EMP
WHERE DEPT_CD NOT IN ('100004','100006')
;

--LIKE 연산자 : 검색에서 주로 사용
--와일드 카드 매핑 (% : 0글자 이상, _ : 딱 한 글자)

SELECT 
	EMP_NO ,EMP_NM 
FROM TB_EMP
WHERE EMP_NM LIKE '%심'; --마지막 글자가 심으로 끝나는 것. 이때 '='을 사용X, LIKE 사용

SELECT 
	EMP_NO , EMP_NM , ADDR 
FROM TB_EMP te 
WHERE ADDR LIKE '%용인%' --용인 앞에 0글자 이상, 용인 뒤에 0글자 이상.
;

-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에 하나이면서, 
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회
SELECT 
	EMP_NO , EMP_NM , BIRTH_DE, DEPT_CD  
FROM TB_EMP te 
WHERE 1=1 -- AND 연산 나열할 때, 1=1로 작성해주면 하나의 연산을 지속할 수 있음.
	 AND EMP_NM LIKE '김%'
	 AND DEPT_CD IN (100003, 100004, 100006)
	 AND BIRTH_DE BETWEEN '19900101'AND'19991231'
;

--부정일치 비교 연산자 !=, ^= , <> 같은 의미. ~이 아니다 라는 의미
SELECT EMP_NO,EMP_NM, ADDR, SEX_CD
FROM TB_EMP 
WHERE SEX_CD != 2 
;

SELECT EMP_NO,EMP_NM, ADDR, SEX_CD
FROM TB_EMP 
WHERE SEX_CD ^= 2 
;

SELECT EMP_NO,EMP_NM, ADDR, SEX_CD
FROM TB_EMP 
WHERE SEX_CD <> 2 --가장 많이 쓰이는 연산자
;

SELECT EMP_NO,EMP_NM, ADDR, SEX_CD
FROM TB_EMP 
WHERE NOT SEX_CD = 2 
;


-- 성별코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의
-- 사번, 이름, 성별코드를 조회하세요.

SELECT EMP_NO,EMP_NM,  SEX_CD
FROM TB_EMP 
WHERE SEX_CD <> 1
	AND EMP_NO NOT LIKE '이%' 
;

SELECT EMP_NO, EMP_NM, SEX_CD
FROM TB_EMP 
WHERE 1=1
	AND SEX_CD <> 1
	AND EMP_NM NOT LIKE '이%' 
;


-- NULL값 조회
-- 반드시 IS NULL 연산자로 조회해야 한다.

SELECT 
	EMP_NO, EMP_NM, DIRECT_MANAGER_EMP_NO	
FROM TB_EMP;

--상사가 없는 사람을 조회하고 싶다 
SELECT 
	EMP_NO, EMP_NM, DIRECT_MANAGER_EMP_NO	
FROM TB_EMP
WHERE DIRECT_MANAGER_EMP_NO = NULL; 
-- 불가능한 이유는 NULL값은 비교가 되지 않기 때문에
-- '='으로 NULL에 대한 값을 비교할 수 없음 

-- IS NULL 로 작성해줘야 함. 
SELECT 
	EMP_NO, EMP_NM, DIRECT_MANAGER_EMP_NO	
FROM TB_EMP
WHERE DIRECT_MANAGER_EMP_NO IS NULL;

--NULL 값이 아닌 것을 찾을 때는 IS NOT NULL 을 작성.
-- 보통 NOT은 앞에 작성해주지만 이 경우에는 중간에 오는 것 주의. 
SELECT 
	EMP_NO, EMP_NM, DIRECT_MANAGER_EMP_NO	
FROM TB_EMP
WHERE DIRECT_MANAGER_EMP_NO IS NOT NULL;

-- 연산자 우선순위 
-- NOT > AND > OR AND연산자가 우선순위인 점 주의

SELECT EMP_NO, EMP_NM, ADDR
FROM TB_EMP
WHERE 1=1
	AND EMP_NM LIKE '김%'
	AND ADDR LIKE '%수원%' OR ADDR LIKE '%일산%';
--'김'씨가 나오지 않음. 연산자 우선순위에 따라 달라지는 것
-- 이 경우 김씨면서 수원사는 사람과 일산에 사는 사람을 나오게 하는 것

SELECT EMP_NO, EMP_NM, ADDR
FROM TB_EMP
WHERE 1=1
	AND EMP_NM LIKE '김%'
	AND (ADDR LIKE '%수원%' OR ADDR LIKE '%일산%');
-- OR 연산이 먼저 일어나도록 ()로 묶어줘야. 




