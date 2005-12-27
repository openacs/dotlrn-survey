--
--  Copyright (C) 2001, 2002 OpenForce, Inc.
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--

--
-- The survey applet for dotLRN
--
-- @author Ben Adida (ben@openforce.net)
-- @creation-date 2002-05-29
-- @version $Id$
--

declare
    foo                             integer;
begin

    foo := acs_sc_impl.new(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_pretty_name => 'dotlrn_survey',
        impl_owner_name => 'dotlrn_survey'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'GetPrettyName',
        impl_alias => 'dotlrn_survey::get_pretty_name',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'AddApplet',
        impl_alias => 'dotlrn_survey::add_applet',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'RemoveApplet',
        impl_alias => 'dotlrn_survey::remove_applet',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'AddAppletToCommunity',
        impl_alias => 'dotlrn_survey::add_applet_to_community',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'RemoveAppletFromCommunity',
        impl_alias => 'dotlrn_survey::remove_applet_from_community',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'AddUser',
        impl_alias => 'dotlrn_survey::add_user',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'RemoveUser',
        impl_alias => 'dotlrn_survey::remove_user',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'AddUserToCommunity',
        impl_alias => 'dotlrn_survey::add_user_to_community',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'RemoveUserFromCommunity',
        impl_alias => 'dotlrn_survey::remove_user_from_community',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'AddPortlet',
        impl_alias => 'dotlrn_survey::add_portlet',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'RemovePortlet',
        impl_alias => 'dotlrn_survey::remove_portlet',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'Clone',
        impl_alias => 'dotlrn_survey::clone',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias(
        impl_contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey',
        impl_operation_name => 'ChangeEventHandler',
        impl_alias => 'dotlrn_survey::change_event_handler',
        impl_pl => 'TCL'
    );

    acs_sc_binding.new(
        contract_name => 'dotlrn_applet',
        impl_name => 'dotlrn_survey'
    );

end;
/
show errors

create or replace package dotlrn_survey 
as
       procedure clone (
          old_package_id    in apm_packages.package_id%TYPE   default null,
          new_package_id    in apm_packages.package_id%TYPE   default null);      

end dotlrn_survey;
/
show errors

create or replace package body dotlrn_survey 
as
	procedure clone (
          old_package_id    in apm_packages.package_id%TYPE   default null,
          new_package_id    in apm_packages.package_id%TYPE   default null
       )
       as

       v_survey_id surveys.survey_id%TYPE;
       v_section_id survey_sections.section_id%TYPE;
       v_question_id survey_questions.question_id%TYPE;
       v_choice_id survey_question_choices.choice_id%TYPE;

       begin

       for one_survey in (select s.*, o.creation_user
		          from surveys s, acs_objects o
			  where s.package_id=old_package_id
			  and o.object_id=s.survey_id)
       loop
           v_survey_id := survey.new(
		name => one_survey.name,
		description => one_survey.description,
		description_html_p => one_survey.description_html_p,
		enabled_p => one_survey.enabled_p,
		single_response_p => one_survey.single_response_p,
		editable_p => one_survey.editable_p,
		single_section_p => one_survey.single_section_p,
		type => one_survey.type,
		display_type => one_survey.display_type,
		package_id => new_package_id,
		context_id => new_package_id,
		creation_user => one_survey.creation_user
		);
	   
	   for one_section in (select *
	                   from survey_sections
			   where survey_id=one_survey.survey_id)
	   loop
	       v_section_id := survey_section.new (
	           survey_id => v_survey_id,
		   name => one_section.name,
		   description => one_section.description,
		   description_html_p => one_section.description_html_p,
		   context_id => v_survey_id 
		   );

	      for one_question in (select *
	                           from survey_questions
				   where section_id=one_section.section_id)
	      loop
	          v_question_id := survey_question.new (
			section_id => v_section_id,
			sort_order => one_question.sort_order,
			question_text => one_question.question_text,
			abstract_data_type => one_question.abstract_data_type,
			required_p => one_question.required_p,
			active_p => one_question.active_p,
			presentation_type => one_question.presentation_type,
			presentation_options => one_question.presentation_options,
			presentation_alignment => one_question.presentation_alignment,
			context_id => v_section_id 
			);

		  for q_choice in (select *
		                   from survey_question_choices
				   where question_id=one_question.question_id)
		  loop
		      select survey_choice_id_sequence.nextval into v_choice_id from dual;
		      insert into survey_question_choices
		      (choice_id, question_id, label, numeric_value, sort_order)
		       values
		      (v_choice_id,
		       v_question_id,
		       q_choice.label,
		       q_choice.numeric_value,
		       q_choice.sort_order);
		  end loop;
	      end loop;
	  end loop;
      end loop;

      end clone;

end dotlrn_survey;
/
show errors



