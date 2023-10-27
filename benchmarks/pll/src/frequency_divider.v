module frequency_divider #(
    DIVISION = 2
)
(
    input  logic input_clk_digital,
    output logic output_clk_digital,

    input logic reset,
    input logic clk
);

logic [31:0] counter;

always @(posedge input_clk_digital) begin
    if(reset) counter <= 0;
    else if(counter != DIVISION) counter <= counter + 1;
    else counter <= 0;
end

always @(*) begin // We want a latch in this case
    if(reset) output_clk_digital = 0;
    else if(counter == DIVISION) output_clk_digital = !output_clk_digital;
end

endmodule