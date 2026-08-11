
module bin_to_gray_counter #(
  parameter int W = 4
) (
  input  logic         clk,
  input  logic         rst_n,
  input  logic         enable,
  output logic [W-1:0] bin_count,
  output logic [W-1:0] gray_count
);

 always_ff@(posedge clk) begin
if(!rst_n) begin
  bin_count<={W{1'b0}};
  //gray_count<={W{1'b0}};
  end

else if (enable) begin
  bin_count<=bin_count+1'b1;
end
 end
   assign gray_count=bin_count ^(bin_count)>>1;
