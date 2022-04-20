create function edit_user_connection(i_from_id uuid, i_to_id uuid, i_state integer) returns boolean
    language plpgsql
as
$$
declare
        v_from_id uuid := null;
begin
        update user_connection  set status = i_state where from_user = i_from_id and to_user = i_to_id;
        return true;
end;
$$;

alter function edit_user_connection(uuid, uuid, integer) owner to postgres;

