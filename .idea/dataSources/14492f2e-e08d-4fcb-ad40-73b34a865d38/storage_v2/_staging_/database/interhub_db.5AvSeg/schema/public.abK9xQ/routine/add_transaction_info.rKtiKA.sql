create function add_transaction_info(i_transact_id bigint,
                                     i_info character varying DEFAULT NULL::character varying) returns boolean
    language plpgsql
as
$$
DECLARE
    v_user   integer := 2;
    v_ref_id integer;
begin
    begin
        insert into ib_transacts_info (transact_id, info)
        values ( i_transact_id
               , i_info);
    exception
        WHEN unique_violation THEN
            update ib_transacts_info set info = info || ' ' || i_info where transact_id = i_transact_id;
    end;
    return true;
exception
    when others then
        select max(id) into v_ref_id from ib_transact_info;
        perform log_action_atx(v_ref_id || '', 7, sqlerrm || 'add_transaction_info', 'ERROR');
        return false;
END;
$$;

alter function add_transaction_info(bigint, varchar) owner to interhub_user;

