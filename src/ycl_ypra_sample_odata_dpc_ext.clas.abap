class YCL_YPRA_SAMPLE_ODATA_DPC_EXT definition
  public
  inheriting from YCL_YPRA_SAMPLE_ODATA_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_STREAM
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_EXPANDED_ENTITY
    redefinition .
protected section.

  methods EMPLOYEEHEADERSE_GET_ENTITY
    redefinition .
  methods EMPLOYEEHEADERSE_GET_ENTITYSET
    redefinition .
  methods EMPLOYEEINFTYDAT_CREATE_ENTITY
    redefinition .
  methods EMPLOYEEINFTYDAT_DELETE_ENTITY
    redefinition .
  methods EMPLOYEEINFTYDAT_GET_ENTITY
    redefinition .
  methods EMPLOYEEINFTYDAT_GET_ENTITYSET
    redefinition .
  methods EMPLOYEEINFTYDAT_UPDATE_ENTITY
    redefinition .
  methods EMPLOYEESECONDHE_GET_ENTITY
    redefinition .
  methods EMPLOYEEFILESET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS YCL_YPRA_SAMPLE_ODATA_DPC_EXT IMPLEMENTATION.


METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.

  DATA: ls_emp_head_deep TYPE ypra_emp_head_deep.

  CALL METHOD io_data_provider->read_entry_data
    IMPORTING
      es_data = ls_emp_head_deep.

  "Business Logic

  copy_data_to_ref( EXPORTING is_data = ls_emp_head_deep CHANGING cr_data = er_deep_entity ).

ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_stream.


    IF iv_entity_name = iv_entity_name.
    ENDIF.


  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
**  EXPORTING
**    iv_action_name          =
**    it_parameter            =
**    io_tech_request_context =
**  IMPORTING
**    er_data                 =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.

    DATA: er_entity TYPE ycl_ypra_sample_odata_mpc=>ts_employeeheader.

    er_entity-pernr = '00004711'.
    er_entity-bukrs = 'DE01'.
    er_entity-persg = '1'.

    copy_data_to_ref( EXPORTING is_data = er_entity CHANGING cr_data = er_data ).

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_expanded_entity.

    TYPES: BEGIN OF ty_entity,
             pernr          TYPE  pernr_d,
             bukrs          TYPE  bukrs,
             persg          TYPE  persg,
             tosecondheader TYPE ypra_emp_head_more,
           END OF ty_entity.

    DATA: ls_entity TYPE ty_entity.

    ls_entity-pernr = '00004711'.
    ls_entity-bukrs = 'DE01'.
    ls_entity-persg = '1'.
    ls_entity-tosecondheader-pernr = '00004711'.
    ls_entity-tosecondheader-plans = '50025048'.
    ls_entity-tosecondheader-orgeh = '50140011'.
    ls_entity-tosecondheader-stell = '50070999'.

    copy_data_to_ref( EXPORTING is_data = ls_entity CHANGING cr_data = er_entity ).



  ENDMETHOD.


  method EMPLOYEEFILESET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->EMPLOYEEFILESET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  METHOD employeeheaderse_get_entity.



*select pernr bukrs persg FROM pa0001 into ER_ENTITY UP TO 1 ROWS
*  WHERE pernr = lv_pernr and bukrs = lv_bukrs.


    er_entity-pernr = '00004711'.
    er_entity-bukrs = 'DE01'.
    er_entity-persg = '1'.

  ENDMETHOD.


  METHOD employeeheaderse_get_entityset.

    DATA: er_entity TYPE ycl_ypra_sample_odata_mpc=>ts_employeeheader.

    er_entity-pernr = '00004711'.
    er_entity-bukrs = 'DE01'.
    er_entity-persg = '1'.
    APPEND er_entity TO et_entityset.
    CLEAR: er_entity.

    er_entity-pernr = '00004711'.
    er_entity-bukrs = 'DE01'.
    er_entity-persg = '1'.
    APPEND er_entity TO et_entityset.
    CLEAR: er_entity.



  ENDMETHOD.


  method EMPLOYEEINFTYDAT_CREATE_ENTITY.

* Work Area declaration
  DATA: ls_input_data TYPE ycl_ypra_sample_odata_mpc=>ts_employeeinftydata.

* Internal Table/Range Table declaration
  DATA: lt_return TYPE bapiret2_t,                  " return message
        lt_error  TYPE bapiret2_t.                  " return message

* Class Object Declaration
  DATA: lo_meco         TYPE REF TO /iwbep/if_message_container.  " message container
*       lo_objname      TYPE REF TO class_name.

