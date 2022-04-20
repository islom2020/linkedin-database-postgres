create function add_attachment(i_name character varying DEFAULT NULL::character varying, i_content_type character varying DEFAULT NULL::character varying, i_content bytea[] DEFAULT NULL::bytea[], i_size bigint DEFAULT NULL::bigint) returns uuid
    language plpgsql
as
$$
declare
    v_attachment_content_id uuid;
begin
    if i_content is null then
        return null;
    end if;

    select add_attachment_content(i_content) into v_attachment_content_id;
    if not FOUND then
        return null;
    end if;

    insert into attachment(attachment_c_id, name, content_type, size)
    values (v_attachment_content_id, i_name, i_content_type, i_size)
    returning id;

exception
    when others then
        perform add_log('ERROR');
        return null;
end;
$$;

alter function add_attachment(varchar, varchar, bytea[], bigint) owner to postgres;

