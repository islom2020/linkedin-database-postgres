create function add_wallet_client_info(i_first_name character varying, i_surname character varying,
                                       i_last_name character varying, i_birth_date character varying,
                                       i_doc_number character varying, i_nationality character varying,
                                       i_gender character varying, i_birth_address character varying,
                                       i_expiry_doc character varying, i_authority character varying,
                                       i_registration_address character varying, i_doc_photo_url character varying,
                                       i_mail_address character varying, i_self_photo character varying,
                                       i_state_id integer, i_client_id integer, i_info character varying,
                                       i_region_id integer,
                                       i_created_doc_date character varying DEFAULT NULL::character varying,
                                       i_created_date character varying DEFAULT NULL::character varying,
                                       i_doc_address_photo character varying DEFAULT NULL::character varying,
                                       i_oson_file character varying DEFAULT NULL::character varying,
                                       i_yandex_file character varying DEFAULT NULL::character varying,
                                       i_qiwi_file character varying DEFAULT NULL::character varying,
                                       i_filial_id integer DEFAULT NULL::integer,
                                       i_user_id integer DEFAULT NULL::integer) returns boolean
    language plpgsql
as
$$
DECLARE
    v_err_text           varchar;
    v_object_id constant integer := 5;

begin
    insert into ib_wallet_client_info ( first_name
                                      , surname
                                      , last_name
                                      , birth_date
                                      , doc_number
                                      , nationality
                                      , gender
                                      , birth_address
                                      , expiry_doc
                                      , authority
                                      , registration_address
                                      , doc_photo_url
                                      , mail_address
                                      , self_photo
                                      , state_id
                                      , client_id
                                      , info
                                      , region_id
                                      , created_doc_date
                                      , doc_address_photo
                                      , oson_file
                                      , yandex_file
                                      , qiwi_file
                                      , filial_id)
    values ( i_first_name
           , i_surname
           , i_last_name
           , i_birth_date
           , i_doc_number
           , i_nationality
           , i_gender
           , i_birth_address
           , i_expiry_doc
           , i_authority
           , i_registration_address
           , i_doc_photo_url
           , i_mail_address
           , i_self_photo
           , i_state_id
           , i_client_id
           , i_info
           , i_region_id
           , i_created_doc_date
           , i_doc_address_photo
           , i_oson_file
           , i_yandex_file
           , i_qiwi_file, i_filial_id);
    return true;
exception
    when others THEN
        v_err_text := sqlerrm;
        perform log_action_atx(i_first_name, v_object_id, v_err_text || 'add_wallet_client_info', 'ERROR');
        return false;
END;
$$;

alter function add_wallet_client_info(varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar, varchar, integer, integer, varchar, integer, varchar, varchar, varchar, varchar, varchar, varchar, integer, integer) owner to interhub_user;

