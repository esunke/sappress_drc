class ZCL_EDOC_ADAPTOR_HU_ADD_MAIL definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EDOC_ADAPTOR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_EDOC_ADAPTOR_HU_ADD_MAIL IMPLEMENTATION.


  method IF_EDOC_ADAPTOR~CHANGE_EDOCUMENT_TYPE.
  endmethod.


  method IF_EDOC_ADAPTOR~GET_VARIABLE_KEY.
  endmethod.


  method IF_EDOC_ADAPTOR~IS_RELEVANT.
  endmethod.


  method IF_EDOC_ADAPTOR~SET_FIX_VALUES.
  endmethod.


  METHOD if_edoc_adaptor~set_output_data.
    DATA output TYPE edo_hu_i30_manage_invoice_requ.
    DATA ls_add_data TYPE edo_hu_i30_additional_data_typ.
    DATA lt_add_data TYPE edo_hu_i30_additional_data_tab.


    " check if current activity is Invoice request
    IF iv_interface_id <> 'HU_INV_MANAGE_REQUEST'.
      RETURN.
    ENDIF.

    " Load output data
    output = cs_output_data.


    " set the additional mail field
    ls_add_data-data_name            = 'Z00001_EMAIL'.
    ls_add_data-data_description     = 'Zusätzliche E-Mailadresse'.
    ls_add_data-data_value           = 'sunke@sucea.de'.

    APPEND ls_add_data TO lt_add_data.

    output-invoice_data-invoice_main-choice-invoice-invoice_head-invoice_detail-additional_invoice_data = lt_add_data.

    cs_output_data = output.

  ENDMETHOD.


  method IF_EDOC_ADAPTOR~SET_VALUE_MAPPING.
  endmethod.
ENDCLASS.
