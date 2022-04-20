create function add_user(i_login character varying, i_password character varying, i_fullname character varying,
                         i_condition character varying, i_role_id integer, i_access_priority character varying,
                         i_owner_id integer DEFAULT NULL::integer,
                         i_info character varying DEFAULT NULL::character varying,
                         i_filial_id integer DEFAULT NULL::integer) returns boolean
    language plpgsql
as
$$
DECLARE
    v_reference_id integer;
    v_err_text     varchar;
BEGIN
    insert into ib_users ( login
                         , password
                         , fullname
                         , condition
                         , role_id
                         , access_priority
                         , owner_id, info, filial_id)
    values (i_login, i_password, i_fullname, i_condition, i_role_id, i_access_priority, i_owner_id, i_info,
            i_filial_id);
    return true;
exception
    when others THEN
        v_err_text := sqlerrm;
        perform log_action_atx(i_login, 2, v_err_text, 'ERROR');
        return false;
END;
$$;

alter function add_user(varchar, varchar, varchar, varchar, integer, varchar, integer, varchar, integer) owner to interhub_user;