* Constant  declaration
  CONSTANTS:lc_msgtyp   TYPE cc_string  VALUE 'EA'.

* Field Symbol  declaration
  FIELD-SYMBOLS: <lfs_return> TYPE bapiret2.                    " return message

  CLEAR : er_entity.

* Read Request Data
  IF io_data_provider IS BOUND.
    io_data_provider->read_entry_data( IMPORTING es_data = ls_input_data ).
    er_entity = ls_input_data.
  ENDIF.

**********************************************************************
*Add Custom class logic here

*  IF lo_objname IS NOT BOUND.

**  Get object instance of Business Logic Class
*    CALL METHOD class_name=>get_instance
*      RECEIVING
*        re_o_instance     = lo_objname
*      EXCEPTIONS
*        no_object_created = 1
*        OTHERS            = 2.
*  ENDIF.

*  IF lo_objname IS BOUND.
*    CALL METHOD lo_objname->create_employeeinftydata
*      EXPORTING
*        im_input    = ls_input_data         "Input param Description
*      IMPORTING
*        et_output   = er_entity             "Current Entiity Structure
*        ex_i_return = lt_return.
*  ENDIF.
**********************************************************************
  " check return code
  LOOP AT lt_return ASSIGNING <lfs_return>               "#EC CI_STDSEQ
  " less than 500 lines
  WHERE type CA lc_msgtyp.
    INSERT <lfs_return> INTO TABLE lt_error.
  ENDLOOP.

  IF lt_error IS NOT INITIAL.

    " check that mo_context is already bound before it is being used later
    IF mo_context IS NOT BOUND.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
        EXPORTING
          textid = /iwbep/cx_mgw_tech_exception=>internal_error.
    ENDIF.

    lo_meco = mo_context->get_message_container( ).

    IF lo_meco IS BOUND.
      lo_meco->add_messages_from_bapi( it_bapi_messages = lt_error ).
    ENDIF.

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message_container = lo_meco
        textid            = /iwbep/cx_mgw_busi_exception=>business_error_unlimited
        message_unlimited = iv_entity_name.

  ENDIF.


  endmethod.


  METHOD employeeinftydat_delete_entity.


  ENDMETHOD.


  METHOD employeeinftydat_get_entity.

* Work Area declaration
    DATA: ls_filter     TYPE /iwbep/s_cod_select_option,
          ls_input_data TYPE ycl_ypra_sample_odata_mpc=>ts_employeeinftydata,
          ls_textid     TYPE scx_t100key.  " Error Message Text...

* Class object declaration
    DATA: lo_meco            TYPE REF TO /iwbep/if_message_container.  " message container
*          lo_objname         TYPE REF TO class_name.

* Internal Table/Range table declaration
    DATA: lt_keys   TYPE  /iwbep/t_mgw_tech_pairs,
          lt_return TYPE bapiret2_t,                  " return message
          lt_error  TYPE bapiret2_t,
          lr_pernr  TYPE /iwbep/t_cod_select_options,
          lr_infty  TYPE /iwbep/t_cod_select_options,
          lr_endda  TYPE /iwbep/t_cod_select_options,
          lr_begda  TYPE /iwbep/t_cod_select_options.


* Local variable declaration
    DATA: lv_pernr TYPE  ycl_ypra_sample_odata_mpc=>ts_employeeinftydata-pernr,
          lv_infty TYPE  ycl_ypra_sample_odata_mpc=>ts_employeeinftydata-infty,
          lv_endda TYPE  ycl_ypra_sample_odata_mpc=>ts_employeeinftydata-endda,
          lv_begda TYPE  ycl_ypra_sample_odata_mpc=>ts_employeeinftydata-begda.

* Field symbol declaration
    FIELD-SYMBOLS: <lfs_keys>   TYPE /iwbep/s_mgw_tech_pair,
                   <lfs_return> TYPE bapiret2.                    " return message

* Constant  declaration
    CONSTANTS:lc_msgty  TYPE symsgty    VALUE 'E',
              lc_msgid  TYPE symsgid    VALUE '/IWBEP/MC_SB_DPC_ADM',
              lc_pernr  TYPE cc_string  VALUE 'PERNR',
              lc_infty  TYPE cc_string  VALUE 'INFTY',
              lc_endda  TYPE cc_string  VALUE 'ENDDA',
              lc_begda  TYPE cc_string  VALUE 'BEGDA',
              lc_msgtyp TYPE cc_string  VALUE 'EA'.

    CLEAR er_entity.
