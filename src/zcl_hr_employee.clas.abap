class ZCL_HR_EMPLOYEE definition
  public
  create public .

public section.

  interfaces ZIF_HR_EMPLOYEE .

  methods CONSTRUCTOR
    importing
      !IO_DATE_WRAP type ref to ZIF_DATE_WRAP optional
      !IO_POPUP_WRAP type ref to ZIF_POPUP_WRAP optional
      !IO_TEXT_WRAP type ref to ZIF_TEXT_WRAP optional
      !IO_ABAP_WRAP type ref to ZIF_ABAP_WRAP optional .
protected section.

  data MO_DATE_WRAP type ref to ZIF_DATE_WRAP .
  data MO_POPUP_WRAP type ref to ZIF_POPUP_WRAP .
  data MO_TEXT_WRAP type ref to ZIF_TEXT_WRAP .
  data MO_ABAP_WRAP type ref to ZIF_ABAP_WRAP .
  data MV_DAILY_PAYMENT type DMBTR value 250 ##NO_TEXT.
private section.
ENDCLASS.



CLASS ZCL_HR_EMPLOYEE IMPLEMENTATION.


  METHOD constructor.

    IF io_date_wrap IS BOUND.
      mo_date_wrap = io_date_wrap.
    ELSE.
      CREATE OBJECT mo_date_wrap TYPE zcl_date_wrap.
    ENDIF.

    IF io_popup_wrap IS BOUND.
      mo_popup_wrap = io_popup_wrap.
    ELSE.
      CREATE OBJECT mo_popup_wrap TYPE zcl_popup_wrap.
    ENDIF.

    IF io_text_wrap IS BOUND.
      mo_text_wrap = io_text_wrap.
    ELSE.
      CREATE OBJECT mo_text_wrap TYPE zcl_text_wrap.
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

      CATCH zcx_missing_parameter.
        RAISE EXCEPTION TYPE zcx_missing_parameter
          EXPORTING
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
