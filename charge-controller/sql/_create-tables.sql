

CREATE TABLE IF NOT EXISTS `controller_discrete_input` (
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `discrete_over_temp_inside_device` int(11) NOT NULL,
  `discrete_is_night` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE IF NOT EXISTS `controller_rated_data` (
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `rated_input_v` int(11) NOT NULL,
  `rated_input_a` int(11) NOT NULL,
  `rated_input_w` int(11) NOT NULL,
  `rated_output_v` int(11) NOT NULL,
  `rated_output_a` int(11) NOT NULL,
  `rated_mode` int(11) NOT NULL,
  `rated_load_a` int(11) NOT NULL,
  `rated_output_w` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `controller_real_time_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `rt_input_v` float NOT NULL,
  `rt_input_a` float NOT NULL,
  `rt_input_w` float NOT NULL,
  `rt_battery_v` float NOT NULL,
  `rt_battery_a` float NOT NULL,
  `rt_battery_w` float NOT NULL,
  `rt_load_v` float NOT NULL,
  `rt_load_a` float NOT NULL,
  `rt_load_w` float NOT NULL,
  `rt_battery_temp` float NOT NULL,
  `rt_case_temp` float NOT NULL,
  `rt_power_component_temp` float NOT NULL,
  `rt_battery_soc` float NOT NULL,
  `rt_remote_battery_temp` float NOT NULL,
  `rt_battery_rated_v` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `controller_real_time_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `rt_battery_status` int(11) NOT NULL,
  `rt_charging_equipment_status` int(11) NOT NULL,
  `rt_discharging_equipment_status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `controller_settings` (
  `id` int(11) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `setting_battery_type` int(11) NOT NULL,
  `setting_battery_ah` int(11) NOT NULL,
  `setting_temp_coefficient` float NOT NULL,
  `setting_high_volt_disconnect` float NOT NULL,
  `setting_low_volt_disconnect` float NOT NULL,
  `setting_charging_limit_volt` float NOT NULL,
  `setting_over_volt_reconnect` float NOT NULL,
  `setting_equalization_voltage` float NOT NULL,
  `setting_boost_voltage` float NOT NULL,
  `setting_float_voltage` float NOT NULL,
  `setting_boost_reconnect_voltage` float NOT NULL,
  `setting_low_volt_reconnect` float NOT NULL,
  `setting_under_volt_recover` float NOT NULL,
  `setting_under_volt_warning` float NOT NULL,
  `setting_discharge_limit_volt` float NOT NULL,
  `setting_real_time_clock` datetime NOT NULL,
  `setting_equalization_charging_cycle` int(11) NOT NULL,
  `setting_battery_temp_warning_upper_limit` float NOT NULL,
  `setting_battery_temp_warning_lower_limit` float NOT NULL,
  `setting_control_inner_temp_upper_limit` float NOT NULL,
  `setting_control_inner_temp_upper_limit_recover` float NOT NULL,
  `setting_power_component_temp_upper_limit` int(11) NOT NULL,
  `setting_power_component_temp_upper_limit_recover` int(11) NOT NULL,
  `setting_line_impedance` float NOT NULL,
  `setting_nttv` int(11) NOT NULL,
  `setting_nttv_delay` int(11) NOT NULL,
  `setting_dttv` int(11) NOT NULL,
  `setting_dttv_delay` int(11) NOT NULL,
  `setting_load_controlling_modes` int(11) NOT NULL,
  `setting_working_time_length_1` time NOT NULL,
  `setting_working_time_length_2` time NOT NULL,
  `setting_turn_on_timing_1` time NOT NULL,
  `setting_turn_off_timing_1` time NOT NULL,
  `setting_turn_on_timing_2` time NOT NULL,
  `setting_turn_off_timing_2` time NOT NULL,
  `setting_length_of_night` time NOT NULL,
  `setting_battery_rated_voltage` float NOT NULL,
  `setting_load_timing_control_selection` int(11) NOT NULL,
  `setting_default_load_in_manual_mode` int(11) NOT NULL,
  `setting_equalize_duration` int(11) NOT NULL,
  `setting_boost_duration` int(11) NOT NULL,
  `setting_discharging_percentage` float NOT NULL,
  `setting_charging_percentage` float NOT NULL,
  `setting_battery_management_mode` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `controller_statistics` (
  `id` int(11) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `stat_max_input_v_today` float NOT NULL,
  `stat_min_input_v_today` float NOT NULL,
  `stat_max_battery_v_today` float NOT NULL,
  `stat_min_battery_v_today` float NOT NULL,
  `stat_consumed_kwh_today` float NOT NULL,
  `stat_consumed_kwh_month` float NOT NULL,
  `stat_consumed_kwh_year` float NOT NULL,
  `stat_consumed_kwh_total` float NOT NULL,
  `stat_generated_kwh_today` float NOT NULL,
  `stat_generated_kwh_month` float NOT NULL,
  `stat_generated_kwh_year` float NOT NULL,
  `stat_generated_kwh_total` float NOT NULL,
  `stat_carbon_dioxide_reduction` float NOT NULL,
  `stat_battery_current` float NOT NULL,
  `stat_battery_temp` float NOT NULL,
  `stat_ambient_temp` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

