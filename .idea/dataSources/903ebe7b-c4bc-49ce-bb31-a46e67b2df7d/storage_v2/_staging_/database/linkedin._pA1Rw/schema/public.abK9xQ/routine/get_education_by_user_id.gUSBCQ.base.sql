create function get_education_by_user_id(i_user_id uuid)
    returns TABLE(ed_id uuid, ed_name character varying, ed_desc character varying, ed_start_date date, ed_end_date date, ed_degree smallint, ed_faculty character varying)
    language plpgsql
as
$$
declare
begin
    return
        query select ed.id,
                     ed.name,
                     ed.description,
                     ue.start_date,
                     ue.end_date,
                     ue.degree,
                     ue.faculty

              from education ed
                       inner join user_education ue on ed.id = ue.education_id
              where ue.user_id = i_user_id;

end;
$$;

alter function get_education_by_user_id(uuid) owner to postgres;

