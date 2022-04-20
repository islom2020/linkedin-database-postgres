create function get_user_education(i_user_id uuid) returns json
    language plpgsql
as
$$
declare
    v_result json;

begin

    select json_agg(
                   json_build_object(
                           'name', ed.name,
                           'faculty', ued.faculty,
                           'degree', ued.degree,
                           'description', ed.description,
                           'region', get_region(ed.region_id),
                           'linkedin', ed.linkedin_url, 'start_date', ued.start_date, 'end_date', ued.end_date
                       ))
    into v_result
    from education ed
             inner join user_education ued
                        on ed.id = ued.education_id
    where ued.user_id = i_user_id;


    return v_result;
end;
$$;

alter function get_user_education(uuid) owner to postgres;

