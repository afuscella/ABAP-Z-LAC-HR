class ZCL_HR_EMPLOYEE_INTERN definition
  public
  inheriting from ZCL_HR_EMPLOYEE
  create public .

public section.

  methods ZIF_HR_EMPLOYEE~CALCULATE_SALARY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_EMPLOYEE_INTERN IMPLEMENTATION.


  METHOD zif_hr_employee~calculate_salary.

    TRY .
        IF iv_work_days = 0.
          RAISE EXCEPTION TYPE zcx_hr_missing_work_days.
        ENDIF.

        rv_salary = ( mv_daily_payment * iv_work_days ) * '0.15'.

      CATCH zcx_lac_missing_parameter.
        RAISE EXCEPTION TYPE zcx_lac_missing_parameter
          EXPORTING
            textid   = zcx_lac_missing_parameter=>obrligatory_parameter_missing
            mv_param = 'IV_WORK_DAYS'.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
