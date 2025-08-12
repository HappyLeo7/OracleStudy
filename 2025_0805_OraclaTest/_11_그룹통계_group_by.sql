--1. 사원테이블에서 부서별 인원수 / 급여합계 / 급여평균 / 최고급여액 / 최저급여액
--
--group by select ~ from 사이에는 넣을수 있는 항목
--	: group by 필드칼럼,상수,통계함수

select  
	to_char(sysdate,'yyyy') as 현재년도 --상수
	,'년도' as 년도 --문자열상수
	,deptno --필드칼럼 
	, count(*) as 인원수 -- 통계함수 
	,sum(sapay) as 급여합계
	,avg(sapay) as 급여평균
	,max(sapay) as 최고급여액
	,min(sapay) as 최저급여액
	-- group by 했을때는 앞에 무조건 해당 그룹한 컬럼명 이나 '문자만 올수 있다.'
from sawon
group by deptno --deptno 별로 묶는다. , 제목으로 들어간다.
order by deptno --정렬


--2. 사원테이블에서 부서별 성별 인원수
	select
		deptno,sasex,count(*)
	from sawon
	group by deptno,sasex
	order by deptno,sasex
	
	select * from sawon_view2
	
--3. 사원뷰에서 입사년도별 인원수
	select
		hire_year
		,count(*)
	from sawon_view2
	group by hire_year
	order by hire_year
	
--4. 사원뷰에서 입사월별 인원수
	select 
		hire_month
		,count(*)
	from sawon_view2
	group by hire_month
	order by hire_month
	
--5. 사원뷰에서 입사계절별 인원수
	select 
		hire_season ,count(*)
	from sawon_view
	group by hire_season
	order by hire_season
	
--6. 사원뷰에서 입사년대별 인원수
	select 
		trunc(hire_year,-1) || '년대'as 입사년대
		,count(*)
	from sawon_view2
	group by trunc(hire_year,-1)
	order by trunc(hire_year,-1)
	
--7. 고객뷰에서 성별인원수
	select * from gogek_view3 -- 고객뷰3보기
	
	select
		gogekgender,
		count(*)
	from gogek_view3
	group by gogekgender
	order by gogekgender
	
--8. 고객뷰에서 지역(광역시)별 인원수
	select	-- 1
		substr(goaddr,1,2) -- 3
		,count(*) -- 6
	from gogek_view3 -- 2
	group by substr(goaddr,1,2) -- 5
	order by substr(goaddr,1,2) -- 4
	
--9. 고객뷰에서 연령대별 인원수 (10대 20대 30대 40대)
	select * from GOGEK_VIEW3
	select 
		trunc("나이(살)",-1) as 연령대 
		,count(*) as 카운트
	from gogek_view3
	group by trunc("나이(살)",-1)
	order by trunc("나이(살)",-1)
	
--10. 사원뷰에서 성씨별 인원수 (김씨,이씨)
	select 
		substr(goname,1,1) as 성씨
		,count(*) as 카운트
	from gogek_view3
	group by substr(goname,1,1)
	order by substr(goname,1,1)
	
--11. ### group by ~ having절 : group by에 대한 조건절
select
	deptno
	,count(*)
from sawon_view2
where deptno != 100
group by deptno
	having count(*) >= 5 --group by의 조건문 해당되는 결과값을 보여준다.
order by deptno