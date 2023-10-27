

module phase_frequency_detector(

input logic input_reference_clock_digital,
input logic input_feedback_clock_digital,

output logic output_up_digital,
output logic output_down_digital,

input logic reset,
input logic clk
);

logic toggle;

assign toggle = output_up_digital && output_down_digital;

always @(posedge input_reference_clock_digital or posedge reset or posedge toggle) begin
    if(reset || toggle) output_up_digital <= 0;
    else output_up_digital <= 1;
end

always @(posedge input_feedback_clock_digital or posedge reset or posedge toggle) begin
    if(reset || toggle) output_down_digital <= 0;
    else output_down_digital <= 1;
end

endmodule