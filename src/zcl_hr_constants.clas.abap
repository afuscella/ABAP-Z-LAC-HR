CLASS zcl_hr_constants DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS: BEGIN OF sc_message_icon ,
                 error       TYPE iconname VALUE '@0W@',
                 information TYPE iconname VALUE '@19@',
                 success     TYPE iconname VALUE '@0V@',
                 warning     TYPE iconname VALUE '@1A@',
               END OF sc_message_icon.

    CONSTANTS: BEGIN OF sc_message_type ,
                 abort       TYPE c VALUE 'A',
                 error       TYPE c VALUE 'E',
                 exit        TYPE c VALUE 'X',
                 information TYPE c VALUE 'I',
                 success     TYPE c VALUE 'S',
                 warning     TYPE c VALUE 'W',
               END OF sc_message_type.
protected section.
private section.
ENDCLASS.



CLASS ZCL_HR_CONSTANTS IMPLEMENTATION.
ENDCLASS.
