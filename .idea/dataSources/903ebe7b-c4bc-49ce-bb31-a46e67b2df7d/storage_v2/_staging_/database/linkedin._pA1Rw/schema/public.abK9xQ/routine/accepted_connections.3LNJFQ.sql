create or replace function accepted_connections() returns trigger
    language plpgsql
as
$$
begin
    if old.status = 1 then
        insert into user_connection_accepted(user1_id, user2_id)
        values (old.from_user, old.to_user);
    end if;
    return old;
end;
$$;

alter function accepted_connections() owner to postgres;

