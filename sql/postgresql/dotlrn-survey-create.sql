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
-- ported to postgres by mohan pakkurti (mohan@pakkurti.com)
-- 2002-07-12
--

create function inline_0()
returns integer as '
declare
    foo                             integer;
begin

    foo := acs_sc_impl__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''dotlrn_survey''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''GetPrettyName'',
        ''dotlrn_survey::get_pretty_name'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''AddApplet'',
        ''dotlrn_survey::add_applet'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''RemoveApplet'',
        ''dotlrn_survey::remove_applet'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''AddAppletToCommunity'',
        ''dotlrn_survey::add_applet_to_community'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''RemoveAppletFromCommunity'',
        ''dotlrn_survey::remove_applet_from_community'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''AddUser'',
        ''dotlrn_survey::add_user'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''RemoveUser'',
        ''dotlrn_survey::remove_user'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''AddUserToCommunity'',
        ''dotlrn_survey::add_user_to_community'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''RemoveUserFromCommunity'',
        ''dotlrn_survey::remove_user_from_community'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''AddPortlet'',
        ''dotlrn_survey::add_portlet'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''RemovePortlet'',
        ''dotlrn_survey::remove_portlet'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''Clone'',
        ''dotlrn_survey::clone'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_survey'',
        ''ChangeEventHandler'',
        ''dotlrn_survey::change_event_handler'',
        ''TCL''
    );

    perform acs_sc_binding__new (
        ''dotlrn_applet'',
        ''dotlrn_survey''
    );

    return 0;

end;' language 'plpgsql';

select inline_0();
drop function inline_0();

--
-- Survey Clone function
--

create or replace function dotlrn_survey__clone(integer,integer)
returns integer as ' 
declare
	p_old_package_id                alias for $1; -- comment
        p_new_package_id                alias for $2; -- comment
        v_survey_id                     surveys.survey_id%TYPE;
        v_section_id                    survey_sections.section_id%TYPE;
        v_question_id                   survey_questions.question_id%TYPE;
        v_choice_id                     survey_question_choices.choice_id%TYPE;
	c_one_survey                    record;
	c_one_section                   record;
	c_one_question                  record;
	c_q_choice                      record;
begin
	for c_one_survey in select s.*, o.creation_user
                          from surveys s, acs_objects o
                          where package_id=p_old_package_id
                          and o.object_id=s.survey_id
	loop
	v_survey_id := survey__new(
                null,
		c_one_survey.name,
                c_one_survey.description,
                c_one_survey.description_html_p,
                c_one_survey.single_response_p,
                c_one_survey.editable_p,
                c_one_survey.enabled_p,
                c_one_survey.single_section_p,
                c_one_survey.type,
                c_one_survey.display_type,
                p_new_package_id,
                c_one_survey.creation_user,
		p_new_package_id
               );               
	   for c_one_section in select *
	                   from survey_sections
			   where survey_id=c_one_survey.survey_id
	   loop
	       v_section_id := survey_section__new (
                   null,
                   v_survey_id,
		   c_one_section.name,
		   c_one_section.description,
		   c_one_section.description_html_p,
                   c_one_survey.creation_user,
		   v_survey_id 
		   );

	      for c_one_question in select *
	                           from survey_questions
				   where section_id=c_one_section.section_id
	      loop
	          v_question_id := survey_question__new (
	                null,
			v_section_id,
			c_one_question.sort_order,
			c_one_question.question_text,
			c_one_question.abstract_data_type,
			c_one_question.required_p,
			c_one_question.active_p,
			c_one_question.presentation_type,
			c_one_question.presentation_options,
			c_one_question.presentation_alignment,
	                c_one_survey.creation_user,
			v_section_id 
			);

		  for c_q_choice in select *
		                   from survey_question_choices
				   where question_id=c_one_question.question_id
		  loop
                      select survey_choice_id_seq.sequence into v_choice_id;
		      insert into survey_question_choices (choice_id,question_id,label,numeric_value,sort_order) values (v_choice_id,v_question_id,c_q_choice.label,c_q_choice.numeric_value,c_q_choice.sort_order);
		  end loop;
              end loop;
           end loop;
        end loop;
	return v_survey_id;
end;' language 'plpgsql';