*-------------------------------------------------------------------------*
*  Get KEY values
*-------------------------------------------------------------------------*
* Get Filter object
    IF io_tech_request_context IS BOUND.
      lt_keys = io_tech_request_context->get_keys( ).

      "Create Range Table for key value
      READ TABLE lt_keys ASSIGNING <lfs_keys> WITH KEY name = lc_pernr .
      IF sy-subrc = 0.
        ls_filter-sign = if_fdt_range=>gc_sign_include.
        ls_filter-option = if_fdt_range=>gc_option_equal.
        ls_filter-low = <lfs_keys>-value.
        APPEND ls_filter TO lr_pernr .
        CLEAR ls_filter.
*lv_pernr = <lfs_keys>-value.
      ENDIF.

      READ TABLE lt_keys ASSIGNING <lfs_keys> WITH KEY name = lc_infty .
      IF sy-subrc = 0.
        ls_filter-sign = if_fdt_range=>gc_sign_include.
        ls_filter-option = if_fdt_range=>gc_option_equal.
        ls_filter-low = <lfs_keys>-value.
        APPEND ls_filter TO lr_infty .
        CLEAR ls_filter.
*lv_infty = <lfs_keys>-value.
      ENDIF.

      READ TABLE lt_keys ASSIGNING <lfs_keys> WITH KEY name = lc_endda .
      IF sy-subrc = 0.
        ls_filter-sign = if_fdt_range=>gc_sign_include.
        ls_filter-option = if_fdt_range=>gc_option_equal.
        ls_filter-low = <lfs_keys>-value.
        APPEND ls_filter TO lr_endda .
        CLEAR ls_filter.
*lv_endda = <lfs_keys>-value.
      ENDIF.

      READ TABLE lt_keys ASSIGNING <lfs_keys> WITH KEY name = lc_begda .
      IF sy-subrc = 0.
        ls_filter-sign = if_fdt_range=>gc_sign_include.
        ls_filter-option = if_fdt_range=>gc_option_equal.
        ls_filter-low = <lfs_keys>-value.
        APPEND ls_filter TO lr_begda .
        CLEAR ls_filter.
*lv_begda = <lfs_keys>-value.
      ENDIF.


    ENDIF.
*-------------------------------------------------------------------------*
*  Call Business class and error handling. Resultset of business
*  class should be assgined to ER_ENTITY
*-------------------------------------------------------------------------*
* Insert your Code here

*  IF lo_objname IS NOT BOUND.

**  Get object instance of Business Logic Class
*    CALL METHOD class_name=>get_instance
*      RECEIVING
*        re_o_instance     = lo_objname
*      EXCEPTIONS
*        no_object_created = 1
*        OTHERS            = 2.
*  ENDIF.
*  IF lo_objname IS BOUND.
*    CALL METHOD lo_objname->get_employeeinftydata
*      EXPORTING
*          ir_pernr = lr_pernr
*          ir_infty = lr_infty
*          ir_endda = lr_endda
*          ir_begda = lr_begda
*       IMPORTING
*          et_output  = er_entity            "Current Entiity
*          ex_i_return = lt_return.
*  ENDIF.
*-------------------------------------------------------------------------*
* check return code
    LOOP AT lt_return ASSIGNING <lfs_return>             "#EC CI_STDSEQ
    " less than 500 lines
    WHERE type CA lc_msgtyp.
      INSERT <lfs_return> INTO TABLE lt_error.
    ENDLOOP.

    IF lt_error IS NOT INITIAL.

      " check that mo_context is already bound before it is being used later
      IF mo_context IS NOT BOUND.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
          EXPORTING
            textid = /iwbep/cx_mgw_tech_exception=>internal_error.
      ENDIF.

      lo_meco = mo_context->get_message_container( ).

      IF lo_meco IS BOUND.
        lo_meco->add_messages_from_bapi( it_bapi_messages = lt_error ).
      ENDIF.

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_meco
          textid            = /iwbep/cx_mgw_busi_exception=>business_error_unlimited
          message_unlimited = iv_entity_name.

    ENDIF.


  ENDMETHOD.


METHOD employeeinftydat_get_entityset.

* Work area declaration
  DATA: ls_paging     TYPE /iwbep/s_mgw_paging,
        ls_sort_order TYPE /iwbep/s_mgw_sorting_order.

