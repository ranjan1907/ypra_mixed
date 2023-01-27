class YCL_YPRA_SAMPLE_ODATA_MPC_EXT definition
  public
  inheriting from YCL_YPRA_SAMPLE_ODATA_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YCL_YPRA_SAMPLE_ODATA_MPC_EXT IMPLEMENTATION.


METHOD define.


  DATA: lo_entity_type TYPE REF TO /iwbep/if_mgw_odata_entity_typ.
  DATA: lo_property TYPE REF TO /iwbep/if_mgw_odata_property.

  super->define( ).

* Header Entity Name
  lo_entity_type = model->get_entity_type( iv_entity_name = 'EmployeeHeader' ).
* MPC_EXT Deep Structure Name
  lo_entity_type->bind_structure( iv_structure_name = 'YPRA_EMP_HEAD_DEEP' ).



* Header Entity Name
  lo_entity_type = model->get_entity_type( iv_entity_name = 'EmployeeFile' ).

  lo_property = lo_entity_type->get_property( iv_property_name = 'FileName').

  lo_property->set_as_content_type( ).

ENDMETHOD.
ENDCLASS.
