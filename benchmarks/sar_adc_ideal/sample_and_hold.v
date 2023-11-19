

module sample_and_hold
(
  input clk,
  input reset,
  input sys_clk,
  input [10-1:0] input_voltage_real,
  output [10-1:0] output_voltage_real,
  input [1-1:0] input_control_digital
);

  reg [4-1:0] state_cycle_counter;
  reg [1-1:0] prev_sys_clk;
  reg [10-1:0] state_cap;
  reg [32-1:0] fsm;
  localparam fsm_init = 0;
  assign output_voltage_real = state_cap;

  always @(posedge clk) begin
    prev_sys_clk <= sys_clk;
  end

  localparam fsm_1 = 1;

  always @(posedge clk) begin
    if(reset) begin
      fsm <= fsm_init;
    end else begin
      case(fsm)
        fsm_init: begin
          if(reset) begin
            state_cap <= 10'd0;
          end else begin
            state_cap <= input_voltage_real;
          end
          if(input_control_digital) begin
            fsm <= fsm_1;
          end 
        end
        fsm_1: begin
          if(reset) begin
            state_cap <= 10'd0;
          end else begin
            state_cap <= state_cap;
          end
          if(!input_control_digital) begin
            fsm <= fsm_init;
          end 
        end
      endcase
    end
  end


endmodule

