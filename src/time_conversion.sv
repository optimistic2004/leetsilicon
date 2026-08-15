
module timebase (
  input  logic clk,
  input  logic rst_n,
  input  logic tick_1ms,
  output logic sec_pulse,
  output logic min_pulse,
  output logic hour_pulse
);

  // TODO: ms counter 0..999 (counts tick_1ms events).
  logic [9:0] ms_cnt;

  // TODO: sec counter 0..59 (counts sec_pulse events).
  logic [5:0] sec_cnt;

  // TODO: min counter 0..59 (counts min_pulse events).
  logic [5:0] min_cnt;

  // TODO: Use tick_1ms as clock-enable.
always_ff@(posedge clk) begin
if(!rst_n) begin
  ms_cnt<=0;
  sec_pulse<=0;
end
else begin
  sec_pulse<=0;
  if(tick_1ms) begin
  if(ms_cnt==999) begin
ms_cnt<=0;
sec_pulse<=1;
  end else begin
  ms_cnt<=ms_cnt+1;
  end
  end 
end
end

always_ff@(posedge clk) begin
  if(!rst_n) begin
sec_cnt<=0;
min_pulse<=0;
  end else begin
  min_pulse<=0;
  if(sec_pulse) begin
  if(sec_cnt==59) begin
    sec_cnt<=0;
    min_pulse<=1;
  end else begin
sec_cnt<=sec_cnt+1;
  end
  end
  end
end

always_ff@(posedge clk) begin
  if (!rst_n) begin
  min_cnt<=0;
  hour_pulse<=0;
  end else begin
  hour_pulse<=0;
  if(min_pulse) begin
    if(min_cnt==59) begin
    hour_pulse<=1;
    min_cnt<=0;
    end else begin
min_cnt=min_cnt+1;
    end
  end
  end
end
endmodule