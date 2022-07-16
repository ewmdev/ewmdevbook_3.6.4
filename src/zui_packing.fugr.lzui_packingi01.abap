*----------------------------------------------------------------------*
***INCLUDE LZUI_PACKINGI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  SCAN_DEST_HU_999  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE scan_dest_hu_999 INPUT.

  "User scanned a destination HU -> read HU
  CLEAR gs_dest_hu.
  IF NOT /scwm/s_pack_view_scanner-dest_hu_prop_ui
  IS INITIAL.
    /scwm/s_pack_view_scanner-dest_hu =
    /scwm/s_pack_view_scanner-dest_hu_prop_ui.
    CALL METHOD go_model->get_hu
      EXPORTING
        iv_huident = /scwm/s_pack_view_scanner-dest_hu
      IMPORTING
        es_huhdr   = gs_dest_hu
      EXCEPTIONS
        OTHERS     = 99.
    IF sy-subrc <> 0.
      CLEAR /scwm/s_pack_view_scanner-dest_hu_prop_ui.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SCAN_SOURCE_999  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE scan_source_999 INPUT.

  "User scanned a source HU -> read HU
  CLEAR gs_source_hu.
  IF NOT /scwm/s_pack_view_scanner-source_hu_ui IS INITIAL.
    /scwm/s_pack_view_scanner-source_hu =
    /scwm/s_pack_view_scanner-source_hu_ui.
    CALL METHOD go_model->get_hu
      EXPORTING
        iv_huident = /scwm/s_pack_view_scanner-source_hu
      IMPORTING
        es_huhdr   = gs_source_hu
      EXCEPTIONS
        OTHERS     = 99.
    IF sy-subrc <> 0.
      "Scan error -> user must repeat the scan
      CLEAR /scwm/s_pack_view_scanner-source_hu_ui.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.
* 2-98: Additional Checks...
* to be implemented
  "99 Repack the source-hu into the target-HU
  IF gs_source_hu IS NOT INITIAL AND
  gs_dest_hu IS NOT INITIAL.
    CALL METHOD go_model->pack_hu
      EXPORTING
        iv_source_hu = gs_source_hu-guid_hu
        iv_dest_hu   = gs_dest_hu-guid_hu
      EXCEPTIONS
        error        = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    /scwm/cl_pack=>go_log->init( ).
    "Clear input field for the next source-hu
    CLEAR: gs_source_hu,
    /scwm/s_pack_view_scanner-source_hu_ui.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_999  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_999 INPUT.

  "User wants to scan a new target hu, clear the field
  IF sy-ucomm = 'F8'.
    CLEAR /scwm/s_pack_view_scanner-dest_hu_prop_ui.
    "Set function code to default
    CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'
      EXCEPTIONS
        OTHERS = 99.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.

ENDMODULE.
