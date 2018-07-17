%<master>
<property name="title">Survey: Responseg history for @user.full_name@</property>
<property name="context_bar">@context_bar@</property>

<p>
  Response history for
  <b>
    
  </b>
</p>

<p>
<center>
@dimensional_chunk@
</center>
</p>

<center>

<if @view@ eq "date">

  <table bgcolor="#cccccc" width="95%">

    <tr>
      <th align="left" width="30%">Survey</th>
      <th align="left">Subject</th>
      <th align="center" width="20%">Posted</th>
    </tr>

<if @surveys:rowcount;literal@ gt 0>
<multiple name="surveys">

  <if @surveys.rownum@ odd>
    <tr bgcolor="#eeeeee">
  </if>
  <else>
    <tr bgcolor="#d9e4f9">
  </else>

      <td><a href="@surveys.url@survey-view?survey_id=@surveys.survey_id@">@surveys.survey_name@</a></td>
      <td><a href="@surveys.url@one-respondent?response_id=@surveys.response_id@">@surveys.subject@</a></td>
      <td align="center">@surveys.posting_date@</td>

    </tr>

</multiple>
</if>
<else>
    <tr>
      <td colspan="3">
        <i>No Postings.</i>
      </td>
    </tr>
</else>

  </table>

</if>

<if @view@ eq survey>

<multiple name="surveys">

  <table bgcolor="#cccccc" width="95%">

    <tr bgcolor="#eeeeee">
      <th align="left" colspan="2">@surveys.survey_name@<br><br></th>
    </tr>

    <tr>
      <th align="left">Subject</th>
      <th align="center" width="20%">Posted</th>
    </tr>

<group column="survey_name">

  <if @surveys.rownum@ odd>
    <tr bgcolor="#eeeeee">
  </if>
  <else>
    <tr bgcolor="#d9e4f9">
  </else>

      <td><a href="@surveys.url@one-respondent?response_id=@surveys.response_id@">@surveys.subject@</a></td>
      <td align="center">@surveys.posting_date@</td>

    </tr>

</group>

  </table>
  <br>

</multiple>

</if>

</center>
