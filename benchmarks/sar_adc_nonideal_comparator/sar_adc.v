`include "./comparator_latch.v"
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
    input logic sys_clk,
    input logic reset
);

logic [9:0] p_voltage_real;
logic [9:0] n_voltage_real;

logic [9:0] comparator_output_real;
logic       comparator_output_digital;

sample_and_hold sah
(
  .clk(clk),
  .reset(reset),
  .sys_clk(sys_clk),
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
    .clk(sys_clk), 
    .reset(reset) 
);


digital_to_analog_converter DAC_instance (
    .clk(clk), 
    .reset(reset), 
    .input_voltage_digital(output_result_digital), 
    .output_voltage_real(n_voltage_real) 
);

comparator_latch comparator_instance (
    .clk(clk),              
    .reset(reset),            
    .sys_clk(sys_clk),          
    .p(p_voltage_real),   
    .n(n_voltage_real),   
    .out(comparator_output_real)       
);

//D-Latch to make the comparator latch a comparator flip-flop!
always@(posedge clk) begin
    if(reset) begin
        comparator_output_digital <= 0;
    end else if(sys_clk == 1) begin
        comparator_output_digital <= comparator_output_real > 211; //0.5VDD
    end
end

endmodule