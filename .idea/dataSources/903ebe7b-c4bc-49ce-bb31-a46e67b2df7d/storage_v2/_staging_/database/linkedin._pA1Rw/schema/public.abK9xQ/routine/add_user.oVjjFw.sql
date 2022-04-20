create function add_user(i_first_name character varying, i_last_name character varying, i_birth_date character varying,
                         i_region_id uuid, i_email character varying, i_avatar_id uuid DEFAULT NULL::uuid,
                         i_background_id uuid DEFAULT NULL::uuid) returns boolean
    language plpgsql
as
$$
begin

    insert into "user"(first_name, last_name, birth_date, region_id, email, avatar, background)
    values (i_first_name, i_last_name, to_date(i_birth_date, 'YYYY/MM/DD'), i_region_id, i_email, i_avatar_id,
            i_background_id);
    return true;

exception
    when others then
        perform add_log(i_email || ' email already exist');
        return false;
end
$$;

alter function add_user(varchar, varchar, varchar, uuid, varchar, uuid, uuid) owner to postgres;

