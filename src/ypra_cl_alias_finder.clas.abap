class YPRA_CL_ALIAS_FINDER definition
  public
  final
  create public .

public section.

  interfaces /IWFND/IF_MGW_DEST_FINDER_BADI .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS YPRA_CL_ALIAS_FINDER IMPLEMENTATION.


  METHOD /iwfnd/if_mgw_dest_finder_badi~get_system_aliases.

    DATA: lv_lines TYPE sytabix.

    DATA: lv_error TYPE scx_t100key.

    IF iv_user = 'PRAKASH'.


      DESCRIBE TABLE ct_system_aliases LINES lv_lines.

      IF lv_lines > 1.
*
*        CLEAR: ct_system_aliases.
*
*        lv_error-msgid = '00'.
*        lv_error-msgno = '001'.
*        lv_error-attr1 = 'Multiple system alias are available, Please select any one.'.
*
*        RAISE EXCEPTION TYPE /iwfnd/cx_mgw_dest_finder
*          EXPORTING
*            textid = lv_error.
*      previous =
*      business_error_unlimited =
*      remote_error_unlimited =
*      message_container =
*      mgw_context =
*      return_inner_error = abap_true
*      batch_caused_by_previous = abap_false
*      http_status_code =
*      http_header_parameters =
*      sap_note_id =
*      msg_code =
*      rfc_failure_message_v2 =
*      rfc_failure_message =
*      transformation =
*      entity_name =
*      remote_message =
*      remote_system =
*      remote_message_type =
*      service_identifier =
*      method =
*      field_name =
*      field_value =
*      navigation_property =
*      system_alias_list =
*      filter =
*      rfc_message_v1 =
*      rfc_message_v2 =
*      rfc_message_v3 =
*      rfc_message_v4 =
*      system_alias =.


      ENDIF.


    ENDIF.

  ENDMETHOD.
ENDCLASS.
