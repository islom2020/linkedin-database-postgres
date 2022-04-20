create function add_service_field_values(i_title character varying, i_field_id integer, i_parent_id integer) returns integer
    language plpgsql
as
$$
DECLARE
    v_err_text           varchar;
    v_id_max             integer;
    v_object_id constant integer := 1;
BEGIN
    INSERT INTO public.ib_service_field_values (title,
                                                field_id,
                                                parent_id)
    VALUES (i_title,
            i_field_id,
            i_parent_id)
    returning id into v_id_max;
    return v_id_max;
exception
    when others THEN
        select max(id) into v_id_max from ib_service_field_values;
        perform log_action_atx(v_id_max || '', v_object_id, sqlerrm || ' add_service_field_values', 'ERROR');
        return -1;
END;
$$;

alter function add_service_field_values(varchar, integer, integer) owner to interhub_user;

