create function get_user_list(i_full_name character varying DEFAULT NULL::character varying) returns SETOF "user"
    language plpgsql
as
$$
begin
    return query select *
                 from "user"
                 where concat(first_name, ' ', last_name) ilike '%' || i_full_name || '%';
end;

$$;

alter function get_user_list(varchar) owner to postgres;



