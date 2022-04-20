create function get_region(i_id uuid)
 returns character varying
    language plpgsql
as
$$
declare
    v_region character varying;
begin

    select r.name || ',' || c.name
    into v_region
    from country c
             inner join region r on c.id = r.country_id and r.id = i_id;

    return v_region;
end;

$$;

alter function get_region(uuid) owner to postgres;

