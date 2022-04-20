create function add_education(i_name character varying, i_region_id uuid,
                              i_description character varying DEFAULT NULL::character varying,
                              i_linkedin_url character varying DEFAULT NULL::character varying) returns boolean
    language plpgsql
as
$$
DECLARE

BEGIN
    insert into education(name, region_id, description, linkedin_url)
    values (i_name, i_region_id, i_description, i_linkedIn_url);
    return true;

exception
    when others then
        return false;
End;
$$;

alter function add_education(varchar, uuid, varchar, varchar) owner to postgres;

