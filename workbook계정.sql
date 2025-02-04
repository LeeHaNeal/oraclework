select * from tb_department;

select department_name"학과 명",category"계열" from tb_department;

select department_name || '의 정원은'|| capacity || '명 입니다.' from tb_department;

select * from tb_student;

select student_name from tb_student where student_no in('A513079','A513090','A513091','A513110','A513119') order by student_name desc;

select department_name, category from tb_department where capacity >=20 and capacity <=30; 

select * from tb_professor;

select professor_name from tb_professor WHERE department_no IS NULL;

select student_name from tb_student where coach_professor_no is null;

select * from tb_class;

select preattending_class_no from tb_class where preattending_class_no is not null order by preattending_class_no desc;

select distinct category from tb_department; 


select student_no , student_name, student_ssn from tb_student where student_no like 'A2%' and student_address like '전주%' and absence_yn ='N' order by student_name ;

