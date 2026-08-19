
module icg_cell (
  input  logic clk_in,
  input  logic enable,
  output logic clk_gated
);

  
  logic en_latched;

  always_latch begin
    if(!clk_in) en_latched<=enable;
  
  end
  assign clk_gated= clk_in & en_latched;
endmdoule