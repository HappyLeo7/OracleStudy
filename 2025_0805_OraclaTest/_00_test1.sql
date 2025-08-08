--크리에잇
create
create
create
create table 자바공부(no int ,name int
			

--테이블 생성
create table 대학교
	(학번 int,
	학년 int,
	전공 varchar2(100),
	전화번호 varchar2(100)
	)

--구조변경 제약걸기
alter table 대학교
	add constraint unique_대학교_학번 unique(학번)
	              
--제약 체크하기
select * from user_constraints where table_name='대학교'
	
select ceil(10.654) as CEIL from dual

select * from user_tables

select tname from tab

select * from gogek
insert into gogek(goaddr) values('서울 동작구')

