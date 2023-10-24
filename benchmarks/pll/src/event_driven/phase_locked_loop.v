module phase_locked_loop(
input reference_clk_digital,
output output_clk_digital,

input clk, //Clock for event-driven simulator

input reset
);


charge_pump cpmp ( .input_up_digital(), .input_down_digital(), .output_current_real() );
voltage_controlled_oscillator vco(input_voltage_real(), output_clk_digital());
loop_filter lf(.input_current_real(), .output_voltage_real());
phase_frequency_detector pfd(.input_reference_clock_digital(), .input_feedback_clock_digital(), 
                                .output_up_digital(), .output_down_digital(), .reset());

frequency_divider fd(.input_clock_digital(), .output_clock_digital())



endmodule