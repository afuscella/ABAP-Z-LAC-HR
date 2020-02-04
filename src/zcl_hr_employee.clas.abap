CLASS zcl_hr_employee DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_hr_employee .

    METHODS constructor
      IMPORTING
        !io_date_wrap  TYPE REF TO zif_lac_date_wrap OPTIONAL
        !io_popup_wrap TYPE REF TO zif_popup_wrap OPTIONAL
        !io_text_wrap  TYPE REF TO zif_lac_text_wrap OPTIONAL
        !io_abap_wrap  TYPE REF TO zif_abap_wrap OPTIONAL .
PROTECTED SECTION.

  DATA mo_date_wrap TYPE REF TO zif_lac_date_wrap .
  DATA mo_popup_wrap TYPE REF TO zif_popup_wrap .
  DATA mo_text_wrap TYPE REF TO zif_lac_text_wrap .
  DATA mo_abap_wrap TYPE REF TO zif_abap_wrap .
  DATA mv_daily_payment TYPE dmbtr VALUE 250 ##NO_TEXT.
private section.
ENDCLASS.



CLASS ZCL_HR_EMPLOYEE IMPLEMENTATION.


  METHOD constructor.

    IF io_date_wrap IS BOUND.
      mo_date_wrap = io_date_wrap.
    ELSE.
      CREATE OBJECT mo_date_wrap TYPE zcl_lac_date_wrap.
    ENDIF.

    IF io_popup_wrap IS BOUND.
      mo_popup_wrap = io_popup_wrap.
    ELSE.
      CREATE OBJECT mo_popup_wrap TYPE zcl_popup_wrap.
    ENDIF.

    IF io_text_wrap IS BOUND.
      mo_text_wrap = io_text_wrap.
    ELSE.
      CREATE OBJECT mo_text_wrap TYPE zcl_lac_text_wrap.
    ENDIF.

    IF io_abap_wrap IS BOUND.
      mo_abap_wrap = io_abap_wrap.
    ELSE.
      CREATE OBJECT mo_abap_wrap TYPE zcl_abap_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_hr_employee~calculate_salary.

    TRY .
        IF iv_work_days = 0.
          RAISE EXCEPTION TYPE zcx_hr_missing_work_days.
        ENDIF.

        rv_salary = mv_daily_payment * iv_work_days.

      CATCH zcx_lac_missing_parameter.
        RAISE EXCEPTION TYPE zcx_lac_missing_parameter
          EXPORTING
            textid   = zcx_lac_missing_parameter=>obrligatory_parameter_missing
            mv_param = 'IV_WORK_DAYS'.
    ENDTRY.

  ENDMETHOD.


  METHOD zif_hr_employee~display_data.

    DATA: lv_status TYPE iconname,
          lv_number TYPE c LENGTH 3.

    LOOP AT it_data INTO DATA(ls_data).

      IF ls_data-type = zcl_hr_constants=>sc_message_type-abort
        OR ls_data-type = zcl_hr_constants=>sc_message_type-exit
        OR ls_data-type = zcl_hr_constants=>sc_message_type-error.
        lv_status = zcl_hr_constants=>sc_message_icon-error.

      ELSEIF ls_data-type = zcl_hr_constants=>sc_message_type-information.
        lv_status = zcl_hr_constants=>sc_message_icon-information.

      ELSEIF ls_data-type = zcl_hr_constants=>sc_message_type-success.
        lv_status = zcl_hr_constants=>sc_message_icon-success.

      ELSEIF ls_data-type = zcl_hr_constants=>sc_message_type-warning.
        lv_status = zcl_hr_constants=>sc_message_icon-warning.

      ENDIF.

      lv_number = ls_data-number.

      mo_abap_wrap->write(
        iv_status  = lv_status
        iv_id      = ls_data-id
        iv_number  = lv_number
        iv_message = ls_data-message
      ).

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
