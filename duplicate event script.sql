Declare
	v_new_event_name			Text;
	v_old_event_pkid			Text;
	v_new_event_pkid			Text;
	v_new_eipl_pkid				Text;
	v_old_eipl_pkid				Text;
Begin

	v_old_event_pkid = p_event_pkid;
	Select "name" Into v_new_event_name From events_ Where pkid = v_old_event_pkid;
	v_new_event_name = v_new_event_name || '- copy';

	-- duplicate the event putting new event name into it
	Insert Into events_
		(
			"name", start_ts, end_ts, loadin_ts, loadout_ts, details, acountmanager_, startdate_, enddate_, loadindate_, loadoutdate_, starttime_, endtime_, loadintime_, loadouttime_
		)
		Select 
			v_new_event_name, start_ts, end_ts, loadin_ts, loadout_ts, details, acountmanager_, startdate_, enddate_, loadindate_, loadoutdate_, starttime_, endtime_, loadintime_, loadouttime_
		From events_
		Where pkid = v_old_event_pkid 
		Returning pkid Into v_new_event_pkid;

		
	-- duplicate contact venu data records
	Insert Into contact_venue_data 
		(
			fkcontacts, fkvenues, fkevents_, fkeipl, primary_
		)
		Select 
			fkcontacts, fkvenues, v_new_event_pkid, fkeipl, primary_
		From contact_venue_data
		Where fkevents_ = v_old_event_pkid;

	-- Loop through each eipl 
	For v_old_eipl_pkid In 
		Select pkid
		From eipl 
		Where fkevents_ = v_old_event_pkid
	Loop

		Perform * From duplicate_eipl(v_old_eipl_pkid,v_new_event_pkid);

	End Loop;

Return 'done';
End;