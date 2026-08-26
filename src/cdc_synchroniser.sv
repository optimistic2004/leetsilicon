module two_ff_sync (
  input  logic dst_clk,
  input  logic dst_rst_n,
  input  logic async_sig_in,
  output logic sig_sync
);

    logic s1, s2;

  always_ff@(posedge dst_clk or negedge dst_rst_n) begin
    if(!dst_rst_n) begin
      s1<=0;
      s2<=0;
    end
      else begin 
      s1<=async_sig_in;
      s2<=s1;
      end  
  end

  assign sig_sync=s2;
endmodule