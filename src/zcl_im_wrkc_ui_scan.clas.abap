class ZCL_IM_WRKC_UI_SCAN definition
  public
  final
  create public .

public section.

  interfaces /SCWM/IF_EX_WRKC_UI_SCAN_SCR .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_WRKC_UI_SCAN IMPLEMENTATION.


  METHOD /scwm/if_ex_wrkc_ui_scan_scr~set_tab_name.

    BREAK-POINT ID zewmdevbook_364.

    ev_text_scanner_badi_3 = TEXT-001. "HU Multi Repack

  ENDMETHOD.
ENDCLASS.
