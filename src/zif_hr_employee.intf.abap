interface ZIF_HR_EMPLOYEE
  public .


  methods CALCULATE_SALARY
    importing
      !IV_WORK_DAYS type I
    returning
      value(RV_SALARY) type DMBTR
    raising
      ZCX_LAC_MISSING_PARAMETER
      ZCX_HR_MISSING_WORK_DAYS .
  methods DISPLAY_DATA
    importing
      !IT_DATA type BAPIRETTAB optional .
endinterface.
