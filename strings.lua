function data()
return {
	de = {
		["nighty_type_n_hauptsignal_name"] = ("Typ N Hauptsignal"),
		["nighty_type_n_hauptsignal_desc"] = ("Hauptsignale des Typ N Systems mit oder ohne Geschwindigkeitsanzeige"),

		["nighty_no"] = ("Aus"),
		["nighty_yes"] = ("An"),

		["nighty_type_n_signaltype"] = ("Signaltyp\nText kann im Signal-Namen geändert werden.\n z.B. [Zue] oder [Zue|ZHdb] für mehrere Schilder."),
		["nighty_type_n_signaltype_pre"] = ("Signaltyp"),
		["nighty_type_n_signaltype_tooltip"] = ("Wähle einen Signaltyp (Einfahrt-/Ausfahrt- oder Vorangezeigte Einfahrt)"),

		["nighty_type_n_speedindicator"] = ("Geschwindigkeitsanzeige"),
		["nighty_type_n_speedindicator_tooltip"] = ("Wähle ob das Signal mit Geschwindigkeitsanzeige gebaut werden soll."),

		["nighty_type_n_shorten_block"] = ("Verkürzte Blockabstände"),
		["nighty_type_n_shorten_block_tooltip"] = ("[Geschwindigkeitsanzeige muss aktiv sein] Wähle, ob das Signal das Signalbild 'Warnung Verkürzter Blockabstand' datstellen soll."),

		["nighty_type_n_occupied"] = ("Block ist belegt"),
		["nighty_type_n_occupied_tooltip"] = ("[Geschwindigkeitsanzeige muss aktiv sein] Wähle, ob das Signal das Signalbild 'Belegtes Gleis' datstellen soll."),

		["nighty_type_n_id_sign"] = ("Signal Nummer\nText kann im Signal-Namen geändert werden.\nz.B. (E34)"),
		["nighty_type_n_id_sign_tooltip"] = ("Wähle, ob das Signal ein kleines Schild auf dem die Signalnummer angezeigt wird, haben soll."),

		["nighty_type_n_vorsignal_name"] = ("Typ N Vorsignal"),
		["nighty_type_n_vorsignal_desc"] = ("Vorsignale des Typ N Systems mit oder ohne Geschwindigkeitsanzeige"),

		["nighty_type_n_pre_station"] = ("Stationeinfahrts Vorankündigung"),
		["nighty_type_n_pre_station_tooltip"] = ("Wähle, ob das Signal ein Zusatzschild als Vorankündigung für ein Einfahrtssignal darstellen soll"),

		["nighty_type_n_repeat"] = ("Wiederholungs Schild"),
		["nighty_type_n_repeat_tooltip"] = ("Wähle, ob das Signal ein Zusatzschild (Wiederholung) darstellen soll"),

		["nighty_invisible_signal"] = ("Unsichtbares Signal"),
		["nighty_invisible_waypoint"] = ("Unsichtbarer Wegpunkt"),

		["nighty_type_n_build_form"] = ("Signal Bauform"),
		["nighty_type_n_build_form_old"] = ("Alt"),
		["nighty_type_n_build_form_brugg"] = ("Brugg"),
		["nighty_type_n_build_form_rappi"] = ("Rappi"),

		["nighty_type_n_mast"] = ("Signal Mast"),
		["nighty_type_n_mast_basic"] = ("Standard"),
		["nighty_type_n_mast_offset_right"] = ("Versetzt Rechts"),
		["nighty_type_n_mast_offset_left"] = ("Versetzt Links"),

		["nighty_type_n_mast_addon_none"] = ("Keine"),
		["nighty_type_n_mast_addon_leiter"] = ("Leiter"),
		["nighty_type_n_mast_addon_korb"] = ("Korb"),
		["nighty_type_n_mast_addon_korb_leiter"] = ("Korb und Leiter"),

		["sbb_type_n_name"] = ("SBB Typ N Signale (Better Signals)"),
		["sbb_type_n_name_desc"] = ("Schweizer Signale vom Typ N. Im Paket enthalten sind sowohl Vor- wie auch Hauptsignale. Die Signale sind Teil des [Better Signals] Projekts"),

		["better_signals_view_distance"] = ("Signal Erkennungsdistanz"),
		["better_signals_view_distance_tooltip"] = ("Stelle ein, wie weit ein Zug Signale sehen kann"),

		["better_signals_x_offset"] = ("Signalauswahl zum verknüpfen kann \nmit ü und ¨ geändert werden.\n\nSignal Versatz"),
		["better_signals_x_offset_tooltip"] = ("Wähle auf welcher Seite vom Gleis, das Signal snappen soll."),
		["better_signals_snap_left"] = ("Links"),
		["better_signals_snap_right"] = ("Rechts"),
		["better_signals_snap_middle"] = ("Mitte"),
	},
	en = {
		["nighty_no"] = ("Off"),
		["nighty_yes"] = ("On"),

		["nighty_type_n_hauptsignal_name"] = ("Type N Main Signal"),
		["nighty_type_n_hauptsignal_desc"] = ("Minsignal from the Type N System with or without Speedindicator"),

		["nighty_type_n_signaltype"] = ("Signal Type"),
		["nighty_type_n_signaltype_tooltip"] = ("Choose a signaltype (Entry-/Exit- or Entry Announcement)"),

		["nighty_type_n_speedindicator"] = ("Speed Indicator"),
		["nighty_type_n_speedindicator_tooltip"] = ("Choose if the signal should have a speed indicator."),

		["nighty_type_n_shorten_block"] = ("Shortened Block"),
		["nighty_type_n_shorten_block_tooltip"] = ("[Needs Speedindicator to be active] Choose if the signal should be able to display 'Warning, Shortened Blockdistance'."),

		["nighty_type_n_occupied"] = ("Track is Occupied"),
		["nighty_type_n_occupied_tooltip"] = ("[Needs Speedindicator to be active] Choose if the signal should be able to display 'Track is occupied'."),

		["nighty_type_n_id_sign"] = ("Signal Identification Number (E34)"),
		["nighty_type_n_id_sign_tooltip"] = ("Choose if the signal should have a signal identification number."),

		["nighty_type_n_vorsignal_name"] = ("Type N Presignal"),
		["nighty_type_n_vorsignal_desc"] = ("Presignal from the Type N System with or without Speedindicator"),

		["nighty_type_n_pre_station"] = ("Pre-Entry Sign"),
		["nighty_type_n_pre_station_tooltip"] = ("Choose if the 'Pre-Entry Sign' should be displayed"),

		["nighty_type_n_repeat"] = ("Repeat Sign"),
		["nighty_type_n_repeat_tooltip"] = ("Choose if a (Repeat)-Sign should be shown"),

		["nighty_invisible_signal"] = ("Invisible Signal"),
		["nighty_invisible_waypoint"] = ("Invisible Waypoint"),

		["sbb_type_n_name"] = ("SBB Type N Signals (Better Signals)"),
		["sbb_type_n_name_desc"] = ("Swiss Type N Signals. This signal pack includes both pre- and mainsignals. All signals are part of the [Better Signals] project"),
	}
}
end