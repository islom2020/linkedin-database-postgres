create function add_s_filials(i_name character varying, i_condition character varying) returns boolean
    language plpgsql
as
$$
DECLARE
    v_reference_id       integer;
    v_err_text           varchar;
    v_created_by         integer := 1;
    v_date               date    := now()::date;
    v_object_id constant integer := 2;
BEGIN
    insert into ib_s_filials (name, condition)
    values (i_name, i_condition);
    return true;
exception
    when others THEN
        v_err_text := sqlerrm;
        perform log_action_atx(i_name, v_object_id, v_err_text, 'ERROR');
        return false;
END;
$$;

alter function add_s_filials(varchar, varchar) owner to interhub_user;

