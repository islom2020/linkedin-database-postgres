create or replace function add_user_connection(i_from_id uuid, i_to_id uuid) returns boolean
    language plpgsql
as
$$
declare
    v_from_id uuid := null;
begin
    select id
    into v_from_id
    from user_connection
    where from_user = i_from_id and i_to_id = to_user
       or from_user = i_to_id and i_from_id = to_user;
    if not FOUND then
        insert into user_connection(from_user, to_user, status)
        VALUES (i_from_id, i_to_id, 0);
        return true;
    end if;
    return false;
end;

$$;

alter function add_user_connection(uuid, uuid) owner to postgres;