* Internal Table/Range Table declaration
  DATA: lt_filter_select TYPE /iwbep/t_mgw_select_option,
        lt_techorder     TYPE /iwbep/t_mgw_tech_order,
        lt_sort_order    TYPE /iwbep/t_mgw_sorting_order,
        lt_return        TYPE bapiret2_t,                  " return message
        lt_error         TYPE bapiret2_t,
        lr_data1         TYPE /iwbep/t_cod_select_options,
        lr_data2         TYPE /iwbep/t_cod_select_options,
        lr_data3         TYPE /iwbep/t_cod_select_options,
        lr_data4         TYPE /iwbep/t_cod_select_options,
        lr_data5         TYPE /iwbep/t_cod_select_options,
        lr_data6         TYPE /iwbep/t_cod_select_options,
        lr_data7         TYPE /iwbep/t_cod_select_options.

* Class object declaration
  DATA: lo_filter TYPE  REF TO /iwbep/if_mgw_req_filter,
*        lo_objname          TYPE REF TO class_name,
        lo_meco   TYPE REF TO /iwbep/if_message_container.  " message container

* Local Variable declaration
  DATA: lv_filter_str       TYPE string.

* Field Symbol  declaration
  FIELD-SYMBOLS: <lfs_return> TYPE bapiret2,                    " return message
                 <lfs_order>  TYPE /iwbep/s_mgw_tech_order,
                 <lfs_filter> TYPE /iwbep/s_mgw_select_option.

* Constant  declaration
  CONSTANTS: lc_msgty  TYPE symsgty    VALUE 'E',
             lc_msgid  TYPE symsgid    VALUE '/IWBEP/MC_SB_DPC_ADM',
             lc_msgtyp TYPE cc_string  VALUE 'EA',
             lc_data1  TYPE cc_string VALUE 'DATA1',
             lc_data2  TYPE cc_string VALUE 'DATA2',
             lc_data3  TYPE cc_string VALUE 'DATA3',
             lc_data4  TYPE cc_string VALUE 'DATA4',
             lc_data5  TYPE cc_string VALUE 'DATA5',
             lc_data6  TYPE cc_string VALUE 'DATA6',
             lc_data7  TYPE cc_string VALUE 'DATA7'.

  CLEAR et_entityset.
*-------------------------------------------------------------------------*
*           Get FILTER or select option information
*-------------------------------------------------------------------------*
* Get Filter object
  lo_filter = io_tech_request_context->get_filter( ).

  IF lo_filter  IS BOUND.
    lt_filter_select = lo_filter->get_filter_select_options( ).
    lv_filter_str    = lo_filter->get_filter_string( ).

*   Check if the filter is supported by standard gateway runtime process
    IF  lv_filter_str            IS NOT INITIAL
    AND lt_filter_select IS INITIAL.

*     If the string of the Filter System Query Option is not automatically converted into
*     filter option table (lt_filter_select_options), then the filtering combination is not supported
*     Log message in the application log
      /iwbep/if_sb_dpc_comm_services~log_message(
        EXPORTING
          iv_msg_type   = lc_msgty
          iv_msg_id     = lc_msgid
          iv_msg_number = 020
          iv_msg_v1     = iv_entity_name ).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
        EXPORTING
          textid = /iwbep/cx_mgw_tech_exception=>internal_error.
    ENDIF.

    LOOP AT lt_filter_select ASSIGNING <lfs_filter>.

      CASE <lfs_filter>-property.
        WHEN lc_data1 .
          lo_filter->convert_select_option(
                 EXPORTING
                   is_select_option = <lfs_filter>
                 IMPORTING
                   et_select_option = lr_data1 ).

        WHEN lc_data2 .
          lo_filter->convert_select_option(
                 EXPORTING
                   is_select_option = <lfs_filter>
                 IMPORTING
                   et_select_option = lr_data2 ).

        WHEN lc_data3 .
          lo_filter->convert_select_option(
                 EXPORTING
                   is_select_option = <lfs_filter>
                 IMPORTING
                   et_select_option = lr_data3 ).

        WHEN lc_data4 .
          lo_filter->convert_select_option(
                 EXPORTING
                   is_select_option = <lfs_filter>
                 IMPORTING
                   et_select_option = lr_data4 ).

        WHEN lc_data5 .
          lo_filter->convert_select_option(
                 EXPORTING
                   is_select_option = <lfs_filter>
                 IMPORTING
                   et_select_option = lr_data5 ).

        WHEN lc_data6 .
          lo_filter->convert_select_option(
                 EXPORTING
                   is_select_option = <lfs_filter>
                 IMPORTING
                   et_select_option = lr_data6 ).

        WHEN lc_data7 .
          lo_filter->convert_select_option(
                 EXPORTING
                   is_select_option = <lfs_filter>
                 IMPORTING
                   et_select_option = lr_data7 ).

        WHEN OTHERS.
          /iwbep/if_sb_dpc_comm_services~log_message(
       EXPORTING
         iv_msg_type   = lc_msgty
         iv_msg_id     = lc_msgid
         iv_msg_number = 020
         iv_msg_v1     = iv_entity_name ).
          RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
            EXPORTING
              textid = /iwbep/cx_mgw_tech_exception=>internal_error.
      ENDCASE.
    ENDLOOP.
  ENDIF.


