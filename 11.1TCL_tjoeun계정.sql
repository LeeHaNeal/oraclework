/*
    *TCL (TRANSATION CONTROL LANGUAGE) : 트랜잭션 제어 언어
    
    * 트랜잭션
      - 데이터베이스의 논리적 연산단위
      - 데이터의 변경사항(DML)들을 하나의 트랜잭션으로 묶어서 처리
        DML문 한개를 수정할 때 트랜잭션 존재하면 해당 트랜잭션에 같이 묶어서 처리
                                트랜잭션이 존재하지않으면 트랜잭션을 만들어서 묶어서 처리
      COMMIT 하기 전까지 변경사항들을 하나의 트랜잭션에 담는다.
      - 트랜잭션의 대상이 되는 SQL : INSERT,UPDATE,DELETE
      
      COMMIT (트랜잭션 종료 처리후 확정)
      - 한 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영 시킴(트랜잭션 없어짐)
      ROLLBACK (트랜잭션 취소)
      - 트랜잭션에 담겨있는 변경사항들을 삭제(취소)한 후 마지막 COMMIT시점으로 돌아감
      SAVEPOINT (임시저장)
      - 현재 이 시점에 해당포인트명으로 임시저장점을 정의해둠
      ROLLBACK 진행시 변경사항들을 다 삭제하는게 아니라 일부만 롤백 가능
*/

SELECT * FROM EMP_01;

-- 사번 301인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = '301';

-- 사번 210인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = '210';

ROLLBACK; -- 지웠던 301번과 210번이 되살아 남
