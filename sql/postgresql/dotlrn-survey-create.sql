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
