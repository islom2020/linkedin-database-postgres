create function get_user_full_info(ii_user_id character varying) returns json
    language plpgsql
as
$$
declare
    v_result json;
    i_user_id uuid := ii_user_id::uuid;
begin

    select json_agg(json_build_object(
            'first_name', u.first_name,
            'last_name', u.last_name,
            'birth_date', u.birth_date,
            'about', u.about,
            'email', u.email,
            'region', get_region(u.region_id),
            'education', get_user_education(u.id),
            'experience', get_user_experience(u.id),
            'language', get_user_language(u.id),
            'skill', get_user_skill(u.id)
        ))
    into v_result from "user" u where u.id = i_user_id;

    return v_result;
end;

$$;

alter function get_user_full_info(varchar) owner to postgres;

