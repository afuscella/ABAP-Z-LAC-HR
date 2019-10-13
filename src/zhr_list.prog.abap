*&---------------------------------------------------------------------*
*& Report ZREPORT_TEST_HR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zhr_list.

START-OF-SELECTION.
  DATA(lo_factory)  = NEW zcl_hr_employee_factory( ).
  DATA lt_employees TYPE STANDARD TABLE OF REF TO zif_hr_employee.

  APPEND lo_factory->build( lo_factory->sc_employee_type-employee ) TO lt_employees.
  APPEND lo_factory->build( lo_factory->sc_employee_type-intern )   TO lt_employees.
  APPEND lo_factory->build( lo_factory->sc_employee_type-external ) TO lt_employees.

  DATA bapirettab TYPE bapirettab.
  LOOP AT lt_employees ASSIGNING FIELD-SYMBOL(<employee>).

    WRITE / <employee>->calculate_salary( 20 ).
    <employee>->display_data( bapirettab ).

  ENDLOOP.
