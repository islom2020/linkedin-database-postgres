create function get_user_experience(i_user_id uuid) returns json
    language plpgsql
as
$$
declare
    v_result json;

begin

    select json_agg(
        json_build_object(
            'name', ex.name,
            'description', ex.description,
            'region', get_region(ex.region_id),
            'linkedin', ex.linkedin_url,
            'start_date', uex.start_date,
            'end_date', uex.end_date)
        )
    into v_result from experience ex
                           inner join user_experience uex
                                      on ex.id = uex.experience_id
    where uex.user_id = i_user_id;


    return v_result;
end
$$;

alter function get_user_experience(uuid) owner to postgres;