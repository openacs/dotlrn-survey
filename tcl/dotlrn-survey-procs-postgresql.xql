<?xml version="1.0"?>
  <queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="dotlrn_survey::clone.clone_survey_package">
      <querytext>
        select dotlrn_survey__clone(
          :old_package_id,
          :new_package_id
        );
      </querytext>
    </fullquery>

  </queryset>