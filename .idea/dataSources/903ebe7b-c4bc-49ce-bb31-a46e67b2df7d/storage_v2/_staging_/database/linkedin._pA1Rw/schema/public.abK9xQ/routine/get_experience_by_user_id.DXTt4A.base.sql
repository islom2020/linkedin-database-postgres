create function get_experience_by_user_id(i_user_id uuid)
    returns TABLE(ex_id uuid, ex_name character varying, ex_position character varying, ex_start_date date, ex_end_date date, ex_desc character varying)
    language plpgsql
as
$$
declare
begin
    return
        query select ex.id, ex.name, ue.position, ue.start_date, ue.end_date, ex.description
        from experience ex inner join user_experience ue on ex.id = ue.experience_id
    where ue.user_id = i_user_id;

end;
$$;

alter function get_experience_by_user_id(uuid) owner to postgres;

