
module successive_approximation_register #(
    parameter N_BITS = 10
)
(
    input  logic feedback_value,
    input  logic conduct_comparison,

    output logic [N_BITS - 1:0] quantized_voltage,
    output logic               eoc,

    input logic clk,
    input logic reset
);

logic [$clog2(N_BITS) - 1:0] counter;

always@(posedge clk) begin
    if(reset) begin
        counter <= 0;
    end else if(conduct_comparison) begin
        if(counter != N_BITS - 1) counter <= counter + 1;
        else counter <= 0;
    end
end

always@(posedge clk) begin
    if(reset || !conduct_comparison) begin
        quantized_voltage <= 0;
    end else begin 
        quantized_voltage[N_BITS - counter - 1] <= feedback_value;
    end
end

assign eoc = (counter == N_BITS - 1);


endmodule