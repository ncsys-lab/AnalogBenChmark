`include "./comparator.v"
`include "./digital_to_analog_converter.v"
`include "./sample_and_hold.v"
`include "./successive_approximation_register.v"


module sar_adc 
#(
    parameter N_BITS = 10 
)
(

    input logic [9:0] input_voltage_real,
    
    input logic input_hold_digital,

    output logic eoc,
    output logic [N_BITS - 1:0] output_result_digital,


    input logic clk,
    input logic reset
);

logic [9:0] p_voltage_real;
logic [9:0] n_voltage_real;

logic       comparator_output_digital;

sample_and_hold sah
(
  .clk(clk),
  .reset(reset),
  .sys_clk(clk),
  .input_voltage_real(input_voltage_real),
  .output_voltage_real(p_voltage_real),
  .input_control_digital(input_hold_digital)
);

successive_approximation_register #(
    .N_BITS(N_BITS)
) SAR_instance (
    .feedback_value(comparator_output_digital), 
    .quantized_voltage(output_result_digital),
    .conduct_comparison(input_hold_digital),
    .eoc(eoc), 
    .clk(clk), 
    .reset(reset) 
);


digital_to_analog_converter DAC_instance (
    .clk(clk), 
    .reset(reset), 
    .input_voltage_digital(output_result_digital), 
    .output_voltage_real(n_voltage_real) 
);

comparator comparator_instance (
    .clk(clk),              
    .reset(reset),            
    .sys_clk(clk),          
    .p_voltage_real(p_voltage_real),   
    .n_voltage_real(n_voltage_real),   
    .out_digital(comparator_output_digital)       
);


endmodule