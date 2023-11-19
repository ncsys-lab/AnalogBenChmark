
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

logic [$clog2(N_BITS):0] counter;

//need to double buffer the output becaues tecnically the SAR outputs a 1
// for the bit under comparison
logic[N_BITS - 1:0] quantized_voltage_register;

always@(posedge clk) begin
    if(reset) begin
        counter <= 0;
    end else if(conduct_comparison) begin
        if(counter != N_BITS * 2 - 1) counter <= counter + 1;
        else counter <= 0;
    end
end

always@(posedge clk) begin
    if(reset || !conduct_comparison) begin
        quantized_voltage_register <= 0;
    end else begin 
        quantized_voltage_register[(N_BITS - counter/2) - 1] <= feedback_value;
    end
end

always@(*) begin
    int i;
    for(i=0;i<N_BITS;i++) begin
        quantized_voltage[i] = ((N_BITS - counter/2) - 1 == i) ? 1:quantized_voltage_register[i];
    end
end

assign eoc = (counter/2 == N_BITS - 1);


endmodule