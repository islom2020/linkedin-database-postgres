create function get_user_info(ii_user_id character varying)
    returns TABLE
            (
                id         uuid,
                first_name character varying,
                last_name  character varying,
                birth_date date,
                about      character varying,
                email      character varying
            )
    language plpgsql
as
$$
DECLARE
    i_user_id uuid := Ii_user_id::uuid;
begin
    return query select u.id,
                        u.first_name,
                        u.last_name,
                        u.birth_date,
                        u.about,
                        u.email
                 from "user" u
                 where u.id = i_user_id;
end;

$$;

alter function get_user_info(varchar) owner to postgres;