*-------------------------------------------------------------------------*
*  Call Business class and error handling. Resultset of business
*  IMPORTING parameter of business class should be assgined to ET_ENTITYSET
*-------------------------------------------------------------------------*
* Sample Code here

*  IF lo_objname IS NOT BOUND.

**  Get object instance of Business Logic Class
*    CALL METHOD class_name=>get_instance
*      RECEIVING
*        re_o_instance     = lo_objname
*      EXCEPTIONS
*        no_object_created = 1
*        OTHERS            = 2.
*  ENDIF.

*  IF lo_objname IS BOUND.
*    CALL METHOD lo_objname->get_employeeinftydata
*      EXPORTING
*           ir_pernr = lr_pernr
*           ir_infty = lr_infty
*           ir_endda = lr_endda
*           ir_begda = lr_begda
*           ir_data1 = lr_data1
*           ir_data2 = lr_data2
*           ir_data3 = lr_data3
*           ir_data4 = lr_data4
*           ir_data5 = lr_data5
*           ir_data6 = lr_data6
*           ir_data7 = lr_data7
*       IMPORTING
*          et_output   = et_entityset            "Current EntiitySet
*          ex_i_return = lt_return.
*  ENDIF.
*-------------------------------------------------------------------------*
* check return code
  LOOP AT lt_return ASSIGNING <lfs_return>               "#EC CI_STDSEQ
* less than 500 lines
  WHERE type CA lc_msgtyp.
    INSERT <lfs_return> INTO TABLE lt_error.
  ENDLOOP.

  IF lt_error IS NOT INITIAL.

    " check that mo_context is already bound before it is being used later
    IF mo_context IS NOT BOUND.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
        EXPORTING
          textid = /iwbep/cx_mgw_tech_exception=>internal_error.
    ENDIF.

    lo_meco = mo_context->get_message_container( ).

    IF lo_meco IS BOUND.
      lo_meco->add_messages_from_bapi( it_bapi_messages = lt_error ).
    ENDIF.

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        message_container = lo_meco
        textid            = /iwbep/cx_mgw_busi_exception=>business_error_unlimited
        message_unlimited = iv_entity_name.

  ENDIF.

*-------------------------------------------------------------------------*
*           Get ORDER BY or SORT data
*-------------------------------------------------------------------------*
  lt_techorder     = io_tech_request_context->get_orderby( ).

  LOOP AT lt_techorder ASSIGNING <lfs_order>.
    ls_sort_order-order = <lfs_order>-order.
    ls_sort_order-property = <lfs_order>-property.
    APPEND ls_sort_order TO lt_sort_order.
    CLEAR ls_sort_order.
  ENDLOOP.
* Sort data based sorted criteria provided by query string
  IF lt_sort_order IS NOT INITIAL.
    /iwbep/cl_mgw_data_util=>orderby( EXPORTING it_order = lt_sort_order CHANGING ct_data = et_entityset ).
  ENDIF.

*-------------------------------------------------------------------------*
*             INLINE COUNT
*-------------------------------------------------------------------------*

  IF io_tech_request_context->has_inlinecount( ) = abap_true.
    DESCRIBE TABLE et_entityset LINES es_response_context-inlinecount.
  ELSE.
    CLEAR es_response_context-inlinecount.
  ENDIF.

*-------------------------------------------------------------------------*
*             PAGINATION (TOP/SKIP)
*-------------------------------------------------------------------------*

*     get number of records requested
  ls_paging-top = io_tech_request_context->get_top( ).
*     get number of lines that should be skipped
  ls_paging-skip = io_tech_request_context->get_skip( ).

  /iwbep/cl_mgw_data_util=>paging( EXPORTING is_paging = ls_paging CHANGING ct_data = et_entityset ).


ENDMETHOD.


  method EMPLOYEEINFTYDAT_UPDATE_ENTITY.
**TRY.
*CALL METHOD SUPER->EMPLOYEEINFTYDAT_UPDATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  IMPORTING
**    er_entity               =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  METHOD employeesecondhe_get_entity.

    er_entity-pernr = '00004711'.
    er_entity-plans = '50025048'.
    er_entity-orgeh = '50140011'.
    er_entity-stell = '50070999'.

  ENDMETHOD.
ENDCLASS.
