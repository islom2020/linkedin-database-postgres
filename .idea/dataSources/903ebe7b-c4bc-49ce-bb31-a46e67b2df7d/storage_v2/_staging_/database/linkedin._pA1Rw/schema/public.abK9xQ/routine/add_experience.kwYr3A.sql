create function add_user_education(
i_user_id uuid,
i_education_id uuid,
i_start_date date,
i_end_date date,
i_degree smallint,
i_faculty character varying
)
returns boolean
    language plpgsql
as
$$
DECLARE

    BEGIN
        if i_user_id is not null and i_education_id is not null and
           i_start_date is not null and i_end_date is not null and
           i_degree != 0 and i_faculty is not null then

            insert into user_education(user_id,education_id,start_date,end_date,degree,faculty)
            values(i_user_id,i_education_id,i_start_date,i_end_date,i_degree,i_faculty);

            return true;
        end if;

        exception
         when others then
            return false;
    End;
$$;

alter function add_experience(varchar, uuid, varchar, varchar) owner to postgres;


