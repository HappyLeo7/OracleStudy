/**/
--   서브쿼리(SubQuery)
--   : 서브쿼리의 결과을 이용해서 주쿼리(MainQuery)를 수행하는 SQL문
   
   
--   1.사원테이블에서 장동건과 동일한 부서직원 조회
     
--     1)장동건 부서 구한다
       select deptno from sawon where saname='장동건'
       
--     2)구한 부서정보에 해당하는 목록을 조회
       select * from sawon where deptno=40
       
       select * from sawon
         where deptno=(select deptno from sawon where saname='장동건')   
         
--	   데이터가 수정되면 위 쿼리가 에러날수 있으니 다중형 서브쿼리 작성을 해야 에러가 안뜬다(다중행 = 은 in 으로)
       select * from sawon
         where deptno in (select deptno from sawon where saname='장동건')   
       	
       
--   2.사원테이블에서  안재욱보다 급여을 많이 받는 직원 조회
         
       select * from sawon
         where sapay > (select sapay from sawon where saname='안재욱')
         
--	   2)장동건보다 많이 받는 직원 (다중행)
       select * from sawon --ANY( )은 and연산자 취급
    	   	where sapay > ANY(select sapay from sawon where saname='장동건')
       
	   select * from sawon --ALL( )은 or연산자 취급
	       	where sapay > ALL(select sapay from sawon where saname='장동건')
       
--   3. 사원테이블에서 급여평균보다 많이 받는 직원 조회
	select * from sawon where sapay>
	    (select avg(sapay) from sawon) --서브쿼리
--   4. 사원테이블에서 급여평균보다 적게 받는 직원 조회
	select * from sawon where sapay<
	    (select avg(sapay) from sawon)
--   5. 사원테이블에서 최대급여액을 받는 직원 조회
	select * from sawon where sapay=
	    (select max(sapay) from sawon)
--   6. 사원테이블에서 최저급여액을 받는 직원 조회
   	select * from sawon where sapay=
		(select min(sapay) from sawon)
--   7. 사원테이블에서 최초입사자/최근입사자 조회
	select * from sawon where sahire=
   		(select min(sahire) from sawon)
		or sahire=	  
	   	(select max(sahire) from sawon)
--   8. 사원테이블에서 장동건과 동일한 년도에 입사한 직원 조회
	select * from sawon
	where to_char(sahire,'yyyy')=
	(select to_char(sahire,'yyyy') from sawon where saname='장동건')
	
	insert into sawon values(21,'장동건','남자',10,'사원','2010-8-11',16,2500)

--	9. 고객테이블에서 류민과 동일한 지역에 사는 고객
	 select * from gogek
	 where substr(goaddr,1,2) in
		(select substr(goaddr,1,2) from GOGEK where goname='류민')
		
--	10. 고객테이블에서 짬뽕과 동일한 (90)년대에 태어난 고객(90년대)
	select * from gogek
	where substr(gojumin,1,1) in
	(	select substr(gojumin,1,1) from gogek where goname='짬뽕')
		
--	11. 고객테이블에서 가민과 동일한 월에 태어난 고객 조회(2월)
	select * from gogek
	where substr(gojumin,3,2) in
(		select substr(gojumin,3,2) from gogek where goname='가민')
	
--	12. 사원테이블에서 이미자와 동일한 계절에 입사한 직원 조회(봄)
	select * from sawon
	where 
		case floor(to_number(to_char(sahire,'mm'))/3)
				when 1 then'봄'
				when 2 then'여름'
				when 3 then'가을'
				else '겨울'
			end in
		(select 
			case floor(to_number(to_char(sahire,'mm'))/3)
				when 1 then'봄'
				when 2 then'여름'
				when 3 then'가을'
				else '겨울'
			end
		from sawon where saname='장동건')
		
--	13. 사원테이블에서 10번부서에서 최대급여자를 조회
	select * from sawon 
	where
	(sapay) in
	(select max(sapay) from sawon where deptno=10) and deptno=10
	
--	14. 사원테이블에서 각부서별 최대급여자 조회
	select * from sawon 
	where
	sapay in(select max(sapay) from sawon where deptno=10 and deptno=10)
	or sapay = (select max(sapay) from sawon where deptno=20 and deptno=20)
	or sapay = (select max(sapay) from sawon where deptno=30 and deptno=30)
	or sapay = (select max(sapay) from sawon where deptno=40) and deptno=40
	order by deptno
	

--	### 상관쿼리라 부른다 : 주 쿼리가 서프 쿼리와 상관관계
	select * from sawon s1
	where sapay = (select max(sapay) from sawon s2 where s2.deptno=s1.deptno)
	order by deptno

--	### union : 중첩되는값은 안나오고 결합 (합집합)
	select distinct deptno from sawon
	union
	select deptno from dept
	
--	### union [all] : 모든 행의 결합(중첩관계없이 다나옴)
	select distinct deptno from sawon
	union all
	select deptno from dept
	
	
	select * from sawon where sasex='남자'
	union
	select * from sawon where sasex='여자'
		
--	### intersect : 교집합
	select deptno from sawon
	intersect
	select deptno from dept
	
--	### minus : 차집합
	select deptno from dept
	minus
	select deptno from sawon
	
	