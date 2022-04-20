create function add_wallet(i_fullname character varying, i_phone_number character varying, i_state_id integer,
                           i_wallet_type integer, i_currency_id integer,
                           i_mail_address character varying DEFAULT NULL::character varying,
                           i_deposit_state integer DEFAULT 1, i_withdraw_state integer DEFAULT 1) returns integer
    language plpgsql
as
$$
DECLARE
    v_reference_id       integer;
    v_err_text           varchar;
    v_object_id constant integer := 5;
    v_id                 integer;
    v_res_funct          boolean;
    v_wallet_state_id    integer;
    v_count              integer := 0;
    v_special_id         bigint;
    v_client_id          integer;
    v_wallet             ib_wallets%rowtype;
    v_client_condition   varchar;
    v_client             ib_clients%rowtype;
    v_random_sms_code    integer := 1;
    v_wallet_count       integer;
BEGIN
    i_state_id := 2;
    select * into v_client from ib_clients where phone_number = i_phone_number;
    if v_client.id is null then

        v_client_condition := 'A';
        v_random_sms_code = 1;
        select add_client(i_client_name := i_fullname, i_client_type := 'P', i_phone_number := i_phone_number,
                          i_condition => v_client_condition, i_client_wallet_type := i_wallet_type)

        into v_client_id;

    else
        select count(*)
        into v_wallet_count
        from ib_wallets
        where phone_number = i_phone_number
          and currency_id = i_currency_id;
        if v_wallet_count != 0 then
            perform log_action_atx(i_phone_number, v_object_id,
                                   'client mavjud ' || 'add_wallets',
                                   'ERROR');
            return -1;
        end if;
        v_client_id := v_client.id;
        v_client_condition := 'A';
    end if;
    if v_client_condition = 'A' then
        v_wallet_state_id := 2;
    else
        v_wallet_state_id := 1;
    end if;

    insert into ib_wallets(fullname, state_id, phone_number, wallet_type, mail_address,
                           currency_id, client_id, deposit_state, withdraw_state)
    values (i_fullname, i_state_id, i_phone_number, i_wallet_type, i_mail_address,
            i_currency_id, v_client_id, i_deposit_state, i_withdraw_state)
    returning id into v_id;

    perform add_client_account(v_client_id, i_currency_id, v_object_id, i_client_condition =>v_client_condition);
    return v_random_sms_code;
exception
    when others THEN
        v_err_text := sqlerrm;
        perform log_action_atx(i_phone_number, v_object_id,
                               v_err_text || 'add_wallets',
                               'ERROR');
        return -1;
END;
$$;

alter function add_wallet(varchar, varchar, integer, integer, integer, varchar, integer, integer) owner to interhub_user;

