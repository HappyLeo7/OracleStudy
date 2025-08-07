

1.산술연산자 : +  -  *  /  mod(피젯수,젯수)
  
  select
     2+3 , 5-2 , 3*4 , 
     floor(10/3) as 작은쪽정수 ,
     ceil(10/3) as 큰쪽정수,
      mod(10,3)
  from dual  -- dual(임시테이블)

 2.관계(비교)연산자 :  >  >=  <  <=   =   (같지않냐?)=>  !=  <>
                       ALL  ANY  
                       
 3.일반논리연산자   :  and  or  not
 
 4.기타  
   필드 in(A,B)         :  필드=A or 필드=B
   필드 between A and B :  필드의범위가 A~B사이냐?
            
/*
*/