class ZCL_HR_EMPLOYEE_FACTORY definition
  public
  create public .

public section.

  constants:
    BEGIN OF sc_employee_type ,
                 employee TYPE string VALUE 'PERMANENT',
                 intern   TYPE string VALUE 'INTERNET',
                 external TYPE string VALUE 'EXTERNAL',
               END OF sc_employee_type .

  methods BUILD
    importing
      !IV_EMPLOYEE_TYPE type STRING
    returning
      value(RO_HANDLER) type ref to ZIF_HR_EMPLOYEE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_EMPLOYEE_FACTORY IMPLEMENTATION.


  METHOD build.

    IF iv_employee_type = sc_employee_type-employee.
      CREATE OBJECT ro_handler TYPE zcl_hr_employee.

    ELSEIF iv_employee_type = sc_employee_type-external.
      CREATE OBJECT ro_handler TYPE zcl_hr_employee_external.

    ELSEIF iv_employee_type = sc_employee_type-intern.
      CREATE OBJECT ro_handler TYPE zcl_hr_employee_intern.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
