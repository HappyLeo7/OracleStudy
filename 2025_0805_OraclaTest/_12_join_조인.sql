/*
[FK 설정]
dept.deptno -> sawon.deptno
sawon.sabun -> sawon.samgr
sawon.sabun -> gogek.godam
*/

alter table sawon
	add constraint fk_sawon_deptno foreign key(deptno)
									references dept(deptno);
									
alter table sawon
	add constraint fk_sawon_samger foreign key(samgr)
									references sawon(sabun);
									
alter table gogek
	add constraint fk_gogek_godam foreign key(godam)
									references sawon(sabun);

select constraint_type,constraint_name from user_constraints
where table_name=upper('sawon')
select constraint_type,constraint_name from user_constraints
where table_name='GOGEK'

-- upper() 대문자로 바꿔주는 함수


조인(cross join)
	: 2개 이상의 테이블을 연결해서 조회하는 방법
	
	1. inner join(equi-join) : 1 대 1 join
	2. outer join
		left outer join : A left outer join B on 연결조건
						  A와 B의 행은 연결조건에 의해서 결합
						  + 조건에 맞지 않더라도 A행은 모두 나온다.
		right outer join : A right outer join B on 연결조건
						   A와 B의 행은 연결조건에 의해서 결합
						   + 조건에 맞지 않더라도 B행은 모두 나온다.
		full outer join : A full outer join B on 연결조건
						  A와 B의 행은 연결조건에 의해서 결합
						  + 조건에 맞지 않더라도 A,B행은 모두 나온다.
						  
  	3. self join : 자신의 테이블과 조인하는 형식
  	
--  ##inner join
  		select * from sawon , dept
  		where sawon.deptno = dept.deptno
  			and sawon.deptno = 10
  	
--  	[ANSI-92 SQL] : 92년에 표준 sql --표준 지향
--  									on 조인조건
  		select * from sawon inner join dept on sawon.deptno = dept.deptno
  		where sawon.deptno=10
  	
  	
--  ## natural join(2개 테이블에서 공통(PK-FK)속성끼리 자동으로 조인조건 설정) 사용 지양
  		select * from sawon natural join dept
  		select * from sawon join dept using(deptno)
  	
--	##### self join  #####
--	사번  사원직위  사원명 / 상사번호  상사직위  상사명
--		sawon s1	     	sawon s2
		
		select 
			s1.sabun,s1.sajob,s1.saname ,s1.samgr,s2.sabun,s2.sajob,s2.saname
		from sawon s1, sawon s2
		where s1.samgr = s2.sabun
		order by s1.sabun
		
		[ANSI-92 SQL]
		select
			s1.sabun,s1.sajob,s1.saname ,s1.samgr,s2.sabun,s2.sajob,s2.saname
		from sawon s1 inner join sawon s2 on s1.samgr = s2.sabun
		order by s1.sabun
		
--	## left outer join (오라클에서만 적용)  : left는 (+) ##
		select 
			s1.sabun,s1.sajob,s1.saname ,s1.samgr,s2.sabun,s2.sajob,s2.saname
		from sawon s1 , sawon s2
		where s1.samgr=s2.sabun(+)
		order by s1.sabun
		
--		cf) MS-SQL server : where s1.samgr*=s2.sabun
		
--		[ANSI-92 SQL]  s1이 다나오고 s2 는 공통되는거만 나온다 
		select
			s1.sabun,s1.sajob,s1.saname ,s1.samgr,s2.sabun,s2.sajob,s2.saname
		from sawon s1 left join sawon s2 on s1.samgr = s2.sabun
		order by s1.sabun
		
--   사원번호	사원명	/	부서명	/	고객번호	고객명
--  	sawon s			dept d			gogek g
--				  (1)			 
-- 								  (2)
			select * from sawon s inner join dept d on d.deptno=s.deptno
			select s.sabun,s.saname,d.deptno,d.dname    
			,g.gobun,g.goname,g.godam 
				from sawon s 
					inner join dept d on d.deptno=s.deptno --(1) s와 d를 결합
						inner join gogek g on s.sabun=g.godam --(2) s+d 된상태에서 g를 결합 
			order by s.sabun

			--left
			select s.sabun,s.saname,d.deptno,d.dname    
			,g.gobun,g.goname,g.godam 
				from sawon s 
					inner join dept d on d.deptno=s.deptno --(1) s와 d를 결합
						left outer join gogek g on s.sabun=g.godam --(2) s+d 된상태에서 g를 left outer 결합 
			order by s.sabun
						
			
			/*
			사번 사원명 / 부서명 / 사원고객번호 사원고객명 / 상사번호 상사명     / 상사고객번호 상사고객명
			sawon s1  dept d        gogek g         sawon(self) s2	   gogek g2		
					(1)       (2)             (3)                  (4)       */
			select 
			s.sabun as 사원번호, s.saname as 사원명
			,d.dname as 부서명
			,g.gobun as "사원 관리 고객번호",g.goname as"사원 관리 고객명"
			,s2.samgr as "상사번호",s2.saname as"상사명"
			,g2.gobun as "상사 담당 고객번호",g2.goname as "상사 담당 고객명"
			from sawon s
				inner join dept d on s.deptno=d.deptno --(1)
					left outer join gogek g on s.sabun=g.godam --(2)
						left outer join sawon s2 on s2.sabun=s.samgr --(3)
							left outer join gogek g2 on g2.godam=s2.sabun --(4)
			order by s.sabun
			
			/* 연습
--			select
--			swtable.sabun,swtable.saname,dptable.dname
--			,gtable.gobun,gtable.goname
--			,smtable.sabun,smtable.saname
--			from sawon swtable
--				left outer join dept dptable on swtable.deptno=dptable.deptno
--					left outer join gogek gtable on swtable.sabun =gtable.godam
--						left outer join sawon smtable on swtable.samgr=smtable.sabun
--				*/
			
			select * from sawon
			select * from dept
			select * from gogek
			select * from user_sequences