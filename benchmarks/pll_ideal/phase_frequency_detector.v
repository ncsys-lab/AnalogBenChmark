

module phase_frequency_detector(

input logic input_reference_clock_digital,
input logic input_feedback_clock_digital,

output logic output_up_digital,
output logic output_down_digital,

input logic reset,
input logic clk
);



logic res;

assign res = (output_up_digital & output_down_digital) | reset;

logic input_reference_clock_digital_prev;
logic input_feedback_clock_digital_prev;

always@(posedge clk) begin
    if(reset) begin
        input_reference_clock_digital_prev <= 0;
        input_feedback_clock_digital_prev  <= 0;
    end else begin
        input_reference_clock_digital_prev <= input_reference_clock_digital;
        input_feedback_clock_digital_prev  <= input_feedback_clock_digital;
    end
end

logic posedge_reference;
logic posedge_feedback;

assign posedge_feedback = ~input_feedback_clock_digital_prev & input_feedback_clock_digital;
assign posedge_reference = ~input_reference_clock_digital_prev & input_reference_clock_digital;

always @(posedge clk) begin
    if(res) begin
        output_up_digital <= 0;
        output_down_digital <= 0;
    end else begin
        if(posedge_feedback) output_down_digital <= 1;
        if(posedge_reference) output_up_digital <= 1;
    end
end

/*
//This file gets misinterpreted by verilator!
always @(posedge input_reference_clock_digital or posedge res) begin
    if(res) output_up_digital <= 0;
    else output_up_digital <= 1;
end

always @(posedge input_feedback_clock_digital or posedge res) begin
    if(res) output_down_digital <= 0;
    else output_down_digital <=1;
end
*/



endmodule