------秒杀存储过程
Delimiter $$ 
create procedure `seckill`.`execute_seckill`
(   in v_seckill_id bigint, in v_phone bigint, in v_kill_time timestamp, out r_result int ) 
begin
    declare insert_count int DEFAULT 0;
    insert ignore into success_killed(seckill_id,user_phone,create_time) values
    (v_seckill_id,v_phone,v_kill_time);
    select row_count() into insert_count;
    if (insert_count = 0) then
        rollback;
        set r_result=-1;
        elseif (insert_count<0) then
        rollback;
        set r_result = -2;
    else
        update seckill
        set number= number-1
        where seckill_id = v_seckill_id
        and v_kill_time > start_time
        and v_kill_time < end_time
        and number>0;
        select row_count() into insert_count;
        if (insert_count = 0) then
            rollback;
            set r_result=0;
            elseif (insert_count<0) then
            rollback;
            set r_result = -2;
            else
            commit;
            set r_result=1;
        end if;
    end if;
end;
$$
delimiter ;
set @r_result =-3;
call execute_seckill(1000,13458975641,now(),@r_result);
select @r_result;