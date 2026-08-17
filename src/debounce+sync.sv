
module debounce_sync (
  input  logic clk,
  input  logic rst_n,
  input  logic async_in,
  output logic debounced_level,
  output logic debounced_rise_pulse
);

   logic [1:0] hi_hist;
logic debounced_d;
  // TODO: Edge detect on debounced_level.
 always_ff@(posedge clk or negedge rst_n) begin
 if(!rst_n) begin
 s1<='0;
 s2<='0;
 debounced_level<='0;
 end
 else begin 
 s1<=async_in;
 s2<=s1;
 end
 end

 always_ff@(posedge clk or negedge rst_n) begin
 if(!rst_n) begin
 hi_hist<='0;
 debounced_level<='0;
debounced_d<='0;
 end else begin
  hi_hist<={hi_hist[0],s2};
  if(hi_hist==2'b11) debounced_level<=1;
  else if(hi_hist==2'b00) debounced_level<=0;
  $display("shift reg value =%0d",hi_hist);
 end
 end

 always_ff@(posedge clk or negedge rst_n) begin
 if(!rst_n) begin
 debounced_d<='0;
 end else begin debounced_d<=debounced_level;
 end
 end
 assign debounced_rise_pulse=debounced_level & ~debounced_d;
endmodule


// debounced_level is a registered "current state" signal (like a debounced switch position) that
// simply reflects whether the input is currently high or low, updated each cycle based on the
// 2-cycle synchronizer (s1/s2) + hi_hist shift-register majority check, which filters out glitches/bounce.
// Since debounced_level can stay high for many cycles while the input is held, we can't use it directly
// as a "press event" - we need a single-cycle pulse instead. debounced_d is debounced_level delayed by
// one clock cycle (its value "last cycle"), and debounced_rise_pulse = debounced_level & ~debounced_d
// compares "current" vs "previous" to catch the exact one cycle where the signal transitions 0->1
// (current=1 AND previous=0), producing a one-shot pulse instead of a held level - this is the standard
// level-to-pulse edge-detection pattern needed anywhere you want to trigger an action once per event
// (e.g., incrementing a counter) rather than once per clock cycle the input stays high.