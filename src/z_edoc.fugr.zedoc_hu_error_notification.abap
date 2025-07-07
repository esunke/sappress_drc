FUNCTION zedoc_hu_error_notification.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_EDOC_GUID) TYPE  EDOC_GUID
*"     VALUE(IS_PROCESS_ATTR) TYPE  EDOC_ATTR_MANAGED_BY_PROCMGR
*"  EXCEPTIONS
*"      AUTHORIZATION_ERROR
*"      UNKNOWN_ERROR
*"----------------------------------------------------------------------
  DATA:lt_main_text  TYPE soli_tab.
  DATA:ls_main_text  LIKE LINE OF lt_main_text.
  DATA lv_ext_number TYPE balhdr-extnumber .
  DATA lt_messages   TYPE STANDARD TABLE OF balm .
  DATA: lv_msg    TYPE string,
        lo_edo_db TYPE REF TO if_edocument_db,
        ls_edoc   TYPE edocument.

  DATA:lv_subject TYPE so_obj_des.
  DATA:lv_subject_long TYPE string.

  DATA:lv_sender TYPE adr6-smtp_addr.
  DATA lt_recipients_to TYPE bcsy_smtpa .
  DATA ls_recipients_to TYPE ad_smtpadr .

  CHECK iv_edoc_guid IS NOT INITIAL .

  CREATE OBJECT lo_edo_db TYPE cl_edocument_db.
  ls_edoc = lo_edo_db->select_edocument( iv_edoc_guid = iv_edoc_guid ).

  CLEAR lv_ext_number.
  lv_ext_number = iv_edoc_guid .
  "get error messages
  CALL FUNCTION 'APPL_LOG_READ_DB'
    EXPORTING
      object          = 'EDOCUMENT'
      subobject       = '*'
      external_number = lv_ext_number
    TABLES
      messages        = lt_messages.

  "set main text
  CLEAR ls_main_text.
  DATA(str1) = 'Document Source Key:'.
  ls_main_text-line = |{ str1 } { ls_edoc-source_key }|.
  APPEND ls_main_text TO lt_main_text.
  CLEAR ls_main_text.

  DATA(str2) = 'Document Process:'.
  ls_main_text-line = |{ str2 } { is_process_attr-PROCESS } { is_process_attr-PROCESS_VERSION }|.
  APPEND ls_main_text TO lt_main_text.
  CLEAR ls_main_text.

   DATA(str3) = 'Document Process Status:'.
  ls_main_text-line = |{ str3 } { is_process_attr-proc_status }|.
  APPEND ls_main_text TO lt_main_text.
  CLEAR ls_main_text.

  ls_main_text-line = '' .
  APPEND ls_main_text TO lt_main_text.
  ls_main_text-line = 'Message:  ' .
  APPEND ls_main_text TO lt_main_text.


  DELETE ADJACENT DUPLICATES FROM lt_messages COMPARING ALL FIELDS .
  CLEAR lv_msg .
  LOOP AT lt_messages INTO DATA(ls_message).
    lv_msg = |{ ls_message-msgv1 }{ ls_message-msgv2 }{ ls_message-msgv3 }{ ls_message-msgv4 }|.
    ls_main_text-line = lv_msg.
    APPEND ls_main_text TO lt_main_text.
    ls_main_text-line = '' .
    APPEND ls_main_text TO lt_main_text.
    CLEAR ls_message .
  ENDLOOP.

  IF lv_msg IS INITIAL.
    lv_msg = 'No message available.'.
  ENDIF.

  "send Email

  lv_subject = 'SAP DRC EDOC notification ('  && sy-sysid  && ')'.
  lv_sender     = 'gf-no-reply@mail.sucea.de'.

  ls_recipients_to = 'gf-s4hana-sbx@mail.sucea.de'.
  APPEND ls_recipients_to TO lt_recipients_to .
  TRY.
      CALL METHOD cl_edoc_util=>send_email
        EXPORTING
          iv_email_type       = 'RAW'
          iv_subject          = lv_subject
          it_content_text     = lt_main_text
*         it_content_hex      =
*         iv_content_length   =
*         iv_language         = SY-LANGU
*         iv_vsi_profile      =
          iv_sender           = lv_sender
          it_recipients_to    = lt_recipients_to
*         it_recipients_cc    =
*         iv_sensitivity      =
*         iv_importance       =
*         it_email_header     =
*         it_attachments      =
          iv_send_immediately = 'X'.
    CATCH cx_edocument.

  ENDTRY.


ENDFUNCTION.
