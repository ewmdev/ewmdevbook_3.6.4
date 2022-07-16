*----------------------------------------------------------------------*
***INCLUDE LZUI_PACKINGO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_999 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_999 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  "Get the model instance for packing
  IF go_model IS INITIAL.
    CALL METHOD /scwm/cl_wm_packing=>get_instance
      IMPORTING
        eo_instance = go_model.
  ENDIF.
  "Focus on the next field for input
  IF /scwm/s_pack_view_scanner-dest_hu_prop_ui IS INITIAL.
    SET CURSOR FIELD '/SCWM/S_PACK_VIEW_SCANNER-DEST_HU_PROP_UI'.
    EXIT.
  ENDIF.
  IF /scwm/s_pack_view_scanner-source_hu_ui IS INITIAL.
    SET CURSOR FIELD '/SCWM/S_PACK_VIEW_SCANNER-SOURCE_HU_UI'.
    EXIT.
  ENDIF.
ENDMODULE.
