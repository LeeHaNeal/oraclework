SELECT * FROM member WHERE id = 'user01';
SELECT * FROM member ORDER BY create_date DESC LIMIT 10;

    INSERT INTO board 
VALUES (Board_SEQ.NEXTVAL, 0, SYSDATE, SYSDATE, '내용1', '제목1', 'user01');

COMMIT;

INSERT INTO REPLY
values(sysdate,1,reply_seq.nextval,sysdate,'댓글1','user02');

commit;