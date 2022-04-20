create function get_skill_by_user_id(i_user_id uuid)
    returns TABLE(skill_id uuid, skill_name character varying, skill_category_id uuid, skill_category_name character varying)
    language plpgsql
as
$$
declare
begin
    return
        query select s.id as skill_id,
                     s.name as skill,
                     sc.id as skill_category_id,
                     sc.name as skill_category
              from  skill s
                       inner join user_skill sk on s.id = sk.skill_id
                       inner join skill_category sc on s.skill_category_id = sc.id
              where sk.user_id = i_user_id;

end;
$$;

alter function get_skill_by_user_id(uuid) owner to postgres;

