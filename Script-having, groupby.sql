
SELECT * FROM tb_sal_his;

-- 집계 함수 (다중행 함수)
-- : 여러 행을 묶어서 함수를 적용
SELECT * FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
ORDER BY emp_no, pay_de
;

SELECT * FROM tb_sal_his
WHERE emp_no = '1000000005'
;

SELECT
    SUBSTR(emp_nm, 1, 1) 성씨   
FROM tb_emp
;


-- GROUP BY로 소그룹화 하지 않으면 집계함수는 전체행수를 기준으로 집계한다.
SELECT 
    SUM(pay_amt) "지급 총액"
    , AVG(pay_amt) "평균 지급액"
    , COUNT(pay_amt) "지급 횟수"
FROM tb_sal_his
;

SELECT * FROM tb_emp;

SELECT 
    COUNT(emp_no) AS "총 사원수"
    , COUNT(direct_manager_emp_no) "dmen" --특정 컬럼을 지목하면 null이 측정되지 않음 
    , COUNT(*) --조회된 행의 수 모두 측정. * 인경우를 제외하고는 모두 null을 빼고 계산.
    , MIN(birth_de) "최연장자의 생일"
    , MAX(birth_de) "최연소자의 생일"   
FROM tb_emp;


SELECT 
    direct_manager_emp_no
FROM tb_emp;


-- GROUP BY : 지정된 컬럼으로 소그룹화 한 후 집계함수 적용
-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일 부서별 총 사원 수를 조회

SELECT EMP_NO,
	EMP_NM,
	BIRTH_DE,
	DEPT_CD
FROM tb_emp
ORDER BY dept_cd
;

--부서별 최연소자와 최연장자를 보여줌. 
SELECT 
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd
;


-- 사원별 누적 급여수령액 조회
SELECT *
FROM TB_SAL_HIS
ORDER BY EMP_NO, PAY_DE ;

SELECT SUM(PAY_AMT)
FROM TB_SAL_HIS;


SELECT 
    emp_no "사번"
    , SUM(pay_amt) "누적 수령액"
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

-- 사원별로 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
    -- , ROUND(pay_amt, 2)
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

-- 집계화나 그룹화를 한 컬럼은 SELECT에서 지목을 할 수 있지만, 
-- 그룹화하지 않은 그대로의 컬럼은 작성할 수 없음.
-- 숫가 같다고 해서 참조할 수 있는 것은 아님.
-- 수가 같은 컬럼을 나타내고 싶다면 GRUOP BY 로 모두 묶어줄 것 OR SELECT에 그룹함수 쓰기 



-- 사원별로 2019년에 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
-- GROUP BY가 들어있는 sql문에서 WHERE절은 그룹화 하기 전에 필터링

SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "연봉"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;

-- HAVING : 그룹화된 결과에서 조건을 걸어 행 수를 제한
-- 그룹화로 통계 낸 이후에 필터링

-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일, 부서별 총 사원 수를 조회
-- 그런데 부서별 사원이 1명인 부서의 정보는 조회하고 싶지 않음.

SELECT 
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(emp_no) > 1
ORDER BY dept_cd
;


-- 사원별로 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
-- 평균 급여가 450만원 이상인 사람만 조회
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

-- 사원별로 2019년 월평균 수령액이 450만원 이상인 사원의 사원번호와 2019년 연봉 조회
SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
;

-- 그룹화 대상 컬럼이 2개 이상인 경우


SELECT 
    emp_no
    , sex_cd
    , dept_cd
FROM tb_emp
ORDER BY dept_cd, sex_cd
;


SELECT 
    dept_cd
    , SEX_CD 
    , COUNT(*)
FROM tb_emp
GROUP BY dept_cd, sex_cd
ORDER BY dept_cd
;
-- GROUP BY 하지 않은 컬럼으로 ORDER BY 하면 에러가 남. 

-- ORDER BY : 정렬
-- ASC : 오름차 정렬 (기본값), DESC : 내림차 정렬
-- 항상 SELECT절의 맨 마지막에 위치

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_no DESC
;

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm DESC
;

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC
;


SELECT 
    emp_no AS 사번
    , emp_nm AS 이름
    , addr AS 주소
FROM tb_emp
ORDER BY 이름 DESC
;

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, 1 DESC
;


SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, emp_no DESC
;

SELECT emp_no AS 사번, emp_nm AS 이름, addr AS 주소
FROM tb_emp
ORDER BY 이름, 1 DESC
;

SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;