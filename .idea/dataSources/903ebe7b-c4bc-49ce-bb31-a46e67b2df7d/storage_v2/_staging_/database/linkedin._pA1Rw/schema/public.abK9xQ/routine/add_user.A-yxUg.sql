create function add_user(i_first_name character varying, i_last_name character varying, i_region_id uuid,
                         i_email character varying,
                         i_about character varying DEFAULT NULL::character varying) returns boolean
    language plpgsql
as
$$
declare
begin

    raise notice 'functionga kirdi';
    insert into "user"(first_name, last_name, region_id, about, email)
    values (i_first_name, i_last_name, i_region_id, i_about, i_email);
    return true;

exception
    when others then
        perform add_log(i_email || ' email already exist');
        return false;
end
$$;

alter function add_user(varchar, varchar, uuid, varchar, varchar) owner to postgres;

