spool opt1
set echo on
create or replace package opt_lock_save_old_val_demo 
as
  procedure get_emp_details( p_empno in number, p_ename in out varchar2,
    p_sal in out number );
  procedure update_emp_info( p_empno in number, p_old_ename in varchar2, p_old_sal in number, p_new_ename in varchar2, p_new_sal in number, p_num_of_rows_updated in out number );
end;
/
show errors;
create or replace package body opt_lock_save_old_val_demo 
as
  procedure get_emp_details( p_empno in number, p_ename in out varchar2,
    p_sal in out number )
  is
  begin
    select ename, sal
    into p_ename, p_sal
    from emp
    where empno = p_empno;
  end;
  procedure update_emp_info( p_empno in number, p_old_ename in varchar2, p_old_sal in number, p_new_ename in varchar2, p_new_sal in number, p_num_of_rows_updated in out number )
  is
  begin
    p_num_of_rows_updated := 0;
    update emp
    set sal = p_new_sal,
        ename = p_new_ename
    where empno = p_empno 
      and ename = p_old_ename
      and sal = p_old_sal;
    p_num_of_rows_updated := sql%rowcount;
  end;
end;
/
show errors;
spool off
