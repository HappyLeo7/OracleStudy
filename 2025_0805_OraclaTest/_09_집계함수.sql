/**/
--   집계(통계)함수
   
   count(*)     : 전체레코드수 구함
   count(필드)  : 해당도메인수(null 카운트에서 제외)
   
	select 
       count(*) 전체레코드수,
       count(samgr) 부서장이아닌직원수,
       max(sapay) 최고급여액,
       min(sapay) 최저급여액,
       sum(sapay) 급여합계,
       avg(sapay) 급여평균,
       max(sahire) 최근입사일자,
       min(sahire) 최초입사일자 
	from sawon
   
--   1.사원테이블에서 samgr가 null인 정보 조회(is null)
--     : 부서장 조회
    select * from sawon where samgr is null
     
--   2.사원테이블에서 부서장이 아닌 직원 조회(is not null)
	select * from sawon where samgr is not null  
   

